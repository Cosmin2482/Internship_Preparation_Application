/*
  # Batch 4: .NET & EF Core Detailed Terms
  
  Adds missing .NET terms:
  - Middleware
  - Include vs Projection
  - N+1 Problem
  - Minimal API vs MVC Controllers
  - Problem Details
*/

DO $$
DECLARE
  cat_dotnet_id uuid;
  cat_arch_id uuid;
BEGIN
  SELECT id INTO cat_dotnet_id FROM categories WHERE slug = 'dotnet';
  SELECT id INTO cat_arch_id FROM categories WHERE slug = 'architecture';

  -- Middleware
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet_id,
    'Middleware',
    'Middleware = components that handle HTTP requests in a pipeline. Each middleware can process the request, call next middleware, then process response. Order matters! Logging → Auth → CORS → Controllers.',
    'Middleware: software components in the ASP.NET Core request pipeline. Each middleware can: (1) process incoming request, (2) call next middleware, (3) process outgoing response, or (4) short-circuit (not call next). Configured in Program.cs/Startup, executes in order.',
    'Middleware forms a request processing pipeline. Request flows through middlewares in order, each can inspect/modify request, then response flows back in reverse. Common middleware: (1) Logging - records requests. (2) Authentication - validates identity. (3) Authorization - checks permissions. (4) CORS - handles cross-origin requests. (5) Static files - serves CSS/JS. (6) Routing - maps URL to controller. (7) Exception handling - catches errors. Order is critical! Auth before authorization. CORS before controllers. Use app.Use() for custom middleware. Short-circuit example: auth middleware returns 401 without calling next(). Interview: explain pipeline, why order matters, how to write custom middleware.',
    to_jsonb(ARRAY[
      'Wrong middleware order (auth after authorization)',
      'Not calling next() in custom middleware (breaks pipeline)',
      'Adding middleware after endpoints (too late)',
      'Not understanding request vs response flow',
      'Heavy processing in middleware (should be fast)',
      'Not handling exceptions in middleware'
    ]),
    jsonb_build_object(
      'csharp', '// MIDDLEWARE PIPELINE (Program.cs)
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Order matters!
app.UseHttpsRedirection();       // 1. Force HTTPS
app.UseStaticFiles();            // 2. Serve static files
app.UseCors();                   // 3. CORS
app.UseAuthentication();         // 4. Who are you?
app.UseAuthorization();          // 5. What can you do?
app.MapControllers();            // 6. Route to controllers

app.Run();

// CUSTOM MIDDLEWARE
app.Use(async (context, next) => {
    // Before next middleware
    Console.WriteLine($"Request: {context.Request.Path}");
    
    await next(); // Call next middleware
    
    // After next middleware (on the way back)
    Console.WriteLine($"Response: {context.Response.StatusCode}");
});

// MIDDLEWARE CLASS
public class RequestTimingMiddleware {
    private readonly RequestDelegate _next;
    
    public RequestTimingMiddleware(RequestDelegate next) {
        _next = next;
    }
    
    public async Task InvokeAsync(HttpContext context) {
        var watch = Stopwatch.StartNew();
        
        await _next(context); // Continue pipeline
        
        watch.Stop();
        Console.WriteLine($"Request took {watch.ElapsedMilliseconds}ms");
    }
}

// Register middleware
app.UseMiddleware<RequestTimingMiddleware>();

// SHORT-CIRCUIT (stop pipeline)
app.Use(async (context, next) => {
    if (!context.Request.Headers.ContainsKey("X-API-Key")) {
        context.Response.StatusCode = 401;
        await context.Response.WriteAsync("Unauthorized");
        return; // Do not call next()
    }
    await next();
});

// EXCEPTION HANDLING MIDDLEWARE
app.UseExceptionHandler("/error");
// or
app.Use(async (context, next) => {
    try {
        await next();
    } catch (Exception ex) {
        context.Response.StatusCode = 500;
        await context.Response.WriteAsync("Error occurred");
    }
});',
      'typescript', '// Express.js middleware (similar concept)
const express = require(''express'');
const app = express();

// Middleware functions
app.use((req, res, next) => {
    console.log(`${req.method} ${req.url}`);
    next(); // Continue to next middleware
});

// Auth middleware
app.use((req, res, next) => {
    if (!req.headers[''authorization'']) {
        return res.status(401).send(''Unauthorized'');
    }
    next();
});

// Route handler (final middleware)
app.get(''/users'', (req, res) => {
    res.json({ users: [] });
});

// Error handling middleware (last)
app.use((err, req, res, next) => {
    console.error(err);
    res.status(500).send(''Server Error'');
});'
    ),
    'Middleware Pipeline:

Request →
    [Logging]
        ↓ next()
    [Auth]
        ↓ next()
    [CORS]
        ↓ next()
    [Controller] → generates response
        ↑ response
    [CORS]
        ↑ response
    [Auth]
        ↑ response
    [Logging]
← Response

Each middleware:
1. Process request
2. Call next()
3. Process response

Short-circuit:
[Auth] → 401 Unauthorized
(stops, does not call next)

Order matters!
✓ Auth before Authorization
✓ CORS before Controllers
✓ Exception handler first
✗ Auth after Controllers (too late)',
    100
  ) ON CONFLICT DO NOTHING;

  -- Include vs Projection
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet_id,
    'Include vs Projection',
    'Include = eager-load related entities (full objects). Projection (Select) = pick specific fields only. Include brings more data, Projection is leaner (less memory/network). Use projection for read-only views.',
    'Include: EF Core method to eager-load related entities, loading full navigation properties, enables further changes. Projection (Select): query transformation selecting only needed columns/properties, returns anonymous types or DTOs, read-only, more efficient for large datasets.',
    'Two ways to load related data in EF Core. Include brings full related entities: query.Include(u => u.Orders) loads all Order properties. Projection with Select picks specific fields: query.Select(u => new { u.Name, OrderCount = u.Orders.Count }). Key differences: (1) Include loads tracked entities (can update), projection returns untracked DTOs. (2) Include sends all columns over network, projection sends only selected. (3) Include needed for updates, projection better for read-only views. Use projection for reports, APIs returning subsets. Use Include when you need full entity for updates. Interview: explain performance impact, when to use each, avoiding N+1 with both.',
    to_jsonb(ARRAY[
      'Overusing Include (loading unnecessary data)',
      'Not using projection for read-only scenarios',
      'Multiple Includes causing cartesian explosion',
      'Not understanding projection is untracked',
      'Loading full entities just to display name',
      'Mixing Include and projection incorrectly'
    ]),
    jsonb_build_object(
      'csharp', '// INCLUDE - eager load related entities
var users = await _context.Users
    .Include(u => u.Orders)           // Load all orders
    .Include(u => u.Address)          // Load address
    .ToListAsync();

// Full User objects with all related data
// Can modify: users[0].Orders.Add(new Order());

// PROJECTION - select specific fields
var userDtos = await _context.Users
    .Select(u => new {
        u.Id,
        u.Name,
        OrderCount = u.Orders.Count,
        TotalSpent = u.Orders.Sum(o => o.Total)
    })
    .ToListAsync();

// Only selected data, untracked, smaller payload

// INCLUDE multiple levels
var users = await _context.Users
    .Include(u => u.Orders)
        .ThenInclude(o => o.OrderItems)  // Nested include
    .ToListAsync();

// PROJECTION to DTO
public class UserSummaryDto {
    public int Id { get; set; }
    public string Name { get; set; }
    public int OrderCount { get; set; }
}

var summaries = await _context.Users
    .Select(u => new UserSummaryDto {
        Id = u.Id,
        Name = u.Name,
        OrderCount = u.Orders.Count
    })
    .ToListAsync();

// FILTERED Include (EF Core 5+)
var users = await _context.Users
    .Include(u => u.Orders.Where(o => o.Status == OrderStatus.Completed))
    .ToListAsync();

// When to use:
// Include: Need full entity, will update
// Projection: Read-only, performance-critical, API response

// Generated SQL comparison:
// Include:
// SELECT u.*, o.*
// FROM Users u
// LEFT JOIN Orders o ON u.Id = o.UserId

// Projection:
// SELECT u.Id, u.Name, COUNT(o.Id) as OrderCount
// FROM Users u
// LEFT JOIN Orders o ON u.Id = o.UserId
// GROUP BY u.Id, u.Name',
      'typescript', '// TypeORM example
// Include (eager loading)
const users = await userRepository.find({
    relations: [''orders'', ''address'']
});
// Loads full related entities

// Projection (select specific)
const users = await userRepository
    .createQueryBuilder(''user'')
    .select([''user.id'', ''user.name''])
    .leftJoin(''user.orders'', ''order'')
    .addSelect(''COUNT(order.id)'', ''orderCount'')
    .groupBy(''user.id'')
    .getRawMany();
// Only selected fields'
    ),
    'Include vs Projection:

INCLUDE:
_context.Users
    .Include(u => u.Orders)

SQL: SELECT * FROM Users u
     LEFT JOIN Orders o ON ...

Result:
User {
    Id, Name, Email,
    Orders: [
        Order { Id, Total, Items, ... },  ← Full objects
        Order { Id, Total, Items, ... }
    ]
}

✓ Full entities (can update)
✗ All columns (network cost)
✗ Tracked (memory cost)

PROJECTION:
_context.Users
    .Select(u => new {
        u.Name,
        OrderCount = u.Orders.Count
    })

SQL: SELECT u.Name, COUNT(o.Id)
     FROM Users u
     LEFT JOIN Orders o ON ...
     GROUP BY u.Name

Result:
{ Name: "John", OrderCount: 5 }  ← Minimal DTO

✓ Only needed data
✓ Untracked (less memory)
✗ Read-only (cannot update)',
    101
  ) ON CONFLICT DO NOTHING;

  -- N+1 Problem
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet_id,
    'N+1 Problem',
    'N+1 = query in a loop. Load 100 users (1 query), then for each user load orders (100 queries) = 101 total queries. Terrible performance! Fix: eager load with Include or projection.',
    'N+1 problem: performance anti-pattern where loading N parent entities triggers N additional queries for related data. Results in 1 + N database queries. Common with lazy loading. Solutions: eager loading (Include), projection (Select), explicit loading, batching.',
    'Classic ORM performance problem. Load collection of entities, then for each one, access navigation property triggering another query. Example: get users, loop through, access user.Orders for each - each access hits database. 100 users = 101 queries (1 for users + 100 for orders). Devastating performance. How to detect: look for queries in loops, enable SQL logging in dev, use profiling tools. Solutions: (1) Include for eager loading. (2) Projection with Select. (3) Disable lazy loading. (4) AsSplitQuery for multiple includes. Interview: explain the problem, how to identify, multiple fix strategies, why lazy loading causes it.',
    to_jsonb(ARRAY[
      'Enabling lazy loading without understanding N+1',
      'Accessing navigation properties in loops',
      'Not profiling query counts in dev',
      'Assuming EF Core prevents N+1 automatically',
      'Not using Include when iterating',
      'Not seeing the problem until production load'
    ]),
    jsonb_build_object(
      'csharp', '// ✗ N+1 PROBLEM (BAD)
var users = await _context.Users.ToListAsync(); // 1 query

foreach (var user in users) {
    var orderCount = user.Orders.Count; // N queries! (one per user)
    Console.WriteLine($"{user.Name}: {orderCount} orders");
}
// Total: 1 + N queries (if 100 users = 101 queries) ✗

// SQL executed:
// SELECT * FROM Users
// SELECT * FROM Orders WHERE UserId = 1
// SELECT * FROM Orders WHERE UserId = 2
// SELECT * FROM Orders WHERE UserId = 3
// ... (100 more times)

// ✓ FIX 1: INCLUDE (eager loading)
var users = await _context.Users
    .Include(u => u.Orders)  // Load all orders upfront
    .ToListAsync();

foreach (var user in users) {
    var orderCount = user.Orders.Count; // No query! Data already loaded
    Console.WriteLine($"{user.Name}: {orderCount} orders");
}
// Total: 2 queries (Users + Orders) ✓

// SQL executed:
// SELECT * FROM Users
// SELECT * FROM Orders WHERE UserId IN (1,2,3,...,100)

// ✓ FIX 2: PROJECTION
var userSummaries = await _context.Users
    .Select(u => new {
        u.Name,
        OrderCount = u.Orders.Count  // Computed in SQL
    })
    .ToListAsync();

foreach (var summary in userSummaries) {
    Console.WriteLine($"{summary.Name}: {summary.OrderCount} orders");
}
// Total: 1 query ✓

// SQL executed:
// SELECT u.Name, COUNT(o.Id) as OrderCount
// FROM Users u
// LEFT JOIN Orders o ON u.Id = o.UserId
// GROUP BY u.Name

// ✓ FIX 3: Disable lazy loading
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(connectionString)
           .UseLazyLoadingProxies(useLazyLoadingProxies: false) // ✓
);

// DETECTING N+1
_context.Database.Log = msg => Console.WriteLine(msg); // See all SQL

// or use logging
builder.Services.AddDbContext<AppDbContext>(options =>
    options.LogTo(Console.WriteLine, LogLevel.Information)
);',
      'typescript', '// TypeORM N+1 problem
// ✗ BAD
const users = await userRepository.find();
for (const user of users) {
    const orders = await orderRepository.find({ 
        where: { userId: user.id } 
    }); // N queries!
    console.log(`${user.name}: ${orders.length}`);
}

// ✓ GOOD - eager load
const users = await userRepository.find({
    relations: [''orders'']
});
for (const user of users) {
    console.log(`${user.name}: ${user.orders.length}`);
}
// 2 queries total

// ✓ GOOD - projection
const users = await userRepository
    .createQueryBuilder(''user'')
    .leftJoin(''user.orders'', ''order'')
    .select([''user.name''])
    .addSelect(''COUNT(order.id)'', ''orderCount'')
    .groupBy(''user.id'')
    .getRawMany();
// 1 query'
    ),
    'N+1 Problem:

BAD (N+1):
Query 1: SELECT * FROM Users
         → [User1, User2, User3]

Loop through users:
    user1.Orders → Query 2: SELECT * FROM Orders WHERE UserId=1
    user2.Orders → Query 3: SELECT * FROM Orders WHERE UserId=2
    user3.Orders → Query 4: SELECT * FROM Orders WHERE UserId=3
    ...

Total: 1 + N queries ✗

GOOD (Include):
Query 1: SELECT * FROM Users
Query 2: SELECT * FROM Orders WHERE UserId IN (1,2,3,...)

Total: 2 queries ✓

GOOD (Projection):
Query 1: SELECT u.Name, COUNT(o.Id)
         FROM Users u
         LEFT JOIN Orders o
         GROUP BY u.Id

Total: 1 query ✓

Detection:
→ Queries in loops
→ Enable SQL logging
→ Use profiler',
    102
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Completed Batch 4: Added 3 .NET & EF Core terms';
END $$;

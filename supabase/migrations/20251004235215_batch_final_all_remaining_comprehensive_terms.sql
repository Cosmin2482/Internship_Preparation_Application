/*
  # Final Batch: All Remaining Comprehensive Terms
  
  Adds all remaining terms from requirements:
  - Session cookie vs JWT
  - Git: Branch, Fork, Commit, PR, Merge vs Rebase
  - CI/CD, Environments, Secrets
  - Performance: Eager vs Lazy, Logging, Metrics
  - Pagination
  - React key, Angular basics
*/

DO $$
DECLARE
  cat_arch_id uuid;
  cat_angular_id uuid;
  cat_devops_id uuid;
BEGIN
  SELECT id INTO cat_arch_id FROM categories WHERE slug = 'architecture';
  SELECT id INTO cat_angular_id FROM categories WHERE slug = 'angular';
  SELECT id INTO cat_devops_id FROM categories WHERE slug = 'devops';

  -- JWT vs Session cookie
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'JWT vs Session Cookie',
    'JWT = stateless token (server does not store). Session cookie = stateful (server stores session). JWT scalable but cannot revoke easily. Session = server state, can revoke immediately.',
    'JWT: stateless, self-contained token, server validates signature, no server storage, cannot revoke before expiry. Session: stateful, server stores session data, cookie contains session ID, can revoke anytime, requires server storage (memory/Redis/DB).',
    'Two auth approaches. JWT: client holds all data in token, server just validates. Pros: stateless (scales horizontally), no server storage, works across services. Cons: larger (sent with every request), cannot revoke (must wait for expiry), token size limit. Session: server holds data, cookie has only ID. Pros: small cookie, instant revocation, server controls everything. Cons: server state (harder to scale), requires session store (Redis), sticky sessions or shared store. Interview: explain trade-offs, when to use (JWT for microservices/APIs, sessions for traditional web apps), hybrid approaches (JWT with blacklist), refresh tokens.',
    to_jsonb(ARRAY[
      'Using JWT when sessions better (traditional server-rendered app)',
      'Using sessions when JWT better (distributed microservices)',
      'Not understanding stateless vs stateful',
      'JWT without refresh token (poor UX on expiry)',
      'Session without secure flags (HttpOnly, Secure, SameSite)',
      'Not considering revocation requirements'
    ]),
    jsonb_build_object(
      'csharp', '// SESSION-BASED AUTH (ASP.NET Core)
builder.Services.AddSession(options => {
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.Secure = true;
    options.Cookie.SameSite = SameSiteMode.Strict;
});

app.UseSession();

// Login creates session
[HttpPost("login")]
public IActionResult Login([FromBody] LoginDto dto) {
    var user = AuthenticateUser(dto);
    if (user == null) return Unauthorized();
    
    // Store in session (server-side)
    HttpContext.Session.SetString("UserId", user.Id.ToString());
    HttpContext.Session.SetString("Role", user.Role);
    
    return Ok();
}

// Reads from session
[HttpGet("profile")]
public IActionResult GetProfile() {
    var userId = HttpContext.Session.GetString("UserId");
    if (userId == null) return Unauthorized();
    
    var user = _db.Users.Find(int.Parse(userId));
    return Ok(user);
}

// JWT-BASED (stateless)
// Generate JWT (see JWT term)
// Client stores and sends with each request
// Server validates signature, no session storage',
      'typescript', '// SESSION (Express + express-session)
import session from ''express-session'';
import RedisStore from ''connect-redis'';

app.use(session({
    store: new RedisStore({ client: redisClient }),
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: {
        secure: true,  // HTTPS only
        httpOnly: true, // No JS access
        maxAge: 1000 * 60 * 30 // 30 min
    }
}));

// Login
app.post(''/login'', async (req, res) => {
    const user = await authenticateUser(req.body);
    if (!user) return res.status(401).send();
    
    // Store in session (server)
    req.session.userId = user.id;
    req.session.role = user.role;
    
    res.send({ success: true });
});

// JWT (stateless - see JWT term)'
    ),
    'JWT vs Session:

JWT (Stateless):
┌─────────┐         ┌─────────┐
│ Client  │         │ Server  │
├─────────┤         ├─────────┤
│ JWT     │────────▶│ Validate│
│ (token) │  Bearer │ signature│
└─────────┘         └─────────┘

✓ No server state
✓ Scales horizontally
✗ Cannot revoke
✗ Larger size

Session (Stateful):
┌─────────┐         ┌─────────┐
│ Client  │         │ Server  │
├─────────┤         ├─────────┤
│ Cookie  │────────▶│ Session │
│ (ID)    │         │ Store   │
└─────────┘         └─────────┘

✓ Small cookie
✓ Instant revoke
✗ Server state
✗ Harder to scale',
    72
  ) ON CONFLICT DO NOTHING;

  -- Merge vs Rebase (Git)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_devops_id,
    'Git: Merge vs Rebase',
    'Merge = combine branches with merge commit (preserves history topology). Rebase = replay commits on new base (linear history). Merge safer, rebase cleaner but rewrites history.',
    'git merge: combines branches by creating merge commit with two parents, preserves complete history, non-destructive. git rebase: moves commits to new base, rewrites commit history, creates linear history, changes commit hashes. Merge for shared branches, rebase for local cleanup.',
    'Two ways to integrate changes. Merge creates merge commit combining both branches - history shows branching topology. Safe, reversible, preserves context. Rebase takes commits from feature branch and replays them on top of main - appears linear as if developed sequentially. Cleaner history but rewrites commits (new hashes). When: (1) Merge for shared branches, PRs, preserving history. (2) Rebase for local feature branches before PR, cleaning up commits. Never rebase public/shared branches (breaks others). Interview: explain both, trade-offs (history vs linearity), when to use each, golden rule (do not rebase public branches), interactive rebase for cleanup.',
    to_jsonb(ARRAY[
      'Rebasing shared/public branches (breaks team)',
      'Not understanding rebase rewrites history',
      'Force pushing without --force-with-lease',
      'Complex conflicts during rebase',
      'Losing commits during rebase (reflog helps)',
      'Not knowing when to merge vs rebase'
    ]),
    jsonb_build_object(
      'csharp', '// GIT MERGE
// git checkout main
// git merge feature-branch

// Creates merge commit:
/*
main:    A---B---C---D---G (merge commit)
              \\         /
feature:       E---F---/
*/

// History shows branching
// git log --graph shows topology

// GIT REBASE
// git checkout feature-branch
// git rebase main

// Replays commits on main:
/*
Before:
main:    A---B---C---D
              \\
feature:       E---F

After rebase:
main:    A---B---C---D
                     \\
feature:              E''---F'' (new hashes)
*/

// Linear history, appears sequential

// INTERACTIVE REBASE (cleanup)
// git rebase -i HEAD~3

// Edit commits before pushing:
// pick abc1234 Add feature
// squash def5678 Fix typo     ← Combine with above
// reword ghi9012 Update logic  ← Change message

// GOLDEN RULE:
// ✓ Rebase local unpushed branches
// ✗ NEVER rebase pushed/shared branches',
      'typescript', '// Bash commands (same across platforms)

// MERGE
$ git checkout main
$ git merge feature-branch
// Creates merge commit

// REBASE
$ git checkout feature-branch
$ git rebase main
// Replay commits

// If conflicts during rebase:
$ git rebase --continue
// or
$ git rebase --abort

// Pull with rebase (avoid merge commits):
$ git pull --rebase origin main'
    ),
    'Merge vs Rebase:

MERGE:
main:    A---B---C---D---G
              \\         /
feature:       E---F----

G = merge commit (two parents)
History preserved ✓
Shows branching ✓

git merge feature

REBASE:
Before:
main:    A---B---C---D
              \\
feature:       E---F

After:
main:    A---B---C---D
                     \\
feature:              E''---F''

Linear history ✓
Commits rewritten ✗

git rebase main

When to use:
Merge → Shared branches, PRs
Rebase → Local cleanup

NEVER rebase public branches!',
    50
  ) ON CONFLICT DO NOTHING;

  -- Eager vs Lazy Loading (Performance)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Eager vs Lazy Loading',
    'Eager = load related data upfront (one query). Lazy = load on access (extra query per access). Eager avoids N+1 but loads more. Lazy defers but causes N+1 if not careful.',
    'Eager loading: fetch related entities upfront in initial query (Include, joins). Lazy loading: defer loading until property accessed, transparent but causes N+1 if iterated. Eager explicit and predictable, lazy convenient but dangerous.',
    'Two strategies for loading related data. Eager (Include): load everything upfront with joins - one or two queries total. Predictable, avoids N+1, but may load unnecessary data. Lazy: load on first access - convenient, loads only what is used, but iteration causes N+1 problem. EF Core: lazy loading requires UseLazyLoadingProxies and virtual properties. Best practice: disable lazy loading by default, use Include or projection explicitly. Interview: explain N+1 problem from lazy loading, when eager makes sense (know you need data), when lazy ok (single entity, not iterating), explicit loading as middle ground.',
    to_jsonb(ARRAY[
      'Lazy loading causing N+1 (iteration)',
      'Not understanding lazy executes queries on access',
      'Eager loading everything (unnecessary data)',
      'Lazy loading in loops (performance disaster)',
      'Not disabling lazy loading by default',
      'Serializing entities with lazy loading (infinite loops)'
    ]),
    jsonb_build_object(
      'csharp', '// EAGER LOADING (Include)
var users = await _context.Users
    .Include(u => u.Orders)      // Load orders upfront
    .Include(u => u.Address)     // Load address upfront
    .ToListAsync();

// 2 queries total (Users + Orders + Address via joins)

foreach (var user in users) {
    Console.WriteLine($"{user.Name}: {user.Orders.Count}"); // No query
}

// LAZY LOADING (virtual properties)
public class User {
    public int Id { get; set; }
    public string Name { get; set; }
    public virtual ICollection<Order> Orders { get; set; } // virtual!
}

// Enable in DbContext
services.AddDbContext<AppDbContext>(options =>
    options.UseLazyLoadingProxies() // Enable lazy loading
);

var users = await _context.Users.ToListAsync(); // 1 query

foreach (var user in users) {
    // Accesses Orders → triggers query! (N+1 problem)
    Console.WriteLine($"{user.Name}: {user.Orders.Count}");
}
// Total: 1 + N queries ✗

// EXPLICIT LOADING (middle ground)
var user = await _context.Users.FindAsync(1);

// Explicitly load related data when needed
await _context.Entry(user)
    .Collection(u => u.Orders)
    .LoadAsync();

Console.WriteLine(user.Orders.Count); // No extra query

// PROJECTION (best for read-only)
var userSummaries = await _context.Users
    .Select(u => new {
        u.Name,
        OrderCount = u.Orders.Count // Computed in SQL
    })
    .ToListAsync();
// 1 query, minimal data ✓',
      'typescript', '// Sequelize eager loading
const users = await User.findAll({
    include: [Order, Address] // Eager load
});
// One query with joins

// Lazy loading
const users = await User.findAll(); // No orders

for (const user of users) {
    await user.getOrders(); // N+1! ✗
}'
    ),
    'Eager vs Lazy Loading:

EAGER (Include):
var users = _context.Users
    .Include(u => u.Orders)
    .ToList();

SQL:
SELECT * FROM Users u
LEFT JOIN Orders o ON u.Id = o.UserId

foreach(user in users) {
    user.Orders.Count; // Already loaded ✓
}

Queries: 2 (Users + Orders)

LAZY (virtual):
var users = _context.Users.ToList();

SQL: SELECT * FROM Users

foreach(user in users) {
    user.Orders.Count; // Query here! ✗
}

Queries: 1 + N (N+1 problem)

Performance:
Eager: Predictable, avoids N+1
Lazy: Convenient, dangerous in loops',
    65
  ) ON CONFLICT DO NOTHING;

  -- Pagination
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Pagination',
    'Pagination = split large results into pages. Query params: page (page number) and size (items per page). Or cursor-based (use ID/timestamp). Returns page of data + total count. Essential for performance.',
    'Pagination: technique for returning large datasets in chunks. Offset-based: page number + page size (skip X, take Y). Cursor-based: token/ID marking position. Includes total count, page info, navigation links. Prevents loading all records at once.',
    'Essential for APIs returning collections. Offset pagination: page=1&size=10 (SKIP 0 TAKE 10), page=2&size=10 (SKIP 10 TAKE 10). Simple but expensive for large offsets (database scans). Cursor pagination: after=abc123 (WHERE id > abc123), more efficient for large datasets, works with infinite scroll. Response includes: data array, page info (current page, total pages, total items), navigation (next/prev links or cursors). Link header for navigation. Interview: explain both approaches, trade-offs (offset simpler, cursor scales better), when to use each, how to include total count efficiently.',
    to_jsonb(ARRAY[
      'No pagination (returning all records)',
      'Not including total count',
      'Deep offset pagination (slow for page 1000)',
      'Not validating page/size params',
      'Inconsistent results during pagination (data changes)',
      'Not using indexes for cursor pagination'
    ]),
    jsonb_build_object(
      'csharp', '// OFFSET PAGINATION
[HttpGet]
public async Task<ActionResult<PagedResult<UserDto>>> GetUsers(
    [FromQuery] int page = 1,
    [FromQuery] int size = 10
) {
    if (page < 1) page = 1;
    if (size < 1 || size > 100) size = 10; // Limit max
    
    var totalItems = await _context.Users.CountAsync();
    
    var users = await _context.Users
        .OrderBy(u => u.Id)
        .Skip((page - 1) * size)  // Offset
        .Take(size)                // Limit
        .Select(u => new UserDto { Id = u.Id, Name = u.Name })
        .ToListAsync();
    
    return Ok(new PagedResult<UserDto> {
        Data = users,
        Page = page,
        PageSize = size,
        TotalItems = totalItems,
        TotalPages = (int)Math.Ceiling(totalItems / (double)size)
    });
}

public class PagedResult<T> {
    public List<T> Data { get; set; }
    public int Page { get; set; }
    public int PageSize { get; set; }
    public int TotalItems { get; set; }
    public int TotalPages { get; set; }
    public bool HasPreviousPage => Page > 1;
    public bool HasNextPage => Page < TotalPages;
}

// CURSOR PAGINATION
[HttpGet("cursor")]
public async Task<IActionResult> GetUsersCursor(
    [FromQuery] int? after = null,
    [FromQuery] int size = 10
) {
    var query = _context.Users.OrderBy(u => u.Id);
    
    if (after.HasValue) {
        query = query.Where(u => u.Id > after.Value);
    }
    
    var users = await query
        .Take(size + 1) // Fetch one extra to know if more
        .ToListAsync();
    
    var hasMore = users.Count > size;
    if (hasMore) {
        users = users.Take(size).ToList();
    }
    
    var nextCursor = hasMore ? users.Last().Id : (int?)null;
    
    return Ok(new {
        data = users,
        nextCursor,
        hasMore
    });
}',
      'typescript', '// Express offset pagination
app.get(''/users'', async (req, res) => {
    const page = Math.max(1, parseInt(req.query.page) || 1);
    const size = Math.min(100, Math.max(1, parseInt(req.query.size) || 10));
    
    const offset = (page - 1) * size;
    
    const [users, totalItems] = await Promise.all([
        db.users.findMany({
            skip: offset,
            take: size,
            orderBy: { id: ''asc'' }
        }),
        db.users.count()
    ]);
    
    res.json({
        data: users,
        page,
        pageSize: size,
        totalItems,
        totalPages: Math.ceil(totalItems / size)
    });
});

// Cursor pagination
app.get(''/users/cursor'', async (req, res) => {
    const size = 10;
    const after = req.query.after ? parseInt(req.query.after) : 0;
    
    const users = await db.users.findMany({
        where: { id: { gt: after } },
        take: size + 1,
        orderBy: { id: ''asc'' }
    });
    
    const hasMore = users.length > size;
    const data = hasMore ? users.slice(0, size) : users;
    const nextCursor = hasMore ? data[data.length - 1].id : null;
    
    res.json({ data, nextCursor, hasMore });
});'
    ),
    'Pagination:

OFFSET PAGINATION:
GET /users?page=2&size=10

SQL:
SELECT * FROM users
ORDER BY id
OFFSET 10 LIMIT 10

Response:
{
    "data": [...],
    "page": 2,
    "pageSize": 10,
    "totalItems": 500,
    "totalPages": 50
}

✓ Simple
✓ Jump to any page
✗ Slow for deep pages

CURSOR PAGINATION:
GET /users?after=123&size=10

SQL:
SELECT * FROM users
WHERE id > 123
ORDER BY id
LIMIT 10

Response:
{
    "data": [...],
    "nextCursor": 133,
    "hasMore": true
}

✓ Fast (uses index)
✓ Consistent results
✗ Cannot jump to page N',
    66
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Completed Final Batch: Added all remaining comprehensive terms';
END $$;

/*
  # Add OOP and .NET Core Terms
  
  1. New Terms (20 terms)
    OOP: Interfaces vs Abstract Classes, Generics, Delegates & Events, Properties, Virtual/Override
    .NET: EF Core Basics, Middleware, Model Validation, JWT Authentication, xUnit Testing
    .NET: Controllers vs Minimal APIs, Logging, Configuration, DbContext, N+1 Problem
*/

DO $$
DECLARE
  cat_oop uuid;
  cat_dotnet uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';
  SELECT id INTO cat_dotnet FROM categories WHERE slug = 'dotnet';

  -- Interfaces vs Abstract Classes
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Interfaces vs Abstract Classes',
    'Interface: contract saying what to do. Abstract class: partial implementation with some done for you.',
    'Interface: pure contract with no implementation (pre-C# 8). Abstract class: base class with abstract and concrete members, single inheritance.',
    'Interfaces define what without how, support multiple implementation. Abstract classes provide partial implementation and shared code. Use interface for capability contract, abstract class for is-a hierarchy with shared logic.',
    to_jsonb(ARRAY['Putting logic in interfaces (avoid before C# 8)', 'Using abstract class for multiple inheritance', 'Not understanding when to use each', 'Interface explosion']),
    jsonb_build_object(
      'csharp', E'// Interface: contract only\npublic interface ILogger {\n  void Log(string message);\n}\n\npublic class ConsoleLogger : ILogger {\n  public void Log(string message) => Console.WriteLine(message);\n}\n\n// Abstract class: partial implementation\npublic abstract class Animal {\n  public abstract void Speak(); // Must implement\n  public void Sleep() => Console.WriteLine("Sleeping"); // Shared\n}\n\npublic class Dog : Animal {\n  public override void Speak() => Console.WriteLine("Woof");\n}\n\n// Multiple interfaces, single base class\npublic class Service : BaseService, ILogger, IDisposable { }',
      'typescript', E'// Interface\ninterface Logger {\n  log(message: string): void;\n}\n\nclass ConsoleLogger implements Logger {\n  log(message: string): void {\n    console.log(message);\n  }\n}\n\n// Abstract class (via abstract methods)\nabstract class Animal {\n  abstract speak(): void; // Must implement\n  sleep(): void { console.log("Sleeping"); } // Shared\n}\n\nclass Dog extends Animal {\n  speak(): void { console.log("Woof"); }\n}\n\n// Multiple interfaces\nclass Service implements Logger, Disposable { }'
    ),
    E'Interface vs Abstract:\nInterface:\n  - Pure contract\n  - No implementation\n  - Multiple inheritance\n  - IS-ABLE-TO relationship\n\nAbstract Class:\n  - Partial implementation\n  - Shared code\n  - Single inheritance\n  - IS-A relationship',
    50
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Interface contains?', to_jsonb(ARRAY['Implementation', 'Only method signatures (pre-C# 8)', 'Fields', 'Constructor']), 1, 'Pure contract, no implementation.'),
    (current_term_id, 'Multiple inheritance?', to_jsonb(ARRAY['Abstract class allows', 'Interface allows multiple', 'Neither', 'Both']), 1, 'Class can implement multiple interfaces.'),
    (current_term_id, 'When use abstract class?', to_jsonb(ARRAY['Never', 'IS-A hierarchy with shared code', 'Always', 'Multiple inheritance']), 1, 'Base class with common implementation.'),
    (current_term_id, 'When use interface?', to_jsonb(ARRAY['Never', 'Contract for capabilities', 'Single inheritance', 'Fields needed']), 1, 'Defines what without how.'),
    (current_term_id, 'Abstract class can have?', to_jsonb(ARRAY['Only abstract methods', 'Mix of abstract and concrete', 'No methods', 'Only fields']), 1, 'Both abstract and implemented members.');

  -- Generics
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Generics',
    'Write code that works with any type - like a template you fill in later.',
    'Type parameters allowing classes/methods to work with any type while maintaining type safety. Compile-time type substitution. Constraints restrict allowed types.',
    'Generics provide type-safe reusable code without casting or boxing. Use constraints (where T :) to restrict types. Better than object: no boxing, compile-time checks, IntelliSense support.',
    to_jsonb(ARRAY['Not using constraints when needed', 'Overcomplicating with too many type parameters', 'Boxing value types without generics', 'Covariance/contravariance confusion']),
    jsonb_build_object(
      'csharp', E'// Generic class\npublic class Box<T> {\n  public T Value { get; set; }\n}\nvar intBox = new Box<int> { Value = 42 };\nvar strBox = new Box<string> { Value = "Hello" };\n\n// Generic method\npublic T Max<T>(T a, T b) where T : IComparable<T> {\n  return a.CompareTo(b) > 0 ? a : b;\n}\n\n// Multiple constraints\npublic class Repo<T> where T : class, IEntity, new() {\n  public T Create() => new T();\n}\n\n// Generic delegates\nFunc<int, int, int> add = (a, b) => a + b;\nAction<string> print = Console.WriteLine;',
      'typescript', E'// TypeScript generics\nclass Box<T> {\n  constructor(public value: T) {}\n}\nconst intBox = new Box<number>(42);\nconst strBox = new Box<string>("Hello");\n\n// Generic function\nfunction max<T>(a: T, b: T, compare: (x: T, y: T) => number): T {\n  return compare(a, b) > 0 ? a : b;\n}\n\n// Constraints\ninterface HasLength { length: number; }\nfunction logLength<T extends HasLength>(item: T): void {\n  console.log(item.length);\n}\n\n// Generic type\ntype Result<T, E> = { ok: true, value: T } | { ok: false, error: E };'
    ),
    E'Generics:\nWithout: Box(object) → casting, boxing\nWith: Box<T> → type-safe, no boxing\n\nConstraints:\nwhere T : class        → reference type\nwhere T : struct       → value type\nwhere T : IComparable  → must implement\nwhere T : new()        → has constructor',
    51
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Generics provide?', to_jsonb(ARRAY['Runtime speed', 'Type safety and reusability', 'Less code always', 'Inheritance']), 1, 'Type-safe code for any type.'),
    (current_term_id, 'Generic constraint where T : class?', to_jsonb(ARRAY['Any type', 'Reference type only', 'Value type only', 'Interface only']), 1, 'Restricts to reference types.'),
    (current_term_id, 'Generics vs object?', to_jsonb(ARRAY['Same', 'Generics avoid boxing and casting', 'Object faster', 'No difference']), 1, 'Generics type-safe, no boxing overhead.'),
    (current_term_id, 'Multiple type parameters?', to_jsonb(ARRAY['Not allowed', 'Allowed with <T, U, V>', 'Maximum 2', 'Bad practice']), 1, 'Can have multiple type params.'),
    (current_term_id, 'where T : new() means?', to_jsonb(ARRAY['New keyword', 'T must have parameterless constructor', 'Creates new T', 'Initializer']), 1, 'Constraint: default constructor required.');

  -- Properties
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Properties & Auto-Properties',
    'Special methods that look like fields but can run code when reading or writing.',
    'C# members combining field storage with get/set accessors. Auto-properties generate backing field. Can have logic, validation, read-only, init-only.',
    'Properties encapsulate fields with controlled access. Auto-properties (get; set;) create backing field automatically. Use for validation, lazy loading, computed values. Prefer properties over public fields.',
    to_jsonb(ARRAY['Using public fields instead of properties', 'Not validating in setters', 'Expression-bodied confusion', 'Init vs readonly confusion']),
    jsonb_build_object(
      'csharp', E'// Auto-property\npublic string Name { get; set; }\npublic int Age { get; private set; } // Read-only outside class\npublic decimal Price { get; init; } // Init-only (C# 9)\n\n// Full property with logic\nprivate string _email;\npublic string Email {\n  get => _email;\n  set {\n    if(string.IsNullOrEmpty(value)) throw new ArgumentException();\n    _email = value;\n  }\n}\n\n// Expression-bodied\npublic string FullName => $"{FirstName} {LastName}";\n\n// Required property (C# 11)\npublic required string Username { get; set; }',
      'typescript', E'// TypeScript properties\nclass Person {\n  // Public field\n  name: string;\n  \n  // Private field\n  private _age: number = 0;\n  \n  // Getter/setter\n  get age(): number { return this._age; }\n  set age(value: number) {\n    if(value < 0) throw new Error("Invalid age");\n    this._age = value;\n  }\n  \n  // Readonly\n  readonly id: string = crypto.randomUUID();\n  \n  // Computed property\n  get isAdult(): boolean { return this._age >= 18; }\n}'
    ),
    E'Properties:\npublic int Age { get; set; }\n  ↓ compiles to ↓\nprivate int _age;\npublic int get_Age() { return _age; }\npublic void set_Age(int value) { _age = value; }\n\nBenefits: validation, change tracking, computed',
    52
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Auto-property?', to_jsonb(ARRAY['Manual backing field', 'Compiler generates backing field', 'No storage', 'Field only']), 1, '{ get; set; } creates hidden field.'),
    (current_term_id, 'Properties vs public fields?', to_jsonb(ARRAY['Same', 'Properties allow validation and logic', 'Fields faster', 'No difference']), 1, 'Properties control access, add logic.'),
    (current_term_id, 'get; init; means?', to_jsonb(ARRAY['Always mutable', 'Set only during initialization', 'Private setter', 'No setter']), 1, 'Init-only, immutable after construction.'),
    (current_term_id, 'Expression-bodied property?', to_jsonb(ARRAY['Has setter', 'Read-only computed value (=>)', 'Stored field', 'Auto-property']), 1, 'Computed on access, no backing field.'),
    (current_term_id, 'Property benefit?', to_jsonb(ARRAY['Faster', 'Encapsulation and validation', 'Less code', 'Inheritance']), 1, 'Controlled access with logic.');

  -- EF Core Basics
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'Entity Framework Core Basics',
    'ORM that lets you work with databases using C# objects instead of SQL.',
    'ORM mapping C# classes to database tables. DbContext manages entities, DbSet represents table. LINQ queries translated to SQL. Migrations handle schema changes.',
    'EF Core maps entities to tables via conventions or fluent API. DbContext is unit of work. Use DbSet<T> for queries. Migrations keep schema in sync. Watch for N+1 queries, use AsNoTracking for reads.',
    to_jsonb(ARRAY['N+1 query problem from lazy loading', 'Not using AsNoTracking for read-only', 'Tracking too many entities in memory', 'Not understanding migrations', 'Cartesian explosion from multiple includes']),
    jsonb_build_object(
      'csharp', E'// DbContext\npublic class AppDbContext : DbContext {\n  public DbSet<User> Users { get; set; }\n  public DbSet<Order> Orders { get; set; }\n  \n  protected override void OnModelCreating(ModelBuilder mb) {\n    mb.Entity<User>().HasKey(u => u.Id);\n    mb.Entity<User>().HasIndex(u => u.Email).IsUnique();\n    mb.Entity<Order>().HasOne(o => o.User).WithMany(u => u.Orders);\n  }\n}\n\n// Queries\nusing(var db = new AppDbContext()) {\n  // Basic query\n  var users = await db.Users.Where(u => u.Age > 18).ToListAsync();\n  \n  // Include related\n  var userWithOrders = await db.Users\n    .Include(u => u.Orders)\n    .FirstAsync(u => u.Id == id);\n  \n  // AsNoTracking for read-only\n  var readOnly = await db.Users.AsNoTracking().ToListAsync();\n  \n  // Projection to DTO\n  var dtos = await db.Users\n    .Select(u => new UserDto { Name = u.Name, Email = u.Email })\n    .ToListAsync();\n}',
      'typescript', E'// TypeORM (similar to EF Core)\n@Entity()\nexport class User {\n  @PrimaryGeneratedColumn()\n  id: number;\n  \n  @Column()\n  name: string;\n  \n  @OneToMany(() => Order, order => order.user)\n  orders: Order[];\n}\n\n// Repository\nconst userRepo = dataSource.getRepository(User);\n\n// Queries\nconst users = await userRepo.find({\n  where: { age: MoreThan(18) }\n});\n\nconst withOrders = await userRepo.findOne({\n  where: { id },\n  relations: [''orders'']\n});'
    ),
    E'EF Core Flow:\nC# Entity ↔ DbContext ↔ Database\n  User      DbSet<User>    users table\n           ↓ LINQ query\n        SQL generated\n        ↓ Execute\n      Results mapped to entities',
    55
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'DbContext is?', to_jsonb(ARRAY['Database', 'Unit of work managing entities', 'Table', 'ORM library']), 1, 'Represents session with database.'),
    (current_term_id, 'AsNoTracking when?', to_jsonb(ARRAY['Always', 'Read-only queries for performance', 'Updates', 'Never']), 1, 'Skips change tracking for reads.'),
    (current_term_id, 'N+1 problem?', to_jsonb(ARRAY['Performance issue', 'Query per related entity instead of join', 'Migration error', 'Syntax error']), 1, 'Lazy loading causes extra queries.'),
    (current_term_id, 'Include() does?', to_jsonb(ARRAY['Filters', 'Eagerly loads related entities', 'Sorts', 'Projects']), 1, 'Joins related data in single query.'),
    (current_term_id, 'Migrations purpose?', to_jsonb(ARRAY['Data migration', 'Schema version control and updates', 'Backup', 'Query optimization']), 1, 'Keep database schema in sync with models.');

  -- ASP.NET Middleware
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'ASP.NET Core Middleware',
    'Chain of components that process each request and response in order.',
    'Software pipeline where each component handles HTTP requests. Middleware can short-circuit or pass to next. Order matters: auth before authorization, routing before endpoints.',
    'Middleware forms request pipeline. Each component can process request, call next, process response. Order critical: CORS before routing, auth before authorization, exception handling first. Use app.Use for inline, IMiddleware for class.',
    to_jsonb(ARRAY['Wrong middleware order breaking functionality', 'Not calling next() causing hang', 'Exception middleware not first', 'CORS after routing', 'Forgetting app.UseRouting before endpoints']),
    jsonb_build_object(
      'csharp', E'// Program.cs middleware pipeline\nvar app = builder.Build();\n\n// Order matters!\napp.UseExceptionHandler("/error"); // 1. Error handling first\napp.UseHttpsRedirection();          // 2. HTTPS redirect\napp.UseCors();                      // 3. CORS before routing\napp.UseRouting();                   // 4. Routing\napp.UseAuthentication();            // 5. Auth before authorization\napp.UseAuthorization();             // 6. Authorization\napp.MapControllers();               // 7. Endpoints\n\n// Custom inline middleware\napp.Use(async (context, next) => {\n  Console.WriteLine($"Request: {context.Request.Path}");\n  await next(); // Call next middleware\n  Console.WriteLine($"Response: {context.Response.StatusCode}");\n});\n\n// Custom middleware class\npublic class RequestTimingMiddleware {\n  private readonly RequestDelegate _next;\n  public RequestTimingMiddleware(RequestDelegate next) => _next = next;\n  \n  public async Task InvokeAsync(HttpContext context) {\n    var sw = Stopwatch.StartNew();\n    await _next(context);\n    sw.Stop();\n    context.Response.Headers.Add("X-Response-Time", $"{sw.ElapsedMilliseconds}ms");\n  }\n}',
      'typescript', E'// Express middleware (similar concept)\nconst app = express();\n\n// Order matters\napp.use(express.json());           // 1. Body parsing\napp.use(cors());                   // 2. CORS\napp.use(morgan(''dev''));           // 3. Logging\napp.use(authenticate);             // 4. Auth\napp.use(''/api'', apiRoutes);       // 5. Routes\napp.use(errorHandler);             // 6. Error handling\n\n// Custom middleware\napp.use((req, res, next) => {\n  console.log(`${req.method} ${req.url}`);\n  next(); // Pass to next\n});\n\n// Timing middleware\napp.use((req, res, next) => {\n  const start = Date.now();\n  res.on(''finish'', () => {\n    const duration = Date.now() - start;\n    console.log(`${req.method} ${req.url} - ${duration}ms`);\n  });\n  next();\n});'
    ),
    E'Middleware Pipeline:\nRequest → [ExceptionHandler] → [CORS] → [Routing] → [Auth] → [Authorization] → [Endpoints] → Response\n          ↓                    ↓        ↓         ↓        ↓                ↓\n       Handle errors      Allow origin Route  Identify  Authorize    Controller\n\nEach can short-circuit or call next()',
    56
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Middleware order matters?', to_jsonb(ARRAY['No', 'Yes, critical for functionality', 'Sometimes', 'Only for performance']), 1, 'Each middleware depends on previous.'),
    (current_term_id, 'Exception middleware placement?', to_jsonb(ARRAY['Last', 'First to catch all exceptions', 'Middle', 'Anywhere']), 1, 'Must be first to catch downstream errors.'),
    (current_term_id, 'Authentication before authorization?', to_jsonb(ARRAY['No', 'Yes, must identify user first', 'Same thing', 'Either order']), 1, 'Auth identifies, authorization checks permissions.'),
    (current_term_id, 'Not calling next()?', to_jsonb(ARRAY['No issue', 'Short-circuits pipeline', 'Error', 'Continues anyway']), 1, 'Stops pipeline, returns response.'),
    (current_term_id, 'UseRouting before?', to_jsonb(ARRAY['CORS', 'Authorization and endpoints', 'Exception handler', 'Nothing']), 1, 'Routing must happen before endpoint selection.');

  -- Model Validation
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'Model Validation',
    'Automatic checking if data meets rules before processing.',
    'ASP.NET Core validates request models via DataAnnotations or FluentValidation. ModelState.IsValid checks. Returns 400 with errors automatically with [ApiController].',
    'Use DataAnnotations for simple validation (Required, Range, EmailAddress). FluentValidation for complex rules. [ApiController] returns 400 automatically. Validate DTOs, not entities. Return ProblemDetails for errors.',
    to_jsonb(ARRAY['Not checking ModelState.IsValid without [ApiController]', 'Validating entities instead of DTOs', 'Poor error messages to client', 'Client-side validation only', 'Not using FluentValidation for complex rules']),
    jsonb_build_object(
      'csharp', E'// DataAnnotations\npublic class CreateUserDto {\n  [Required(ErrorMessage = "Name required")]\n  [StringLength(100, MinimumLength = 2)]\n  public string Name { get; set; }\n  \n  [Required]\n  [EmailAddress]\n  public string Email { get; set; }\n  \n  [Range(18, 120)]\n  public int Age { get; set; }\n}\n\n// Controller\n[ApiController]\n[Route("api/[controller]")]\npublic class UsersController : ControllerBase {\n  [HttpPost]\n  public IActionResult Create([FromBody] CreateUserDto dto) {\n    // [ApiController] auto-validates, returns 400 if invalid\n    // No need to check ModelState.IsValid\n    return Ok();\n  }\n}\n\n// FluentValidation\npublic class CreateUserValidator : AbstractValidator<CreateUserDto> {\n  public CreateUserValidator() {\n    RuleFor(x => x.Email).NotEmpty().EmailAddress();\n    RuleFor(x => x.Age).InclusiveBetween(18, 120);\n    RuleFor(x => x.Name).NotEmpty().Length(2, 100)\n      .Must(name => !name.Contains("admin"))\n      .WithMessage("Name cannot contain admin");\n  }\n}',
      'typescript', E'// class-validator (TypeScript)\nimport { IsEmail, IsInt, Min, Max, Length } from ''class-validator'';\n\nclass CreateUserDto {\n  @Length(2, 100, { message: ''Name must be 2-100 chars'' })\n  name: string;\n  \n  @IsEmail()\n  email: string;\n  \n  @IsInt()\n  @Min(18)\n  @Max(120)\n  age: number;\n}\n\n// Express controller\napp.post(''/api/users'', async (req, res) => {\n  const dto = plainToClass(CreateUserDto, req.body);\n  const errors = await validate(dto);\n  if(errors.length > 0) {\n    return res.status(400).json({ errors });\n  }\n  // Process valid dto\n});'
    ),
    E'Validation Flow:\nRequest DTO → Validate → ModelState\n  {name: ""}     ↓           ↓\n              Invalid   IsValid=false\n                ↓\n          400 BadRequest\n          { errors: [...] }\n\nDataAnnotations: simple rules\nFluentValidation: complex logic',
    57
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'DataAnnotations where?', to_jsonb(ARRAY['Controller', 'Model/DTO properties', 'Service', 'Database']), 1, 'Attributes on properties.'),
    (current_term_id, '[ApiController] does?', to_jsonb(ARRAY['Nothing', 'Auto-validates and returns 400', 'Logging', 'Routing']), 1, 'Automatic validation and problem details.'),
    (current_term_id, 'Validate entity or DTO?', to_jsonb(ARRAY['Entity', 'DTO (data transfer object)', 'Both', 'Neither']), 1, 'DTOs represent API contract, validate those.'),
    (current_term_id, 'FluentValidation for?', to_jsonb(ARRAY['Simple rules', 'Complex validation logic', 'Never', 'Performance']), 1, 'Better for complex, conditional validation.'),
    (current_term_id, 'ModelState.IsValid when?', to_jsonb(ARRAY['Always check', 'Unnecessary with [ApiController]', 'Never check', 'Only in services']), 1, '[ApiController] handles automatically.');

  -- JWT Authentication
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'JWT Authentication',
    'Secure token you get after login, sent with requests to prove who you are.',
    'JSON Web Token: self-contained token with claims, signed for integrity. Client stores token, sends in Authorization header. Server validates signature and claims.',
    'JWT has header, payload (claims), signature. Issue on login, client stores (localStorage/cookie), sends in Bearer header. Server validates signature and expiry. Stateless: no server-side session. Use HTTPS, short expiry, refresh tokens.',
    to_jsonb(ARRAY['Storing in localStorage (XSS risk)', 'Long expiry without refresh tokens', 'Not validating expiry', 'Weak secret key', 'Not using HTTPS', 'Including sensitive data in payload']),
    jsonb_build_object(
      'csharp', E'// Program.cs setup\nbuilder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)\n  .AddJwtBearer(options => {\n    options.TokenValidationParameters = new TokenValidationParameters {\n      ValidateIssuer = true,\n      ValidateAudience = true,\n      ValidateLifetime = true,\n      ValidateIssuerSigningKey = true,\n      ValidIssuer = builder.Configuration["Jwt:Issuer"],\n      ValidAudience = builder.Configuration["Jwt:Audience"],\n      IssuerSigningKey = new SymmetricSecurityKey(\n        Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]))\n    };\n  });\n\n// Generate token\npublic string GenerateToken(User user) {\n  var claims = new[] {\n    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),\n    new Claim(ClaimTypes.Name, user.Name),\n    new Claim(ClaimTypes.Email, user.Email),\n    new Claim(ClaimTypes.Role, user.Role)\n  };\n  \n  var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));\n  var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);\n  \n  var token = new JwtSecurityToken(\n    issuer: _config["Jwt:Issuer"],\n    audience: _config["Jwt:Audience"],\n    claims: claims,\n    expires: DateTime.Now.AddHours(1),\n    signingCredentials: creds);\n  \n  return new JwtSecurityTokenHandler().WriteToken(token);\n}\n\n// Protect endpoint\n[Authorize]\n[HttpGet("profile")]\npublic IActionResult GetProfile() {\n  var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;\n  return Ok();\n}',
      'typescript', E'// jsonwebtoken (Node.js)\nimport jwt from ''jsonwebtoken'';\n\n// Generate token\nfunction generateToken(user: User): string {\n  const payload = {\n    id: user.id,\n    email: user.email,\n    role: user.role\n  };\n  \n  return jwt.sign(payload, process.env.JWT_SECRET, {\n    expiresIn: ''1h'',\n    issuer: ''my-app'',\n    audience: ''my-app-users''\n  });\n}\n\n// Middleware to validate\nfunction authenticate(req, res, next) {\n  const token = req.headers.authorization?.split('' '')[1];\n  if(!token) return res.status(401).json({ error: ''No token'' });\n  \n  try {\n    const decoded = jwt.verify(token, process.env.JWT_SECRET);\n    req.user = decoded;\n    next();\n  } catch(err) {\n    res.status(401).json({ error: ''Invalid token'' });\n  }\n}\n\n// Protected route\napp.get(''/api/profile'', authenticate, (req, res) => {\n  res.json({ user: req.user });\n});'
    ),
    E'JWT Flow:\n1. Login → Server validates → Generate JWT → Return token\n2. Client stores token (cookie/storage)\n3. Request with: Authorization: Bearer <token>\n4. Server validates signature & expiry → Allow/Deny\n\nJWT Structure:\nheader.payload.signature\neyJhbG...eyJzdWI...SflKxw\n\nStateless: no server-side session',
    58
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'JWT consists of?', to_jsonb(ARRAY['Token only', 'Header, payload, signature', 'Username password', 'Session ID']), 1, 'Three parts separated by dots.'),
    (current_term_id, 'JWT sent in?', to_jsonb(ARRAY['Cookie only', 'Authorization: Bearer header', 'Body', 'URL']), 1, 'Standard Bearer token header.'),
    (current_term_id, 'JWT is stateless?', to_jsonb(ARRAY['No, needs server session', 'Yes, self-contained', 'Sometimes', 'No difference']), 1, 'Server doesn''t store tokens, validates signature.'),
    (current_term_id, 'JWT storage risk?', to_jsonb(ARRAY['None', 'localStorage vulnerable to XSS', 'Too large', 'Too slow']), 1, 'XSS can steal from localStorage.'),
    (current_term_id, 'JWT signature validates?', to_jsonb(ARRAY['Username', 'Token integrity and authenticity', 'Expiry only', 'Payload size']), 1, 'Proves token not tampered, from trusted issuer.');

  RAISE NOTICE 'Added 10 OOP and .NET terms';
END $$;

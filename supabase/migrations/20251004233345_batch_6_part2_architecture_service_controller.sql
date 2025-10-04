/*
  # Batch 6 Part 2: Architecture - Service, Controller, APIs
  
  Adds: Service layer, Controller/Endpoint, Minimal API vs MVC, Problem Details
*/

DO $$
DECLARE
  cat_arch_id uuid;
BEGIN
  SELECT id INTO cat_arch_id FROM categories WHERE slug = 'architecture';

  -- Service Layer
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Service (Application Layer)',
    'Service layer = orchestrates use cases and business logic. Sits between controllers and repositories. Example: UserService.RegisterUser checks email uniqueness, hashes password, calls repository. Controllers stay thin.',
    'Service layer (Application layer): orchestrates business workflows, coordinates between domain and infrastructure, implements use cases, handles transactions. Controllers delegate to services, services use repositories. Keeps controllers thin, domain logic separate from infrastructure.',
    'Service layer contains application logic and use case orchestration. Controller receives HTTP request, calls service method, service executes business flow using repositories/domain entities, returns result. Example: RegisterUser service method: (1) Validate input. (2) Check email uniqueness via repository. (3) Hash password. (4) Create user entity. (5) Save via repository. (6) Return user. Benefits: (1) Testable business logic. (2) Reusable across controllers/endpoints. (3) Transaction boundaries. (4) Thin controllers (just HTTP concerns). Interview: explain layering (Controller → Service → Repository), where validation goes (both controller for HTTP, service for business rules), why not put logic in controller.',
    to_jsonb(ARRAY[
      'Fat controllers with business logic',
      'Services directly accessing DbContext (skip repository)',
      'Services knowing about HTTP (Request/Response objects)',
      'No service layer (logic in controllers)',
      'Services calling other services excessively (coupling)',
      'Anemic services (just pass-through to repository)'
    ]),
    jsonb_build_object(
      'csharp', '// SERVICE LAYER
public class UserService {
    private readonly IUserRepository _userRepo;
    private readonly IEmailService _emailService;
    private readonly IPasswordHasher _hasher;
    
    public UserService(
        IUserRepository userRepo,
        IEmailService emailService,
        IPasswordHasher hasher
    ) {
        _userRepo = userRepo;
        _emailService = emailService;
        _hasher = hasher;
    }
    
    // USE CASE: Register new user
    public async Task<UserDto> RegisterUserAsync(CreateUserDto dto) {
        // Business rule: email must be unique
        var existing = await _userRepo.GetByEmailAsync(dto.Email);
        if (existing != null)
            throw new BusinessException("Email already registered");
        
        // Business logic: hash password
        var passwordHash = _hasher.Hash(dto.Password);
        
        // Create domain entity
        var user = new User {
            Name = dto.Name,
            Email = dto.Email,
            PasswordHash = passwordHash,
            CreatedAt = DateTime.UtcNow
        };
        
        // Save (transaction)
        await _userRepo.AddAsync(user);
        
        // Side effect: send welcome email
        await _emailService.SendWelcomeEmail(user.Email, user.Name);
        
        // Map to DTO
        return new UserDto {
            Id = user.Id,
            Name = user.Name,
            Email = user.Email
        };
    }
    
    // USE CASE: Get user profile
    public async Task<UserDto> GetUserProfileAsync(int userId) {
        var user = await _userRepo.GetByIdAsync(userId);
        if (user == null)
            throw new NotFoundException("User not found");
        
        return new UserDto {
            Id = user.Id,
            Name = user.Name,
            Email = user.Email
        };
    }
}

// CONTROLLER (thin - just HTTP concerns)
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase {
    private readonly UserService _service;
    
    public UsersController(UserService service) {
        _service = service;
    }
    
    [HttpPost("register")]
    public async Task<ActionResult<UserDto>> Register([FromBody] CreateUserDto dto) {
        // Validation (HTTP-level)
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        try {
            // Delegate to service
            var user = await _service.RegisterUserAsync(dto);
            return CreatedAtAction(nameof(GetProfile), new { id = user.Id }, user);
        }
        catch (BusinessException ex) {
            return Conflict(ex.Message);
        }
    }
    
    [HttpGet("{id}")]
    public async Task<ActionResult<UserDto>> GetProfile(int id) {
        try {
            var user = await _service.GetUserProfileAsync(id);
            return Ok(user);
        }
        catch (NotFoundException) {
            return NotFound();
        }
    }
}',
      'typescript', '// Service layer
class UserService {
    constructor(
        private userRepo: IUserRepository,
        private emailService: IEmailService,
        private hasher: IPasswordHasher
    ) {}
    
    async registerUser(dto: CreateUserDto): Promise<UserDto> {
        // Business rules
        const existing = await this.userRepo.getByEmail(dto.email);
        if (existing) {
            throw new BusinessError(''Email already registered'');
        }
        
        // Business logic
        const passwordHash = await this.hasher.hash(dto.password);
        
        const user = await this.userRepo.add({
            name: dto.name,
            email: dto.email,
            passwordHash,
            createdAt: new Date()
        });
        
        // Side effects
        await this.emailService.sendWelcome(user.email, user.name);
        
        return {
            id: user.id,
            name: user.name,
            email: user.email
        };
    }
}

// Controller (thin)
app.post(''/api/users/register'', async (req, res) => {
    try {
        const user = await userService.registerUser(req.body);
        res.status(201).json(user);
    } catch (err) {
        if (err instanceof BusinessError) {
            res.status(409).json({ error: err.message });
        } else {
            res.status(500).json({ error: ''Server error'' });
        }
    }
});'
    ),
    'Layered Architecture:

┌─────────────────────┐
│ CONTROLLER          │ ← HTTP concerns
│ (Presentation)      │   Routing, validation
├─────────────────────┤   Status codes
│ Receives request    │
│ Validates input     │
│ Calls service       │
│ Returns response    │
└─────────────────────┘
         ↓ delegates
┌─────────────────────┐
│ SERVICE             │ ← Business logic
│ (Application)       │   Use cases
├─────────────────────┤   Orchestration
│ Business rules      │
│ Transactions        │
│ Calls repositories  │
│ Orchestrates flow   │
└─────────────────────┘
         ↓ uses
┌─────────────────────┐
│ REPOSITORY          │ ← Data access
│ (Infrastructure)    │   Queries
├─────────────────────┤
│ GetById, Add, etc   │
│ Encapsulates queries│
│ Uses DbContext      │
└─────────────────────┘
         ↓
┌─────────────────────┐
│ DATABASE            │
└─────────────────────┘

Responsibilities:
Controller → HTTP I/O
Service → Business logic
Repository → Data access',
    63
  ) ON CONFLICT DO NOTHING;

  -- Minimal API vs MVC Controllers
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Minimal API vs MVC Controllers',
    'Minimal API = lightweight, map routes directly (app.MapGet). MVC Controllers = attribute-based routing, model binding, filters, conventions. Minimal for microservices, MVC for larger apps.',
    'Minimal APIs: ASP.NET Core 6+ feature for defining HTTP endpoints with minimal ceremony, using route mapping without controllers. MVC Controllers: class-based, attribute routing, built-in features (model binding, validation, filters, conventions). Choose based on app complexity.',
    'Two approaches for building APIs. Minimal API: simple, functional style - app.MapGet("/users/{id}", async (int id, DbContext db) => ...). Pros: less boilerplate, faster startup, great for microservices. Cons: less structure, no built-in filters/conventions. MVC Controllers: attribute-based, class per resource - [HttpGet("{id}")] public IActionResult Get(int id). Pros: rich ecosystem (filters, model binding, validation), good for large apps, testable. Cons: more boilerplate. Interview: explain both, when to use (Minimal for small APIs/microservices, MVC for complex apps with many endpoints), migration path, OpenAPI/Swagger support in both.',
    to_jsonb(ARRAY[
      'Using Minimal API for large complex apps',
      'Not understanding middleware order in Minimal APIs',
      'Missing validation in Minimal APIs (no [FromBody] attributes)',
      'Converting MVC to Minimal without considering trade-offs',
      'Not using filters in MVC (repeating cross-cutting code)',
      'Choosing based on hype rather than requirements'
    ]),
    jsonb_build_object(
      'csharp', '// MINIMAL API (ASP.NET Core 6+)
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<AppDbContext>();

var app = builder.Build();

// Direct route mapping
app.MapGet("/users/{id}", async (int id, AppDbContext db) => {
    var user = await db.Users.FindAsync(id);
    return user is not null ? Results.Ok(user) : Results.NotFound();
});

app.MapPost("/users", async (CreateUserDto dto, AppDbContext db) => {
    var user = new User { Name = dto.Name, Email = dto.Email };
    db.Users.Add(user);
    await db.SaveChangesAsync();
    return Results.Created($"/users/{user.Id}", user);
});

app.MapPut("/users/{id}", async (int id, UpdateUserDto dto, AppDbContext db) => {
    var user = await db.Users.FindAsync(id);
    if (user is null) return Results.NotFound();
    
    user.Name = dto.Name;
    await db.SaveChangesAsync();
    return Results.NoContent();
});

app.MapDelete("/users/{id}", async (int id, AppDbContext db) => {
    var user = await db.Users.FindAsync(id);
    if (user is null) return Results.NotFound();
    
    db.Users.Remove(user);
    await db.SaveChangesAsync();
    return Results.NoContent();
});

app.Run();

// MVC CONTROLLER (traditional)
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase {
    private readonly AppDbContext _db;
    
    public UsersController(AppDbContext db) {
        _db = db;
    }
    
    [HttpGet("{id}")]
    public async Task<ActionResult<User>> Get(int id) {
        var user = await _db.Users.FindAsync(id);
        if (user == null)
            return NotFound();
        return Ok(user);
    }
    
    [HttpPost]
    public async Task<ActionResult<User>> Create([FromBody] CreateUserDto dto) {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var user = new User { Name = dto.Name, Email = dto.Email };
        _db.Users.Add(user);
        await _db.SaveChangesAsync();
        return CreatedAtAction(nameof(Get), new { id = user.Id }, user);
    }
    
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] UpdateUserDto dto) {
        var user = await _db.Users.FindAsync(id);
        if (user == null)
            return NotFound();
        
        user.Name = dto.Name;
        await _db.SaveChangesAsync();
        return NoContent();
    }
    
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id) {
        var user = await _db.Users.FindAsync(id);
        if (user == null)
            return NotFound();
        
        _db.Users.Remove(user);
        await _db.SaveChangesAsync();
        return NoContent();
    }
}

// MINIMAL API WITH GROUPING
var users = app.MapGroup("/api/users");

users.MapGet("/{id}", GetUser);
users.MapPost("/", CreateUser);
users.MapPut("/{id}", UpdateUser);
users.MapDelete("/{id}", DeleteUser);

static async Task<IResult> GetUser(int id, AppDbContext db) {
    var user = await db.Users.FindAsync(id);
    return user is not null ? Results.Ok(user) : Results.NotFound();
}',
      'typescript', '// Express.js (similar to Minimal API style)
const app = express();

// Direct route handlers
app.get(''/users/:id'', async (req, res) => {
    const user = await db.users.findById(req.params.id);
    if (!user) return res.status(404).json({ error: ''Not found'' });
    res.json(user);
});

app.post(''/users'', async (req, res) => {
    const user = await db.users.create(req.body);
    res.status(201).json(user);
});

// Class-based (similar to MVC Controllers)
class UsersController {
    async get(req: Request, res: Response) {
        const user = await db.users.findById(req.params.id);
        if (!user) return res.status(404).json({ error: ''Not found'' });
        res.json(user);
    }
    
    async create(req: Request, res: Response) {
        const user = await db.users.create(req.body);
        res.status(201).json(user);
    }
}

const controller = new UsersController();
app.get(''/users/:id'', controller.get.bind(controller));
app.post(''/users'', controller.create.bind(controller));'
    ),
    'Minimal API vs MVC Controllers:

MINIMAL API:
var app = WebApplication.CreateBuilder(args).Build();

app.MapGet("/users/{id}", async (int id) => {
    // Handler inline
});

✓ Less boilerplate
✓ Faster startup
✓ Great for microservices
✗ No built-in filters
✗ Less structure

MVC CONTROLLER:
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase {
    [HttpGet("{id}")]
    public IActionResult Get(int id) {
        // Method per endpoint
    }
}

✓ Structured (class-based)
✓ Built-in features (filters, validation)
✓ Rich conventions
✓ Better for large apps
✗ More boilerplate

When to use:
Minimal → Small APIs, microservices
MVC → Large apps, many endpoints',
    64
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Completed Batch 6: Added 5 Architecture terms';
END $$;

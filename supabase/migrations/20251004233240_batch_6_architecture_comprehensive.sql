/*
  # Batch 6: Architecture Comprehensive Terms
  
  Adds missing Architecture terms:
  - Client-Server
  - Layered Architecture
  - DTO vs Entity vs ViewModel
  - Repository pattern
  - Service layer
  - Controller/Endpoint
  - Minimal API vs MVC Controllers
  - Problem Details
*/

DO $$
DECLARE
  cat_arch_id uuid;
BEGIN
  SELECT id INTO cat_arch_id FROM categories WHERE slug = 'architecture';

  -- Client-Server
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Client-Server',
    'Client-Server = two parts. Client (browser, app) requests data. Server processes and responds. Client displays result. Separation of concerns: UI vs business logic.',
    'Client-Server architecture: distributed computing model where clients (user-facing applications) request services from servers (backend systems). Client handles presentation, server handles business logic and data. Communication via network protocols (HTTP, WebSocket). Separation enables scalability, security, maintainability.',
    'Fundamental architecture for web apps. Client is the user interface (browser, mobile app) that initiates requests. Server is the backend that processes requests, applies business rules, accesses database, and returns responses. Benefits: (1) Centralized business logic and data. (2) Multiple client types can use same server. (3) Security enforced server-side. (4) Easier to scale servers independently. (5) Updates to business logic do not require client updates. Common pattern: React/Angular client → ASP.NET Core API server → SQL database. Interview: explain responsibilities of each, why separation matters, stateless vs stateful servers.',
    to_jsonb(ARRAY[
      'Putting business logic in client (insecure, duplicated)',
      'Not validating on server (trusting client)',
      'Tight coupling between client and server',
      'Server maintaining client-specific state (scalability issues)',
      'Not using DTOs for API contracts',
      'Confusing client-side validation with security'
    ]),
    jsonb_build_object(
      'csharp', '// SERVER (ASP.NET Core API)
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase {
    private readonly IUserService _service;
    
    public UsersController(IUserService service) {
        _service = service;
    }
    
    [HttpGet("{id}")]
    public async Task<IActionResult> GetUser(int id) {
        // Server: business logic, validation, data access
        var user = await _service.GetUserAsync(id);
        
        if (user == null)
            return NotFound();
        
        return Ok(new UserDto {
            Id = user.Id,
            Name = user.Name,
            Email = user.Email
        });
    }
    
    [HttpPost]
    public async Task<IActionResult> CreateUser([FromBody] CreateUserDto dto) {
        // Server: validation, business rules
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var user = await _service.CreateUserAsync(dto);
        return CreatedAtAction(nameof(GetUser), new { id = user.Id }, user);
    }
}

// CLIENT (React/TypeScript)
async function fetchUser(id: number): Promise<User> {
    // Client: initiates request
    const response = await fetch(`/api/users/${id}`, {
        headers: { ''Accept'': ''application/json'' }
    });
    
    if (!response.ok) {
        throw new Error(''Failed to fetch user'');
    }
    
    return await response.json();
}

// CLIENT: displays data
function UserProfile({ userId }: Props) {
    const [user, setUser] = useState<User | null>(null);
    
    useEffect(() => {
        fetchUser(userId).then(setUser);
    }, [userId]);
    
    return <div>{user?.name}</div>;
}',
      'typescript', '// Node.js SERVER (Express)
app.get(''/api/users/:id'', async (req, res) => {
    // Server: business logic
    const user = await userService.getUser(req.params.id);
    
    if (!user) {
        return res.status(404).json({ error: ''User not found'' });
    }
    
    res.json({
        id: user.id,
        name: user.name,
        email: user.email
    });
});

// CLIENT (browser JavaScript)
async function fetchUser(id) {
    const response = await fetch(`/api/users/${id}`);
    const user = await response.json();
    document.getElementById(''userName'').textContent = user.name;
}'
    ),
    'Client-Server Architecture:

┌──────────────┐       ┌──────────────┐
│   CLIENT     │       │   SERVER     │
├──────────────┤       ├──────────────┤
│ UI/Presentation │ HTTP │ Business Logic│
│ React/Angular│◄─────►│ API/Services │
│ User Input   │       │ Validation   │
│ Display Data │       │ Data Access  │
└──────────────┘       └──────────────┘
                              ↓
                       ┌──────────────┐
                       │   DATABASE   │
                       └──────────────┘

REQUEST FLOW:
1. User clicks button (Client)
2. Client → HTTP GET /api/users/1
3. Server receives request
4. Server queries database
5. Server applies business logic
6. Server → HTTP 200 + JSON data
7. Client receives response
8. Client updates UI

Responsibilities:
CLIENT: UI, display, user interaction
SERVER: validation, logic, data, security',
    60
  ) ON CONFLICT DO NOTHING;

  -- DTO vs Entity vs ViewModel
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'DTO vs Entity vs ViewModel',
    'Entity = database model (User table). DTO = data transfer object crossing boundaries (API request/response). ViewModel = UI-specific shape (form data). Keep them separate for clean architecture.',
    'Entity: domain model mapped to database tables, contains business logic, tracked by ORM. DTO (Data Transfer Object): simple data carrier for crossing boundaries (API, services), no business logic, often flattened. ViewModel: UI-specific data structure, may combine multiple entities, includes presentation logic. Separation prevents tight coupling.',
    'Three distinct types with different purposes. Entity is your domain model: class User maps to users table, has relationships (Orders), business methods. Lives in domain/data layer. DTO is for data transfer: API request CreateUserDto, API response UserDto. Simple, no logic, optimized for network. Lives at API boundary. ViewModel is for UI: combines data for specific view, may include computed properties, validation attributes. Lives in presentation. Why separate? (1) Entities expose internal structure. (2) DTOs optimize for API contracts. (3) ViewModels match UI needs. (4) Changes to one do not break others. Interview: explain each role, why not reuse Entity everywhere (tight coupling, over-fetching, security).',
    to_jsonb(ARRAY[
      'Using Entities directly in API responses (exposes DB structure)',
      'Not using DTOs (tight coupling to database)',
      'Returning entities with navigation properties (circular references, over-fetching)',
      'No mapping between Entity and DTO (manual code)',
      'ViewModel in business layer (wrong layer)',
      'Confusing DTO with Entity'
    ]),
    jsonb_build_object(
      'csharp', '// ENTITY (Domain/Database layer)
public class User {
    public int Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public string PasswordHash { get; set; }  // Should NOT be in DTO!
    public DateTime CreatedAt { get; set; }
    
    // Navigation properties
    public ICollection<Order> Orders { get; set; }
    public Address Address { get; set; }
    
    // Business logic
    public void UpdateEmail(string newEmail) {
        // Validation logic
        Email = newEmail;
    }
}

// DTO (API layer - request)
public class CreateUserDto {
    [Required]
    public string Name { get; set; }
    
    [EmailAddress]
    public string Email { get; set; }
    
    [MinLength(8)]
    public string Password { get; set; }
    
    // No PasswordHash, no Orders, no business logic
}

// DTO (API layer - response)
public class UserDto {
    public int Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public int OrderCount { get; set; }  // Computed
    
    // No PasswordHash, no navigation properties
}

// VIEWMODEL (UI layer - MVC Razor)
public class UserProfileViewModel {
    public string Name { get; set; }
    public string Email { get; set; }
    public List<OrderSummary> RecentOrders { get; set; }
    public string WelcomeMessage => $"Hello, {Name}!";  // UI logic
    
    [Display(Name = "Email Address")]
    public string EmailDisplay { get; set; }
}

// MAPPING (Controller)
[HttpGet("{id}")]
public async Task<ActionResult<UserDto>> GetUser(int id) {
    var entity = await _context.Users
        .Include(u => u.Orders)
        .FirstOrDefaultAsync(u => u.Id == id);
    
    if (entity == null)
        return NotFound();
    
    // Map Entity → DTO
    var dto = new UserDto {
        Id = entity.Id,
        Name = entity.Name,
        Email = entity.Email,
        OrderCount = entity.Orders.Count
    };
    
    return Ok(dto);
}

// Using AutoMapper
var dto = _mapper.Map<UserDto>(entity);',
      'typescript', '// ENTITY (database/domain)
interface User {
    id: number;
    name: string;
    email: string;
    passwordHash: string;  // Internal only
    createdAt: Date;
    orders?: Order[];
}

// DTO (API contract)
interface CreateUserDto {
    name: string;
    email: string;
    password: string;
}

interface UserDto {
    id: number;
    name: string;
    email: string;
    orderCount: number;
}

// VIEWMODEL (UI)
interface UserProfileViewModel {
    name: string;
    email: string;
    recentOrders: OrderSummary[];
    welcomeMessage: string;  // Computed
}

// Mapping
function toDto(entity: User): UserDto {
    return {
        id: entity.id,
        name: entity.name,
        email: entity.email,
        orderCount: entity.orders?.length ?? 0
    };
}'
    ),
    'Entity vs DTO vs ViewModel:

ENTITY (Domain/DB):
┌─────────────────────┐
│ User                │
├─────────────────────┤
│ Id                  │
│ Name                │
│ Email               │
│ PasswordHash        │ ← Internal
│ CreatedAt           │
│ Orders: Order[]     │ ← Navigation
├─────────────────────┤
│ UpdateEmail()       │ ← Business logic
└─────────────────────┘
Lives: Data layer

DTO (Transfer):
┌─────────────────────┐
│ UserDto             │
├─────────────────────┤
│ Id                  │
│ Name                │
│ Email               │
│ OrderCount          │ ← Computed
└─────────────────────┘
No PasswordHash ✓
No navigation props ✓
No business logic ✓
Lives: API boundary

VIEWMODEL (UI):
┌─────────────────────┐
│ UserProfileViewModel│
├─────────────────────┤
│ Name                │
│ Email               │
│ RecentOrders        │
│ WelcomeMessage      │ ← Display logic
└─────────────────────┘
Lives: Presentation

Flow:
Database → Entity → DTO → Client
         (mapping)  (JSON)',
    61
  ) ON CONFLICT DO NOTHING;

  -- Repository Pattern
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Repository',
    'Repository = abstraction over data access. Instead of DbContext everywhere, use IUserRepository with methods (GetById, Save). Benefits: testable, swappable data source, encapsulates queries.',
    'Repository pattern: abstraction separating business logic from data access logic. Provides collection-like interface for domain entities. Encapsulates query logic, enables testability via interfaces, allows switching data sources. Generic vs specific repositories.',
    'Repository abstracts data access so business logic does not depend on EF Core or SQL. Define IUserRepository interface with methods like GetById, GetAll, Add, Delete. Implementation uses DbContext but service layer only sees interface. Benefits: (1) Testable - mock repository in unit tests. (2) Encapsulation - query logic hidden. (3) Swappable - change database without affecting services. (4) Single Responsibility - repository handles data, service handles logic. Debate: some say EF Core DbSet already is repository pattern (Unit of Work). Interview: explain pattern, benefits, when to skip (simple CRUD, EF already abstracts DB), generic repository vs specific.',
    to_jsonb(ARRAY[
      'Overusing repositories (wrapping everything unnecessarily)',
      'Generic repository hiding domain-specific queries',
      'Not understanding EF Core already provides abstraction',
      'Leaking IQueryable from repository (breaks abstraction)',
      'Repository with hundreds of methods (too generic)',
      'Using repository pattern just because without benefit'
    ]),
    jsonb_build_object(
      'csharp', '// REPOSITORY INTERFACE
public interface IUserRepository {
    Task<User> GetByIdAsync(int id);
    Task<User> GetByEmailAsync(string email);
    Task<IEnumerable<User>> GetAllAsync();
    Task<User> AddAsync(User user);
    Task UpdateAsync(User user);
    Task DeleteAsync(int id);
}

// REPOSITORY IMPLEMENTATION
public class UserRepository : IUserRepository {
    private readonly AppDbContext _context;
    
    public UserRepository(AppDbContext context) {
        _context = context;
    }
    
    public async Task<User> GetByIdAsync(int id) {
        return await _context.Users
            .Include(u => u.Orders)
            .FirstOrDefaultAsync(u => u.Id == id);
    }
    
    public async Task<User> GetByEmailAsync(string email) {
        return await _context.Users
            .FirstOrDefaultAsync(u => u.Email == email);
    }
    
    public async Task<IEnumerable<User>> GetAllAsync() {
        return await _context.Users.ToListAsync();
    }
    
    public async Task<User> AddAsync(User user) {
        _context.Users.Add(user);
        await _context.SaveChangesAsync();
        return user;
    }
    
    public async Task UpdateAsync(User user) {
        _context.Users.Update(user);
        await _context.SaveChangesAsync();
    }
    
    public async Task DeleteAsync(int id) {
        var user = await GetByIdAsync(id);
        if (user != null) {
            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
        }
    }
}

// SERVICE USING REPOSITORY
public class UserService {
    private readonly IUserRepository _repository;
    
    public UserService(IUserRepository repository) {
        _repository = repository;  // Interface, not concrete
    }
    
    public async Task<User> GetUserAsync(int id) {
        return await _repository.GetByIdAsync(id);
    }
    
    public async Task<User> RegisterUserAsync(string name, string email) {
        // Check if exists
        var existing = await _repository.GetByEmailAsync(email);
        if (existing != null)
            throw new InvalidOperationException("Email already exists");
        
        var user = new User { Name = name, Email = email };
        return await _repository.AddAsync(user);
    }
}

// DEPENDENCY INJECTION
services.AddScoped<IUserRepository, UserRepository>();
services.AddScoped<UserService>();

// TESTING WITH MOCK
[Fact]
public async Task RegisterUser_UniqueEmail_CreatesUser() {
    var mockRepo = new Mock<IUserRepository>();
    mockRepo.Setup(r => r.GetByEmailAsync(It.IsAny<string>()))
            .ReturnsAsync((User)null);  // No existing user
    
    var service = new UserService(mockRepo.Object);
    var user = await service.RegisterUserAsync("John", "john@example.com");
    
    Assert.NotNull(user);
    mockRepo.Verify(r => r.AddAsync(It.IsAny<User>()), Times.Once);
}',
      'typescript', '// Repository interface
interface IUserRepository {
    getById(id: number): Promise<User | null>;
    getByEmail(email: string): Promise<User | null>;
    getAll(): Promise<User[]>;
    add(user: User): Promise<User>;
    update(user: User): Promise<void>;
    delete(id: number): Promise<void>;
}

// Implementation
class UserRepository implements IUserRepository {
    constructor(private db: Database) {}
    
    async getById(id: number): Promise<User | null> {
        return await this.db.users.findOne({ id });
    }
    
    async add(user: User): Promise<User> {
        return await this.db.users.insert(user);
    }
    
    // ... other methods
}

// Service using repository
class UserService {
    constructor(private repo: IUserRepository) {}
    
    async registerUser(name: string, email: string): Promise<User> {
        const existing = await this.repo.getByEmail(email);
        if (existing) {
            throw new Error(''Email exists'');
        }
        return await this.repo.add({ name, email });
    }
}'
    ),
    'Repository Pattern:

WITHOUT Repository:
┌─────────────┐
│ UserService │
├─────────────┤
│ _context    │ ← Direct DbContext dependency
└─────────────┘
    ↓ query
┌─────────────┐
│  DbContext  │
└─────────────┘

WITH Repository:
┌─────────────┐
│ UserService │
├─────────────┤
│ _repository │ ← Interface IUserRepository
└─────────────┘
    ↓ interface
┌──────────────────┐
│ IUserRepository  │ ← Abstraction
├──────────────────┤
│ GetById()        │
│ GetByEmail()     │
│ Add()            │
└──────────────────┘
    ↑ implements
┌──────────────────┐
│ UserRepository   │ ← Implementation
├──────────────────┤
│ _context         │
└──────────────────┘
    ↓ uses
┌─────────────┐
│  DbContext  │
└─────────────┘

Benefits:
✓ Testable (mock interface)
✓ Encapsulates queries
✓ Swappable implementation
✓ Single Responsibility',
    62
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Added Batch 6 part 1: Architecture terms (3 so far)';
END $$;

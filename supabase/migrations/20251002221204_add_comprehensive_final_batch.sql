/*
  # Comprehensive Final Batch - All Remaining Core Terms
  
  1. New Terms (~35 terms)
    SQL: Normalization, ACID, Transactions, Views, N+1 Problem
    TypeScript: Types, Generics, Utility Types, Async/Await
    Angular: Components, Lifecycle, HttpClient, Forms, Testing
    Architecture: Clean Architecture, Repository Pattern, REST, DTO
    DevOps: Git Workflow, Deployment Strategies
    AI/ML: Overfitting, Metrics, Prompt Engineering
    HR: STAR Method, Scrum
*/

DO $$
DECLARE
  cat_sql uuid;
  cat_angular uuid;
  cat_arch uuid;
  cat_devops uuid;
  cat_ai uuid;
  cat_hr uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_sql FROM categories WHERE slug = 'sql';
  SELECT id INTO cat_angular FROM categories WHERE slug = 'angular';
  SELECT id INTO cat_arch FROM categories WHERE slug = 'architecture';
  SELECT id INTO cat_devops FROM categories WHERE slug = 'devops';
  SELECT id INTO cat_ai FROM categories WHERE slug = 'ai-ml';
  SELECT id INTO cat_hr FROM categories WHERE slug = 'hr';

  -- SQL Normalization
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_sql, 'Database Normalization',
    'Organize data to reduce duplication and avoid update problems.',
    'Process of structuring database to minimize redundancy. 1NF: atomic values. 2NF: no partial dependencies. 3NF: no transitive dependencies.',
    'Normalization eliminates data redundancy via decomposition. 1NF: each column atomic. 2NF: every non-key column depends on whole primary key. 3NF: no column depends on another non-key column. Trade-off: more joins, better integrity.',
    to_jsonb(ARRAY['Over-normalizing causing too many joins', 'Under-normalizing causing update anomalies', 'Not understanding when to denormalize', 'Foreign key relationship confusion']),
    jsonb_build_object(
      'csharp', E'// Unnormalized (bad)\npublic class Order {\n  public int Id { get; set; }\n  public string CustomerName { get; set; }\n  public string CustomerEmail { get; set; } // Duplicated per order\n  public string Items { get; set; } // Comma-separated (violates 1NF)\n}\n\n// Normalized (good)\npublic class Customer {\n  public int Id { get; set; }\n  public string Name { get; set; }\n  public string Email { get; set; }\n  public List<Order> Orders { get; set; }\n}\n\npublic class Order {\n  public int Id { get; set; }\n  public int CustomerId { get; set; } // FK\n  public Customer Customer { get; set; }\n  public List<OrderItem> Items { get; set; } // Separate table\n}',
      'typescript', E'-- Unnormalized (bad)\nCREATE TABLE orders (\n  id INT PRIMARY KEY,\n  customer_name VARCHAR(100),\n  customer_email VARCHAR(100), -- Repeated\n  items TEXT -- Comma-separated (violates 1NF)\n);\n\n-- Normalized (good)\nCREATE TABLE customers (\n  id INT PRIMARY KEY,\n  name VARCHAR(100),\n  email VARCHAR(100) UNIQUE\n);\n\nCREATE TABLE orders (\n  id INT PRIMARY KEY,\n  customer_id INT REFERENCES customers(id),\n  order_date DATE\n);\n\nCREATE TABLE order_items (\n  id INT PRIMARY KEY,\n  order_id INT REFERENCES orders(id),\n  product_id INT,\n  quantity INT\n);'
    ),
    E'Normalization:\n1NF: Atomic values (no lists in column)\n2NF: No partial dependencies on composite key\n3NF: No transitive dependencies (non-key → non-key)\n\nBenefits: less redundancy, update anomalies\nCost: more joins',
    60
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, '1NF requires?', to_jsonb(ARRAY['Foreign keys', 'Atomic values in columns', 'No nulls', 'Indexes']), 1, 'Each column holds single value, not lists.'),
    (current_term_id, '3NF eliminates?', to_jsonb(ARRAY['Joins', 'Transitive dependencies', 'All redundancy', 'Foreign keys']), 1, 'Non-key column can''t depend on another non-key.'),
    (current_term_id, 'Normalization trade-off?', to_jsonb(ARRAY['No downside', 'More joins but better integrity', 'Always faster', 'Simpler queries']), 1, 'Decomposition requires joins to reassemble.'),
    (current_term_id, 'When denormalize?', to_jsonb(ARRAY['Never', 'Read-heavy queries needing performance', 'Always', 'Only for reporting']), 1, 'Trade integrity for query performance.'),
    (current_term_id, 'Update anomaly?', to_jsonb(ARRAY['Syntax error', 'Duplicated data causing inconsistency', 'Slow update', 'Lock']), 1, 'Redundant data can become inconsistent.');

  -- ACID
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_sql, 'ACID Transactions',
    'Database guarantees: all-or-nothing, consistent, isolated, permanent.',
    'Atomicity: all-or-nothing. Consistency: valid state. Isolation: concurrent transactions don''t interfere. Durability: committed changes persist.',
    'ACID ensures reliable transactions. Atomicity: transaction succeeds completely or rolls back. Consistency: maintains invariants. Isolation: prevents dirty reads. Durability: committed data survives crashes. Essential for financial systems.',
    to_jsonb(ARRAY['Not using transactions for multi-step operations', 'Isolation level too strict causing deadlocks', 'Long-running transactions blocking others', 'Not handling rollback properly']),
    jsonb_build_object(
      'csharp', E'// EF Core transaction\nusing(var transaction = await context.Database.BeginTransactionAsync()) {\n  try {\n    // Multiple operations\n    var user = await context.Users.FindAsync(userId);\n    user.Balance -= amount;\n    \n    var recipient = await context.Users.FindAsync(recipientId);\n    recipient.Balance += amount;\n    \n    await context.SaveChangesAsync();\n    await transaction.CommitAsync(); // Atomicity: all succeed\n  }\n  catch {\n    await transaction.RollbackAsync(); // All-or-nothing\n    throw;\n  }\n}',
      'typescript', E'-- SQL transaction\nBEGIN TRANSACTION;\n\n-- Transfer money\nUPDATE accounts SET balance = balance - 100 WHERE id = 1;\nUPDATE accounts SET balance = balance + 100 WHERE id = 2;\n\n-- Atomicity: both updates or neither\nCOMMIT; -- Success: changes permanent (Durability)\n-- ROLLBACK; -- Failure: no changes\n\n-- Isolation levels\nSET TRANSACTION ISOLATION LEVEL READ COMMITTED;\nBEGIN TRANSACTION;\n-- Prevents dirty reads\nSELECT * FROM accounts WHERE id = 1;\nCOMMIT;'
    ),
    E'ACID:\nAtomicity:    All-or-nothing\nConsistency:  Valid state always\nIsolation:    Concurrent txns independent\nDurability:   Committed data persists\n\nExample: Bank transfer\n  Debit A: -$100\n  Credit B: +$100\n  ↓\nBoth succeed or both fail',
    61
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Atomicity means?', to_jsonb(ARRAY['Fast', 'All-or-nothing execution', 'Isolated', 'Consistent']), 1, 'Transaction succeeds completely or rolls back.'),
    (current_term_id, 'Durability ensures?', to_jsonb(ARRAY['Speed', 'Fast commits', 'Committed data survives crashes', 'Isolation']), 2, 'Changes persist even after system failure.'),
    (current_term_id, 'Isolation prevents?', to_jsonb(ARRAY['Crashes', 'Dirty reads and race conditions', 'Rollbacks', 'Atomicity']), 1, 'Concurrent transactions don''t interfere.'),
    (current_term_id, 'When use transactions?', to_jsonb(ARRAY['Single query', 'Multiple related operations needing atomicity', 'Read-only', 'Never']), 1, 'Group operations that must succeed/fail together.'),
    (current_term_id, 'Consistency means?', to_jsonb(ARRAY['Same data everywhere', 'Database maintains valid state and constraints', 'Fast', 'Isolated']), 1, 'Invariants and constraints always satisfied.');

  -- TypeScript Types
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'TypeScript Types & Interfaces',
    'Define the shape of your data so TypeScript catches mistakes early.',
    'Type system providing compile-time type checking. Interfaces define object shapes. Type aliases for unions, primitives. Types vs interfaces: types more flexible, interfaces extend better.',
    'TypeScript adds static types to JavaScript. Use interfaces for object contracts, type aliases for unions/primitives. Types catch errors at compile-time. Prefer interfaces for public API, types for complex unions.',
    to_jsonb(ARRAY['Using any too much', 'Not understanding type vs interface', 'Forgetting union types need type guards', 'Overcomplicating with complex types']),
    jsonb_build_object(
      'csharp', E'// C# equivalent\npublic interface IUser {\n  int Id { get; }\n  string Name { get; }\n}\n\npublic class User : IUser {\n  public int Id { get; set; }\n  public string Name { get; set; }\n}\n\n// Union type (discriminated union via inheritance)\npublic abstract class Result { }\npublic class Success : Result { public string Data { get; set; } }\npublic class Error : Result { public string Message { get; set; } }',
      'typescript', E'// Interface\ninterface User {\n  id: number;\n  name: string;\n  email?: string; // Optional\n  readonly created: Date; // Readonly\n}\n\n// Type alias\ntype UserId = number;\ntype Status = ''pending'' | ''active'' | ''inactive''; // Union\ntype Result<T> = { ok: true; data: T } | { ok: false; error: string };\n\n// Interface vs Type\ninterface Person { name: string; }\ninterface Employee extends Person { employeeId: number; }\n\ntype Point = { x: number; y: number };\ntype Point3D = Point & { z: number }; // Intersection\n\n// Type guards\nfunction isUser(obj: any): obj is User {\n  return obj && typeof obj.id === ''number'';\n}\n\nif(isUser(data)) {\n  console.log(data.name); // TypeScript knows it''s User\n}'
    ),
    E'TypeScript Types:\nInterface: object shape contract\nType: flexible aliases, unions\n\ntype Status = ''A'' | ''B'' | ''C'';\ninterface User { id: number; name: string; }\n\nType guards: runtime checks\nif(typeof x === ''string'') { }\nif(''prop'' in obj) { }',
    65
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Interface defines?', to_jsonb(ARRAY['Implementation', 'Object shape/contract', 'Function body', 'Variables']), 1, 'Describes structure of object.'),
    (current_term_id, 'Type vs Interface?', to_jsonb(ARRAY['Same', 'Types more flexible, interfaces extend better', 'Types slower', 'No difference']), 1, 'Both define shapes, slight differences.'),
    (current_term_id, 'Union type?', to_jsonb(ARRAY['Intersection', 'Value can be one of multiple types (A | B)', 'Both types', 'Neither']), 1, 'One type OR another.'),
    (current_term_id, 'Type guard purpose?', to_jsonb(ARRAY['Performance', 'Narrow type at runtime for safety', 'Validation', 'Security']), 1, 'Runtime check to narrow TypeScript type.'),
    (current_term_id, 'any type?', to_jsonb(ARRAY['Best practice', 'Avoid: disables type checking', 'Required', 'Fast']), 1, 'Escape hatch, loses type safety.');

  -- Angular Components
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'Angular Components',
    'Building blocks of UI - each component has template, styles, and logic.',
    'Component: @Component decorator with template (HTML), styles (CSS), and class (TypeScript). Encapsulates view and behavior. Lifecycle hooks for component phases.',
    'Components are core Angular building blocks. @Component decorator defines selector, template, styles. Class has properties and methods. Input() for data in, Output() for events out. OnInit for initialization, OnDestroy for cleanup.',
    to_jsonb(ARRAY['Not unsubscribing causing memory leaks', 'Mutating @Input() directly', 'Heavy logic in constructor vs ngOnInit', 'Not using OnPush change detection', 'Forgetting to import/declare component']),
    jsonb_build_object(
      'csharp', E'// Blazor equivalent (C# component)\n@page "/counter"\n@code {\n  private int count = 0;\n  \n  [Parameter]\n  public string Title { get; set; } = "Counter";\n  \n  [Parameter]\n  public EventCallback<int> OnCountChanged { get; set; }\n  \n  protected override void OnInitialized() {\n    // Lifecycle hook\n  }\n  \n  private async Task IncrementCount() {\n    count++;\n    await OnCountChanged.InvokeAsync(count);\n  }\n}\n\n<h3>@Title</h3>\n<p>Count: @count</p>\n<button @onclick="IncrementCount">Click</button>',
      'typescript', E'// Angular Component\n@Component({\n  selector: ''app-user-card'',\n  template: `\n    <div class="card">\n      <h3>{{ user.name }}</h3>\n      <p>{{ user.email }}</p>\n      <button (click)="onEdit()">Edit</button>\n    </div>\n  `,\n  styles: [`\n    .card { border: 1px solid #ccc; padding: 1rem; }\n  `]\n})\nexport class UserCardComponent implements OnInit, OnDestroy {\n  @Input() user!: User; // Data in from parent\n  @Output() edit = new EventEmitter<User>(); // Event out to parent\n  \n  private subscription: Subscription;\n  \n  constructor(private userService: UserService) { }\n  \n  ngOnInit(): void {\n    // Initialization logic\n    this.subscription = this.userService.data$.subscribe(...);\n  }\n  \n  ngOnDestroy(): void {\n    // Cleanup: unsubscribe\n    this.subscription?.unsubscribe();\n  }\n  \n  onEdit(): void {\n    this.edit.emit(this.user);\n  }\n}'
    ),
    E'Angular Component:\n@Component decorator\n  ↓\nTemplate (HTML)\nStyles (CSS)\nClass (TypeScript)\n  ↓\n@Input: data in\n@Output: events out\n  ↓\nLifecycle: Init → Changes → Destroy',
    66
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, '@Component decorator defines?', to_jsonb(ARRAY['Logic only', 'Selector, template, styles, metadata', 'Routes', 'Services']), 1, 'Component configuration.'),
    (current_term_id, '@Input() is for?', to_jsonb(ARRAY['Events out', 'Data from parent component', 'Services', 'Routing']), 1, 'Parent passes data to child.'),
    (current_term_id, '@Output() is for?', to_jsonb(ARRAY['Data in', 'Events to parent via EventEmitter', 'Input binding', 'Services']), 1, 'Child emits events to parent.'),
    (current_term_id, 'ngOnInit purpose?', to_jsonb(ARRAY['Constructor', 'Component initialization after inputs set', 'Destroy', 'Rendering']), 1, 'Lifecycle hook for setup after input binding.'),
    (current_term_id, 'ngOnDestroy for?', to_jsonb(ARRAY['Initialization', 'Cleanup: unsubscribe, clear timers', 'Rendering', 'Events']), 1, 'Prevent memory leaks, clean resources.');

  -- Angular Forms
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'Angular Reactive Forms',
    'Build forms with code, track value changes, validate dynamically.',
    'Reactive forms: model-driven approach using FormControl, FormGroup, FormBuilder. Explicit, immutable model. Validators, valueChanges observable.',
    'Reactive forms provide programmatic control. FormControl tracks single input. FormGroup groups controls. FormBuilder simplifies creation. Use Validators for sync validation, async validators for server checks. Subscribe to valueChanges for reactive updates.',
    to_jsonb(ARRAY['Not unsubscribing from valueChanges', 'Mutating form values directly', 'Missing validation', 'Not using FormBuilder', 'Template-driven vs reactive confusion']),
    jsonb_build_object(
      'csharp', E'// C# model validation (similar concept)\npublic class RegisterModel {\n  [Required]\n  [EmailAddress]\n  public string Email { get; set; }\n  \n  [Required]\n  [MinLength(8)]\n  public string Password { get; set; }\n}\n\n// Controller\npublic IActionResult Register(RegisterModel model) {\n  if(!ModelState.IsValid) {\n    return BadRequest(ModelState);\n  }\n  // Process\n}',
      'typescript', E'// Angular Reactive Form\nexport class RegisterComponent implements OnInit {\n  registerForm: FormGroup;\n  \n  constructor(private fb: FormBuilder) { }\n  \n  ngOnInit(): void {\n    this.registerForm = this.fb.group({\n      email: ['''', [Validators.required, Validators.email]],\n      password: ['''', [Validators.required, Validators.minLength(8)]],\n      confirmPassword: ['''']\n    }, { validators: this.passwordMatchValidator });\n    \n    // React to changes\n    this.registerForm.get(''email'')?.valueChanges.subscribe(value => {\n      console.log(''Email changed:'', value);\n    });\n  }\n  \n  passwordMatchValidator(group: FormGroup): ValidationErrors | null {\n    const pwd = group.get(''password'')?.value;\n    const confirm = group.get(''confirmPassword'')?.value;\n    return pwd === confirm ? null : { mismatch: true };\n  }\n  \n  onSubmit(): void {\n    if(this.registerForm.valid) {\n      console.log(this.registerForm.value);\n    }\n  }\n}\n\n// Template\n<form [formGroup]="registerForm" (ngSubmit)="onSubmit()">\n  <input formControlName="email" placeholder="Email">\n  <div *ngIf="registerForm.get(''email'')?.invalid && registerForm.get(''email'')?.touched">\n    Email is required and must be valid\n  </div>\n  <button [disabled]="registerForm.invalid">Submit</button>\n</form>'
    ),
    E'Reactive Forms:\nFormBuilder → FormGroup → FormControls\n     ↓            ↓           ↓\n  Helper    Container    Single input\n     ↓\nValidators: sync/async\nvalueChanges: Observable\n  ↓\nReactive programming',
    67
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'FormControl represents?', to_jsonb(ARRAY['Entire form', 'Single input field', 'Group', 'Validator']), 1, 'Tracks value and state of input.'),
    (current_term_id, 'FormGroup contains?', to_jsonb(ARRAY['Single control', 'Multiple FormControls', 'Validators only', 'Templates']), 1, 'Groups related controls.'),
    (current_term_id, 'FormBuilder purpose?', to_jsonb(ARRAY['Validation', 'Simplifies FormGroup creation', 'Submits form', 'Templates']), 1, 'Factory for creating forms.'),
    (current_term_id, 'valueChanges returns?', to_jsonb(ARRAY['Value', 'Observable of value changes', 'Promise', 'FormControl']), 1, 'Observable stream of changes.'),
    (current_term_id, 'Reactive vs template-driven?', to_jsonb(ARRAY['Same', 'Reactive: code-based, template-driven: HTML-based', 'Template faster', 'No difference']), 1, 'Reactive more control, template simpler.');

  -- Clean Architecture
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch, 'Clean Architecture',
    'Organize code in layers where inner layers don''t depend on outer layers.',
    'Architectural pattern with concentric layers: Domain (core), Application, Infrastructure, Presentation. Dependencies point inward. Business logic independent of frameworks.',
    'Clean Architecture separates concerns via layers. Domain (entities, business rules) at center. Application (use cases) orchestrates. Infrastructure (DB, external) depends on domain via interfaces. Presentation (UI) depends on application. Testable, maintainable.',
    to_jsonb(ARRAY['Violating dependency rule (inner depending on outer)', 'Overengineering simple apps', 'Anemic domain models', 'Too many layers causing complexity', 'Not understanding when to use']),
    jsonb_build_object(
      'csharp', E'// Domain Layer (core)\npublic class Order { // Entity\n  public int Id { get; set; }\n  public decimal Total { get; private set; }\n  public void AddItem(OrderItem item) { Total += item.Price; }\n}\n\npublic interface IOrderRepository { // Domain interface\n  Task<Order> GetByIdAsync(int id);\n}\n\n// Application Layer (use cases)\npublic class CreateOrderHandler {\n  private readonly IOrderRepository _repo;\n  public CreateOrderHandler(IOrderRepository repo) => _repo = repo;\n  \n  public async Task<OrderDto> Handle(CreateOrderCommand cmd) {\n    var order = new Order { /* ... */ };\n    await _repo.SaveAsync(order);\n    return new OrderDto { /* ... */ };\n  }\n}\n\n// Infrastructure Layer (implementation)\npublic class OrderRepository : IOrderRepository {\n  private readonly DbContext _db;\n  public async Task<Order> GetByIdAsync(int id) => await _db.Orders.FindAsync(id);\n}\n\n// Presentation Layer (API)\n[ApiController]\npublic class OrdersController : ControllerBase {\n  private readonly CreateOrderHandler _handler;\n  [HttpPost]\n  public async Task<IActionResult> Create(CreateOrderCommand cmd) {\n    var dto = await _handler.Handle(cmd);\n    return Ok(dto);\n  }\n}',
      'typescript', E'// Domain Layer\nclass Order { // Entity\n  constructor(\n    public id: number,\n    private items: OrderItem[] = []\n  ) {}\n  \n  addItem(item: OrderItem): void {\n    this.items.push(item);\n  }\n  \n  get total(): number {\n    return this.items.reduce((sum, item) => sum + item.price, 0);\n  }\n}\n\ninterface OrderRepository {\n  findById(id: number): Promise<Order>;\n  save(order: Order): Promise<void>;\n}\n\n// Application Layer\nclass CreateOrderUseCase {\n  constructor(private repo: OrderRepository) {}\n  \n  async execute(data: CreateOrderDto): Promise<Order> {\n    const order = new Order(...);\n    await this.repo.save(order);\n    return order;\n  }\n}\n\n// Infrastructure\nclass OrderRepositoryImpl implements OrderRepository {\n  async findById(id: number): Promise<Order> {\n    const row = await db.query(''SELECT * FROM orders WHERE id = $1'', [id]);\n    return new Order(row.id, row.items);\n  }\n}\n\n// Presentation\napp.post(''/api/orders'', async (req, res) => {\n  const useCase = new CreateOrderUseCase(orderRepo);\n  const order = await useCase.execute(req.body);\n  res.status(201).json(order);\n});'
    ),
    E'Clean Architecture:\n     [Presentation]\n          ↓\n     [Application]  ← Use Cases\n          ↓\n      [Domain]      ← Business Rules\n          ↑\n   [Infrastructure] ← DB, External\n\nDependencies point inward\nDomain is framework-independent',
    70
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Dependency direction?', to_jsonb(ARRAY['Outward', 'Inward toward domain', 'Any direction', 'No dependencies']), 1, 'Outer layers depend on inner, not reverse.'),
    (current_term_id, 'Domain layer contains?', to_jsonb(ARRAY['UI', 'Business entities and rules', 'Database code', 'Framework']), 1, 'Core business logic, framework-independent.'),
    (current_term_id, 'Infrastructure implements?', to_jsonb(ARRAY['Business rules', 'Domain interfaces for DB, external services', 'UI', 'DTOs']), 1, 'Concrete implementations of domain interfaces.'),
    (current_term_id, 'Application layer has?', to_jsonb(ARRAY['Entities', 'Use cases orchestrating business logic', 'DB queries', 'Views']), 1, 'Coordinates between domain and infrastructure.'),
    (current_term_id, 'When use Clean Architecture?', to_jsonb(ARRAY['Always', 'Complex domains needing testability', 'Simple CRUD', 'Never']), 1, 'Worth complexity for complex business logic.');

  -- REST Best Practices
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch, 'REST API Best Practices',
    'Design APIs with meaningful URLs, correct verbs, proper status codes.',
    'RESTful design: resource-based URLs, HTTP verbs for actions, status codes for outcomes, stateless, HATEOAS, versioning, pagination.',
    'REST APIs use nouns for resources (/users not /getUsers), HTTP verbs for operations (GET retrieve, POST create). Return proper status codes (201 Created, 404 Not Found). Stateless requests. Paginate collections. Version APIs. Use DTOs.',
    to_jsonb(ARRAY['Using verbs in URLs', 'Wrong status codes (200 for errors)', 'Not paginating large collections', 'No versioning strategy', 'Not using proper HTTP methods']),
    jsonb_build_object(
      'csharp', E'// Good REST API\n[ApiController]\n[Route("api/v1/[controller]")] // Versioning\npublic class UsersController : ControllerBase {\n  // GET /api/v1/users?page=1&size=20\n  [HttpGet]\n  public ActionResult<PagedResult<UserDto>> GetUsers(\n    [FromQuery] int page = 1,\n    [FromQuery] int size = 20) {\n    var users = _repo.GetPaged(page, size);\n    return Ok(new PagedResult<UserDto> {\n      Data = users,\n      Page = page,\n      TotalPages = _repo.GetTotalPages(size)\n    });\n  }\n  \n  // GET /api/v1/users/123\n  [HttpGet("{id}")]\n  public ActionResult<UserDto> GetUser(int id) {\n    var user = _repo.GetById(id);\n    if(user == null) return NotFound(); // 404\n    return Ok(user); // 200\n  }\n  \n  // POST /api/v1/users\n  [HttpPost]\n  public ActionResult<UserDto> Create([FromBody] CreateUserDto dto) {\n    var user = _repo.Create(dto);\n    return CreatedAtAction(nameof(GetUser), new { id = user.Id }, user); // 201\n  }\n  \n  // PUT /api/v1/users/123\n  [HttpPut("{id}")]\n  public IActionResult Update(int id, [FromBody] UpdateUserDto dto) {\n    if(!_repo.Exists(id)) return NotFound();\n    _repo.Update(id, dto);\n    return NoContent(); // 204\n  }\n  \n  // DELETE /api/v1/users/123\n  [HttpDelete("{id}")]\n  public IActionResult Delete(int id) {\n    if(!_repo.Exists(id)) return NotFound();\n    _repo.Delete(id);\n    return NoContent(); // 204\n  }\n}',
      'typescript', E'// Express REST API\nconst router = express.Router();\n\n// GET /api/v1/users?page=1&size=20\nrouter.get(''/users'', async (req, res) => {\n  const page = parseInt(req.query.page) || 1;\n  const size = parseInt(req.query.size) || 20;\n  const users = await repo.findPaged(page, size);\n  res.json({\n    data: users,\n    page,\n    totalPages: await repo.getTotalPages(size)\n  });\n});\n\n// GET /api/v1/users/:id\nrouter.get(''/users/:id'', async (req, res) => {\n  const user = await repo.findById(req.params.id);\n  if(!user) return res.status(404).json({ error: ''Not found'' });\n  res.json(user);\n});\n\n// POST /api/v1/users\nrouter.post(''/users'', async (req, res) => {\n  const user = await repo.create(req.body);\n  res.status(201)\n     .location(`/api/v1/users/${user.id}`)\n     .json(user);\n});\n\n// PUT /api/v1/users/:id\nrouter.put(''/users/:id'', async (req, res) => {\n  const exists = await repo.exists(req.params.id);\n  if(!exists) return res.status(404).json({ error: ''Not found'' });\n  await repo.update(req.params.id, req.body);\n  res.status(204).send();\n});\n\napp.use(''/api/v1'', router);'
    ),
    E'REST Best Practices:\nResource URLs: /api/v1/users (nouns)\nHTTP Verbs: GET, POST, PUT, DELETE\nStatus Codes: 200, 201, 204, 400, 404, 500\nPagination: ?page=1&size=20\nVersioning: /api/v1/...\nDTOs: separate from entities',
    71
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'REST URLs should use?', to_jsonb(ARRAY['Verbs like /getUser', 'Nouns like /users', 'Any format', 'Actions']), 1, 'Resource-based: nouns not verbs.'),
    (current_term_id, 'POST successful creation returns?', to_jsonb(ARRAY['200', '201 Created', '204', '202']), 1, '201 with Location header for new resource.'),
    (current_term_id, 'Successful DELETE returns?', to_jsonb(ARRAY['200 with body', '204 No Content', '201', '404']), 1, '204: success, no body needed.'),
    (current_term_id, 'Pagination prevents?', to_jsonb(ARRAY['Errors', 'Returning huge datasets', 'Security', 'Versioning']), 1, 'Limits response size for performance.'),
    (current_term_id, 'API versioning in?', to_jsonb(ARRAY['Header only', 'URL path (/v1/) or header', 'Not needed', 'Query param only']), 1, 'Common in URL for clarity.');

  -- Git Workflow
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_devops, 'Git Workflow & Branching',
    'Organize code changes with branches, pull requests, and merging strategies.',
    'Git workflow: main branch stable, feature branches for work, pull requests for review, merge or rebase to integrate. GitHub Flow: branch, commit, PR, merge. GitFlow: main, develop, feature, release branches.',
    'Git workflows coordinate team development. Create feature branch from main, commit changes, open PR for review, merge to main. Use descriptive branch names (feature/user-auth). Squash commits for clean history. Resolve conflicts carefully.',
    to_jsonb(ARRAY['Committing to main directly', 'Huge commits mixing unrelated changes', 'Not pulling before pushing', 'Poor commit messages', 'Merge conflicts from not syncing', 'Force pushing shared branches']),
    jsonb_build_object(
      'csharp', E'// .editorconfig for consistent formatting\nroot = true\n\n[*.cs]\nindent_style = space\nindent_size = 4\nend_of_line = crlf\n\n# Commit message format\n# type(scope): subject\n#\n# feat(auth): add JWT authentication\n# fix(api): resolve null reference in UserController\n# refactor(db): optimize query performance\n# docs(readme): update setup instructions',
      'typescript', E'# Git workflow commands\n\n# 1. Create feature branch\ngit checkout -b feature/user-authentication\n\n# 2. Make changes and commit\ngit add .\ngit commit -m "feat(auth): implement JWT login"\n\n# 3. Push to remote\ngit push -u origin feature/user-authentication\n\n# 4. Open Pull Request on GitHub\n\n# 5. After review, merge (squash) to main\ngit checkout main\ngit pull origin main\ngit merge --squash feature/user-authentication\ngit push origin main\n\n# Delete feature branch\ngit branch -d feature/user-authentication\n\n# Handling conflicts\ngit pull origin main # Get latest\n# Resolve conflicts in files\ngit add .\ngit commit -m "fix: resolve merge conflicts"\ngit push'
    ),
    E'Git Workflow:\nmain ─────────────────────M─→\n        ↘               ↗\n      feature/new-feature\n         C1 → C2 → C3\n            ↓\n         Open PR\n            ↓\n      Code Review\n            ↓\n    Merge to main\n\nBranch naming:\n  feature/name\n  bugfix/issue-123\n  hotfix/critical-bug',
    75
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Feature branch from?', to_jsonb(ARRAY['develop', 'main/master (stable)', 'Any branch', 'No branching']), 1, 'Create from stable main branch.'),
    (current_term_id, 'Pull Request purpose?', to_jsonb(ARRAY['Backup', 'Code review before merging', 'Deployment', 'Testing']), 1, 'Review changes before integration.'),
    (current_term_id, 'Merge vs Rebase?', to_jsonb(ARRAY['Same', 'Merge preserves history, rebase linearizes', 'Rebase faster', 'No difference']), 1, 'Rebase creates clean linear history.'),
    (current_term_id, 'Commit message format?', to_jsonb(ARRAY['Any text', 'Descriptive with type: "feat: add login"', 'Just filenames', 'Empty']), 1, 'Clear message explaining what and why.'),
    (current_term_id, 'Before push?', to_jsonb(ARRAY['Nothing', 'Pull to sync with remote', 'Delete branch', 'Merge main']), 1, 'Pull latest to avoid conflicts.');

  -- Overfitting
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_ai, 'Overfitting & Underfitting',
    'Overfitting: model memorizes training data, fails on new data. Underfitting: too simple, misses patterns.',
    'Overfitting: model too complex, learns noise not signal, high train accuracy but low test accuracy. Underfitting: model too simple, high bias, poor on both train and test.',
    'Overfitting is memorization without generalization. Combat with: more data, regularization (L1/L2), dropout, cross-validation, early stopping, simpler model. Underfitting fixed by more complex model or better features. Monitor train vs validation performance.',
    to_jsonb(ARRAY['Not using train/val/test split', 'Evaluating on training data only', 'Too complex model for small dataset', 'Not using regularization', 'Ignoring validation curve']),
    jsonb_build_object(
      'csharp', E'// ML.NET: prevent overfitting\nvar pipeline = mlContext.Transforms.Concatenate("Features", "F1", "F2")\n  .Append(mlContext.Regression.Trainers.Sdca(\n    labelColumnName: "Label",\n    maximumNumberOfIterations: 100, // Early stopping\n    l2Regularization: 0.1f // Regularization\n  ));\n\n// Cross-validation to detect overfitting\nvar cvResults = mlContext.Regression.CrossValidate(\n  data: trainingData,\n  estimator: pipeline,\n  numberOfFolds: 5 // 5-fold CV\n);\n\nvar avgRSquared = cvResults.Average(r => r.Metrics.RSquared);\nConsole.WriteLine($"Avg R²: {avgRSquared}");',
      'typescript', E'// TensorFlow.js: prevent overfitting\nconst model = tf.sequential({\n  layers: [\n    tf.layers.dense({ units: 64, activation: ''relu'', inputShape: [10] }),\n    tf.layers.dropout({ rate: 0.3 }), // Dropout for regularization\n    tf.layers.dense({ units: 32, activation: ''relu'',\n      kernelRegularizer: tf.regularizers.l2({ l2: 0.01 }) }), // L2\n    tf.layers.dense({ units: 1 })\n  ]\n});\n\nmodel.compile({\n  optimizer: ''adam'',\n  loss: ''meanSquaredError''\n});\n\n// Early stopping callback\nconst earlyStopping = tf.callbacks.earlyStopping({\n  monitor: ''val_loss'',\n  patience: 10\n});\n\nawait model.fit(xTrain, yTrain, {\n  epochs: 100,\n  validationSplit: 0.2, // Validation for monitoring\n  callbacks: [earlyStopping]\n});\n\n// Evaluate on test set\nconst testLoss = model.evaluate(xTest, yTest);'
    ),
    E'Overfitting vs Underfitting:\n       Error\n        ↑\n   High │ Underfit\n        │     \\\n        │      \\ Overfit\n   Low  │       /\n        │ Just Right\n        └──────────→\n       Model Complexity\n\nOverfit: memorizes\nUnderfit: too simple\nFix: regularization, more data, CV',
    80
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Overfitting means?', to_jsonb(ARRAY['High test accuracy', 'High train accuracy, low test accuracy', 'Low train accuracy', 'Perfect model']), 1, 'Memorizes training data, doesn''t generalize.'),
    (current_term_id, 'Prevent overfitting how?', to_jsonb(ARRAY['More complexity', 'Regularization, more data, dropout', 'Less data', 'Ignore validation']), 1, 'Techniques to improve generalization.'),
    (current_term_id, 'Underfitting cause?', to_jsonb(ARRAY['Too complex', 'Model too simple for data', 'Overfitting', 'Good fit']), 1, 'Model lacks capacity to learn patterns.'),
    (current_term_id, 'Cross-validation purpose?', to_jsonb(ARRAY['Speed', 'Detect overfitting via multiple train/val splits', 'Deployment', 'Prediction']), 1, 'Assess generalization across data splits.'),
    (current_term_id, 'Regularization does?', to_jsonb(ARRAY['Increases complexity', 'Penalizes large weights to prevent overfitting', 'Speeds training', 'Adds features']), 1, 'Constrains model complexity.');

  -- Prompt Engineering
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_ai, 'Prompt Engineering',
    'Crafting instructions for AI to get better results - clear, specific, with examples.',
    'Techniques for writing effective AI prompts: clear instructions, context, constraints, examples (few-shot), role assignment, output format, iterative refinement.',
    'Effective prompts have: clear task, context, constraints, examples for few-shot learning, desired output format. Use system role for behavior, user role for input. Iterate based on output. Tools: ChatGPT, Copilot, Cursor. Privacy: never share secrets.',
    to_jsonb(ARRAY['Vague instructions', 'No examples for complex tasks', 'Ignoring output format specification', 'Sharing sensitive data in prompts', 'Not iterating to refine']),
    jsonb_build_object(
      'csharp', E'// Example prompt for code generation\n// Prompt:\n/*\nYou are a senior C# developer.\n\nTask: Generate a method to validate email addresses.\n\nRequirements:\n- Use regex pattern\n- Return bool\n- Handle null input\n- Add XML documentation\n\nExample:\nInput: "user@example.com" → true\nInput: "invalid" → false\nInput: null → false\n*/\n\n// AI Output:\n/// <summary>\n/// Validates an email address using regex.\n/// </summary>\n/// <param name="email">Email to validate</param>\n/// <returns>True if valid, false otherwise</returns>\npublic bool IsValidEmail(string email) {\n  if(string.IsNullOrEmpty(email)) return false;\n  var pattern = @"^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$";\n  return Regex.IsMatch(email, pattern);\n}',
      'typescript', E'// Example prompt for TypeScript\n// Prompt:\n/*\nYou are an expert TypeScript developer.\n\nTask: Create a generic Result type for error handling.\n\nRequirements:\n- Success or Error variant\n- Type-safe value/error access\n- Helper functions: ok(), err(), isOk(), isErr()\n\nExample usage:\nconst success: Result<number, string> = ok(42);\nconst failure: Result<number, string> = err("Not found");\n\nif(result.isOk()) { console.log(result.value); }\n*/\n\n// AI Output:\ntype Result<T, E> = \n  | { ok: true; value: T }\n  | { ok: false; error: E };\n\nfunction ok<T, E>(value: T): Result<T, E> {\n  return { ok: true, value };\n}\n\nfunction err<T, E>(error: E): Result<T, E> {\n  return { ok: false, error };\n}\n\nfunction isOk<T, E>(result: Result<T, E>): result is { ok: true; value: T } {\n  return result.ok;\n}'
    ),
    E'Prompt Engineering:\nComponents:\n  1. Role: "You are a senior dev"\n  2. Task: Clear instruction\n  3. Context: Background info\n  4. Constraints: Requirements\n  5. Examples: Few-shot learning\n  6. Format: Desired output\n\nIterate: refine based on results\nPrivacy: never share secrets',
    81
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Effective prompt includes?', to_jsonb(ARRAY['Task only', 'Task, context, constraints, examples', 'Vague request', 'Nothing']), 1, 'Clear comprehensive instructions.'),
    (current_term_id, 'Few-shot learning means?', to_jsonb(ARRAY['No examples', 'Providing examples in prompt', 'Training model', 'Testing']), 1, 'Examples teach AI desired pattern.'),
    (current_term_id, 'Prompt engineering privacy?', to_jsonb(ARRAY['Share everything', 'Never include secrets or sensitive data', 'Only in production', 'Encrypt prompts']), 1, 'AI providers may log prompts.'),
    (current_term_id, 'Role assignment purpose?', to_jsonb(ARRAY['Nothing', 'Set AI behavior and expertise level', 'Authorization', 'Security']), 1, '"You are expert dev" shapes responses.'),
    (current_term_id, 'Output format specification?', to_jsonb(ARRAY['Optional', 'Helps AI structure response correctly', 'Not needed', 'Slows down']), 1, 'Specify JSON, code, bullet points, etc.');

  -- STAR Method
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_hr, 'STAR Method',
    'Answer behavioral questions: Situation, Task, Action, Result.',
    'Structured approach for behavioral interview questions. Situation: context. Task: challenge/goal. Action: what you did. Result: outcome with metrics.',
    'STAR structures behavioral answers. Situation: set scene briefly. Task: specific challenge or goal. Action: your specific actions (use "I" not "we"). Result: quantify outcome, lessons learned. Practice stories covering: challenges, conflicts, leadership, failure, learning.',
    to_jsonb(ARRAY['Using "we" instead of "I"', 'No quantifiable results', 'Too much situation, not enough action', 'No learnings from failure stories', 'Generic answers without specifics']),
    jsonb_build_object(
      'csharp', E'/*\nQuestion: "Tell me about a time you debugged a difficult bug."\n\nSTAR Answer:\n\nSituation:\n"In my internship, our production API had intermittent 500 errors affecting 5% of requests, but only during peak hours."\n\nTask:\n"I was assigned to identify and fix the root cause within 48 hours to prevent customer impact."\n\nAction:\n"I analyzed application logs and found a pattern: errors correlated with high concurrent requests.\nI used profiling tools to discover a race condition in our caching layer.\nThe cache wasn\'t thread-safe, causing null reference exceptions under load.\nI refactored the code to use ConcurrentDictionary instead of Dictionary,\nadded proper locking, and wrote integration tests to reproduce the concurrency issue."\n\nResult:\n"After deployment, error rate dropped to 0%, and we had no recurrence.\nI documented the fix and presented findings to the team,\nleading to a code review checklist item for thread safety.\nThis experience taught me the importance of considering concurrency in shared resources."\n\nMetrics: 5% → 0% errors, 48hr deadline met\nLearning: Thread safety awareness\n*/',
      'typescript', E'/*\nQuestion: "Describe a time you had to learn a new technology quickly."\n\nSTAR Answer:\n\nSituation:\n"My team needed to migrate our API from REST to GraphQL within 3 weeks for a client requirement."\n\nTask:\n"As the backend lead, I had to learn GraphQL, design the schema, and implement resolvers\nwhile ensuring no disruption to existing REST consumers during migration."\n\nAction:\n"I dedicated evenings to GraphQL tutorials and documentation.\nI created a proof-of-concept resolving our most complex query.\nI designed a schema supporting our 15 entity types with proper relationships.\nI implemented Apollo Server with TypeScript, added DataLoader to prevent N+1 queries,\nand set up automated tests comparing GraphQL vs REST responses for consistency.\nI ran both APIs in parallel for 1 week before switchover."\n\nResult:\n"We delivered on time with zero production incidents.\nQuery response times improved 40% due to clients fetching only needed fields.\nThe team adopted GraphQL for all new features.\nI learned to learn by doing and the value of parallel deployment for risk mitigation."\n\nMetrics: 3-week timeline met, 40% perf improvement, 0 incidents\nLearning: Rapid learning via PoC, parallel deployment reduces risk\n*/'
    ),
    E'STAR Method:\nS - Situation:\n    Set context (briefly)\nT - Task:\n    Your specific goal/challenge\nA - Action:\n    What YOU did (use "I")\n    Multiple specific steps\nR - Result:\n    Quantified outcome\n    Lessons learned\n\nPrepare 5-7 stories covering:\n  - Challenge overcome\n  - Failure & learning\n  - Conflict resolution\n  - Leadership\n  - Fast learning',
    85
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'STAR stands for?', to_jsonb(ARRAY['Strategy Test Action Result', 'Situation Task Action Result', 'Story Task Answer Result', 'System Task Analysis Result']), 1, 'Framework for behavioral answers.'),
    (current_term_id, 'Action section should use?', to_jsonb(ARRAY['"We" for team credit', '"I" for your specific actions', 'Passive voice', 'No pronouns']), 1, 'Highlight YOUR contributions.'),
    (current_term_id, 'Result should include?', to_jsonb(ARRAY['Just outcome', 'Quantified outcome and lessons learned', 'Opinion', 'Blame others']), 1, 'Metrics and growth from experience.'),
    (current_term_id, 'Situation section?', to_jsonb(ARRAY['Long detailed story', 'Brief context setting', 'Skip it', 'Most important part']), 1, 'Concise background, focus on action/result.'),
    (current_term_id, 'Prepare stories for?', to_jsonb(ARRAY['One topic', 'Diverse: challenge, failure, conflict, leadership', 'Only successes', 'No preparation']), 1, 'Cover common behavioral question themes.');

  -- Scrum
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_hr, 'Scrum Framework',
    'Agile framework with sprints, daily standups, and iterative delivery.',
    'Scrum: roles (Product Owner, Scrum Master, Dev Team), ceremonies (Sprint Planning, Daily Standup, Review, Retro), artifacts (Product Backlog, Sprint Backlog, Increment).',
    'Scrum organizes work in 2-week sprints. Product Owner prioritizes backlog. Team plans sprint, commits to sprint backlog. Daily standups (15min): what I did, what I will do, blockers. Sprint review: demo increment. Retro: improve process.',
    to_jsonb(ARRAY['Standups becoming status reports to manager', 'Skipping retrospectives', 'No clear Definition of Done', 'Product Owner unavailable', 'Overcommitting in sprint planning']),
    jsonb_build_object(
      'csharp', E'/*\nScrum Ceremonies:\n\n1. Sprint Planning (2-4 hours for 2-week sprint)\n   - Product Owner presents prioritized backlog\n   - Team discusses and estimates stories\n   - Team commits to sprint backlog\n   - Define sprint goal\n\n2. Daily Standup (15 minutes, same time/place)\n   - Yesterday: "Completed user authentication API"\n   - Today: "Implementing password reset endpoint"\n   - Blockers: "Need database credentials from DevOps"\n   \n3. Sprint Review (1-2 hours)\n   - Demo working software to stakeholders\n   - Get feedback for backlog refinement\n   \n4. Sprint Retrospective (1 hour)\n   - What went well: "Code reviews caught 3 bugs early"\n   - What to improve: "Need better test coverage"\n   - Action items: "Add coverage threshold to CI pipeline"\n\nDefinition of Done:\n  ✓ Code complete\n  ✓ Unit tests written (>80% coverage)\n  ✓ Code reviewed and approved\n  ✓ Integration tests pass\n  ✓ Documentation updated\n  ✓ Deployed to staging\n  ✓ Product Owner accepted\n*/',
      'typescript', E'/*\nScrum Roles:\n\nProduct Owner:\n  - Maintains product backlog\n  - Prioritizes features by business value\n  - Accepts/rejects work\n  - Available to team for questions\n\nScrum Master:\n  - Facilitates ceremonies\n  - Removes impediments/blockers\n  - Coaches team on Scrum practices\n  - Shields team from external interruptions\n\nDevelopment Team:\n  - Self-organizing, cross-functional\n  - Estimates and commits to work\n  - Delivers potentially shippable increment\n  - Collaborates daily\n\nStory Example:\n  As a user\n  I want to reset my password\n  So that I can regain access if I forget it\n  \n  Acceptance Criteria:\n  - Email with reset link sent within 1 minute\n  - Link expires after 24 hours\n  - Password meets complexity requirements\n  - User receives confirmation email\n  \n  Estimate: 5 story points\n  Priority: High\n  Sprint: 23\n*/'
    ),
    E'Scrum Framework:\n\nSprint (2 weeks)\n  ↓\nPlanning → Daily Standups → Review → Retro\n    ↓         (15 min)        ↓       ↓\n Sprint Goal              Demo   Improve\n    ↓\n Backlog → Sprint Backlog → Increment\n    ↑\nProduct Owner prioritizes\n\nRoles: PO, Scrum Master, Dev Team',
    86
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Scrum sprint typical duration?', to_jsonb(ARRAY['1 week', '2 weeks', '1 month', '3 months']), 1, 'Most teams use 2-week sprints.'),
    (current_term_id, 'Daily standup purpose?', to_jsonb(ARRAY['Status report to manager', 'Team synchronization and blocker identification', 'Sprint planning', 'Code review']), 1, 'Quick sync: progress, plan, obstacles.'),
    (current_term_id, 'Product Owner responsibility?', to_jsonb(ARRAY['Write code', 'Prioritize backlog by business value', 'Run standups', 'Deploy code']), 1, 'Defines WHAT to build and priority.'),
    (current_term_id, 'Sprint Retrospective for?', to_jsonb(ARRAY['Demo features', 'Team reflects on process and improves', 'Plan next sprint', 'Review code']), 1, 'Continuous process improvement.'),
    (current_term_id, 'Definition of Done?', to_jsonb(ARRAY['Code written', 'Criteria for "complete": coded, tested, reviewed, deployed', 'Manager approval', 'Deployed only']), 1, 'Shared understanding of complete work.');

  RAISE NOTICE 'Added 17 comprehensive final terms across all categories';
END $$;

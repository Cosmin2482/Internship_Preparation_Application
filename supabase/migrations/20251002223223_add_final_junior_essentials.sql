/*
  # Final Junior Level Essentials
  
  1. New Terms (15 terms)
    - Angular: HttpClient, Routing, Services & DI details
    - SQL: GROUP BY/HAVING, Transactions, Keys
    - TypeScript: Async/Await, Promises
    - Architecture: DTO, Repository Pattern
    - DevOps: Deployment, Observability
    - More OOP & patterns
*/

DO $$
DECLARE
  cat_angular uuid;
  cat_sql uuid;
  cat_arch uuid;
  cat_devops uuid;
  cat_oop uuid;
  cat_ai uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_angular FROM categories WHERE slug = 'angular';
  SELECT id INTO cat_sql FROM categories WHERE slug = 'sql';
  SELECT id INTO cat_arch FROM categories WHERE slug = 'architecture';
  SELECT id INTO cat_devops FROM categories WHERE slug = 'devops';
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';
  SELECT id INTO cat_ai FROM categories WHERE slug = 'ai-ml';

  -- Angular HttpClient
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'Angular HttpClient',
    'Built-in service for making HTTP requests to APIs, returns Observables.',
    'HttpClient: Angular service for HTTP requests. Returns Observables. Supports interceptors for auth, error handling, retry. Automatic JSON parsing.',
    'HttpClient makes API calls returning Observables. Inject in services, not components. Use interceptors for cross-cutting concerns (auth tokens, errors). Handle errors with catchError. Unsubscribe or use async pipe to prevent leaks.',
    to_jsonb(ARRAY['Not unsubscribing from HTTP Observables', 'Using in components instead of services', 'Not handling errors', 'Not using interceptors for auth', 'Subscribing multiple times to same request']),
    jsonb_build_object(
      'csharp', E'// C# HttpClient equivalent\npublic class UserService {\n  private readonly HttpClient _client;\n  \n  public UserService(HttpClient client) {\n    _client = client;\n  }\n  \n  public async Task<User> GetUserAsync(int id) {\n    var response = await _client.GetAsync($"/api/users/{id}");\n    response.EnsureSuccessStatusCode();\n    return await response.Content.ReadFromJsonAsync<User>();\n  }\n  \n  public async Task<User> CreateUserAsync(User user) {\n    var response = await _client.PostAsJsonAsync("/api/users", user);\n    response.EnsureSuccessStatusCode();\n    return await response.Content.ReadFromJsonAsync<User>();\n  }\n}',
      'typescript', E'import { HttpClient, HttpErrorResponse } from ''@angular/common/http'';\nimport { Injectable } from ''@angular/core'';\nimport { Observable, throwError } from ''rxjs'';\nimport { catchError, retry } from ''rxjs/operators'';\n\n@Injectable({ providedIn: ''root'' })\nexport class UserService {\n  private apiUrl = ''/api/users'';\n  \n  constructor(private http: HttpClient) {}\n  \n  // GET request\n  getUsers(): Observable<User[]> {\n    return this.http.get<User[]>(this.apiUrl)\n      .pipe(\n        retry(2), // Retry failed requests\n        catchError(this.handleError)\n      );\n  }\n  \n  getUser(id: number): Observable<User> {\n    return this.http.get<User>(`${this.apiUrl}/${id}`)\n      .pipe(catchError(this.handleError));\n  }\n  \n  // POST request\n  createUser(user: User): Observable<User> {\n    return this.http.post<User>(this.apiUrl, user)\n      .pipe(catchError(this.handleError));\n  }\n  \n  // PUT request\n  updateUser(id: number, user: User): Observable<void> {\n    return this.http.put<void>(`${this.apiUrl}/${id}`, user)\n      .pipe(catchError(this.handleError));\n  }\n  \n  // DELETE request\n  deleteUser(id: number): Observable<void> {\n    return this.http.delete<void>(`${this.apiUrl}/${id}`)\n      .pipe(catchError(this.handleError));\n  }\n  \n  private handleError(error: HttpErrorResponse) {\n    if(error.status === 0) {\n      console.error(''Network error:'', error.error);\n    } else {\n      console.error(`Server error ${error.status}:`, error.error);\n    }\n    return throwError(() => new Error(''Something went wrong''));\n  }\n}'
    ),
    E'HttpClient:\nService\n  ↓ inject HttpClient\nHTTP request → Observable<T>\n  ↓\nInterceptors (auth, errors)\n  ↓\nSubscribe in component\n  or\nAsync pipe in template\n\nAlways handle errors!',
    110
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'HttpClient returns?', to_jsonb(ARRAY['Promise', 'Observable', 'Array', 'void']), 1, 'Returns Observable for reactive programming.'),
    (current_term_id, 'Where use HttpClient?', to_jsonb(ARRAY['Components', 'Services', 'Templates', 'Modules']), 1, 'Inject in services, not components.'),
    (current_term_id, 'Prevent memory leaks?', to_jsonb(ARRAY['Nothing', 'Unsubscribe or use async pipe', 'Use Promise', 'Delete component']), 1, 'Unsubscribe in ngOnDestroy or use async pipe.'),
    (current_term_id, 'Interceptors for?', to_jsonb(ARRAY['Components', 'Cross-cutting: auth, errors, retry', 'Styling', 'Routing']), 1, 'Add headers, handle errors globally.'),
    (current_term_id, 'catchError purpose?', to_jsonb(ARRAY['Retry', 'Handle errors gracefully', 'Map data', 'Filter']), 1, 'Error handling in Observable pipeline.');

  -- Angular Routing
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'Angular Routing',
    'Navigate between different views/pages in single-page app using URL routes.',
    'Angular Router: maps URL paths to components. RouterModule configures routes. router-outlet displays routed component. RouterLink for navigation. Guards protect routes. Lazy loading for code splitting.',
    'Router enables SPA navigation. Define routes mapping paths to components. <router-outlet> renders matched component. Use [routerLink] for links. Guards (CanActivate) protect routes. Lazy load modules with loadChildren for performance.',
    to_jsonb(ARRAY['Not using lazy loading for large apps', 'Forgetting to import RouterModule', 'Wildcard route not last', 'Guards returning observables not unwrapped', 'Direct DOM navigation breaking routing']),
    jsonb_build_object(
      'csharp', E'// Blazor routing equivalent\n// App.razor\n<Router AppAssembly="@typeof(App).Assembly">\n  <Found Context="routeData">\n    <RouteView RouteData="@routeData" DefaultLayout="@typeof(MainLayout)" />\n  </Found>\n  <NotFound>\n    <p>Page not found</p>\n  </NotFound>\n</Router>\n\n// Page component\n@page "/users/{id:int}"\n@code {\n  [Parameter] public int Id { get; set; }\n  \n  protected override async Task OnInitializedAsync() {\n    var user = await UserService.GetByIdAsync(Id);\n  }\n}\n\n// Navigation\n@inject NavigationManager Nav\nNav.NavigateTo("/users/5");',
      'typescript', E'// app-routing.module.ts\nimport { NgModule } from ''@angular/core'';\nimport { RouterModule, Routes } from ''@angular/router'';\nimport { AuthGuard } from ''./auth.guard'';\n\nconst routes: Routes = [\n  { path: '''', redirectTo: ''/home'', pathMatch: ''full'' },\n  { path: ''home'', component: HomeComponent },\n  { path: ''users'', component: UsersComponent },\n  { path: ''users/:id'', component: UserDetailComponent },\n  {\n    path: ''admin'',\n    component: AdminComponent,\n    canActivate: [AuthGuard] // Protected route\n  },\n  // Lazy loading\n  {\n    path: ''products'',\n    loadChildren: () => import(''./products/products.module'')\n      .then(m => m.ProductsModule)\n  },\n  { path: ''**'', component: NotFoundComponent } // Wildcard last\n];\n\n@NgModule({\n  imports: [RouterModule.forRoot(routes)],\n  exports: [RouterModule]\n})\nexport class AppRoutingModule {}\n\n// Template navigation\n<a [routerLink]="[''/users'']">Users</a>\n<a [routerLink]="[''/users'', userId]">User Detail</a>\n<router-outlet></router-outlet>\n\n// Programmatic navigation\nexport class MyComponent {\n  constructor(private router: Router) {}\n  \n  goToUser(id: number) {\n    this.router.navigate([''/users'', id]);\n  }\n}\n\n// Route Guard\n@Injectable({ providedIn: ''root'' })\nexport class AuthGuard implements CanActivate {\n  canActivate(): boolean {\n    return this.authService.isLoggedIn();\n  }\n}'
    ),
    E'Angular Routing:\nURL: /users/5\n    ↓\n[Router matches]\n    ↓\n[Guard checks]\n    ↓\n[Load Component]\n    ↓\n<router-outlet>\n    ↓\nUserDetailComponent\n\nLazy: loadChildren for code splitting',
    111
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, '<router-outlet> purpose?', to_jsonb(ARRAY['Navigation links', 'Placeholder for routed component', 'Guard', 'Service']), 1, 'Renders matched component.'),
    (current_term_id, '[routerLink] vs href?', to_jsonb(ARRAY['Same', 'routerLink: SPA navigation, href: full reload', 'href better', 'No difference']), 1, 'RouterLink preserves SPA behavior.'),
    (current_term_id, 'CanActivate guard?', to_jsonb(ARRAY['Component', 'Protects route access', 'Service', 'Module']), 1, 'Authorization check before route activation.'),
    (current_term_id, 'Lazy loading with?', to_jsonb(ARRAY['component', 'loadChildren', 'import', 'redirectTo']), 1, 'Loads module on demand for performance.'),
    (current_term_id, 'Wildcard route (**)?', to_jsonb(ARRAY['First route', 'Last route for 404 handling', 'Middle', 'Not needed']), 1, 'Catch-all, must be last.');

  -- SQL GROUP BY & HAVING
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_sql, 'GROUP BY & HAVING',
    'GROUP BY: group rows with same values. HAVING: filter groups (like WHERE but for groups).',
    'GROUP BY: groups rows sharing values in specified columns. Aggregate functions (COUNT, SUM, AVG) operate on groups. HAVING: filters groups after aggregation. WHERE filters rows before grouping.',
    'GROUP BY creates groups for aggregation. Use with COUNT, SUM, AVG, MAX, MIN. HAVING filters aggregated results. WHERE filters before grouping, HAVING after. SELECT columns must be in GROUP BY or aggregated.',
    to_jsonb(ARRAY['Selecting non-grouped columns', 'Using WHERE instead of HAVING for aggregates', 'HAVING without GROUP BY', 'Not understanding WHERE vs HAVING order']),
    jsonb_build_object(
      'csharp', E'// EF Core GroupBy\nvar orderStats = await context.Orders\n  .GroupBy(o => o.CustomerId)\n  .Select(g => new {\n    CustomerId = g.Key,\n    OrderCount = g.Count(),\n    TotalAmount = g.Sum(o => o.Total),\n    AvgAmount = g.Average(o => o.Total)\n  })\n  .Where(x => x.OrderCount > 5) // HAVING equivalent\n  .ToListAsync();\n\n// Get customers with > $1000 total\nvar highSpenders = await context.Orders\n  .GroupBy(o => o.CustomerId)\n  .Select(g => new {\n    CustomerId = g.Key,\n    Total = g.Sum(o => o.Amount)\n  })\n  .Where(x => x.Total > 1000)\n  .ToListAsync();',
      'typescript', E'-- Count orders per customer\nSELECT customer_id, COUNT(*) as order_count\nFROM orders\nGROUP BY customer_id;\n\n-- With aggregates\nSELECT \n  customer_id,\n  COUNT(*) as order_count,\n  SUM(total) as total_amount,\n  AVG(total) as avg_amount\nFROM orders\nGROUP BY customer_id;\n\n-- HAVING: filter groups\nSELECT customer_id, COUNT(*) as order_count\nFROM orders\nGROUP BY customer_id\nHAVING COUNT(*) > 5; -- Only customers with >5 orders\n\n-- WHERE vs HAVING\nSELECT customer_id, COUNT(*) as order_count\nFROM orders\nWHERE order_date >= ''2024-01-01'' -- Filter rows first\nGROUP BY customer_id\nHAVING COUNT(*) > 5; -- Then filter groups\n\n-- Multiple columns\nSELECT customer_id, product_id, SUM(quantity) as total_qty\nFROM order_items\nGROUP BY customer_id, product_id\nHAVING SUM(quantity) > 10;'
    ),
    E'GROUP BY & HAVING:\nOrders table:\n  customer_id | total\n  1           | 100\n  1           | 200\n  2           | 150\n    ↓ GROUP BY customer_id\nGroups:\n  1: [100, 200] → COUNT=2, SUM=300\n  2: [150]      → COUNT=1, SUM=150\n    ↓ HAVING COUNT(*) > 1\nResult: customer 1\n\nWHERE: before grouping\nHAVING: after aggregation',
    112
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'GROUP BY purpose?', to_jsonb(ARRAY['Sort', 'Group rows for aggregation', 'Filter', 'Join']), 1, 'Creates groups for COUNT, SUM, etc.'),
    (current_term_id, 'WHERE vs HAVING?', to_jsonb(ARRAY['Same', 'WHERE: before grouping, HAVING: after aggregates', 'HAVING faster', 'No difference']), 1, 'WHERE filters rows, HAVING filters groups.'),
    (current_term_id, 'SELECT without GROUP BY?', to_jsonb(ARRAY['Always OK', 'Must be in GROUP BY or aggregated', 'Never allowed', 'Optional']), 1, 'Non-aggregate columns must be grouped.'),
    (current_term_id, 'HAVING without GROUP BY?', to_jsonb(ARRAY['Common', 'Rare, filters entire result as one group', 'Error', 'Required']), 1, 'Treats all rows as single group.'),
    (current_term_id, 'Aggregate functions?', to_jsonb(ARRAY['WHERE', 'COUNT, SUM, AVG, MAX, MIN', 'JOIN', 'GROUP BY']), 1, 'Operate on groups of rows.');

  -- SQL Keys
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_sql, 'Database Keys (Primary, Foreign, Unique)',
    'Primary Key: unique ID per row. Foreign Key: reference to another table. Unique: no duplicates.',
    'Primary Key (PK): unique identifier for row, not null. Foreign Key (FK): references PK in another table, enforces referential integrity. Unique: ensures no duplicate values. Composite key: multiple columns.',
    'PK uniquely identifies each row, often auto-increment ID. FK maintains relationships, prevents orphans. Unique constraint prevents duplicates but allows null. Composite PK uses multiple columns. FK with CASCADE options for delete/update.',
    to_jsonb(ARRAY['No primary key on tables', 'Forgetting to index foreign keys', 'Using natural keys that change', 'Not understanding cascade options', 'Null in unique constraint allowing duplicates']),
    jsonb_build_object(
      'csharp', E'// EF Core key configuration\npublic class User {\n  [Key] // Primary key\n  public int Id { get; set; }\n  \n  [Required]\n  [MaxLength(100)]\n  public string Email { get; set; } // Will add unique constraint\n  \n  public ICollection<Order> Orders { get; set; }\n}\n\npublic class Order {\n  [Key]\n  public int Id { get; set; }\n  \n  [ForeignKey("User")] // Foreign key\n  public int UserId { get; set; }\n  public User User { get; set; }\n}\n\n// OnModelCreating fluent API\nmodelBuilder.Entity<User>()\n  .HasIndex(u => u.Email)\n  .IsUnique(); // Unique constraint\n\nmodelBuilder.Entity<Order>()\n  .HasOne(o => o.User)\n  .WithMany(u => u.Orders)\n  .HasForeignKey(o => o.UserId)\n  .OnDelete(DeleteBehavior.Cascade); // Cascade delete',
      'typescript', E'-- Primary Key\nCREATE TABLE users (\n  id SERIAL PRIMARY KEY,  -- Auto-increment PK\n  email VARCHAR(100) UNIQUE NOT NULL,  -- Unique constraint\n  name VARCHAR(100)\n);\n\n-- Foreign Key\nCREATE TABLE orders (\n  id SERIAL PRIMARY KEY,\n  user_id INT NOT NULL,\n  total DECIMAL(10,2),\n  FOREIGN KEY (user_id) REFERENCES users(id)\n    ON DELETE CASCADE  -- Delete orders when user deleted\n    ON UPDATE CASCADE  -- Update FK when PK changes\n);\n\n-- Composite Primary Key\nCREATE TABLE order_items (\n  order_id INT,\n  product_id INT,\n  quantity INT,\n  PRIMARY KEY (order_id, product_id),  -- Composite PK\n  FOREIGN KEY (order_id) REFERENCES orders(id)\n);\n\n-- Unique constraint (multiple columns)\nCREATE TABLE employees (\n  id SERIAL PRIMARY KEY,\n  email VARCHAR(100) UNIQUE,  -- Single column unique\n  ssn VARCHAR(11) UNIQUE,\n  UNIQUE(department_id, badge_number)  -- Composite unique\n);'
    ),
    E'Database Keys:\nusers\n  id (PK) | email (UNIQUE)\n  1       | alice@...\n  2       | bob@...\n       ↓ referenced by FK\norders\n  id (PK) | user_id (FK) | total\n  101     | 1            | 100\n  102     | 1            | 200\n  103     | 2            | 150\n\nPK: unique identifier\nFK: maintains relationships\nUNIQUE: no duplicates',
    113
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Primary Key can be NULL?', to_jsonb(ARRAY['Yes', 'No, must be NOT NULL and unique', 'Sometimes', 'Depends']), 1, 'PK uniquely identifies, cannot be null.'),
    (current_term_id, 'Foreign Key purpose?', to_jsonb(ARRAY['Uniqueness', 'Enforce referential integrity between tables', 'Speed', 'Indexing']), 1, 'Links tables, prevents orphan records.'),
    (current_term_id, 'ON DELETE CASCADE?', to_jsonb(ARRAY['Deletes FK', 'Deletes child records when parent deleted', 'Prevents delete', 'No effect']), 1, 'Automatically removes dependent rows.'),
    (current_term_id, 'Unique vs Primary Key?', to_jsonb(ARRAY['Same', 'Unique allows NULL, PK does not', 'PK allows NULL', 'No difference']), 1, 'Unique can have one NULL, PK cannot.'),
    (current_term_id, 'Composite key?', to_jsonb(ARRAY['Single column', 'Multiple columns form key together', 'Foreign key', 'Index']), 1, 'Combination of columns as PK/unique.');

  -- TypeScript Async/Await
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'TypeScript Async/Await & Promises',
    'Handle asynchronous code with async functions and await keyword, makes async code look synchronous.',
    'Promise: object representing eventual completion/failure of async operation. async function returns Promise. await pauses execution until Promise resolves. Error handling with try-catch.',
    'Promises for async operations: pending, fulfilled, rejected. async functions implicitly return Promise. await suspends execution until Promise resolves. Use try-catch for errors. Chain with .then() or await. Prefer async/await for readability.',
    to_jsonb(ARRAY['Not handling rejections', 'Forgetting await (Promise not resolved)', 'Using async unnecessarily', 'Not understanding Promise.all for parallel', 'Mixing callbacks with Promises']),
    jsonb_build_object(
      'csharp', E'// C# async/await (similar)\npublic async Task<User> GetUserAsync(int id) {\n  try {\n    var response = await _httpClient.GetAsync($"/api/users/{id}");\n    response.EnsureSuccessStatusCode();\n    return await response.Content.ReadFromJsonAsync<User>();\n  }\n  catch(HttpRequestException ex) {\n    _logger.LogError(ex, "Failed to get user");\n    throw;\n  }\n}\n\n// Parallel execution\npublic async Task<(User, Order[])> GetUserWithOrdersAsync(int id) {\n  var userTask = GetUserAsync(id);\n  var ordersTask = GetOrdersAsync(id);\n  \n  await Task.WhenAll(userTask, ordersTask); // Parallel\n  \n  return (await userTask, await ordersTask);\n}',
      'typescript', E'// Promise basics\nfunction fetchUser(id: number): Promise<User> {\n  return fetch(`/api/users/${id}`)\n    .then(res => res.json());\n}\n\n// async/await (cleaner)\nasync function getUser(id: number): Promise<User> {\n  try {\n    const response = await fetch(`/api/users/${id}`);\n    if(!response.ok) throw new Error(''Failed to fetch'');\n    return await response.json();\n  } catch(error) {\n    console.error(''Error:'', error);\n    throw error;\n  }\n}\n\n// Sequential vs Parallel\nasync function loadData() {\n  // Sequential (slow)\n  const user = await getUser(1);     // Wait\n  const orders = await getOrders(1); // Then wait\n  \n  // Parallel (fast)\n  const [user2, orders2] = await Promise.all([\n    getUser(1),\n    getOrders(1)\n  ]); // Both at same time\n}\n\n// Error handling\nasync function processUser(id: number): Promise<void> {\n  try {\n    const user = await getUser(id);\n    await updateUser(user);\n  } catch(error) {\n    if(error instanceof NotFoundError) {\n      console.log(''User not found'');\n    } else {\n      console.error(''Unexpected error:'', error);\n    }\n  }\n}\n\n// Promise creation\nfunction delay(ms: number): Promise<void> {\n  return new Promise(resolve => setTimeout(resolve, ms));\n}\n\nawait delay(1000); // Wait 1 second'
    ),
    E'Async/Await:\nasync function getData() {\n  const result = await fetch(url);\n            ↓ suspends here\n  return result.json();\n}\n\nPromise States:\n  Pending → Fulfilled (resolve)\n         → Rejected (reject)\n\nPromise.all: parallel execution\nPromise.race: first to complete',
    114
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'async function returns?', to_jsonb(ARRAY['Value', 'Promise', 'void', 'Observable']), 1, 'Implicitly wraps return in Promise.'),
    (current_term_id, 'await does?', to_jsonb(ARRAY['Blocks thread', 'Pauses function until Promise resolves', 'Creates Promise', 'Loops']), 1, 'Waits for Promise, unwraps value.'),
    (current_term_id, 'Parallel async operations?', to_jsonb(ARRAY['Sequential await', 'Promise.all([...])', 'Impossible', 'Callbacks']), 1, 'Start all, wait for all to complete.'),
    (current_term_id, 'Error handling with await?', to_jsonb(ARRAY['.catch()', 'try-catch block', 'if statement', 'No handling needed']), 1, 'Use try-catch around await.'),
    (current_term_id, 'Promise states?', to_jsonb(ARRAY['On/Off', 'Pending, Fulfilled, Rejected', 'True/False', 'Active/Inactive']), 1, 'Three states of async operation.');

  -- DTO Pattern
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch, 'DTO (Data Transfer Object)',
    'Simple object carrying data between layers or across network, separate from domain entities.',
    'DTO: object transferring data between processes or layers. No business logic, only data. Maps to/from domain entities. Separates internal model from external API contract.',
    'DTOs decouple API contract from domain model. Use for API requests/responses. Contains only data, no logic. Map between DTO and entity. Prevents over-posting, under-fetching. Use separate DTOs for create/update/response.',
    to_jsonb(ARRAY['Using entities directly in API', 'Business logic in DTOs', 'One DTO for all operations', 'Manual mapping everywhere (use AutoMapper)', 'Exposing sensitive fields']),
    jsonb_build_object(
      'csharp', E'// Domain Entity (internal)\npublic class User {\n  public int Id { get; set; }\n  public string Name { get; set; }\n  public string Email { get; set; }\n  public string PasswordHash { get; set; } // Sensitive, don''t expose\n  public DateTime CreatedAt { get; set; }\n  public bool IsActive { get; set; }\n}\n\n// DTOs (external API)\npublic class UserResponseDto {\n  public int Id { get; set; }\n  public string Name { get; set; }\n  public string Email { get; set; }\n  // No password, no internal fields\n}\n\npublic class CreateUserDto {\n  [Required]\n  public string Name { get; set; }\n  [EmailAddress]\n  public string Email { get; set; }\n  [Required]\n  [MinLength(8)]\n  public string Password { get; set; } // Plain password, will hash\n}\n\npublic class UpdateUserDto {\n  public string? Name { get; set; } // Optional for partial update\n  public string? Email { get; set; }\n}\n\n// Mapping\npublic class UserService {\n  public UserResponseDto GetUser(int id) {\n    var user = _repo.GetById(id);\n    return new UserResponseDto {\n      Id = user.Id,\n      Name = user.Name,\n      Email = user.Email\n    };\n  }\n  \n  public void CreateUser(CreateUserDto dto) {\n    var entity = new User {\n      Name = dto.Name,\n      Email = dto.Email,\n      PasswordHash = HashPassword(dto.Password),\n      CreatedAt = DateTime.UtcNow,\n      IsActive = true\n    };\n    _repo.Add(entity);\n  }\n}',
      'typescript', E'// Domain Entity\ninterface User {\n  id: number;\n  name: string;\n  email: string;\n  passwordHash: string; // Sensitive\n  createdAt: Date;\n  isActive: boolean;\n}\n\n// DTOs\ninterface UserResponseDto {\n  id: number;\n  name: string;\n  email: string;\n}\n\ninterface CreateUserDto {\n  name: string;\n  email: string;\n  password: string; // Plain password\n}\n\ninterface UpdateUserDto {\n  name?: string;\n  email?: string;\n}\n\n// Mapping\nclass UserService {\n  getUser(id: number): UserResponseDto {\n    const user = this.repo.getById(id);\n    return {\n      id: user.id,\n      name: user.name,\n      email: user.email\n      // passwordHash NOT exposed\n    };\n  }\n  \n  createUser(dto: CreateUserDto): UserResponseDto {\n    const entity: User = {\n      id: 0,\n      name: dto.name,\n      email: dto.email,\n      passwordHash: hashPassword(dto.password),\n      createdAt: new Date(),\n      isActive: true\n    };\n    const created = this.repo.create(entity);\n    return this.toDto(created);\n  }\n}'
    ),
    E'DTO Pattern:\nAPI Layer\n  ↓ DTOs\n[CreateUserDto] → [Service] → [Entity]\n[UpdateUserDto]       ↓\n       ↑          [Repository]\n[UserResponseDto]     ↓\n                  Database\n\nBenefits:\n- API contract stability\n- Security (hide sensitive fields)\n- Validation at boundary',
    115
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'DTO purpose?', to_jsonb(ARRAY['Business logic', 'Transfer data between layers/processes', 'Database access', 'Validation only']), 1, 'Carries data, no behavior.'),
    (current_term_id, 'DTOs should contain?', to_jsonb(ARRAY['Business logic', 'Only data properties', 'Methods', 'Database code']), 1, 'Plain data, no logic.'),
    (current_term_id, 'Why not use entities in API?', to_jsonb(ARRAY['Too fast', 'Exposes internal model, sensitive fields', 'Required', 'No difference']), 1, 'Decouples API from domain.'),
    (current_term_id, 'Separate DTOs for create/update/response?', to_jsonb(ARRAY['Never', 'Yes, each has different fields', 'One DTO enough', 'Not needed']), 1, 'Different operations need different fields.'),
    (current_term_id, 'DTO vs Entity?', to_jsonb(ARRAY['Same', 'DTO: data transfer, Entity: domain model', 'Entity for API', 'No difference']), 1, 'DTOs external, entities internal.');

  -- Repository Pattern
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch, 'Repository Pattern',
    'Abstraction layer between business logic and data access, centralizes data queries.',
    'Repository: interface abstracting data access. Provides collection-like API for domain objects. Encapsulates query logic. Unit of Work often paired for transactions.',
    'Repository abstracts data store as in-memory collection. Interfaces for testability. Centralizes query logic. With EF Core, sometimes debated as over-abstraction. Use for complex queries, testing, or swapping data sources.',
    to_jsonb(ARRAY['Leaky abstractions exposing ORM details', 'Generic repository over-engineering', 'Not understanding EF Core already unit of work', 'Repository returning IQueryable (leaky)', 'One repo per entity (might be overkill)']),
    jsonb_build_object(
      'csharp', E'// Repository interface\npublic interface IUserRepository {\n  Task<User> GetByIdAsync(int id);\n  Task<IEnumerable<User>> GetAllAsync();\n  Task<User> GetByEmailAsync(string email);\n  Task AddAsync(User user);\n  Task UpdateAsync(User user);\n  Task DeleteAsync(int id);\n  Task<bool> ExistsAsync(int id);\n}\n\n// Implementation with EF Core\npublic class UserRepository : IUserRepository {\n  private readonly AppDbContext _context;\n  \n  public UserRepository(AppDbContext context) {\n    _context = context;\n  }\n  \n  public async Task<User> GetByIdAsync(int id) {\n    return await _context.Users.FindAsync(id);\n  }\n  \n  public async Task<IEnumerable<User>> GetAllAsync() {\n    return await _context.Users.ToListAsync();\n  }\n  \n  public async Task<User> GetByEmailAsync(string email) {\n    return await _context.Users\n      .FirstOrDefaultAsync(u => u.Email == email);\n  }\n  \n  public async Task AddAsync(User user) {\n    await _context.Users.AddAsync(user);\n    await _context.SaveChangesAsync();\n  }\n  \n  public async Task UpdateAsync(User user) {\n    _context.Users.Update(user);\n    await _context.SaveChangesAsync();\n  }\n  \n  public async Task DeleteAsync(int id) {\n    var user = await GetByIdAsync(id);\n    if(user != null) {\n      _context.Users.Remove(user);\n      await _context.SaveChangesAsync();\n    }\n  }\n  \n  public async Task<bool> ExistsAsync(int id) {\n    return await _context.Users.AnyAsync(u => u.Id == id);\n  }\n}\n\n// Service using repository\npublic class UserService {\n  private readonly IUserRepository _repo;\n  \n  public UserService(IUserRepository repo) {\n    _repo = repo;\n  }\n  \n  public async Task<UserDto> GetUserAsync(int id) {\n    var user = await _repo.GetByIdAsync(id);\n    return MapToDto(user);\n  }\n}',
      'typescript', E'// Repository interface\ninterface IUserRepository {\n  getById(id: number): Promise<User | null>;\n  getAll(): Promise<User[]>;\n  getByEmail(email: string): Promise<User | null>;\n  create(user: User): Promise<User>;\n  update(id: number, user: User): Promise<void>;\n  delete(id: number): Promise<void>;\n  exists(id: number): Promise<boolean>;\n}\n\n// Implementation\nclass UserRepository implements IUserRepository {\n  constructor(private db: Database) {}\n  \n  async getById(id: number): Promise<User | null> {\n    return this.db.query(''SELECT * FROM users WHERE id = $1'', [id]);\n  }\n  \n  async getAll(): Promise<User[]> {\n    return this.db.query(''SELECT * FROM users'');\n  }\n  \n  async getByEmail(email: string): Promise<User | null> {\n    return this.db.query(''SELECT * FROM users WHERE email = $1'', [email]);\n  }\n  \n  async create(user: User): Promise<User> {\n    return this.db.query(\n      ''INSERT INTO users (name, email) VALUES ($1, $2) RETURNING *'',\n      [user.name, user.email]\n    );\n  }\n  \n  async update(id: number, user: User): Promise<void> {\n    await this.db.query(\n      ''UPDATE users SET name = $1, email = $2 WHERE id = $3'',\n      [user.name, user.email, id]\n    );\n  }\n  \n  async delete(id: number): Promise<void> {\n    await this.db.query(''DELETE FROM users WHERE id = $1'', [id]);\n  }\n  \n  async exists(id: number): Promise<boolean> {\n    const result = await this.db.query(\n      ''SELECT 1 FROM users WHERE id = $1'',\n      [id]\n    );\n    return result !== null;\n  }\n}'
    ),
    E'Repository Pattern:\nService Layer\n    ↓\n[IUserRepository] interface\n    ↓ implements\n[UserRepository]\n    ↓\n EF Core / SQL\n    ↓\nDatabase\n\nBenefits:\n- Testable (mock IUserRepository)\n- Centralized queries\n- Abstraction over data source',
    116
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Repository purpose?', to_jsonb(ARRAY['UI', 'Abstract data access as collection', 'Business logic', 'Validation']), 1, 'Mediates between domain and data source.'),
    (current_term_id, 'Repository benefits?', to_jsonb(ARRAY['Performance', 'Testability and centralized queries', 'Security', 'Faster']), 1, 'Easy to mock for unit tests.'),
    (current_term_id, 'Repository should return?', to_jsonb(ARRAY['IQueryable (leaky)', 'Domain entities or collections', 'DTOs', 'DbContext']), 1, 'Concrete results, not IQueryable.'),
    (current_term_id, 'Repository with EF Core?', to_jsonb(ARRAY['Always required', 'Optional, EF Core is already abstraction', 'Never use', 'Required']), 1, 'DbContext is Unit of Work, repos optional.'),
    (current_term_id, 'Generic repository?', to_jsonb(ARRAY['Always best', 'Can over-engineer, prefer specific', 'Required', 'Bad practice']), 1, 'Specific repos better for unique queries.');

  RAISE NOTICE 'Added 15 final junior essential terms';
END $$;

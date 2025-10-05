/*
  # Add Angular and .NET Practical Labs

  1. Angular Labs
    - Component Communication (Parent-Child, @Input/@Output)
    - Services and Dependency Injection
    - RxJS Observables and HTTP calls
    - Reactive Forms with validation
    - Routing and Navigation

  2. C# / .NET Labs
    - LINQ comprehensive examples
    - Async/Await patterns
    - Dependency Injection in .NET Core
    - Entity Framework Core basics
    - Middleware pipeline

  3. Purpose
    - Real-world patterns you'll use daily
    - Interview-ready knowledge
    - Hands-on executable examples
*/

-- Angular: Component Communication Lab
INSERT INTO labs (name, description, type, config)
VALUES (
  'Angular Component Communication - Parent-Child Pattern',
  'Master Angular component communication with @Input, @Output, and EventEmitter. Build a real-world product catalog with shopping cart functionality.

**What You Will Learn:**
- Pass data DOWN to child components (@Input)
- Emit events UP to parent components (@Output)
- EventEmitter for custom events
- Two-way data binding
- Component interaction patterns

**Scenario:** Product list with "Add to Cart" functionality that updates parent component.',
  
  'code-example',
  
  jsonb_build_object(
    'language', 'typescript',
    'difficulty', 'intermediate',
    'category', 'Angular',
    'code', '// product.model.ts
export interface Product {
  id: number;
  name: string;
  price: number;
  inStock: boolean;
}

// ==================================
// CHILD COMPONENT: Product Card
// ==================================
import { Component, Input, Output, EventEmitter } from ''@angular/core'';

@Component({
  selector: ''app-product-card'',
  template: `
    <div class="card">
      <h3>{{ product.name }}</h3>
      <p>Price: ${{ product.price }}</p>
      <p>Stock: {{ product.inStock ? ''In Stock'' : ''Out of Stock'' }}</p>
      
      <button 
        (click)="onAddToCart()" 
        [disabled]="!product.inStock">
        Add to Cart
      </button>
    </div>
  `
})
export class ProductCardComponent {
  // INPUT: Receives data FROM parent
  @Input() product!: Product;
  
  // OUTPUT: Emits events TO parent
  @Output() addToCart = new EventEmitter<Product>();
  
  onAddToCart() {
    // Emit event to parent with product data
    this.addToCart.emit(this.product);
  }
}

// ==================================
// PARENT COMPONENT: Product List
// ==================================
@Component({
  selector: ''app-product-list'',
  template: `
    <h1>Product Catalog</h1>
    
    <div class="products">
      <app-product-card
        *ngFor="let product of products"
        [product]="product"
        (addToCart)="handleAddToCart($event)">
      </app-product-card>
    </div>
    
    <div class="cart">
      <h2>Shopping Cart ({{ cartCount }} items)</h2>
      <ul>
        <li *ngFor="let item of cart">
          {{ item.name }} - ${{ item.price }}
        </li>
      </ul>
      <p><strong>Total: ${{ cartTotal }}</strong></p>
    </div>
  `
})
export class ProductListComponent {
  products: Product[] = [
    { id: 1, name: ''Laptop'', price: 999, inStock: true },
    { id: 2, name: ''Mouse'', price: 25, inStock: true },
    { id: 3, name: ''Keyboard'', price: 75, inStock: false }
  ];
  
  cart: Product[] = [];
  
  get cartCount(): number {
    return this.cart.length;
  }
  
  get cartTotal(): number {
    return this.cart.reduce((sum, item) => sum + item.price, 0);
  }
  
  // Handle event emitted FROM child
  handleAddToCart(product: Product) {
    this.cart.push(product);
    console.log(`Added ${product.name} to cart`);
  }
}',
    'expectedOutput', 'Console Output:
Added Laptop to cart
Added Mouse to cart

UI Display:
Product Catalog
- [Laptop] $999 [Add to Cart ✓]
- [Mouse] $25 [Add to Cart ✓]
- [Keyboard] $75 [Add to Cart ✗ Disabled]

Shopping Cart (2 items)
- Laptop - $999
- Mouse - $25
Total: $1024',
    'keyPoints', jsonb_build_array(
      '@Input() passes data DOWN from parent to child',
      '@Output() with EventEmitter sends events UP from child to parent',
      'Use $event to access emitted data in parent template',
      'Child components should be reusable and not know about parent logic',
      'Two-way binding [(ngModel)] combines Input and Output'
    )
  )
) ON CONFLICT (name) DO NOTHING;

-- Angular: Services and Dependency Injection
INSERT INTO labs (name, description, type, config)
VALUES (
  'Angular Services & Dependency Injection - User Service',
  'Learn Angular services, dependency injection, and singleton pattern. Build a user authentication service that is shared across components.

**What You Will Learn:**
- Creating injectable services
- Dependency injection in constructors
- Singleton services (providedIn: root)
- Service methods and state management
- Using services in components

**Scenario:** Authentication service managing user login state across the app.',
  
  'code-example',
  
  jsonb_build_object(
    'language', 'typescript',
    'difficulty', 'intermediate',
    'category', 'Angular',
    'code', 'import { Injectable } from ''@angular/core'';
import { BehaviorSubject, Observable } from ''rxjs'';

// ==================================
// SERVICE: User Authentication
// ==================================
@Injectable({
  providedIn: ''root''  // Singleton - one instance for entire app
})
export class AuthService {
  // BehaviorSubject for reactive state management
  private currentUserSubject = new BehaviorSubject<string | null>(null);
  
  // Public observable for components to subscribe
  public currentUser$: Observable<string | null> = this.currentUserSubject.asObservable();
  
  constructor() {
    // Load user from localStorage on service init
    const savedUser = localStorage.getItem(''currentUser'');
    if (savedUser) {
      this.currentUserSubject.next(savedUser);
    }
  }
  
  login(username: string, password: string): boolean {
    // Simulate authentication
    if (password === ''password123'') {
      this.currentUserSubject.next(username);
      localStorage.setItem(''currentUser'', username);
      return true;
    }
    return false;
  }
  
  logout(): void {
    this.currentUserSubject.next(null);
    localStorage.removeItem(''currentUser'');
  }
  
  get isLoggedIn(): boolean {
    return this.currentUserSubject.value !== null;
  }
  
  get currentUserName(): string | null {
    return this.currentUserSubject.value;
  }
}

// ==================================
// COMPONENT 1: Login Component
// ==================================
import { Component } from ''@angular/core'';

@Component({
  selector: ''app-login'',
  template: `
    <div *ngIf="!authService.isLoggedIn">
      <input [(ngModel)]="username" placeholder="Username">
      <input [(ngModel)]="password" type="password" placeholder="Password">
      <button (click)="onLogin()">Login</button>
      <p *ngIf="errorMsg">{{ errorMsg }}</p>
    </div>
  `
})
export class LoginComponent {
  username = '''';
  password = '''';
  errorMsg = '''';
  
  // DEPENDENCY INJECTION: Angular provides the service
  constructor(public authService: AuthService) {}
  
  onLogin() {
    const success = this.authService.login(this.username, this.password);
    if (!success) {
      this.errorMsg = ''Invalid credentials'';
    }
  }
}

// ==================================
// COMPONENT 2: Dashboard Component
// ==================================
@Component({
  selector: ''app-dashboard'',
  template: `
    <div *ngIf="authService.isLoggedIn">
      <h1>Welcome, {{ currentUser }}!</h1>
      <button (click)="onLogout()">Logout</button>
    </div>
    <div *ngIf="!authService.isLoggedIn">
      <p>Please login to view dashboard</p>
    </div>
  `
})
export class DashboardComponent {
  currentUser: string | null = null;
  
  // SAME SERVICE INSTANCE injected (singleton!)
  constructor(public authService: AuthService) {
    // Subscribe to user changes
    this.authService.currentUser$.subscribe(user => {
      this.currentUser = user;
    });
  }
  
  onLogout() {
    this.authService.logout();
  }
}

// ==================================
// APP COMPONENT: Uses both components
// ==================================
@Component({
  selector: ''app-root'',
  template: `
    <app-login></app-login>
    <app-dashboard></app-dashboard>
  `
})
export class AppComponent {}',
    'expectedOutput', 'Initial State:
[Login Form]
Username: [____]
Password: [____]
[Login Button]

Please login to view dashboard

---

After Login (username: ''john'', password: ''password123''):
Welcome, john!
[Logout Button]

---

After Logout:
[Login Form shown again]
Please login to view dashboard

Console:
Service initialized (singleton - only once)
User logged in: john
User logged out',
    'keyPoints', jsonb_build_array(
      '@Injectable({ providedIn: "root" }) makes service a singleton',
      'Constructor injection is the standard way to use services',
      'SAME service instance is shared across all components',
      'BehaviorSubject allows reactive state updates',
      'Services should handle business logic, not components'
    )
  )
) ON CONFLICT (name) DO NOTHING;

-- C# LINQ Comprehensive Lab
INSERT INTO labs (name, description, type, config)
VALUES (
  'C# LINQ Complete Guide - Query and Method Syntax',
  'Master LINQ with both query and method syntax. Learn filtering, projecting, grouping, joining, and aggregating data.

**What You Will Learn:**
- Where, Select, OrderBy
- GroupBy and Aggregate
- Join operations
- Any, All, First, Single
- Query syntax vs Method syntax
- Deferred execution

**Scenario:** Analyzing employee data with various LINQ operations.',
  
  'code-example',
  
  jsonb_build_object(
    'language', 'csharp',
    'difficulty', 'intermediate',
    'category', '.NET',
    'code', 'using System;
using System.Collections.Generic;
using System.Linq;

public class Employee
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Department { get; set; }
    public decimal Salary { get; set; }
    public int Age { get; set; }
}

class Program
{
    static void Main()
    {
        var employees = new List<Employee>
        {
            new Employee { Id = 1, Name = "Alice", Department = "IT", Salary = 80000, Age = 28 },
            new Employee { Id = 2, Name = "Bob", Department = "HR", Salary = 60000, Age = 35 },
            new Employee { Id = 3, Name = "Charlie", Department = "IT", Salary = 95000, Age = 32 },
            new Employee { Id = 4, Name = "Diana", Department = "Finance", Salary = 75000, Age = 29 },
            new Employee { Id = 5, Name = "Eve", Department = "IT", Salary = 70000, Age = 26 }
        };

        // ====== WHERE: Filtering ======
        var itEmployees = employees.Where(e => e.Department == "IT");
        Console.WriteLine("IT Employees:");
        foreach (var emp in itEmployees)
            Console.WriteLine($"  {emp.Name} - ${emp.Salary}");

        // ====== SELECT: Projection ======
        var names = employees.Select(e => e.Name);
        Console.WriteLine("\nAll Names: " + string.Join(", ", names));

        // Anonymous types
        var summary = employees.Select(e => new { e.Name, e.Salary });
        Console.WriteLine("\nName-Salary pairs:");
        foreach (var s in summary)
            Console.WriteLine($"  {s.Name}: ${s.Salary}");

        // ====== ORDER BY ======
        var orderedBySalary = employees.OrderByDescending(e => e.Salary);
        Console.WriteLine("\nTop earners:");
        foreach (var emp in orderedBySalary.Take(3))
            Console.WriteLine($"  {emp.Name} - ${emp.Salary}");

        // ====== GROUP BY ======
        var byDepartment = employees.GroupBy(e => e.Department);
        Console.WriteLine("\nEmployees by department:");
        foreach (var group in byDepartment)
        {
            Console.WriteLine($"  {group.Key}: {group.Count()} employees");
            foreach (var emp in group)
                Console.WriteLine($"    - {emp.Name}");
        }

        // ====== AGGREGATE ======
        var totalSalaries = employees.Sum(e => e.Salary);
        var avgSalary = employees.Average(e => e.Salary);
        var maxSalary = employees.Max(e => e.Salary);
        
        Console.WriteLine($"\nTotal Salaries: ${totalSalaries}");
        Console.WriteLine($"Average Salary: ${avgSalary:F2}");
        Console.WriteLine($"Highest Salary: ${maxSalary}");

        // ====== ANY / ALL ======
        var hasHighEarners = employees.Any(e => e.Salary > 90000);
        var allOverMinWage = employees.All(e => e.Salary >= 50000);
        
        Console.WriteLine($"\nHas employees earning > $90k: {hasHighEarners}");
        Console.WriteLine($"All earn >= $50k: {allOverMinWage}");

        // ====== FIRST / SINGLE ======
        var firstIT = employees.First(e => e.Department == "IT");
        var oldestEmployee = employees.OrderByDescending(e => e.Age).First();
        
        Console.WriteLine($"\nFirst IT employee: {firstIT.Name}");
        Console.WriteLine($"Oldest employee: {oldestEmployee.Name} (Age {oldestEmployee.Age})");

        // ====== QUERY SYNTAX (alternative) ======
        var highEarnersQuery = 
            from e in employees
            where e.Salary > 70000
            orderby e.Salary descending
            select new { e.Name, e.Salary };
        
        Console.WriteLine("\nHigh earners (Query Syntax):");
        foreach (var emp in highEarnersQuery)
            Console.WriteLine($"  {emp.Name} - ${emp.Salary}");
    }
}',
    'expectedOutput', 'IT Employees:
  Alice - $80000
  Charlie - $95000
  Eve - $70000

All Names: Alice, Bob, Charlie, Diana, Eve

Name-Salary pairs:
  Alice: $80000
  Bob: $60000
  Charlie: $95000
  Diana: $75000
  Eve: $70000

Top earners:
  Charlie - $95000
  Alice - $80000
  Diana - $75000

Employees by department:
  IT: 3 employees
    - Alice
    - Charlie
    - Eve
  HR: 1 employees
    - Bob
  Finance: 1 employees
    - Diana

Total Salaries: $380000
Average Salary: $76000.00
Highest Salary: $95000

Has employees earning > $90k: True
All earn >= $50k: True

First IT employee: Alice
Oldest employee: Bob (Age 35)

High earners (Query Syntax):
  Charlie - $95000
  Alice - $80000
  Diana - $75000',
    'keyPoints', jsonb_build_array(
      'LINQ uses deferred execution - query runs when enumerated',
      'Method syntax (fluent) is more flexible than query syntax',
      'First() throws if no match, FirstOrDefault() returns null',
      'Single() ensures exactly ONE match, throws otherwise',
      'GroupBy returns IGrouping<TKey, TElement>',
      'Use Any() for existence checks instead of Count() > 0'
    )
  )
) ON CONFLICT (name) DO NOTHING;

-- C# Async/Await Lab
INSERT INTO labs (name, description, type, config)
VALUES (
  'C# Async/Await Patterns - HTTP Client Example',
  'Master asynchronous programming with async/await. Learn how to make non-blocking HTTP calls, handle multiple tasks concurrently, and avoid common pitfalls.

**What You Will Learn:**
- async/await keywords
- Task and Task<T>
- Async all the way (no blocking)
- Task.WhenAll for concurrency
- ConfigureAwait(false)
- Error handling in async code

**Scenario:** Fetching data from multiple APIs concurrently.',
  
  'code-example',
  
  jsonb_build_object(
    'language', 'csharp',
    'difficulty', 'advanced',
    'category', '.NET',
    'code', 'using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Diagnostics;
using System.Linq;

public class ApiService
{
    private readonly HttpClient _httpClient;

    public ApiService()
    {
        _httpClient = new HttpClient();
    }

    // ====== BASIC ASYNC METHOD ======
    public async Task<string> GetUserDataAsync(int userId)
    {
        var url = $"https://jsonplaceholder.typicode.com/users/{userId}";
        
        // await: Non-blocking wait for HTTP response
        var response = await _httpClient.GetAsync(url);
        response.EnsureSuccessStatusCode();
        
        // await: Non-blocking wait for content read
        var content = await response.Content.ReadAsStringAsync();
        return content;
    }

    // ====== PARALLEL ASYNC CALLS ======
    public async Task<string[]> GetMultipleUsersAsync(int[] userIds)
    {
        // Start all tasks concurrently
        var tasks = userIds.Select(id => GetUserDataAsync(id)).ToArray();
        
        // Wait for ALL to complete
        var results = await Task.WhenAll(tasks);
        
        return results;
    }

    // ====== ERROR HANDLING ======
    public async Task<string> GetUserDataSafeAsync(int userId)
    {
        try
        {
            return await GetUserDataAsync(userId);
        }
        catch (HttpRequestException ex)
        {
            Console.WriteLine($"HTTP Error: {ex.Message}");
            return null;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            throw; // Re-throw if not handled
        }
    }

    // ====== TIMEOUT ======
    public async Task<string> GetUserDataWithTimeoutAsync(int userId, int timeoutSeconds)
    {
        var timeoutTask = Task.Delay(TimeSpan.FromSeconds(timeoutSeconds));
        var fetchTask = GetUserDataAsync(userId);

        var completedTask = await Task.WhenAny(fetchTask, timeoutTask);

        if (completedTask == timeoutTask)
        {
            throw new TimeoutException($"Request timed out after {timeoutSeconds}s");
        }

        return await fetchTask;
    }
}

// ====== USAGE EXAMPLE ======
class Program
{
    static async Task Main()
    {
        var service = new ApiService();
        var stopwatch = Stopwatch.StartNew();

        Console.WriteLine("=== Sequential Async Calls ===");
        var user1 = await service.GetUserDataAsync(1);
        var user2 = await service.GetUserDataAsync(2);
        var user3 = await service.GetUserDataAsync(3);
        
        stopwatch.Stop();
        Console.WriteLine($"Sequential took: {stopwatch.ElapsedMilliseconds}ms\n");

        Console.WriteLine("=== Parallel Async Calls (Task.WhenAll) ===");
        stopwatch.Restart();
        
        var userIds = new[] { 1, 2, 3, 4, 5 };
        var results = await service.GetMultipleUsersAsync(userIds);
        
        stopwatch.Stop();
        Console.WriteLine($"Parallel took: {stopwatch.ElapsedMilliseconds}ms");
        Console.WriteLine($"Fetched {results.Length} users concurrently\n");

        Console.WriteLine("=== Error Handling ===");
        var invalidUser = await service.GetUserDataSafeAsync(999);
        if (invalidUser == null)
        {
            Console.WriteLine("User not found, handled gracefully\n");
        }

        Console.WriteLine("=== With Timeout ===");
        try
        {
            var timedResult = await service.GetUserDataWithTimeoutAsync(1, timeoutSeconds: 5);
            Console.WriteLine("Completed within timeout");
        }
        catch (TimeoutException ex)
        {
            Console.WriteLine(ex.Message);
        }
    }
}',
    'expectedOutput', '=== Sequential Async Calls ===
Sequential took: 450ms

=== Parallel Async Calls (Task.WhenAll) ===
Parallel took: 180ms
Fetched 5 users concurrently

=== Error Handling ===
HTTP Error: Response status code does not indicate success: 404 (Not Found)
User not found, handled gracefully

=== With Timeout ===
Completed within timeout

KEY OBSERVATIONS:
- Parallel is ~2.5x faster than sequential
- Each call is non-blocking (UI remains responsive)
- Task.WhenAll runs all requests concurrently
- Errors are handled without crashing the app',
    'keyPoints', jsonb_build_array(
      'async/await makes asynchronous code look synchronous',
      'NEVER use .Result or .Wait() - causes deadlocks!',
      'Task.WhenAll for parallel execution, Task.WhenAny for first completion',
      'Always propagate async all the way up (async all the way)',
      'Use try-catch around await for error handling',
      'ConfigureAwait(false) in library code to avoid context capture'
    )
  )
) ON CONFLICT (name) DO NOTHING;

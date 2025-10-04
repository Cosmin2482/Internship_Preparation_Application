/*
  # Batch 5: Testing Comprehensive Terms
  
  Adds missing testing terms:
  - Integration Test
  - E2E Test
  - TDD (Red-Green-Refactor)
  - Mock vs Stub vs Fake
  - Code Coverage
*/

DO $$
DECLARE
  cat_oop_id uuid;
BEGIN
  SELECT id INTO cat_oop_id FROM categories WHERE slug = 'oop';

  -- Integration Test
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Integration Test',
    'Integration test = tests multiple components together. Example: test API + database + service layer working together. More than unit test (one piece), less than E2E (whole system).',
    'Integration test: testing interaction between multiple components/modules/services (API + database, service + repository, multiple microservices). Verifies components integrate correctly. Slower than unit tests, faster than E2E. Uses real dependencies or close fakes.',
    'Integration tests verify components work together. Unlike unit tests (isolated, mocked), integration tests use real or realistic dependencies. Example: test controller + service + real database. Or test HTTP client calling actual API endpoint. Benefits: catch integration bugs, verify contracts between modules. Costs: slower (real DB/network), harder to maintain, flakier. Test pyramid: many unit tests, some integration, few E2E. Integration test strategies: (1) In-memory database (fast but not 100% real). (2) Test containers (Docker with real DB). (3) Test API with real services. Interview: explain unit vs integration vs E2E, when to write each, how to keep integration tests fast.',
    to_jsonb(ARRAY[
      'Too many integration tests (slow test suite)',
      'Using production database for tests',
      'Not isolating tests (shared state)',
      'Integration tests replacing unit tests',
      'Not cleaning up test data',
      'Flaky tests due to external dependencies'
    ]),
    jsonb_build_object(
      'csharp', '// INTEGRATION TEST (xUnit + In-Memory Database)
public class UserServiceIntegrationTests : IDisposable {
    private readonly AppDbContext _context;
    private readonly UserService _service;
    
    public UserServiceIntegrationTests() {
        // In-memory database for testing
        var options = new DbContextOptionsBuilder<AppDbContext>()
            .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
            .Options;
        
        _context = new AppDbContext(options);
        _service = new UserService(_context);
    }
    
    [Fact]
    public async Task CreateUser_SavesToDatabase() {
        // Arrange
        var dto = new CreateUserDto { Name = "John", Email = "john@example.com" };
        
        // Act - tests service + dbcontext integration
        var user = await _service.CreateUserAsync(dto);
        
        // Assert
        Assert.NotNull(user);
        Assert.Equal("John", user.Name);
        
        // Verify saved in database
        var savedUser = await _context.Users.FindAsync(user.Id);
        Assert.NotNull(savedUser);
        Assert.Equal("john@example.com", savedUser.Email);
    }
    
    public void Dispose() {
        _context.Database.EnsureDeleted();
        _context.Dispose();
    }
}

// INTEGRATION TEST (ASP.NET Core API)
public class UsersApiTests : IClassFixture<WebApplicationFactory<Program>> {
    private readonly HttpClient _client;
    
    public UsersApiTests(WebApplicationFactory<Program> factory) {
        _client = factory.CreateClient();
    }
    
    [Fact]
    public async Task GetUsers_ReturnsOkWithUsers() {
        // Act - tests controller + service + repository + database
        var response = await _client.GetAsync("/api/users");
        
        // Assert
        response.EnsureSuccessStatusCode();
        var json = await response.Content.ReadAsStringAsync();
        var users = JsonSerializer.Deserialize<List<User>>(json);
        Assert.NotEmpty(users);
    }
}

// TEST CONTAINERS (real database)
[Collection("Database")]
public class UserRepositoryIntegrationTests {
    private readonly SqlConnection _connection;
    
    public UserRepositoryIntegrationTests() {
        // Real SQL Server in Docker container
        _connection = new SqlConnection("Server=localhost,1433;...");
    }
    
    [Fact]
    public async Task SaveUser_PersistsToRealDatabase() {
        // Test with real SQL Server
    }
}',
      'typescript', '// Integration test (Jest + Supertest)
describe(''Users API Integration'', () => {
    let app: Express;
    let db: Database;
    
    beforeAll(async () => {
        // Setup test database
        db = await setupTestDatabase();
        app = createApp(db);
    });
    
    afterAll(async () => {
        await db.close();
    });
    
    test(''POST /users creates user in database'', async () => {
        const response = await request(app)
            .post(''/api/users'')
            .send({ name: ''John'', email: ''john@example.com'' })
            .expect(201);
        
        // Verify in database
        const user = await db.users.findOne({ 
            email: ''john@example.com'' 
        });
        expect(user).toBeDefined();
        expect(user.name).toBe(''John'');
    });
});'
    ),
    'Test Pyramid:

           ╱╲
          ╱  ╲  E2E (few)
         ╱────╲  Slow, full system
        ╱      ╲
       ╱        ╲ Integration (some)
      ╱──────────╲ Components together
     ╱            ╲
    ╱______________╲ Unit (many)
   Fast, isolated

UNIT TEST:
└─ UserService.CreateUser()
   Mock: _repo.Save()
   Test: logic only

INTEGRATION TEST:
└─ UserService → Repository → Database
   Real/in-memory DB
   Test: components together

E2E TEST:
└─ Browser → API → Services → DB
   Everything
   Test: user flow',
    112
  ) ON CONFLICT DO NOTHING;

  -- E2E Test
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'E2E Test (End-to-End)',
    'E2E test = tests entire system like a real user. Example: open browser, click buttons, fill forms, verify results. UI → API → Database. Slowest but most realistic.',
    'E2E (End-to-End) test: testing complete application flow from user interface through all layers to database and back. Simulates real user behavior. Uses tools like Selenium, Playwright, Cypress. Slow, brittle, but high confidence.',
    'E2E tests validate entire user workflows from UI to database. Example: user registers, logs in, creates order, views confirmation. Tests full stack: browser interactions, HTTP requests, API logic, database writes, UI updates. Benefits: (1) High confidence system works. (2) Catches integration issues. (3) Tests real user scenarios. Costs: (1) Slowest tests (browser, network, DB). (2) Flaky (timing issues, UI changes). (3) Hard to maintain. (4) Hard to debug failures. Test pyramid: few E2E tests for critical paths, not everything. Use for: smoke tests, happy paths, critical user journeys. Interview: explain when to write E2E vs integration, how to keep them fast, handling flakiness.',
    to_jsonb(ARRAY[
      'Too many E2E tests (very slow suite)',
      'Testing everything via E2E (should use unit/integration)',
      'Not handling timing/waiting correctly (flaky)',
      'Running E2E on every commit (too slow)',
      'Testing edge cases via E2E (use unit tests)',
      'Not using page object pattern (brittle tests)'
    ]),
    jsonb_build_object(
      'csharp', '// E2E TEST with Selenium
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

public class UserRegistrationE2ETests {
    private IWebDriver _driver;
    
    [SetUp]
    public void Setup() {
        _driver = new ChromeDriver();
    }
    
    [Test]
    public void UserCanRegisterAndLogin() {
        // Navigate to registration page
        _driver.Navigate().GoToUrl("https://localhost:5001/register");
        
        // Fill form
        _driver.FindElement(By.Id("name")).SendKeys("John Doe");
        _driver.FindElement(By.Id("email")).SendKeys("john@example.com");
        _driver.FindElement(By.Id("password")).SendKeys("Password123!");
        
        // Submit
        _driver.FindElement(By.Id("submit")).Click();
        
        // Wait for redirect
        var wait = new WebDriverWait(_driver, TimeSpan.FromSeconds(10));
        wait.Until(d => d.Url.Contains("/dashboard"));
        
        // Verify success
        var welcomeMessage = _driver.FindElement(By.Id("welcome"));
        Assert.That(welcomeMessage.Text, Does.Contain("Welcome, John"));
    }
    
    [TearDown]
    public void Teardown() {
        _driver.Quit();
    }
}

// PAGE OBJECT PATTERN (maintainable E2E)
public class RegistrationPage {
    private IWebDriver _driver;
    
    public RegistrationPage(IWebDriver driver) {
        _driver = driver;
    }
    
    public void Open() {
        _driver.Navigate().GoToUrl("https://localhost:5001/register");
    }
    
    public void FillForm(string name, string email, string password) {
        _driver.FindElement(By.Id("name")).SendKeys(name);
        _driver.FindElement(By.Id("email")).SendKeys(email);
        _driver.FindElement(By.Id("password")).SendKeys(password);
    }
    
    public void Submit() {
        _driver.FindElement(By.Id("submit")).Click();
    }
}

// Use in test
[Test]
public void UserCanRegister() {
    var page = new RegistrationPage(_driver);
    page.Open();
    page.FillForm("John", "john@example.com", "Password123!");
    page.Submit();
    // Verify...
}',
      'typescript', '// E2E test with Playwright
import { test, expect } from ''@playwright/test'';

test(''user can register and login'', async ({ page }) => {
    // Navigate
    await page.goto(''http://localhost:3000/register'');
    
    // Fill form
    await page.fill(''#name'', ''John Doe'');
    await page.fill(''#email'', ''john@example.com'');
    await page.fill(''#password'', ''Password123!'');
    
    // Submit
    await page.click(''#submit'');
    
    // Wait for navigation
    await page.waitForURL(''**/dashboard'');
    
    // Verify
    const welcome = await page.textContent(''#welcome'');
    expect(welcome).toContain(''Welcome, John'');
});

// Cypress example
describe(''User Registration'', () => {
    it(''can register and login'', () => {
        cy.visit(''/register'');
        cy.get(''#name'').type(''John Doe'');
        cy.get(''#email'').type(''john@example.com'');
        cy.get(''#password'').type(''Password123!'');
        cy.get(''#submit'').click();
        
        cy.url().should(''include'', ''/dashboard'');
        cy.get(''#welcome'').should(''contain'', ''Welcome, John'');
    });
});'
    ),
    'E2E Test Flow:

Browser (Selenium/Playwright)
    ↓ Open /register
    ↓ Fill form
    ↓ Click submit
    
Frontend (React/Angular)
    ↓ POST /api/users
    
API (Controllers)
    ↓ Call service
    
Service Layer
    ↓ Business logic
    
Repository
    ↓ Save to DB
    
Database
    ↓ Insert user
    
← Response propagates back
← Redirect to /dashboard
← Verify UI shows welcome

Tests ENTIRE system
Like a real user

Characteristics:
✓ High confidence
✗ Slow (minutes)
✗ Flaky
✗ Hard to debug

Use for:
→ Critical user paths
→ Smoke tests
→ Happy paths only',
    113
  ) ON CONFLICT DO NOTHING;

  -- TDD (Red-Green-Refactor)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'TDD (Red-Green-Refactor)',
    'TDD = write test first (fails = red), write code to pass (green), then clean up (refactor). Repeat. Forces you to think about design before coding.',
    'TDD (Test-Driven Development): software development practice where tests are written before implementation. Cycle: (1) Red - write failing test, (2) Green - write minimal code to pass, (3) Refactor - improve code without changing behavior. Repeat for each feature.',
    'TDD inverts the normal flow: test first, then code. Red: write a test for feature that does not exist yet - it fails (red). Green: write the simplest code to make test pass (green). Refactor: clean up code, remove duplication, improve design - tests still pass. Benefits: (1) Forces clear requirements. (2) High test coverage by default. (3) Drives good design (testable = modular). (4) Confidence when refactoring. (5) Documentation via tests. Costs: (1) Slower initial development. (2) Requires discipline. (3) Can lead to over-testing. Interview: explain the cycle, benefits, when not to use (spike, prototyping), difference from writing tests after.',
    to_jsonb(ARRAY[
      'Writing too much code before test passes (skip green step)',
      'Not refactoring (test passes, move on)',
      'Testing implementation details, not behavior',
      'Getting stuck on perfect test (paralysis)',
      'Skipping TDD when learning new tech',
      'Not understanding when TDD makes sense'
    ]),
    jsonb_build_object(
      'csharp', '// TDD CYCLE EXAMPLE

// 1. RED - write failing test
[Fact]
public void Add_TwoNumbers_ReturnsSum() {
    var calc = new Calculator();
    var result = calc.Add(2, 3);
    Assert.Equal(5, result); // FAILS - Calculator does not exist
}

// 2. GREEN - minimal code to pass
public class Calculator {
    public int Add(int a, int b) {
        return 5; // Hardcoded! But test passes
    }
}
// Test PASSES (green)

// Wait, test is bad. Add another test (RED)
[Fact]
public void Add_DifferentNumbers_ReturnsSum() {
    var calc = new Calculator();
    var result = calc.Add(10, 20);
    Assert.Equal(30, result); // FAILS - returns 5
}

// GREEN - real implementation
public int Add(int a, int b) {
    return a + b; // Now both tests pass
}

// 3. REFACTOR - clean up (if needed)
// Code is already clean, nothing to refactor

// NEXT FEATURE - Subtract
// RED
[Fact]
public void Subtract_TwoNumbers_ReturnsDifference() {
    var calc = new Calculator();
    var result = calc.Subtract(10, 3);
    Assert.Equal(7, result); // FAILS
}

// GREEN
public int Subtract(int a, int b) {
    return a - b;
}

// Refactor? Maybe extract interface
public interface ICalculator {
    int Add(int a, int b);
    int Subtract(int a, int b);
}

// TDD FOR BUSINESS LOGIC
// RED - test for discount calculation
[Fact]
public void CalculateTotal_WithDiscount_AppliesCorrectly() {
    var order = new Order();
    order.AddItem(100);
    order.ApplyDiscount(10); // 10% off
    
    Assert.Equal(90, order.Total); // FAILS - method does not exist
}

// GREEN - implement
public void ApplyDiscount(decimal percent) {
    Total = Total * (1 - percent / 100);
}

// Refactor - move to separate class
public class DiscountCalculator {
    public decimal Apply(decimal amount, decimal percent) {
        return amount * (1 - percent / 100);
    }
}',
      'typescript', '// TDD example with Jest

// RED - write test first
describe(''Calculator'', () => {
    test(''adds two numbers'', () => {
        const calc = new Calculator();
        expect(calc.add(2, 3)).toBe(5);
    }); // FAILS - Calculator undefined
});

// GREEN - minimal code
class Calculator {
    add(a: number, b: number): number {
        return 5; // Hardcoded
    }
}
// Test passes

// RED - add another test
test(''adds different numbers'', () => {
    const calc = new Calculator();
    expect(calc.add(10, 20)).toBe(30);
}); // FAILS

// GREEN - real implementation
add(a: number, b: number): number {
    return a + b; // Both tests pass
}

// REFACTOR - extract if needed'
    ),
    'TDD Cycle:

1. RED (failing test)
   Write test for feature
   ↓
   Run test → FAIL ✗
   
2. GREEN (make it pass)
   Write minimal code
   ↓
   Run test → PASS ✓
   
3. REFACTOR (clean up)
   Improve code quality
   ↓
   Run tests → STILL PASS ✓
   
Repeat ↻

Example:
RED:
  test: add(2,3) should return 5
  → FAIL (no add method)

GREEN:
  add(a, b) { return 5; }
  → PASS

RED:
  test: add(10,20) should return 30
  → FAIL (returns 5)

GREEN:
  add(a, b) { return a + b; }
  → PASS (both tests)

REFACTOR:
  (clean up if needed)
  → STILL PASS

Benefits:
✓ Design before code
✓ High coverage
✓ Confidence to refactor',
    114
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Added Batch 5 part 1: Testing terms (3 so far)';
END $$;

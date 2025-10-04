/*
  # Batch 5 Part 2: Testing - Mocks and Coverage
  
  Adds: Mock vs Stub vs Fake, Code Coverage
*/

DO $$
DECLARE
  cat_oop_id uuid;
BEGIN
  SELECT id INTO cat_oop_id FROM categories WHERE slug = 'oop';

  -- Mock vs Stub vs Fake
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Mock vs Stub vs Fake',
    'Stub = provides canned answers. Mock = records calls and verifies expectations. Fake = working lightweight implementation (in-memory DB). All are test doubles replacing real dependencies.',
    'Test doubles: objects replacing real dependencies in tests. Stub: returns predefined values, no verification. Mock: programmable object that verifies interactions (method called? right params?). Fake: simplified working implementation (e.g., in-memory database instead of SQL). Dummy: passed but never used.',
    'Three main types of test doubles. Stub: provides data without verification - "when GetUser called, return this user". Used when you need data but do not care how it was obtained. Mock: verifies interactions - "GetUser must be called exactly once with id=5". Used when testing behavior and communication between objects. Fake: real implementation but simplified - in-memory database, fake HTTP server. Used when you need realistic behavior but faster/simpler. Interview: explain each with example, when to use each (mocks for interaction testing, stubs for state testing, fakes for complex dependencies). Moq is popular .NET mock framework.',
    to_jsonb(ARRAY[
      'Overusing mocks (test becomes fragile)',
      'Mocking everything (test implementation, not behavior)',
      'Confusing stubs with mocks',
      'Over-verifying with mocks (too strict)',
      'Not using fakes when appropriate',
      'Mocks testing private implementation details'
    ]),
    jsonb_build_object(
      'csharp', '// STUB - provides data
public class UserRepositoryStub : IUserRepository {
    public User GetUser(int id) {
        // Always returns same user
        return new User { Id = id, Name = "Test User" };
    }
}

[Fact]
public void GetUserProfile_ReturnsUserName() {
    var repoStub = new UserRepositoryStub();
    var service = new UserService(repoStub);
    
    var profile = service.GetUserProfile(1);
    
    Assert.Equal("Test User", profile.Name);
    // No verification of how stub was called
}

// MOCK - verifies interactions (with Moq)
[Fact]
public void CreateUser_CallsRepositorySave() {
    var mockRepo = new Mock<IUserRepository>();
    mockRepo.Setup(r => r.Save(It.IsAny<User>()))
            .Returns(true);
    
    var service = new UserService(mockRepo.Object);
    service.CreateUser("John", "john@example.com");
    
    // VERIFY interaction
    mockRepo.Verify(
        r => r.Save(It.Is<User>(u => u.Name == "John")),
        Times.Once // Must be called exactly once
    );
}

// FAKE - simplified real implementation
public class InMemoryUserRepository : IUserRepository {
    private List<User> _users = new List<User>();
    
    public void Save(User user) {
        _users.Add(user);
    }
    
    public User GetUser(int id) {
        return _users.FirstOrDefault(u => u.Id == id);
    }
}

[Fact]
public void CreateAndRetrieveUser_Works() {
    var fakeRepo = new InMemoryUserRepository();
    var service = new UserService(fakeRepo);
    
    service.CreateUser("John", "john@example.com");
    var user = service.GetUserById(1);
    
    Assert.NotNull(user);
    Assert.Equal("John", user.Name);
    // Fake behaves like real repo, just in-memory
}

// MOCK SETUP WITH SPECIFIC PARAMS
mockRepo.Setup(r => r.GetUser(5))
        .Returns(new User { Id = 5, Name = "Alice" });

mockRepo.Setup(r => r.GetUser(It.IsInRange(1, 10, Range.Inclusive)))
        .Returns(new User { Name = "Any user 1-10" });

// MOCK THROWS EXCEPTION
mockRepo.Setup(r => r.GetUser(999))
        .Throws<NotFoundException>();

// VERIFY with arguments
mockRepo.Verify(r => r.Delete(It.Is<int>(id => id > 0)), Times.Once);

// VERIFY never called
mockRepo.Verify(r => r.Delete(It.IsAny<int>()), Times.Never);',
      'typescript', '// Jest mocking

// STUB
const userRepositoryStub = {
    getUser: (id: number) => ({ 
        id, 
        name: ''Test User'' 
    })
};

test(''getUserProfile returns user name'', () => {
    const service = new UserService(userRepositoryStub);
    const profile = service.getUserProfile(1);
    expect(profile.name).toBe(''Test User'');
});

// MOCK (with verification)
const mockRepo = {
    save: jest.fn().mockResolvedValue(true)
};

test(''createUser calls repository save'', async () => {
    const service = new UserService(mockRepo);
    await service.createUser(''John'', ''john@example.com'');
    
    // VERIFY called
    expect(mockRepo.save).toHaveBeenCalledTimes(1);
    expect(mockRepo.save).toHaveBeenCalledWith(
        expect.objectContaining({ name: ''John'' })
    );
});

// FAKE
class InMemoryUserRepository {
    private users: User[] = [];
    
    save(user: User): void {
        this.users.push(user);
    }
    
    getUser(id: number): User | null {
        return this.users.find(u => u.id === id) ?? null;
    }
}

test(''create and retrieve user works'', () => {
    const fakeRepo = new InMemoryUserRepository();
    const service = new UserService(fakeRepo);
    
    service.createUser(''John'', ''john@example.com'');
    const user = service.getUserById(1);
    
    expect(user).toBeDefined();
    expect(user?.name).toBe(''John'');
});'
    ),
    'Test Doubles:

STUB (state verification):
IUserRepository stub
└─ GetUser(5) → User{Name:"Test"}
   └─ Just returns data
   └─ No verification

Test: Does result have correct name? ✓

MOCK (behavior verification):
Mock<IUserRepository>
└─ Setup: Save(any) → true
└─ Verify: Save called once ✓

Test: Was Save called correctly? ✓

FAKE (real behavior):
InMemoryUserRepository
├─ List<User> _users
├─ Save(u) → _users.Add(u)
└─ GetUser(id) → _users.Find(...)

Real logic, just in-memory
Works like production

When to use:
Stub → Need data, do not care how
Mock → Test interactions/calls
Fake → Need realistic behavior',
    115
  ) ON CONFLICT DO NOTHING;

  -- Code Coverage
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Code Coverage',
    'Code coverage = % of code executed by tests. 80% coverage = tests run 80% of lines. Higher is better BUT quality > quantity. 100% coverage does not mean bug-free.',
    'Code coverage: metric measuring percentage of code (lines, branches, methods) executed during test runs. Types: line coverage, branch coverage, method coverage. Tool-generated reports show covered/uncovered code. Goal: identify untested code, but not sole quality metric.',
    'Code coverage measures how much of your codebase tests actually execute. 70% line coverage = tests run 70% of lines. Tools (coverlet, dotCover) instrument code and track execution. Types: (1) Line coverage - % lines executed. (2) Branch coverage - % if/else paths taken. (3) Method coverage - % methods called. Interview points: (1) Coverage is not quality - can have high coverage with bad tests. (2) 80-90% is good target, 100% often not worth effort. (3) Focus on critical paths, complex logic. (4) Uncovered code is risk but do not test trivial getters/setters. (5) Branch coverage > line coverage (catches missed conditions). Use coverage to find gaps, not as goal itself.',
    to_jsonb(ARRAY[
      'Chasing 100% coverage (diminishing returns)',
      'High coverage with poor test quality (checking nothing)',
      'Ignoring branch coverage (only checking line)',
      'Testing trivial code to boost numbers',
      'Using coverage as only quality metric',
      'Not reviewing what is uncovered (blindly trusting metric)'
    ]),
    jsonb_build_object(
      'csharp', '// GENERATING COVERAGE (coverlet + reportgenerator)

// 1. Install coverlet
// dotnet add package coverlet.collector

// 2. Run tests with coverage
// dotnet test --collect:"XPlat Code Coverage"

// 3. Generate report
// reportgenerator -reports:**/coverage.cobertura.xml -targetdir:coverage

// EXAMPLE CODE
public class Calculator {
    public int Divide(int a, int b) {
        if (b == 0) {                    // Branch 1
            throw new DivideByZeroException();
        }
        return a / b;                    // Branch 2
    }
}

// POOR TEST (low branch coverage)
[Fact]
public void Divide_ValidNumbers_ReturnsQuotient() {
    var calc = new Calculator();
    var result = calc.Divide(10, 2);
    Assert.Equal(5, result);
}
// LINE COVERAGE: 66% (2 of 3 lines)
// BRANCH COVERAGE: 50% (only happy path, not exception)

// GOOD TEST (high branch coverage)
[Fact]
public void Divide_ByZero_ThrowsException() {
    var calc = new Calculator();
    Assert.Throws<DivideByZeroException>(() => calc.Divide(10, 0));
}
// Now BRANCH COVERAGE: 100% (both paths tested)

// COVERAGE IN CI/CD
// .github/workflows/test.yml
// - name: Test with coverage
//   run: dotnet test --collect:"XPlat Code Coverage"
// - name: Upload to CodeCov
//   run: codecov -f coverage.xml

// Reading coverage report:
// Green lines = covered ✓
// Red lines = not covered ✗
// Yellow lines = partially covered

// FOCUS ON:
// ✓ Business logic (high value)
// ✓ Complex algorithms
// ✓ Error handling
// ✗ Simple getters/setters
// ✗ Auto-generated code',
      'typescript', '// Jest coverage
// package.json
{
    "scripts": {
        "test:coverage": "jest --coverage"
    }
}

// Run: npm run test:coverage

// Generated report shows:
// File      | % Stmts | % Branch | % Funcs | % Lines
// ----------|---------|----------|---------|--------
// calc.ts   |   75.00 |    50.00 |  100.00 |   75.00

// Coverage thresholds (jest.config.js)
module.exports = {
    coverageThreshold: {
        global: {
            branches: 80,
            functions: 80,
            lines: 80,
            statements: 80
        }
    }
};

// HTML report: coverage/lcov-report/index.html'
    ),
    'Code Coverage:

CODE:
1  public int Divide(int a, int b) {
2      if (b == 0)                    ← Branch A
3          throw new Exception();
4      return a / b;                  ← Branch B
5  }

TEST 1: Divide(10, 2)
Executes: lines 1,2,4 (no exception)
Line coverage: 75% (3 of 4 lines)
Branch coverage: 50% (only Branch B)

TEST 2: Divide(10, 0)
Executes: lines 1,2,3
Now:
Line coverage: 100% ✓
Branch coverage: 100% ✓

Metrics:
Line coverage = % lines executed
Branch coverage = % if/else paths
Method coverage = % methods called

Good targets:
80-90% line coverage
80%+ branch coverage

Remember:
✓ Quality > quantity
✓ Test critical paths
✗ Do not chase 100%
✗ High coverage ≠ good tests',
    116
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Completed Batch 5: Added 5 testing terms';
END $$;

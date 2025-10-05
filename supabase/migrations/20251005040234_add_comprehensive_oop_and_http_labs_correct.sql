/*
  # Add Comprehensive Labs for OOP and HTTP Methods

  1. New Labs Added
    - **OOP Comprehensive Lab**: Complete C# lab covering all OOP pillars
      - Abstract classes, Sealed classes, Inheritance
      - Encapsulation, Polymorphism, Interfaces
      - Executable example with real-world scenario
    
    - **HTTP Methods Lab**: Practical examples for all HTTP methods
      - GET, POST, PUT, PATCH, DELETE
      - Response status codes and headers
      - Real-world API controller

  2. Lab Structure
    - Uses existing labs table with jsonb config
    - Type: "code-example" for executable labs
    - Config contains code, language, expected output

  3. Purpose
    - Hands-on practice for interview preparation
    - Real-world scenarios
    - Understanding through execution
*/

-- OOP Comprehensive Lab
INSERT INTO labs (name, description, type, config)
VALUES (
  'Complete OOP Pillars - Animal Kingdom System',
  'A comprehensive lab covering ALL OOP concepts: Abstract classes, Sealed classes, Inheritance, Encapsulation, Polymorphism, and Interfaces. Build a complete animal kingdom management system that demonstrates every OOP pillar in action.

**What You Will Learn:**
- Abstract base classes and abstract methods
- Sealed classes (cannot be inherited)
- Multi-level inheritance hierarchies
- Encapsulation with properties and access modifiers
- Polymorphism through method overriding
- Interface implementation
- Real-world design patterns

**Scenario:** You are building a Zoo Management System that needs to handle different types of animals with varying behaviors.',
  
  'code-example',
  
  jsonb_build_object(
    'language', 'csharp',
    'difficulty', 'advanced',
    'category', 'OOP',
    'code', '// STEP 1: Define an interface for common behaviors
public interface IFeedable
{
    void Feed(string food);
    int GetHungerLevel();
}

// STEP 2: Abstract base class - Animal
public abstract class Animal : IFeedable
{
    // Encapsulation: private fields with public properties
    private string _name;
    private int _age;
    protected int _hungerLevel;

    public string Name 
    { 
        get => _name; 
        set => _name = value ?? throw new ArgumentNullException(nameof(value));
    }
    
    public int Age 
    { 
        get => _age;
        set => _age = value >= 0 ? value : throw new ArgumentException("Age cannot be negative");
    }

    // Abstract method - MUST be implemented by derived classes
    public abstract void MakeSound();
    
    // Virtual method - CAN be overridden by derived classes
    public virtual void Sleep()
    {
        Console.WriteLine($"{Name} is sleeping...");
    }

    // Interface implementation
    public void Feed(string food)
    {
        Console.WriteLine($"{Name} is eating {food}");
        _hungerLevel = Math.Max(0, _hungerLevel - 30);
    }

    public int GetHungerLevel() => _hungerLevel;

    protected Animal(string name, int age)
    {
        Name = name;
        Age = age;
        _hungerLevel = 50;
    }
}

// STEP 3: Inheritance - Mammal class
public class Mammal : Animal
{
    public bool HasFur { get; set; }

    public Mammal(string name, int age, bool hasFur) : base(name, age)
    {
        HasFur = hasFur;
    }

    public override void MakeSound()
    {
        Console.WriteLine($"{Name} makes a mammal sound");
    }

    public void GiveBirth()
    {
        Console.WriteLine($"{Name} gave birth to live young");
    }
}

// STEP 4: Further inheritance - Lion
public class Lion : Mammal
{
    public int PrideSize { get; set; }

    public Lion(string name, int age, int prideSize) 
        : base(name, age, hasFur: true)
    {
        PrideSize = prideSize;
    }

    // Polymorphism: Override the abstract method
    public override void MakeSound()
    {
        Console.WriteLine($"{Name} roars: ROAAAAR!");
    }

    // Polymorphism: Override the virtual method
    public override void Sleep()
    {
        Console.WriteLine($"{Name} sleeps 20 hours a day like a true king");
    }

    public void Hunt()
    {
        Console.WriteLine($"{Name} is hunting with pride of {PrideSize} lions");
        _hungerLevel += 20;
    }
}

// STEP 5: Sealed class - Penguin (cannot be inherited further)
public sealed class Penguin : Animal
{
    public bool CanFly => false;
    public int SwimSpeed { get; set; }

    public Penguin(string name, int age, int swimSpeed) : base(name, age)
    {
        SwimSpeed = swimSpeed;
    }

    public override void MakeSound()
    {
        Console.WriteLine($"{Name} says: HONK HONK!");
    }

    public void Swim()
    {
        Console.WriteLine($"{Name} swims at {SwimSpeed} km/h");
    }

    public override void Sleep()
    {
        Console.WriteLine($"{Name} sleeps standing up in the cold");
    }
}

// Execute the program
class Program
{
    static void Main()
    {
        Console.WriteLine("=== Zoo Management System ===\n");

        Animal[] zoo = new Animal[]
        {
            new Lion("Simba", 5, prideSize: 7),
            new Penguin("Pingu", 3, swimSpeed: 25),
            new Mammal("Generic Mammal", 2, hasFur: true)
        };

        foreach (var animal in zoo)
        {
            Console.WriteLine($"\n--- {animal.Name} ({animal.GetType().Name}) ---");
            animal.MakeSound();
            animal.Sleep();
            Console.WriteLine($"Hunger: {animal.GetHungerLevel()}");
            animal.Feed("fresh food");
            Console.WriteLine($"After feeding: {animal.GetHungerLevel()}");
        }

        Console.WriteLine("\n=== Specific Behaviors ===");
        Lion simba = (Lion)zoo[0];
        simba.Hunt();
        simba.GiveBirth();

        Penguin pingu = (Penguin)zoo[1];
        pingu.Swim();
        Console.WriteLine($"Can fly? {pingu.CanFly}");
    }
}',
    'expectedOutput', '=== Zoo Management System ===

--- Simba (Lion) ---
Simba roars: ROAAAAR!
Simba sleeps 20 hours a day like a true king
Hunger: 50
Simba is eating fresh food
After feeding: 20

--- Pingu (Penguin) ---
Pingu says: HONK HONK!
Pingu sleeps standing up in the cold
Hunger: 50
Pingu is eating fresh food
After feeding: 20

--- Generic Mammal (Mammal) ---
Generic Mammal makes a mammal sound
Generic Mammal is sleeping...
Hunger: 50
Generic Mammal is eating fresh food
After feeding: 20

=== Specific Behaviors ===
Simba is hunting with pride of 7 lions
Simba gave birth to live young
Pingu swims at 25 km/h
Can fly? False',
    'keyPoints', jsonb_build_array(
      'Abstract classes define contracts that derived classes MUST implement',
      'Sealed classes CANNOT be inherited (security and design)',
      'Polymorphism allows treating derived classes as base class',
      'Encapsulation protects internal state with properties',
      'Interfaces define capabilities that classes can implement'
    )
  )
) ON CONFLICT (name) DO NOTHING;

-- HTTP Methods Lab
INSERT INTO labs (name, description, type, config)
VALUES (
  'HTTP Methods Complete Guide - RESTful API',
  'Master all HTTP methods with practical examples. Learn when to use GET, POST, PUT, PATCH, and DELETE in a real-world User Management API. Understand status codes, idempotency, and proper request/response patterns.

**What You Will Learn:**
- GET: Retrieve resources (with query params)
- POST: Create new resources (returns 201)
- PUT: Full resource replacement (idempotent)
- PATCH: Partial resource updates
- DELETE: Remove resources
- HTTP status codes (200, 201, 204, 400, 404)
- Request/Response headers and body structure

**Scenario:** Building a User Management API with all CRUD operations.',
  
  'code-example',
  
  jsonb_build_object(
    'language', 'csharp',
    'difficulty', 'intermediate',
    'category', 'HTTP',
    'code', 'using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    private static List<User> _users = new List<User>
    {
        new User { Id = 1, Name = "Alice", Email = "alice@example.com", Age = 28 },
        new User { Id = 2, Name = "Bob", Email = "bob@example.com", Age = 35 }
    };

    // GET /api/users - Returns all users
    [HttpGet]
    public ActionResult<IEnumerable<User>> GetAllUsers()
    {
        return Ok(_users); // 200 OK
    }

    // GET /api/users/1 - Returns single user by ID
    [HttpGet("{id}")]
    public ActionResult<User> GetUserById(int id)
    {
        var user = _users.FirstOrDefault(u => u.Id == id);
        if (user == null)
            return NotFound(); // 404 Not Found
        
        return Ok(user); // 200 OK
    }

    // GET /api/users/search?name=Alice
    [HttpGet("search")]
    public ActionResult<IEnumerable<User>> SearchUsers([FromQuery] string name)
    {
        var results = _users.Where(u => u.Name.Contains(name));
        return Ok(results);
    }

    // POST /api/users - Creates a new user
    // Body: { "name": "Charlie", "email": "charlie@example.com", "age": 30 }
    [HttpPost]
    public ActionResult<User> CreateUser([FromBody] CreateUserDto dto)
    {
        if (string.IsNullOrEmpty(dto.Name))
            return BadRequest(); // 400 Bad Request

        var newUser = new User
        {
            Id = _users.Max(u => u.Id) + 1,
            Name = dto.Name,
            Email = dto.Email,
            Age = dto.Age
        };

        _users.Add(newUser);
        return CreatedAtAction(nameof(GetUserById), new { id = newUser.Id }, newUser); // 201 Created
    }

    // PUT /api/users/1 - Replaces entire user (IDEMPOTENT)
    // Body: { "name": "Alice Updated", "email": "alice.new@example.com", "age": 29 }
    [HttpPut("{id}")]
    public IActionResult UpdateUser(int id, [FromBody] UpdateUserDto dto)
    {
        var user = _users.FirstOrDefault(u => u.Id == id);
        if (user == null)
            return NotFound();

        // REPLACE all fields
        user.Name = dto.Name;
        user.Email = dto.Email;
        user.Age = dto.Age;

        return NoContent(); // 204 No Content
    }

    // PATCH /api/users/1 - Updates only specified fields
    // Body: { "age": 30 }
    [HttpPatch("{id}")]
    public IActionResult PatchUser(int id, [FromBody] PatchUserDto dto)
    {
        var user = _users.FirstOrDefault(u => u.Id == id);
        if (user == null)
            return NotFound();

        // UPDATE only provided fields
        if (dto.Name != null) user.Name = dto.Name;
        if (dto.Email != null) user.Email = dto.Email;
        if (dto.Age.HasValue) user.Age = dto.Age.Value;

        return Ok(user); // 200 OK
    }

    // DELETE /api/users/1 - Removes user
    [HttpDelete("{id}")]
    public IActionResult DeleteUser(int id)
    {
        var user = _users.FirstOrDefault(u => u.Id == id);
        if (user == null)
            return NotFound();

        _users.Remove(user);
        return NoContent(); // 204 No Content
    }
}

public class User
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public int Age { get; set; }
}

public class CreateUserDto
{
    public string Name { get; set; }
    public string Email { get; set; }
    public int Age { get; set; }
}

public class UpdateUserDto
{
    public string Name { get; set; }
    public string Email { get; set; }
    public int Age { get; set; }
}

public class PatchUserDto
{
    public string? Name { get; set; }
    public string? Email { get; set; }
    public int? Age { get; set; }
}',
    'expectedOutput', 'REQUEST:  GET /api/users
RESPONSE: 200 OK
[
  { "id": 1, "name": "Alice", "email": "alice@example.com", "age": 28 },
  { "id": 2, "name": "Bob", "email": "bob@example.com", "age": 35 }
]

REQUEST:  POST /api/users
BODY:     { "name": "Charlie", "email": "charlie@example.com", "age": 30 }
RESPONSE: 201 Created with Location header
{ "id": 3, "name": "Charlie", "email": "charlie@example.com", "age": 30 }

REQUEST:  PUT /api/users/1
BODY:     { "name": "Alice Updated", "email": "alice.new@example.com", "age": 29 }
RESPONSE: 204 No Content

REQUEST:  PATCH /api/users/1
BODY:     { "age": 30 }
RESPONSE: 200 OK
{ "id": 1, "name": "Alice Updated", "email": "alice.new@example.com", "age": 30 }

REQUEST:  DELETE /api/users/1
RESPONSE: 204 No Content',
    'keyPoints', jsonb_build_array(
      'PUT replaces ENTIRE resource (idempotent), PATCH updates PARTIAL fields',
      'POST creates NEW resource (server assigns ID), PUT updates EXISTING',
      'GET is safe and idempotent (no side effects)',
      'DELETE is idempotent (same result if called multiple times)',
      '200 OK = success with body, 204 No Content = success without body',
      '201 Created = new resource, 404 Not Found = resource does not exist'
    )
  )
) ON CONFLICT (name) DO NOTHING;

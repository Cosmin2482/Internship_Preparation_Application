/*
  # Add More Junior Level Essentials - Batch 1
  
  1. New Terms (20 terms)
    CS: Recursion, Linear Search, Insertion Sort, Selection Sort, Prefix Sum
    OOP: Class vs Object, Access Modifiers, Constructors, Virtual/Override, Delegates & Events
    .NET: Controllers, Configuration, Logging, Health Checks, Testing with xUnit
    SQL: Views, Stored Procedures, GROUP BY & HAVING
    TypeScript: Enums, Union Types, Type Guards
*/

DO $$
DECLARE
  cat_cs uuid;
  cat_oop uuid;
  cat_dotnet uuid;
  cat_sql uuid;
  cat_angular uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';
  SELECT id INTO cat_dotnet FROM categories WHERE slug = 'dotnet';
  SELECT id INTO cat_sql FROM categories WHERE slug = 'sql';
  SELECT id INTO cat_angular FROM categories WHERE slug = 'angular';

  -- Recursion vs Iteration
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Recursion vs Iteration',
    'Recursion: function calls itself. Iteration: use loops. Both solve repetitive problems.',
    'Recursion: function calls itself with base case to terminate. Iteration: loops (for/while) with explicit state. Recursion uses call stack, iteration uses loop variables.',
    'Recursion elegant for tree/divide-conquer problems but risks stack overflow. Iteration more memory efficient. Choose recursion for naturally recursive problems (trees, factorial), iteration for simple loops. Any recursion can be converted to iteration.',
    to_jsonb(ARRAY['Stack overflow from missing/wrong base case', 'Inefficient recursion without memoization', 'Excessive memory from deep call stack', 'Not considering iteration alternative']),
    jsonb_build_object(
      'csharp', E'// Recursion: Factorial\nint FactorialRecursive(int n) {\n  if(n <= 1) return 1; // Base case\n  return n * FactorialRecursive(n - 1);\n}\n\n// Iteration: Factorial\nint FactorialIterative(int n) {\n  int result = 1;\n  for(int i = 2; i <= n; i++) {\n    result *= i;\n  }\n  return result;\n}\n\n// Recursion: Tree traversal (natural fit)\nvoid PrintTreeRecursive(TreeNode node) {\n  if(node == null) return;\n  Console.WriteLine(node.Value);\n  PrintTreeRecursive(node.Left);\n  PrintTreeRecursive(node.Right);\n}',
      'typescript', E'// Recursion: Fibonacci (inefficient)\nfunction fibRecursive(n: number): number {\n  if(n <= 1) return n;\n  return fibRecursive(n - 1) + fibRecursive(n - 2);\n}\n\n// Iteration: Fibonacci (efficient)\nfunction fibIterative(n: number): number {\n  if(n <= 1) return n;\n  let a = 0, b = 1;\n  for(let i = 2; i <= n; i++) {\n    [a, b] = [b, a + b];\n  }\n  return b;\n}\n\n// Recursion with memoization\nfunction fibMemo(n: number, cache: Map<number, number> = new Map()): number {\n  if(n <= 1) return n;\n  if(cache.has(n)) return cache.get(n)!;\n  const result = fibMemo(n - 1, cache) + fibMemo(n - 2, cache);\n  cache.set(n, result);\n  return result;\n}'
    ),
    E'Recursion vs Iteration:\nRecursion:\n  factorial(3)\n    → 3 × factorial(2)\n      → 2 × factorial(1)\n        → 1 (base case)\n  Stack: grows then unwinds\n\nIteration:\n  result = 1\n  for i in 1..3:\n    result *= i\n  No call stack growth',
    90
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Recursion requires?', to_jsonb(ARRAY['Loop', 'Base case to terminate', 'Array', 'Iteration']), 1, 'Base case prevents infinite recursion.'),
    (current_term_id, 'Recursion uses?', to_jsonb(ARRAY['Heap memory', 'Call stack', 'Global variables', 'Database']), 1, 'Each call adds stack frame.'),
    (current_term_id, 'Recursion best for?', to_jsonb(ARRAY['Simple counting', 'Tree/divide-and-conquer problems', 'Never', 'Always']), 1, 'Natural fit for hierarchical structures.'),
    (current_term_id, 'Stack overflow cause?', to_jsonb(ARRAY['Too fast', 'Missing or wrong base case', 'Iteration', 'Correct code']), 1, 'Infinite recursion exhausts stack.'),
    (current_term_id, 'Tail recursion?', to_jsonb(ARRAY['First call', 'Recursive call is last operation, can be optimized', 'Multiple calls', 'Iteration']), 1, 'Some compilers optimize to iteration.');

  -- Linear Search
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Linear Search',
    'Check each item one by one until you find what you want or reach the end.',
    'Sequential search algorithm checking each element until target found or end reached. O(n) time complexity.',
    'Linear search is simplest search: iterate through array comparing each element. O(n) worst case. Use for unsorted data or small datasets. Binary search (O(log n)) better for sorted arrays.',
    to_jsonb(ARRAY['Using on large sorted arrays (use binary search)', 'Not handling empty array', 'Continuing after finding element', 'Off-by-one errors']),
    jsonb_build_object(
      'csharp', E'int LinearSearch(int[] arr, int target) {\n  for(int i = 0; i < arr.Length; i++) {\n    if(arr[i] == target) return i; // Found at index i\n  }\n  return -1; // Not found\n}\n\n// Generic version\nint LinearSearch<T>(T[] arr, T target) where T : IEquatable<T> {\n  for(int i = 0; i < arr.Length; i++) {\n    if(arr[i].Equals(target)) return i;\n  }\n  return -1;\n}',
      'typescript', E'function linearSearch(arr: number[], target: number): number {\n  for(let i = 0; i < arr.length; i++) {\n    if(arr[i] === target) return i;\n  }\n  return -1;\n}\n\n// Generic\nfunction linearSearch<T>(arr: T[], target: T): number {\n  for(let i = 0; i < arr.length; i++) {\n    if(arr[i] === target) return i;\n  }\n  return -1;\n}\n\n// With predicate\nfunction linearSearchBy<T>(arr: T[], predicate: (item: T) => boolean): number {\n  for(let i = 0; i < arr.length; i++) {\n    if(predicate(arr[i])) return i;\n  }\n  return -1;\n}'
    ),
    E'Linear Search:\n[3, 7, 1, 9, 5, 2] target=9\n ↓  ↓  ↓  ↓ found!\nCheck each: O(n)\nBest: O(1) (first element)\nWorst: O(n) (last or not found)\nAvg: O(n/2) → O(n)',
    91
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Linear search complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n²)']), 2, 'Must check each element in worst case.'),
    (current_term_id, 'Linear search works on?', to_jsonb(ARRAY['Only sorted', 'Sorted and unsorted arrays', 'Only trees', 'Only linked lists']), 1, 'No sorting requirement.'),
    (current_term_id, 'Linear search best case?', to_jsonb(ARRAY['O(1) if target is first', 'O(log n)', 'O(n)', 'O(n²)']), 0, 'First element check succeeds.'),
    (current_term_id, 'When prefer linear search?', to_jsonb(ARRAY['Always', 'Small or unsorted arrays', 'Large sorted arrays', 'Never']), 1, 'Simple, works on unsorted data.'),
    (current_term_id, 'Linear vs binary search?', to_jsonb(ARRAY['Same speed', 'Binary O(log n) on sorted, linear O(n) any', 'Linear faster', 'No difference']), 1, 'Binary requires sorted data.');

  -- Class vs Object
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Class vs Object',
    'Class is blueprint/template. Object is actual instance created from that blueprint.',
    'Class: type definition with fields, properties, methods. Object: instance of class with actual data. Class is compile-time, object is runtime.',
    'Class defines structure and behavior. Object is concrete instance with state. One class, many objects. Class is like cookie cutter, objects are cookies. Class allocated once, objects use heap memory.',
    to_jsonb(ARRAY['Confusing class and object terminology', 'Not understanding multiple instances', 'Static vs instance members confusion', 'Treating class as object']),
    jsonb_build_object(
      'csharp', E'// Class: blueprint\npublic class Person {\n  // Fields\n  public string Name { get; set; }\n  public int Age { get; set; }\n  \n  // Constructor\n  public Person(string name, int age) {\n    Name = name;\n    Age = age;\n  }\n  \n  // Method\n  public void SayHello() {\n    Console.WriteLine($"Hello, I am {Name}");\n  }\n}\n\n// Objects: instances\nPerson person1 = new Person("Alice", 25); // Object 1\nPerson person2 = new Person("Bob", 30);   // Object 2\n\nperson1.SayHello(); // "Hello, I am Alice"\nperson2.SayHello(); // "Hello, I am Bob"\n\n// Different objects, different data\nConsole.WriteLine(person1.Age); // 25\nConsole.WriteLine(person2.Age); // 30',
      'typescript', E'// Class: blueprint\nclass Person {\n  name: string;\n  age: number;\n  \n  constructor(name: string, age: number) {\n    this.name = name;\n    this.age = age;\n  }\n  \n  sayHello(): void {\n    console.log(`Hello, I am ${this.name}`);\n  }\n}\n\n// Objects: instances\nconst person1 = new Person("Alice", 25);\nconst person2 = new Person("Bob", 30);\n\nperson1.sayHello(); // "Hello, I am Alice"\nperson2.sayHello(); // "Hello, I am Bob"\n\nconsole.log(person1.age); // 25\nconsole.log(person2.age); // 30'
    ),
    E'Class vs Object:\nClass Person:\n  - Name: string\n  - Age: int\n  - SayHello() method\n  ↓ new Person(...)\nObject person1:        Object person2:\n  Name: "Alice"          Name: "Bob"\n  Age: 25                Age: 30\n\nOne class → many objects',
    92
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Class is?', to_jsonb(ARRAY['Instance', 'Blueprint/template defining structure', 'Memory location', 'Variable']), 1, 'Defines type, not actual data.'),
    (current_term_id, 'Object is?', to_jsonb(ARRAY['Class', 'Instance of class with actual data', 'Method', 'Property']), 1, 'Concrete realization of class.'),
    (current_term_id, 'One class can have?', to_jsonb(ARRAY['One object only', 'Multiple objects', 'No objects', 'Must have object']), 1, 'Create many instances from one class.'),
    (current_term_id, 'Objects stored in?', to_jsonb(ARRAY['Stack', 'Heap memory', 'Class definition', 'Code']), 1, 'Reference types on heap.'),
    (current_term_id, 'Class analogy?', to_jsonb(ARRAY['Cookie', 'Cookie cutter', 'Oven', 'Ingredients']), 1, 'Template to create objects (cookies).');

  -- Access Modifiers
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Access Modifiers',
    'Keywords controlling who can see and use your code: public (everyone), private (only me), protected (me and children).',
    'C# access modifiers: public (any code), private (same class only), protected (class and derived), internal (same assembly), protected internal (assembly or derived).',
    'Access modifiers enforce encapsulation. Public exposes API. Private hides implementation. Protected for inheritance. Internal limits to assembly. Prefer least privilege: default private, expose only needed members.',
    to_jsonb(ARRAY['Making everything public', 'Not understanding protected vs private', 'Exposing fields instead of properties', 'Internal vs protected confusion']),
    jsonb_build_object(
      'csharp', E'public class BankAccount {\n  // Private: only this class\n  private decimal balance;\n  private string accountNumber;\n  \n  // Public: external access\n  public string Owner { get; set; }\n  \n  // Public methods for controlled access\n  public void Deposit(decimal amount) {\n    if(amount > 0) balance += amount;\n  }\n  \n  public decimal GetBalance() => balance;\n  \n  // Protected: this class and derived classes\n  protected void LogTransaction(string message) {\n    Console.WriteLine($"{DateTime.Now}: {message}");\n  }\n  \n  // Internal: same assembly only\n  internal void ResetForTesting() {\n    balance = 0;\n  }\n}\n\npublic class SavingsAccount : BankAccount {\n  public void AddInterest() {\n    // Can access protected method\n    LogTransaction("Interest added");\n    // Cannot access private balance directly\n  }\n}',
      'typescript', E'// TypeScript access modifiers\nclass BankAccount {\n  // Private: only this class\n  private balance: number = 0;\n  private accountNumber: string;\n  \n  // Public: external access (default)\n  public owner: string;\n  \n  constructor(owner: string, accountNumber: string) {\n    this.owner = owner;\n    this.accountNumber = accountNumber;\n  }\n  \n  public deposit(amount: number): void {\n    if(amount > 0) this.balance += amount;\n  }\n  \n  public getBalance(): number {\n    return this.balance;\n  }\n  \n  // Protected: this class and derived\n  protected logTransaction(message: string): void {\n    console.log(`${new Date()}: ${message}`);\n  }\n}\n\nclass SavingsAccount extends BankAccount {\n  addInterest(): void {\n    this.logTransaction("Interest added"); // OK\n    // this.balance += 10; // Error: private\n  }\n}'
    ),
    E'Access Modifiers:\npublic     → Everyone\ninternal   → Same assembly\nprotected  → Class + derived\nprivate    → Class only\n\nEncapsulation:\n  [Public API]\n       ↓\n  [Protected for inheritance]\n       ↓\n  [Private implementation]',
    93
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'public means?', to_jsonb(ARRAY['Class only', 'Accessible from any code', 'Derived classes', 'Assembly only']), 1, 'No access restrictions.'),
    (current_term_id, 'private means?', to_jsonb(ARRAY['Everyone', 'Only within same class', 'Derived classes', 'Assembly']), 1, 'Most restrictive, encapsulation.'),
    (current_term_id, 'protected allows?', to_jsonb(ARRAY['Everyone', 'Class and derived classes', 'Class only', 'Assembly']), 1, 'Inheritance hierarchy access.'),
    (current_term_id, 'Default access for fields?', to_jsonb(ARRAY['public', 'private', 'protected', 'internal']), 1, 'Fields private by default, good practice.'),
    (current_term_id, 'internal means?', to_jsonb(ARRAY['Private', 'Same assembly only', 'Everyone', 'Derived only']), 1, 'Assembly-level access.');

  -- Constructors
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Constructors',
    'Special method that runs when creating a new object to set it up with initial values.',
    'Constructor: method called during object instantiation. Same name as class, no return type. Initializes object state. Can be parameterless (default) or parameterized. Constructor chaining.',
    'Constructors initialize objects. Default constructor provided if none defined. Use parameters to require initialization. Constructor chaining (: this()) reduces duplication. Static constructor runs once per type. Avoid heavy logic in constructors.',
    to_jsonb(ARRAY['Complex logic in constructors', 'Not validating parameters', 'Calling virtual methods in constructor', 'Forgetting to chain constructors', 'Exception in constructor leaves partial object']),
    jsonb_build_object(
      'csharp', E'public class Person {\n  public string Name { get; }\n  public int Age { get; }\n  public string Email { get; }\n  \n  // Parameterless constructor\n  public Person() : this("Unknown", 0, "") { }\n  \n  // Parameterized constructor\n  public Person(string name, int age) : this(name, age, "") { }\n  \n  // Primary constructor (most parameters)\n  public Person(string name, int age, string email) {\n    // Validation\n    if(string.IsNullOrEmpty(name)) \n      throw new ArgumentException(nameof(name));\n    if(age < 0) \n      throw new ArgumentException(nameof(age));\n    \n    Name = name;\n    Age = age;\n    Email = email;\n  }\n  \n  // Static constructor: runs once per type\n  static Person() {\n    Console.WriteLine("Person class initialized");\n  }\n}\n\n// Usage\nvar p1 = new Person(); // "Unknown", 0\nvar p2 = new Person("Alice", 25);\nvar p3 = new Person("Bob", 30, "bob@example.com");',
      'typescript', E'class Person {\n  name: string;\n  age: number;\n  email: string;\n  \n  // Constructor\n  constructor(name: string = "Unknown", age: number = 0, email: string = "") {\n    // Validation\n    if(!name) throw new Error("Name required");\n    if(age < 0) throw new Error("Age must be positive");\n    \n    this.name = name;\n    this.age = age;\n    this.email = email;\n  }\n  \n  // Alternative: parameter properties\n  // constructor(\n  //   public name: string,\n  //   public age: number,\n  //   public email: string = ""\n  // ) { }\n}\n\n// Usage\nconst p1 = new Person();\nconst p2 = new Person("Alice", 25);\nconst p3 = new Person("Bob", 30, "bob@example.com");'
    ),
    E'Constructors:\nnew Person("Alice", 25)\n       ↓\n  Constructor runs\n       ↓\n  Initialize fields\n       ↓\n  Validate parameters\n       ↓\n  Object ready\n\nChaining: this() calls another constructor',
    94
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Constructor purpose?', to_jsonb(ARRAY['Delete object', 'Initialize object during creation', 'Copy object', 'Compare objects']), 1, 'Sets up new instance.'),
    (current_term_id, 'Constructor return type?', to_jsonb(ARRAY['void', 'Class type', 'No return type', 'int']), 2, 'Special method, no return.'),
    (current_term_id, 'Default constructor?', to_jsonb(ARRAY['Never exists', 'Provided if no constructor defined', 'Always required', 'Has parameters']), 1, 'Parameterless, auto-generated if needed.'),
    (current_term_id, 'Constructor chaining?', to_jsonb(ARRAY['Inheritance', 'Calling one constructor from another (:this())', 'Multiple classes', 'Static method']), 1, 'Reuse initialization logic.'),
    (current_term_id, 'Static constructor runs?', to_jsonb(ARRAY['Per object', 'Once per type, before first use', 'Never', 'Every call']), 1, 'Type initialization, runs once.');

  -- Virtual/Override
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Virtual & Override',
    'Virtual: parent says "you can customize this". Override: child provides custom version.',
    'Virtual method in base class can be overridden in derived classes. Override keyword replaces base implementation. Enables polymorphism: base reference calls derived method.',
    'Virtual enables runtime polymorphism. Base class marks method virtual, derived class uses override. Call on base reference executes derived version. Use for is-a hierarchies. Abstract is virtual + no implementation.',
    to_jsonb(ARRAY['Forgetting override keyword (hides instead)', 'Not marking base method virtual', 'Confusing override with new (hiding)', 'Virtual in sealed classes']),
    jsonb_build_object(
      'csharp', E'public class Animal {\n  // Virtual: can be overridden\n  public virtual void Speak() {\n    Console.WriteLine("Some sound");\n  }\n  \n  public virtual string GetName() => "Animal";\n}\n\npublic class Dog : Animal {\n  // Override: replace base implementation\n  public override void Speak() {\n    Console.WriteLine("Woof!");\n  }\n  \n  public override string GetName() => "Dog";\n}\n\npublic class Cat : Animal {\n  public override void Speak() {\n    Console.WriteLine("Meow!");\n  }\n}\n\n// Polymorphism in action\nAnimal[] animals = { new Dog(), new Cat(), new Animal() };\nforeach(var animal in animals) {\n  animal.Speak(); // Calls overridden version\n}\n// Output: "Woof!" "Meow!" "Some sound"\n\n// Base reference, derived object\nAnimal myDog = new Dog();\nmyDog.Speak(); // "Woof!" (runtime polymorphism)',
      'typescript', E'class Animal {\n  // TypeScript methods virtual by default\n  speak(): void {\n    console.log("Some sound");\n  }\n  \n  getName(): string {\n    return "Animal";\n  }\n}\n\nclass Dog extends Animal {\n  // Override (replace base)\n  speak(): void {\n    console.log("Woof!");\n  }\n  \n  getName(): string {\n    return "Dog";\n  }\n}\n\nclass Cat extends Animal {\n  speak(): void {\n    console.log("Meow!");\n  }\n}\n\n// Polymorphism\nconst animals: Animal[] = [new Dog(), new Cat(), new Animal()];\nanimals.forEach(a => a.speak());\n// Output: "Woof!" "Meow!" "Some sound"\n\nconst myDog: Animal = new Dog();\nmyDog.speak(); // "Woof!"'
    ),
    E'Virtual & Override:\nBase: Animal\n  virtual Speak()\n     ↓ override\nDerived: Dog\n  override Speak() → "Woof"\n\nPolymorphism:\nAnimal a = new Dog();\na.Speak(); → "Woof"\n(runtime decides which method)',
    95
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'virtual keyword means?', to_jsonb(ARRAY['Must override', 'Can be overridden in derived class', 'Cannot override', 'Static']), 1, 'Allows but doesn''t require override.'),
    (current_term_id, 'override keyword?', to_jsonb(ARRAY['Hides base', 'Replaces base virtual/abstract method', 'Creates new method', 'Static']), 1, 'Polymorphic replacement.'),
    (current_term_id, 'Missing override keyword?', to_jsonb(ARRAY['Error', 'Warning: hides base method instead', 'Works same', 'Nothing']), 1, 'Method hiding, not polymorphism.'),
    (current_term_id, 'Runtime polymorphism?', to_jsonb(ARRAY['Compile-time decision', 'Base reference calls derived override at runtime', 'Overloading', 'Templates']), 1, 'Dynamic dispatch via virtual methods.'),
    (current_term_id, 'abstract vs virtual?', to_jsonb(ARRAY['Same', 'Abstract has no implementation, must override', 'Virtual faster', 'No difference']), 1, 'Abstract forces override, virtual is optional.');

  -- Controllers
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'ASP.NET Core Controllers',
    'Classes that handle HTTP requests and return responses in MVC pattern.',
    'Controller: class handling requests in MVC/API. Actions are public methods returning IActionResult. [ApiController] attribute enables conventions. Model binding, routing, filters.',
    'Controllers handle HTTP requests. Actions map to routes via attributes or convention. Model binding maps request to parameters. Return IActionResult (Ok, NotFound, BadRequest). [ApiController] provides automatic 400 validation, binding source inference.',
    to_jsonb(ARRAY['Fat controllers with business logic', 'Not using async actions', 'Improper status code returns', 'Not leveraging [ApiController] features', 'Missing route attributes']),
    jsonb_build_object(
      'csharp', E'[ApiController]\n[Route("api/[controller]")] // Route: /api/users\npublic class UsersController : ControllerBase {\n  private readonly IUserService _service;\n  private readonly ILogger<UsersController> _logger;\n  \n  public UsersController(IUserService service, ILogger<UsersController> logger) {\n    _service = service;\n    _logger = logger;\n  }\n  \n  // GET /api/users\n  [HttpGet]\n  public async Task<ActionResult<IEnumerable<UserDto>>> GetAll() {\n    var users = await _service.GetAllAsync();\n    return Ok(users);\n  }\n  \n  // GET /api/users/5\n  [HttpGet("{id}")]\n  public async Task<ActionResult<UserDto>> Get(int id) {\n    var user = await _service.GetByIdAsync(id);\n    if(user == null) return NotFound();\n    return Ok(user);\n  }\n  \n  // POST /api/users\n  [HttpPost]\n  public async Task<ActionResult<UserDto>> Create([FromBody] CreateUserDto dto) {\n    // [ApiController] auto-validates\n    var user = await _service.CreateAsync(dto);\n    return CreatedAtAction(nameof(Get), new { id = user.Id }, user);\n  }\n  \n  // PUT /api/users/5\n  [HttpPut("{id}")]\n  public async Task<IActionResult> Update(int id, [FromBody] UpdateUserDto dto) {\n    if(!await _service.ExistsAsync(id)) return NotFound();\n    await _service.UpdateAsync(id, dto);\n    return NoContent();\n  }\n  \n  // DELETE /api/users/5\n  [HttpDelete("{id}")]\n  public async Task<IActionResult> Delete(int id) {\n    if(!await _service.ExistsAsync(id)) return NotFound();\n    await _service.DeleteAsync(id);\n    return NoContent();\n  }\n}',
      'typescript', E'// Express controller (similar concept)\nimport { Request, Response } from ''express'';\nimport { UserService } from ''./user.service'';\n\nexport class UsersController {\n  constructor(private userService: UserService) {}\n  \n  // GET /api/users\n  async getAll(req: Request, res: Response) {\n    const users = await this.userService.getAll();\n    res.json(users);\n  }\n  \n  // GET /api/users/:id\n  async getById(req: Request, res: Response) {\n    const user = await this.userService.getById(req.params.id);\n    if(!user) return res.status(404).json({ error: ''Not found'' });\n    res.json(user);\n  }\n  \n  // POST /api/users\n  async create(req: Request, res: Response) {\n    const user = await this.userService.create(req.body);\n    res.status(201)\n       .location(`/api/users/${user.id}`)\n       .json(user);\n  }\n  \n  // PUT /api/users/:id\n  async update(req: Request, res: Response) {\n    const exists = await this.userService.exists(req.params.id);\n    if(!exists) return res.status(404).json({ error: ''Not found'' });\n    await this.userService.update(req.params.id, req.body);\n    res.status(204).send();\n  }\n}'
    ),
    E'Controller Flow:\nHTTP Request\n    ↓\n[Routing]\n    ↓\n[Model Binding]\n    ↓\n[Controller Action]\n    ↓\n[Service Layer] (business logic)\n    ↓\n[Repository] (data)\n    ↓\nIActionResult\n    ↓\nHTTP Response',
    96
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Controller action returns?', to_jsonb(ARRAY['void', 'IActionResult for flexibility', 'string', 'bool']), 1, 'ActionResult allows various responses.'),
    (current_term_id, '[ApiController] provides?', to_jsonb(ARRAY['Nothing', 'Auto 400 validation, binding inference', 'Performance', 'Security']), 1, 'Automatic API conventions.'),
    (current_term_id, 'Controller should contain?', to_jsonb(ARRAY['All business logic', 'Request/response handling only', 'Database code', 'HTML']), 1, 'Thin controller, delegate to services.'),
    (current_term_id, 'Model binding?', to_jsonb(ARRAY['Database mapping', 'Maps request data to action parameters', 'Validation', 'Routing']), 1, 'Automatic parameter population from request.'),
    (current_term_id, 'Async actions why?', to_jsonb(ARRAY['Faster always', 'Free thread during I/O operations', 'Required', 'Simpler']), 1, 'Scalability via non-blocking I/O.');

  -- Configuration
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'Configuration & Options Pattern',
    'Store settings in files (appsettings.json) and inject them into your code.',
    'ASP.NET Core configuration from appsettings.json, environment variables, user secrets. Options pattern binds configuration to strongly-typed classes via IOptions<T>.',
    'Configuration from multiple sources: appsettings.json, appsettings.{Environment}.json, environment variables, secrets. Use Options pattern for strongly-typed settings. Register with services.Configure<T>(). Inject IOptions<T> or IOptionsSnapshot<T> for reloadable.',
    to_jsonb(ARRAY['Hardcoding settings instead of config', 'Not using environment-specific configs', 'Secrets in appsettings.json', 'Not using Options pattern', 'IOptions vs IOptionsSnapshot confusion']),
    jsonb_build_object(
      'csharp', E'// appsettings.json\n{\n  "ConnectionStrings": {\n    "DefaultConnection": "Server=..."\n  },\n  "JwtSettings": {\n    "SecretKey": "dev-secret-key",\n    "ExpiryMinutes": 60\n  },\n  "Logging": {\n    "LogLevel": {\n      "Default": "Information"\n    }\n  }\n}\n\n// Strongly-typed settings class\npublic class JwtSettings {\n  public string SecretKey { get; set; }\n  public int ExpiryMinutes { get; set; }\n}\n\n// Program.cs registration\nbuilder.Services.Configure<JwtSettings>(builder.Configuration.GetSection("JwtSettings"));\n\n// Inject into service\npublic class AuthService {\n  private readonly JwtSettings _jwtSettings;\n  \n  public AuthService(IOptions<JwtSettings> jwtSettings) {\n    _jwtSettings = jwtSettings.Value;\n  }\n  \n  public string GenerateToken(User user) {\n    var key = _jwtSettings.SecretKey;\n    var expiry = TimeSpan.FromMinutes(_jwtSettings.ExpiryMinutes);\n    // ...\n  }\n}\n\n// Access in controller\npublic class AuthController : ControllerBase {\n  public AuthController(IConfiguration config) {\n    var connStr = config.GetConnectionString("DefaultConnection");\n    var logLevel = config["Logging:LogLevel:Default"];\n  }\n}',
      'typescript', E'// config.ts (Node.js)\ninterface Config {\n  database: {\n    host: string;\n    port: number;\n    name: string;\n  };\n  jwt: {\n    secret: string;\n    expiryMinutes: number;\n  };\n}\n\n// Load from environment\nexport const config: Config = {\n  database: {\n    host: process.env.DB_HOST || ''localhost'',\n    port: parseInt(process.env.DB_PORT || ''5432''),\n    name: process.env.DB_NAME || ''mydb''\n  },\n  jwt: {\n    secret: process.env.JWT_SECRET || ''dev-secret'',\n    expiryMinutes: parseInt(process.env.JWT_EXPIRY || ''60'')\n  }\n};\n\n// Usage\nimport { config } from ''./config'';\n\nclass AuthService {\n  generateToken(user: User): string {\n    const secret = config.jwt.secret;\n    const expiry = config.jwt.expiryMinutes;\n    // ...\n  }\n}'
    ),
    E'Configuration:\nappsettings.json\n  ↓\nappsettings.Development.json (override)\n  ↓\nEnvironment Variables (override)\n  ↓\nUser Secrets (dev only)\n  ↓\nOptions Pattern: IOptions<T>\n  ↓\nStrongly-typed settings\n\nNever commit secrets!',
    97
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Configuration sources?', to_jsonb(ARRAY['JSON only', 'JSON, env vars, secrets (multiple)', 'Code only', 'Database']), 1, 'Layered from multiple sources.'),
    (current_term_id, 'Options pattern benefit?', to_jsonb(ARRAY['Performance', 'Strongly-typed settings with IntelliSense', 'Security', 'Speed']), 1, 'Type-safe configuration access.'),
    (current_term_id, 'Secrets in production?', to_jsonb(ARRAY['appsettings.json', 'Environment variables or vault', 'Code', 'Database']), 1, 'Never in files, use secure storage.'),
    (current_term_id, 'IOptions vs IOptionsSnapshot?', to_jsonb(ARRAY['Same', 'IOptionsSnapshot reloads on change', 'IOptions faster', 'No difference']), 1, 'Snapshot supports reloading config.'),
    (current_term_id, 'appsettings.Development.json?', to_jsonb(ARRAY['Production settings', 'Development-specific overrides', 'Backup', 'Testing']), 1, 'Environment-specific configuration.');

  RAISE NOTICE 'Added 10 more junior essential terms';
END $$;

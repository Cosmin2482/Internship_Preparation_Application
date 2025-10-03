/*
  # Add Comprehensive OOP and HTTP Fundamentals
  
  Deep explanations with extensive code examples for:
  - Value Types vs Reference Types
  - Composition vs Inheritance
  - HTTP Request/Response detailed
  - PUT vs PATCH
  - Idempotency
  - 401 vs 403
  - String Immutability
*/

DO $$
DECLARE
  cat_oop uuid;
  cat_cs uuid;
  cat_arch uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';
  SELECT id INTO cat_arch FROM categories WHERE slug = 'architecture';

  -- Value Types vs Reference Types (CRITICAL for C#)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Value Types vs Reference Types',
    'Value types (int, struct) live on STACK, copied by value. Reference types (class, string) live on HEAP, copied by reference (address).',
    'Value types: stored on stack, contain actual data, copied entirely. Reference types: stored on heap, variables hold reference (address), multiple variables can reference same object.',
    'Value types (int, bool, struct, enum) are stack-allocated, fast, copied completely. Reference types (class, object, string, array) are heap-allocated, passed by reference. When you assign reference type, you copy the reference not the object. String special: immutable reference type.',
    to_jsonb(ARRAY['Confusing reference semantics', 'Not understanding string immutability', 'Boxing/unboxing performance', 'Struct vs class choice', 'Thinking reference type parameters are by reference (they pass reference by value)']),
    jsonb_build_object(
      'csharp', E'// VALUE TYPES (Stack)\nint a = 10;\nint b = a;  // COPY of value\nb = 20;\nConsole.WriteLine(a); // 10 (unchanged!)\nConsole.WriteLine(b); // 20\n\nstruct Point { // Value type\n  public int X { get; set; }\n  public int Y { get; set; }\n}\n\nPoint p1 = new Point { X = 1, Y = 2 };\nPoint p2 = p1; // COPY entire struct\np2.X = 10;\nConsole.WriteLine(p1.X); // 1 (unchanged)\nConsole.WriteLine(p2.X); // 10\n\n// REFERENCE TYPES (Heap)\nclass Person { // Reference type\n  public string Name { get; set; }\n  public int Age { get; set; }\n}\n\nPerson p1 = new Person { Name = "John", Age = 30 };\nPerson p2 = p1; // COPY reference (both point to SAME object)\np2.Age = 40;\nConsole.WriteLine(p1.Age); // 40 (CHANGED! Same object)\nConsole.WriteLine(p2.Age); // 40\n\n// String: immutable reference type\nstring s1 = "Hello";\nstring s2 = s1; // Copy reference\ns2 = "World";   // Creates NEW string, s1 unchanged\nConsole.WriteLine(s1); // "Hello"\nConsole.WriteLine(s2); // "World"\n\n// Array: reference type\nint[] arr1 = { 1, 2, 3 };\nint[] arr2 = arr1; // Copy reference\narr2[0] = 999;\nConsole.WriteLine(arr1[0]); // 999 (SAME array!)\n\n// Passing to methods\nvoid ModifyValue(int x) {\n  x = 100; // Only modifies copy\n}\n\nvoid ModifyReference(Person p) {\n  p.Age = 100; // Modifies original object!\n}\n\nvoid ModifyReferenceItself(Person p) {\n  p = new Person { Name = "New", Age = 99 }; // Only changes local reference\n}\n\nint num = 10;\nModifyValue(num);\nConsole.WriteLine(num); // 10 (unchanged)\n\nPerson person = new Person { Name = "John", Age = 30 };\nModifyReference(person);\nConsole.WriteLine(person.Age); // 100 (changed!)\n\nModifyReferenceItself(person);\nConsole.WriteLine(person.Name); // "John" (unchanged, local ref changed)',
      'typescript', E'// TypeScript doesn''t have value vs reference distinction like C#\n// Primitives behave like values, objects like references\n\n// Primitives (like value types)\nlet a: number = 10;\nlet b: number = a; // Copy\nb = 20;\nconsole.log(a); // 10\nconsole.log(b); // 20\n\n// Objects (like reference types)\ninterface Person {\n  name: string;\n  age: number;\n}\n\nconst p1: Person = { name: "John", age: 30 };\nconst p2: Person = p1; // Copy reference\np2.age = 40;\nconsole.log(p1.age); // 40 (SAME object)\n\n// Arrays (reference type)\nconst arr1 = [1, 2, 3];\nconst arr2 = arr1; // Copy reference\narr2[0] = 999;\nconsole.log(arr1[0]); // 999\n\n// Immutability pattern\nconst original = { name: "John", age: 30 };\nconst copy = { ...original }; // Shallow copy\ncopy.age = 40;\nconsole.log(original.age); // 30 (separate objects)'
    ),
    E'Stack vs Heap:\n\nSTACK (Value Types):\n  [int a = 10]\n  [int b = 10] ← COPY\n  Fast, automatic cleanup\n\nHEAP (Reference Types):\n  Stack:      Heap:\n  [ref1] ───→ [Object {name: "John"}]\n  [ref2] ───→ [Object {name: "John"}]\n         └────→ Same object!\n  \nValue: copied entirely\nReference: address copied\n\nString special: immutable ref type',
    125
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Value types stored where?', to_jsonb(ARRAY['Heap', 'Stack', 'Database', 'Cache']), 1, 'Stack: fast, automatic cleanup.'),
    (current_term_id, 'Reference types stored where?', to_jsonb(ARRAY['Stack', 'Heap', 'Database', 'Memory']), 1, 'Heap: managed by GC.'),
    (current_term_id, 'Assign reference type copies?', to_jsonb(ARRAY['Entire object', 'Reference (address)', 'Nothing', 'Value']), 1, 'Both variables point to same object.'),
    (current_term_id, 'int is?', to_jsonb(ARRAY['Reference type', 'Value type', 'Class', 'Object']), 1, 'Primitive value type.'),
    (current_term_id, 'string is?', to_jsonb(ARRAY['Value type', 'Immutable reference type', 'Mutable', 'Struct']), 1, 'Special: reference but immutable.'),
    (current_term_id, 'struct is?', to_jsonb(ARRAY['Reference type', 'Value type', 'Class', 'Interface']), 1, 'User-defined value type.'),
    (current_term_id, 'class is?', to_jsonb(ARRAY['Value type', 'Reference type', 'Struct', 'Primitive']), 1, 'User-defined reference type.'),
    (current_term_id, 'Passing value type to method?', to_jsonb(ARRAY['Modifies original', 'Passes copy, original unchanged', 'Passes reference', 'Error']), 1, 'Copy passed, original safe.');

  -- Composition vs Inheritance
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Composition vs Inheritance',
    'Inheritance = "is-a" (Dog IS-A Animal). Composition = "has-a" (Car HAS-A Engine). Prefer composition for flexibility.',
    'Inheritance: class inherits from parent. Composition: class contains instances of other classes. "Favor composition over inheritance" principle.',
    'Inheritance good for true "is-a" relationships, enables polymorphism. But creates tight coupling. Composition more flexible: combine behaviors by "having" components. Easier to test, change. Use inheritance sparingly, composition by default.',
    to_jsonb(ARRAY['Deep inheritance hierarchies', 'Inheritance for code reuse (use composition)', 'Fragile base class problem', 'Multiple inheritance issues', 'Not recognizing when to use each']),
    jsonb_build_object(
      'csharp', E'// INHERITANCE (is-a)\nclass Animal {\n  public virtual void Move() {\n    Console.WriteLine("Animal moves");\n  }\n}\n\nclass Dog : Animal { // Dog IS-A Animal\n  public override void Move() {\n    Console.WriteLine("Dog runs");\n  }\n  \n  public void Bark() {\n    Console.WriteLine("Woof!");\n  }\n}\n\nclass Bird : Animal { // Bird IS-A Animal\n  public override void Move() {\n    Console.WriteLine("Bird flies");\n  }\n}\n\n// Usage\nAnimal dog = new Dog();\ndog.Move(); // "Dog runs" - polymorphism!\n\n// COMPOSITION (has-a)\nclass Engine {\n  public void Start() => Console.WriteLine("Engine started");\n  public void Stop() => Console.WriteLine("Engine stopped");\n}\n\nclass Wheels {\n  public void Rotate() => Console.WriteLine("Wheels rotating");\n}\n\nclass Car { // Car HAS-A Engine, HAS-A Wheels\n  private Engine engine = new Engine();\n  private Wheels wheels = new Wheels();\n  \n  public void Drive() {\n    engine.Start();\n    wheels.Rotate();\n    Console.WriteLine("Car driving");\n  }\n  \n  public void Stop() {\n    engine.Stop();\n    Console.WriteLine("Car stopped");\n  }\n}\n\n// Why composition better here:\n// Can easily swap engine implementation\nclass ElectricEngine {\n  public void Start() => Console.WriteLine("Electric engine silent start");\n  public void Stop() => Console.WriteLine("Electric engine stopped");\n}\n\nclass ModernCar {\n  private readonly Engine engine;\n  \n  // Dependency injection!\n  public ModernCar(Engine eng) {\n    engine = eng;\n  }\n  \n  public void Drive() {\n    engine.Start();\n  }\n}\n\n// Flexible!\nvar gasCar = new ModernCar(new Engine());\nvar electricCar = new ModernCar(new ElectricEngine());\n\n// BAD Inheritance example:\nclass Vehicle {\n  public void StartEngine() { }\n}\n\nclass Bicycle : Vehicle { // PROBLEM! Bicycle has no engine\n  // Inherits StartEngine() which makes no sense\n}\n\n// GOOD Composition:\nclass Bicycle {\n  private Pedals pedals = new Pedals();\n  public void Ride() => pedals.Push();\n}',
      'typescript', E'// INHERITANCE\nclass Animal {\n  move(): void {\n    console.log("Animal moves");\n  }\n}\n\nclass Dog extends Animal {\n  move(): void {\n    console.log("Dog runs");\n  }\n  \n  bark(): void {\n    console.log("Woof!");\n  }\n}\n\n// COMPOSITION\nclass Engine {\n  start(): void { console.log("Engine started"); }\n  stop(): void { console.log("Engine stopped"); }\n}\n\nclass Wheels {\n  rotate(): void { console.log("Wheels rotating"); }\n}\n\nclass Car {\n  private engine: Engine;\n  private wheels: Wheels;\n  \n  constructor(engine: Engine, wheels: Wheels) {\n    this.engine = engine;\n    this.wheels = wheels;\n  }\n  \n  drive(): void {\n    this.engine.start();\n    this.wheels.rotate();\n    console.log("Car driving");\n  }\n}\n\n// Flexible composition\nconst regularEngine = new Engine();\nconst regularWheels = new Wheels();\nconst car = new Car(regularEngine, regularWheels);\ncar.drive();\n\n// Easy to swap components\nclass ElectricEngine extends Engine {\n  start(): void {\n    console.log("Silent electric start");\n  }\n}\n\nconst electricCar = new Car(new ElectricEngine(), regularWheels);'
    ),
    E'Inheritance vs Composition:\n\nInheritance (is-a):\n  Animal\n    ↓\n  Dog, Cat, Bird\n  \n  Pros: Polymorphism, clear hierarchy\n  Cons: Tight coupling, fragile\n\nComposition (has-a):\n  Car\n   ├─ Engine\n   ├─ Wheels\n   └─ Transmission\n  \n  Pros: Flexible, testable, loose coupling\n  Cons: More objects\n\nRule: Favor composition over inheritance',
    126
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Inheritance represents?', to_jsonb(ARRAY['Has-a', 'Is-a relationship', 'Uses', 'Contains']), 1, 'Dog IS-A Animal.'),
    (current_term_id, 'Composition represents?', to_jsonb(ARRAY['Is-a', 'Has-a relationship', 'Inherits', 'Extends']), 1, 'Car HAS-A Engine.'),
    (current_term_id, 'Why favor composition?', to_jsonb(ARRAY['Slower', 'More flexible, loose coupling, testable', 'Required', 'Faster']), 1, 'Easier to change and test.'),
    (current_term_id, 'Inheritance best for?', to_jsonb(ARRAY['Code reuse only', 'True is-a relationships + polymorphism', 'Everything', 'Nothing']), 1, 'Clear hierarchies with shared behavior.'),
    (current_term_id, 'Fragile base class problem?', to_jsonb(ARRAY['No problem', 'Changes to parent break children', 'Performance', 'Memory']), 1, 'Tight coupling issue with inheritance.');

  -- HTTP Request/Response Detailed
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch, 'HTTP Request & Response Anatomy',
    'Request = what client sends (method, URL, headers, body). Response = what server sends back (status, headers, body).',
    'HTTP Request: method (GET/POST), URL, headers (metadata), optional body. Response: status code (200/404), headers, body (data).',
    'Request has: method (verb), path, HTTP version, headers (Content-Type, Authorization), body for POST/PUT. Response has: status code (success/error), headers (Content-Type, Cache), body (JSON/HTML). Stateless protocol.',
    to_jsonb(ARRAY['Not setting Content-Type', 'Forgetting Authorization header', 'Wrong method for operation', 'Not handling error responses', 'Ignoring status codes']),
    jsonb_build_object(
      'csharp', E'// HTTP REQUEST anatomy\n/*\nPOST /api/users HTTP/1.1\nHost: api.example.com\nContent-Type: application/json\nAuthorization: Bearer eyJhbGc...\nAccept: application/json\n\n{"name":"John","age":30}\n*/\n\n// C# HttpClient\nusing var client = new HttpClient();\nclient.BaseAddress = new Uri("https://api.example.com");\nclient.DefaultRequestHeaders.Add("Authorization", "Bearer token123");\n\n// POST request\nvar user = new { name = "John", age = 30 };\nvar json = JsonSerializer.Serialize(user);\nvar content = new StringContent(json, Encoding.UTF8, "application/json");\n\nvar response = await client.PostAsync("/api/users", content);\n\n// HTTP RESPONSE anatomy\n/*\nHTTP/1.1 201 Created\nContent-Type: application/json\nLocation: /api/users/123\nCache-Control: no-cache\n\n{"id":123,"name":"John","age":30}\n*/\n\n// Handle response\nif(response.IsSuccessStatusCode) {\n  var responseBody = await response.Content.ReadAsStringAsync();\n  var createdUser = JsonSerializer.Deserialize<User>(responseBody);\n  Console.WriteLine($"Created user {createdUser.Id}");\n} else {\n  Console.WriteLine($"Error: {response.StatusCode}");\n}\n\n// GET with query parameters\nvar getResponse = await client.GetAsync("/api/users?page=1&limit=10");\n\n// Custom headers\nvar request = new HttpRequestMessage(HttpMethod.Get, "/api/users/123");\nrequest.Headers.Add("X-Custom-Header", "value");\nvar customResponse = await client.SendAsync(request);',
      'typescript', E'// HTTP REQUEST anatomy\n/*\nGET /api/users/123 HTTP/1.1\nHost: api.example.com\nAuthorization: Bearer eyJhbGc...\nAccept: application/json\n*/\n\n// Fetch API\nconst response = await fetch(''https://api.example.com/api/users/123'', {\n  method: ''GET'',\n  headers: {\n    ''Authorization'': ''Bearer token123'',\n    ''Accept'': ''application/json''\n  }\n});\n\n// POST request\nconst user = { name: ''John'', age: 30 };\nconst postResponse = await fetch(''https://api.example.com/api/users'', {\n  method: ''POST'',\n  headers: {\n    ''Content-Type'': ''application/json'',\n    ''Authorization'': ''Bearer token123''\n  },\n  body: JSON.stringify(user)\n});\n\n// HTTP RESPONSE handling\n/*\nHTTP/1.1 200 OK\nContent-Type: application/json\nCache-Control: max-age=3600\n\n{"id":123,"name":"John","age":30}\n*/\n\nif(response.ok) { // status 200-299\n  const data = await response.json();\n  console.log(data);\n} else {\n  console.error(''Error:'', response.status, response.statusText);\n  \n  if(response.status === 404) {\n    console.error(''User not found'');\n  } else if(response.status === 401) {\n    console.error(''Unauthorized - please login'');\n  } else if(response.status === 500) {\n    console.error(''Server error'');\n  }\n}\n\n// Access response headers\nconst contentType = response.headers.get(''Content-Type'');\nconst cacheControl = response.headers.get(''Cache-Control'');\n\n// Query parameters\nconst params = new URLSearchParams({ page: ''1'', limit: ''10'' });\nconst url = `https://api.example.com/api/users?${params}`;\nconst listResponse = await fetch(url);'
    ),
    E'HTTP Request:\n┌─────────────────────────┐\n│ POST /api/users         │ Method + Path\n│ Host: api.example.com   │\n│ Content-Type: app/json  │ Headers\n│ Authorization: Bearer...│\n│                         │\n│ {"name":"John"}         │ Body\n└─────────────────────────┘\n\nHTTP Response:\n┌─────────────────────────┐\n│ HTTP/1.1 201 Created    │ Status\n│ Content-Type: app/json  │ Headers\n│ Location: /api/users/123│\n│                         │\n│ {"id":123,"name":"John"}│ Body\n└─────────────────────────┘',
    71
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'HTTP request contains?', to_jsonb(ARRAY['Only URL', 'Method, URL, headers, optional body', 'Just body', 'Status code']), 1, 'Complete request structure.'),
    (current_term_id, 'HTTP response contains?', to_jsonb(ARRAY['Only data', 'Status code, headers, body', 'Just status', 'Method']), 1, 'Server response structure.'),
    (current_term_id, 'Content-Type header for?', to_jsonb(ARRAY['Security', 'Specifies format of body data', 'Caching', 'Authorization']), 1, 'application/json, text/html, etc.'),
    (current_term_id, 'Authorization header for?', to_jsonb(ARRAY['Content type', 'Authentication credentials', 'Cache', 'Language']), 1, 'Bearer tokens, API keys.'),
    (current_term_id, 'Accept header for?', to_jsonb(ARRAY['Authorization', 'Client specifies desired response format', 'Body', 'Method']), 1, 'Tell server what formats client accepts.');

  RAISE NOTICE 'Added comprehensive OOP and HTTP fundamentals';
END $$;

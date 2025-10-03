/*
  # Add Missing OOP and .NET Terms from Glossary
  
  Add: Overloading, Sealed, Static vs Instance, Fields vs Properties, Design Patterns
*/

DO $$
DECLARE
  cat_oop uuid;
  cat_dotnet uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';
  SELECT id INTO cat_dotnet FROM categories WHERE slug = 'dotnet';

  -- Method Overloading
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Method Overloading',
    'Multiple methods with same name but different parameters. Compiler chooses the right one based on arguments.',
    'Method overloading = multiple methods with same name, different parameter types or count. Compile-time polymorphism.',
    'Overloading provides different ways to call same operation. Same name, different signatures. Compiler resolves at compile-time based on arguments. Useful for flexible APIs with optional parameters or type variations.',
    to_jsonb(ARRAY['Confusing overloading with overriding', 'Return type alone cannot overload', 'Ambiguous overload resolution', 'Too many overloads making code confusing']),
    jsonb_build_object(
      'csharp', E'public class Calculator {\n  // Method overloading - same name, different parameters\n  public int Add(int a, int b) {\n    return a + b;\n  }\n  \n  public int Add(int a, int b, int c) {\n    return a + b + c;\n  }\n  \n  public double Add(double a, double b) {\n    return a + b;\n  }\n  \n  public string Add(string a, string b) {\n    return a + b;\n  }\n}\n\nvar calc = new Calculator();\nint result1 = calc.Add(1, 2);           // Calls int version\nint result2 = calc.Add(1, 2, 3);        // Calls 3-parameter version\ndouble result3 = calc.Add(1.5, 2.5);    // Calls double version\nstring result4 = calc.Add("Hello", " World"); // Calls string version\n\n// Constructor overloading\npublic class Person {\n  public string Name { get; set; }\n  public int Age { get; set; }\n  \n  public Person() : this("Unknown", 0) { }\n  public Person(string name) : this(name, 0) { }\n  public Person(string name, int age) {\n    Name = name;\n    Age = age;\n  }\n}',
      'typescript', E'class Calculator {\n  // Method overloading with union types\n  add(a: number, b: number): number;\n  add(a: string, b: string): string;\n  add(a: number, b: number, c: number): number;\n  add(a: any, b: any, c?: any): any {\n    if(typeof a === "number" && typeof b === "number") {\n      return c !== undefined ? a + b + c : a + b;\n    }\n    if(typeof a === "string" && typeof b === "string") {\n      return a + b;\n    }\n  }\n}\n\nconst calc = new Calculator();\nconst r1 = calc.add(1, 2);      // number\nconst r2 = calc.add(1, 2, 3);   // number\nconst r3 = calc.add("Hi", " there"); // string'
    ),
    E'Method Overloading:\nAdd(int, int)      → 3\nAdd(int, int, int) → 6\nAdd(double, double)→ 3.5\nAdd(string, string)→ "HelloWorld"\n\nSame name, different signatures\nCompile-time polymorphism',
    120
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Method overloading means?', to_jsonb(ARRAY['Override in child', 'Same name, different parameters', 'Virtual methods', 'Interface implementation']), 1, 'Multiple versions of method with different signatures.'),
    (current_term_id, 'Overloading resolved?', to_jsonb(ARRAY['Runtime', 'Compile-time', 'Never', 'Random']), 1, 'Compiler chooses based on arguments.'),
    (current_term_id, 'Can overload by return type only?', to_jsonb(ARRAY['Yes', 'No, need different parameters', 'Sometimes', 'Depends']), 1, 'Return type alone insufficient.'),
    (current_term_id, 'Overloading vs Overriding?', to_jsonb(ARRAY['Same', 'Overloading: same name diff params, Override: redefine in child', 'No difference', 'Override compile-time']), 1, 'Overloading = compile-time, override = runtime.'),
    (current_term_id, 'Common use for overloading?', to_jsonb(ARRAY['Inheritance', 'Flexible APIs with optional parameters', 'Encapsulation', 'Abstraction']), 1, 'Convenient variations of same operation.');

  -- Sealed Classes
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Sealed Classes & Methods',
    'Sealed class cannot be inherited. Sealed method cannot be overridden in derived classes.',
    'sealed keyword prevents inheritance (classes) or further overriding (methods). Used for security, optimization, or design finality.',
    'Sealed prevents further inheritance/overriding. Use for security (prevent malicious override), optimization (compiler/JIT can inline), or design finality (complete implementation). Records in C# are implicitly sealed.',
    to_jsonb(ARRAY['Overusing sealed limiting extensibility', 'Not understanding when to seal', 'Sealing without reason', 'Confusing sealed with abstract']),
    jsonb_build_object(
      'csharp', E'// Sealed class - cannot be inherited\npublic sealed class FinalClass {\n  public void DoSomething() {\n    Console.WriteLine("Final implementation");\n  }\n}\n\n// Compile error: Cannot inherit from sealed\n// public class Derived : FinalClass { } // ERROR!\n\n// Sealed method - cannot be further overridden\npublic class Base {\n  public virtual void Method() {\n    Console.WriteLine("Base");\n  }\n}\n\npublic class Middle : Base {\n  // Override and seal - no further overriding\n  public sealed override void Method() {\n    Console.WriteLine("Middle - final override");\n  }\n}\n\npublic class Derived : Middle {\n  // Cannot override sealed method\n  // public override void Method() { } // ERROR!\n}\n\n// Practical use: String is sealed\nsealed class String { } // .NET implementation\n\n// Records are implicitly sealed (C# 9)\npublic record Person(string Name, int Age);\n// Cannot inherit from record unless explicitly not sealed',
      'typescript', E'// TypeScript doesn''t have sealed keyword\n// But you can prevent extension with patterns\n\nclass FinalClass {\n  private constructor() { } // Private constructor\n  \n  static create(): FinalClass {\n    return new FinalClass();\n  }\n}\n\n// Cannot extend due to private constructor\n// class Derived extends FinalClass { } // Error\n\n// Or use Object.freeze for instances\nclass Config {\n  constructor(public readonly value: string) {\n    Object.freeze(this);\n  }\n}\n\nconst config = new Config("immutable");\n// config.value = "new"; // Error: readonly'
    ),
    E'Sealed:\nBase → Middle (sealed override) → Derived\n  ↓         ↓                        ↓\n virtual   sealed override      ❌ cannot override\n\nSealed class:\n  Cannot inherit\n  \nBenefits:\n  - Security\n  - Optimization\n  - Design finality',
    121
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Sealed class means?', to_jsonb(ARRAY['Cannot instantiate', 'Cannot be inherited', 'Abstract', 'Interface']), 1, 'Prevents inheritance.'),
    (current_term_id, 'Sealed method?', to_jsonb(ARRAY['Cannot call', 'Cannot be further overridden', 'Abstract', 'Virtual']), 1, 'Stops override chain.'),
    (current_term_id, 'Why use sealed?', to_jsonb(ARRAY['Always required', 'Security, optimization, design finality', 'No reason', 'Slower']), 1, 'Prevent unintended inheritance.'),
    (current_term_id, 'String class is sealed?', to_jsonb(ARRAY['Yes in .NET', 'No', 'Sometimes', 'Depends']), 0, 'Cannot inherit from String.'),
    (current_term_id, 'Sealed vs Abstract?', to_jsonb(ARRAY['Same', 'Sealed = cannot inherit, Abstract = must inherit', 'Abstract sealed', 'No difference']), 1, 'Opposite concepts.');

  -- Static vs Instance
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Static vs Instance Members',
    'Static belongs to class (shared by all). Instance belongs to each object (unique per object).',
    'Static members: shared across all instances, accessed via class name. Instance members: unique per object, accessed via object reference.',
    'Static members belong to type, not instance. One copy shared globally. No "this". Useful for utilities, constants, counters. Instance members unique per object. Use static for stateless operations, instance for object-specific data.',
    to_jsonb(ARRAY['Static state causing concurrency issues', 'Overusing static (hard to test)', 'Cannot access instance members from static', 'Static constructors rare needs']),
    jsonb_build_object(
      'csharp', E'public class Counter {\n  // Static - shared by all instances\n  private static int totalCount = 0;\n  \n  // Instance - unique per object\n  private int instanceCount = 0;\n  \n  public Counter() {\n    totalCount++;    // Increment shared counter\n    instanceCount++; // Each instance has own\n  }\n  \n  // Static method - accessed via class\n  public static int GetTotalCount() {\n    return totalCount;\n    // Cannot access instanceCount here!\n  }\n  \n  // Instance method - accessed via object\n  public int GetInstanceCount() {\n    return instanceCount;\n    // Can access both static and instance\n    Console.WriteLine($"Total: {totalCount}");\n  }\n}\n\n// Usage\nvar c1 = new Counter();\nvar c2 = new Counter();\nvar c3 = new Counter();\n\nConsole.WriteLine(Counter.GetTotalCount()); // 3 (static)\nConsole.WriteLine(c1.GetInstanceCount());   // 1 (instance)\n\n// Static utility class\npublic static class MathHelper {\n  public static double Pi = 3.14159;\n  \n  public static double Square(double x) {\n    return x * x;\n  }\n}\n\nvar result = MathHelper.Square(5); // 25',
      'typescript', E'class Counter {\n  // Static - shared\n  private static totalCount = 0;\n  \n  // Instance - per object\n  private instanceCount = 0;\n  \n  constructor() {\n    Counter.totalCount++;\n    this.instanceCount++;\n  }\n  \n  static getTotalCount(): number {\n    return Counter.totalCount;\n  }\n  \n  getInstanceCount(): number {\n    return this.instanceCount;\n  }\n}\n\nconst c1 = new Counter();\nconst c2 = new Counter();\n\nconsole.log(Counter.getTotalCount()); // 2\nconsole.log(c1.getInstanceCount());   // 1\n\n// Static utility\nclass MathHelper {\n  static readonly PI = 3.14159;\n  \n  static square(x: number): number {\n    return x * x;\n  }\n}\n\nconst result = MathHelper.square(5);'
    ),
    E'Static vs Instance:\n\n[Class Counter]\n  Static: totalCount = 3 ← shared\n     ↓\n[Object c1]  [Object c2]  [Object c3]\n  count=1      count=1      count=1\n  ↑ each has own instance data\n\nAccess:\n  Static: Counter.Method()\n  Instance: object.Method()',
    122
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Static members belong to?', to_jsonb(ARRAY['Each object', 'Class (shared)', 'Parent class', 'Interface']), 1, 'One copy per class.'),
    (current_term_id, 'Instance members?', to_jsonb(ARRAY['Shared', 'Unique per object', 'Global', 'Static']), 1, 'Each object has own copy.'),
    (current_term_id, 'Access static member?', to_jsonb(ARRAY['object.Method()', 'ClassName.Method()', 'this.Method()', 'base.Method()']), 1, 'Via class name.'),
    (current_term_id, 'Static method can access?', to_jsonb(ARRAY['Instance members', 'Only static members', 'Everything', 'Nothing']), 1, 'No access to instance data.'),
    (current_term_id, 'Use static for?', to_jsonb(ARRAY['Object state', 'Utility functions, constants', 'Everything', 'Instance data']), 1, 'Stateless operations.');

  -- Fields vs Properties
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Fields vs Properties',
    'Field = raw variable. Property = controlled access to field with get/set logic.',
    'Field: direct variable storage. Property: methods (get/set) providing controlled access. Properties enable validation, computed values, lazy loading.',
    'Fields are raw storage. Properties are methods disguised as fields. Use properties for public API (validation, change notification, computed values). Auto-properties generate backing field. Prefer properties over public fields for encapsulation.',
    to_jsonb(ARRAY['Public fields breaking encapsulation', 'No validation in property setters', 'Heavy logic in getters (should be lightweight)', 'Confusing field naming (_field vs field)']),
    jsonb_build_object(
      'csharp', E'public class Person {\n  // Field - raw storage (private)\n  private string _name;\n  private int _age;\n  \n  // Property with backing field - controlled access\n  public string Name {\n    get { return _name; }\n    set {\n      if(string.IsNullOrEmpty(value))\n        throw new ArgumentException("Name required");\n      _name = value;\n    }\n  }\n  \n  public int Age {\n    get { return _age; }\n    set {\n      if(value < 0 || value > 150)\n        throw new ArgumentException("Invalid age");\n      _age = value;\n    }\n  }\n  \n  // Auto-property - compiler generates backing field\n  public string Email { get; set; }\n  \n  // Read-only property\n  public string FullName => $"{FirstName} {LastName}";\n  \n  // Init-only property (C# 9)\n  public int Id { get; init; }\n  \n  // Property with private setter\n  public DateTime CreatedAt { get; private set; } = DateTime.Now;\n}\n\nvar person = new Person { \n  Name = "John",  // Calls setter with validation\n  Age = 30 \n};\n\n// person.Name = ""; // Throws exception!\nstring name = person.Name; // Calls getter',
      'typescript', E'class Person {\n  // Private field\n  private _name: string = "";\n  private _age: number = 0;\n  \n  // Property with getter/setter\n  get name(): string {\n    return this._name;\n  }\n  \n  set name(value: string) {\n    if(!value) throw new Error("Name required");\n    this._name = value;\n  }\n  \n  get age(): number {\n    return this._age;\n  }\n  \n  set age(value: number) {\n    if(value < 0 || value > 150) throw new Error("Invalid age");\n    this._age = value;\n  }\n  \n  // Readonly (no setter)\n  readonly id: number = 0;\n  \n  // Computed property\n  get fullName(): string {\n    return `${this.firstName} ${this.lastName}`;\n  }\n}\n\nconst p = new Person();\np.name = "John"; // Calls setter\nconst n = p.name; // Calls getter'
    ),
    E'Fields vs Properties:\n\nField (private):\n  private int _age;\n  Direct storage\n  \nProperty (public):\n  public int Age { \n    get { return _age; }\n    set { \n      validate(value);\n      _age = value;\n    }\n  }\n  Controlled access\n  \nAuto-property:\n  public string Name { get; set; }\n  Compiler generates field',
    123
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Field is?', to_jsonb(ARRAY['Method', 'Raw variable storage', 'Property', 'Class']), 1, 'Direct data member.'),
    (current_term_id, 'Property is?', to_jsonb(ARRAY['Field', 'Methods (get/set) for controlled access', 'Variable', 'Constructor']), 1, 'Encapsulated access to data.'),
    (current_term_id, 'Auto-property?', to_jsonb(ARRAY['No backing field', 'Compiler generates backing field', 'Public field', 'Method']), 1, '{ get; set; } creates hidden field.'),
    (current_term_id, 'Why properties over fields?', to_jsonb(ARRAY['Faster', 'Validation, encapsulation, flexibility', 'Less code', 'No difference']), 1, 'Control access and add logic.'),
    (current_term_id, 'Init-only property?', to_jsonb(ARRAY['Always mutable', 'Set only during object initialization', 'Private', 'Static']), 1, 'Immutable after construction.');

  RAISE NOTICE 'Added missing OOP terms';
END $$;

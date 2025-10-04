/*
  # Add Critical Missing Terms
  
  Add key terms explicitly mentioned in requirements that are missing
*/

DO $$
DECLARE
  cat_oop_id uuid;
  cat_http_id uuid;
  cat_dotnet_id uuid;
  cat_sql_id uuid;
BEGIN
  -- Get category IDs
  SELECT id INTO cat_oop_id FROM categories WHERE slug = 'oop';
  SELECT id INTO cat_http_id FROM categories WHERE slug = 'architecture';
  SELECT id INTO cat_dotnet_id FROM categories WHERE slug = 'dotnet';
  SELECT id INTO cat_sql_id FROM categories WHERE slug = 'sql';

  -- Field vs Property (Critical OOP/C# concept)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Field vs Property',
    'Field = simple variable in a class. Property = smart accessor with get/set logic. Properties can validate, transform, or compute values. Fields are raw storage.',
    'Field: direct variable storage in a class, typically private. Property: encapsulates field access through get/set accessors, enabling validation, computed values, or side effects. Properties provide controlled access to fields.',
    'Field is raw data storage - just a variable. Property wraps field access with get/set accessors. I use properties for public exposure because they allow validation (if age < 0 reject), lazy initialization, change notifications, or computed values (FullName combining FirstName + LastName). Fields stay private. Properties enable encapsulation - I can change internal storage without breaking callers. Auto-properties (get; set;) are syntactic sugar for simple field+property combo.',
    to_jsonb(ARRAY[
      'Making fields public (breaks encapsulation)',
      'Not validating in property setters',
      'Heavy logic in getters (should be fast)',
      'Confusion: property is not a field',
      'Not understanding auto-properties',
      'Using fields when properties are needed'
    ]),
    jsonb_build_object(
      'csharp', '// FIELD - raw storage
public class Person {
    private string name; // Field (private)
    private int age;     // Field
    
    // PROPERTY - controlled access
    public string Name {
        get { return name; }
        set { 
            if (!string.IsNullOrEmpty(value))
                name = value; 
        }
    }
    
    // Auto-property (compiler creates hidden field)
    public string Email { get; set; }
    
    // Computed property (no backing field)
    public bool IsAdult {
        get { return age >= 18; }
    }
    
    // Property with validation
    public int Age {
        get { return age; }
        set {
            if (value < 0 || value > 150)
                throw new ArgumentException("Invalid age");
            age = value;
        }
    }
}

// Usage
var p = new Person();
p.Name = "John"; // Calls property setter
p.Email = "j@example.com"; // Auto-property
bool adult = p.IsAdult; // Computed property',
      'typescript', '// TypeScript uses getters/setters
class Person {
    private _name: string = "";
    private _age: number = 0;
    
    // Getter
    get name(): string {
        return this._name;
    }
    
    // Setter with validation
    set name(value: string) {
        if (value && value.length > 0) {
            this._name = value;
        }
    }
    
    // Computed property
    get isAdult(): boolean {
        return this._age >= 18;
    }
    
    // Direct property (no getter/setter)
    email: string = "";
}

const p = new Person();
p.name = "John"; // Uses setter
p.email = "j@example.com"; // Direct access'
    ),
    'Field vs Property:

[FIELD]
private int age;
├─ Raw storage
├─ Direct access (internal)
└─ No logic

[PROPERTY]
public int Age {
  get { return age; }
  set { 
    if(value >= 0) 
      age = value; 
  }
}
├─ Controlled access
├─ Validation
├─ Can compute
└─ Encapsulation

Auto-Property:
public string Name { get; set; }
→ Compiler creates hidden field',
    101
  ) ON CONFLICT DO NOTHING;

  -- Virtual vs Override vs New (Critical for polymorphism understanding)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Virtual vs Override vs New',
    'virtual = parent allows child to change behavior. override = child changes it (polymorphism!). new = child hides parent method (NOT polymorphism - breaks it).',
    'virtual: base class method can be overridden in derived classes. override: derived class provides new implementation, participates in polymorphism. new: hides base method, breaks polymorphism - called based on compile-time type, not runtime type.',
    'virtual in base class means "this method can be customized by children". override in derived class replaces the method and enables polymorphism - runtime decides which version to call based on actual object type. new keyword hides the base method without polymorphism - it is called based on variable type, not object type. Critical difference: override gives polymorphism, new breaks it. Interview example: Animal.Speak() virtual → Dog.Speak() override = polymorphism works. Dog.Speak() new = polymorphism broken. Always prefer override unless you specifically want to hide.',
    to_jsonb(ARRAY[
      'Using new when you meant override (breaks polymorphism)',
      'Forgetting virtual in base class',
      'Not understanding new hides, not overrides',
      'Confusion: new is compile-time, override is runtime',
      'Missing override keyword (warning, but dangerous)',
      'Calling base.Method() when you did not mean to'
    ]),
    jsonb_build_object(
      'csharp', '// VIRTUAL and OVERRIDE - Polymorphism ✓
public class Animal {
    public virtual void Speak() {
        Console.WriteLine("Animal sound");
    }
}

public class Dog : Animal {
    public override void Speak() { // OVERRIDE
        Console.WriteLine("Woof!");
    }
}

Animal a = new Dog();
a.Speak(); // → Woof! (polymorphism works)

// NEW - Hides method, breaks polymorphism ✗
public class Cat : Animal {
    public new void Speak() { // NEW keyword
        Console.WriteLine("Meow!");
    }
}

Animal a2 = new Cat();
a2.Speak(); // → "Animal sound" (NOT Meow!)
            // Broken! Variable type (Animal) decides

Cat c = new Cat();
c.Speak(); // → "Meow!" (variable type is Cat)

// RULE: Use override for polymorphism
//       Use new only when intentionally hiding',
      'typescript', '// TypeScript does not have virtual/override
// All methods are virtual by default
class Animal {
    speak(): void {
        console.log("Animal sound");
    }
}

class Dog extends Animal {
    speak(): void { // Automatically overrides
        console.log("Woof!");
    }
}

const a: Animal = new Dog();
a.speak(); // Woof! (polymorphism always works)'
    ),
    'Virtual/Override/New:

VIRTUAL (Base)
└─ Allows override
   ↓
OVERRIDE (Derived)
└─ Replaces method
└─ POLYMORPHISM ✓

Animal a = new Dog();
a.Speak() → Woof!

NEW (Derived)
└─ HIDES method
└─ NO polymorphism ✗

Animal a = new Cat();
a.Speak() → Animal sound
(WRONG - ignores Cat.Speak)',
    102
  ) ON CONFLICT DO NOTHING;

  -- Classes and Objects
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Class vs Object',
    'Class = blueprint/recipe (defines what something is). Object = actual instance (the thing you built from the blueprint). One class, many objects.',
    'Class: template defining structure (fields, properties, methods) and behavior. Object (instance): concrete realization of a class created with new keyword. Class is the type, object is the variable.',
    'Class is the blueprint defining what something is - like architectural plans. Object is the actual instance created from that blueprint - the house built from those plans. One class can create many objects. Example: class Person defines name, age, and Walk() method. john = new Person() creates an object. mary = new Person() creates another object. Both are Person instances but separate in memory with their own data. Class is the type definition, object is the runtime value.',
    to_jsonb(ARRAY[
      'Confusing class with object',
      'Thinking class has data (only objects have data)',
      'Not understanding one class, many objects',
      'Forgetting to use new to create objects',
      'Confusing static (class-level) vs instance (object-level)',
      'Thinking classes are singletons by default'
    ]),
    jsonb_build_object(
      'csharp', '// CLASS - Blueprint/Template
public class Person {
    public string Name { get; set; }
    public int Age { get; set; }
    
    public void Greet() {
        Console.WriteLine($"Hi, I am {Name}");
    }
}

// OBJECTS - Actual instances
Person john = new Person { Name = "John", Age = 30 };
Person mary = new Person { Name = "Mary", Age = 25 };

john.Greet(); // Hi, I am John
mary.Greet(); // Hi, I am Mary

// Two objects, one class
// Each object has its own Name/Age data',
      'typescript', '// CLASS
class Person {
    name: string;
    age: number;
    
    constructor(name: string, age: number) {
        this.name = name;
        this.age = age;
    }
    
    greet(): void {
        console.log(`Hi, I am ${this.name}`);
    }
}

// OBJECTS
const john = new Person("John", 30);
const mary = new Person("Mary", 25);

john.greet(); // Hi, I am John
mary.greet(); // Hi, I am Mary'
    ),
    'Class vs Object:

[CLASS] Person
├─ Name: string
├─ Age: int
└─ Greet(): void

Blueprint (1)
     ↓ new
[OBJECT] john
├─ Name: "John"
├─ Age: 30
└─ Greet()

[OBJECT] mary
├─ Name: "Mary"
├─ Age: 25
└─ Greet()

Many objects from one class',
    103
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Added critical missing OOP terms';
END $$;

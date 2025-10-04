/*
  # Batch 1: Critical OOP & C# Fundamentals
  
  Adds 20+ critical missing OOP and C# terms:
  - Object (standalone)
  - struct vs class
  - record types
  - Value types vs Reference types
  - Generics & Constraints
  - Exception handling
  - IDisposable/using
  - And more fundamentals
*/

DO $$
DECLARE
  cat_oop_id uuid;
BEGIN
  SELECT id INTO cat_oop_id FROM categories WHERE slug = 'oop';

  -- Object (runtime instance)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Object',
    'An object is the actual thing built from a class blueprint. Class = recipe, Object = the cake you baked. Each object has its own data in memory.',
    'Object: a runtime instance of a class. Created with the new keyword, it allocates memory and holds state (field values). Multiple objects can exist from one class, each with independent data.',
    'An object is a concrete instance of a class. The class defines the structure and behavior, but the object is the actual entity in memory with real values. Example: if Person is the class, then john = new Person() creates an object. john has its own Name and Age values. Each object occupies separate memory, so john and mary are independent even though both are Person instances.',
    to_jsonb(ARRAY[
      'Confusing the class definition with object instances',
      'Thinking objects share data (each has its own)',
      'Forgetting objects are allocated on the heap (for reference types)',
      'Not understanding object lifetime and garbage collection',
      'Mixing up null (no object) vs empty object'
    ]),
    jsonb_build_object(
      'csharp', '// CLASS definition
public class Person {
    public string Name { get; set; }
    public int Age { get; set; }
}

// OBJECTS (instances)
Person john = new Person { Name = "John", Age = 30 };
Person mary = new Person { Name = "Mary", Age = 25 };

// Each object has its own data
john.Age = 31; // Only affects john
Console.WriteLine(mary.Age); // Still 25

// john and mary are separate objects in memory',
      'typescript', '// CLASS
class Person {
    name: string;
    age: number;
    
    constructor(name: string, age: number) {
        this.name = name;
        this.age = age;
    }
}

// OBJECTS
const john = new Person("John", 30);
const mary = new Person("Mary", 25);

// Separate instances
john.age = 31;
console.log(mary.age); // 25'
    ),
    'Class vs Object:

[CLASS] Person
   ↓ new
[OBJECT] john
  Name: "John"
  Age: 30
  (in memory)

[OBJECT] mary  
  Name: "Mary"
  Age: 25
  (separate memory)',
    10
  ) ON CONFLICT DO NOTHING;

  -- struct vs class
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'struct vs class',
    'struct = value type (copied, stack-friendly, lightweight). class = reference type (referenced, heap-allocated). Use struct for small, immutable data like Point(x, y).',
    'struct: value type, copied by value, typically stack-allocated (unless boxed), no inheritance (except interfaces). class: reference type, passed by reference, heap-allocated, supports full OOP inheritance. structs should be small, immutable, and logically represent a single value.',
    'struct is a value type - when you pass it, you copy the whole thing. class is a reference type - you pass a pointer to the heap object. Key difference: struct assignment creates a copy, class assignment shares the same object. Use struct for lightweight data like coordinates, colors, or small mathematical types (< 16 bytes is guideline). Use class for most objects with behavior and state. Structs cannot inherit from other structs/classes but can implement interfaces. Structs get default parameterless constructor automatically.',
    to_jsonb(ARRAY[
      'Making structs too large (copy cost)',
      'Making structs mutable (leads to confusion with copies)',
      'Expecting reference semantics with structs',
      'Not understanding boxing when struct → object',
      'Forgetting structs cannot be null (unless Nullable<T>)',
      'Using struct when class is more appropriate'
    ]),
    jsonb_build_object(
      'csharp', '// STRUCT - value type
public struct Point {
    public int X { get; set; }
    public int Y { get; set; }
}

Point p1 = new Point { X = 10, Y = 20 };
Point p2 = p1; // COPY created
p2.X = 30;

Console.WriteLine(p1.X); // 10 (p1 unaffected)
Console.WriteLine(p2.X); // 30

// CLASS - reference type
public class Circle {
    public int Radius { get; set; }
}

Circle c1 = new Circle { Radius = 5 };
Circle c2 = c1; // REFERENCE copied (same object)
c2.Radius = 10;

Console.WriteLine(c1.Radius); // 10 (both point to same object)
Console.WriteLine(c2.Radius); // 10

// Good struct example: immutable
public readonly struct Money {
    public decimal Amount { get; init; }
    public string Currency { get; init; }
}',
      'typescript', '// TypeScript does not have struct
// All objects are reference types
// For value-like behavior, use immutability

interface Point {
    readonly x: number;
    readonly y: number;
}

const p1: Point = { x: 10, y: 20 };
const p2: Point = { ...p1, x: 30 }; // Spread creates new object

console.log(p1.x); // 10
console.log(p2.x); // 30'
    ),
    'struct vs class:

STRUCT (value type)
├─ Copied on assignment
├─ Stack-allocated*
├─ No inheritance
├─ Small, immutable
└─ Example: Point, Color

Point p1 = ...
Point p2 = p1;  → COPY
p2.X = 99;
p1.X unchanged ✓

CLASS (reference type)
├─ Referenced on assignment
├─ Heap-allocated
├─ Full inheritance
├─ Larger objects
└─ Example: Person, Order

Circle c1 = ...
Circle c2 = c1;  → REFERENCE
c2.Radius = 99;
c1.Radius also 99 ✓',
    104
  ) ON CONFLICT DO NOTHING;

  -- record types
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'record (class/struct)',
    'record = special class/struct built for data. Automatic value-based equality (compare contents, not reference), with-expressions for non-destructive mutation, great for DTOs.',
    'record: reference type (record class) or value type (record struct) with compiler-generated value-based Equals/GetHashCode, ToString, with-expressions, and positional deconstruction. Designed for immutable data transfer objects.',
    'record is a C# 9+ feature for data-focused types. Key difference vs normal class: records compare by value, not reference. Two record instances with same property values are considered equal. Records give you with-expressions for non-destructive updates - create a copy with one property changed. Perfect for DTOs, events, immutable data models. record class is default (reference), record struct is value type. Records auto-generate useful methods like ToString with all properties. Use records when your type is primarily data with little behavior.',
    to_jsonb(ARRAY[
      'Using records when behavior/methods are primary (use class)',
      'Expecting reference semantics from record struct (it is a value type)',
      'Not understanding with creates a copy',
      'Making records mutable (defeats the purpose)',
      'Overusing records for entity models with EF Core'
    ]),
    jsonb_build_object(
      'csharp', '// RECORD CLASS (default)
public record Person(string Name, int Age);

Person john = new Person("John", 30);
Person john2 = new Person("John", 30);

// VALUE-BASED EQUALITY
Console.WriteLine(john == john2); // TRUE (same values)

// CLASS would be FALSE (different references)
// public class PersonClass { ... }
// PersonClass p1 = new(...);
// PersonClass p2 = new(...);
// p1 == p2 → FALSE

// WITH-EXPRESSION (non-destructive mutation)
Person olderJohn = john with { Age = 31 };
Console.WriteLine(john.Age); // 30 (original unchanged)
Console.WriteLine(olderJohn.Age); // 31

// RECORD STRUCT (value type)
public record struct Point(int X, int Y);

Point p1 = new Point(10, 20);
Point p2 = p1; // Copied (value type)

// Traditional style also works
public record Employee {
    public string Name { get; init; }
    public decimal Salary { get; init; }
}',
      'typescript', '// TypeScript does not have records
// Use readonly interfaces for similar effect

interface Person {
    readonly name: string;
    readonly age: number;
}

const john: Person = { name: "John", age: 30 };
const olderJohn: Person = { ...john, age: 31 };

// For equality, need custom comparison
function equals(p1: Person, p2: Person): boolean {
    return p1.name === p2.name && p1.age === p2.age;
}'
    ),
    'record vs class:

RECORD
├─ Value-based equality ✓
├─ with-expressions ✓
├─ Auto ToString ✓
├─ Great for DTOs
└─ Data-focused

record Person(string Name, int Age);
var p1 = new Person("John", 30);
var p2 = new Person("John", 30);
p1 == p2  → TRUE (same values)

var older = p1 with { Age = 31 };

CLASS
├─ Reference equality
├─ No with-expressions
├─ Manual ToString
├─ Behavior-focused
└─ Mutable by default

class PersonClass { ... }
var c1 = new PersonClass(...);
var c2 = new PersonClass(...);
c1 == c2  → FALSE (different objects)',
    105
  ) ON CONFLICT DO NOTHING;

  -- Value types vs Reference types
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Value Types vs Reference Types',
    'Value type = data copied (int, struct). Reference type = pointer copied, data stays on heap (class, string). Value types live on stack (usually), reference types on heap.',
    'Value types: store data directly, copied on assignment, typically stack-allocated, include primitives (int, bool, etc.) and structs. Reference types: store reference to heap data, assignment copies pointer (both refer to same object), include classes, interfaces, delegates, strings.',
    'Critical distinction: value type assignment copies the data; reference type assignment copies the pointer. Value types: int, bool, double, decimal, structs, enums. Reference types: classes, arrays, delegates, strings (immutable but still reference). Stack vs heap: value types usually stack, reference types always heap. Nullability: value types not nullable by default (need Nullable<T> or T?), reference types nullable. Boxing: value type → object = boxing (heap allocation). Performance: value types avoid heap allocation overhead but large structs hurt performance due to copying.',
    to_jsonb(ARRAY[
      'Confusing copy vs reference semantics',
      'Not understanding boxing/unboxing costs',
      'Forgetting string is reference type (but immutable)',
      'Making large structs (copy performance hit)',
      'Not knowing when to use Nullable<T>',
      'Thinking stack = fast always (large struct copies are slow)'
    ]),
    jsonb_build_object(
      'csharp', '// VALUE TYPES (copied)
int a = 10;
int b = a;  // COPY
b = 20;
Console.WriteLine(a); // 10 (unaffected)

struct Point { public int X, Y; }
Point p1 = new Point { X = 1, Y = 2 };
Point p2 = p1;  // COPY
p2.X = 99;
Console.WriteLine(p1.X); // 1 (unaffected)

// REFERENCE TYPES (referenced)
class Person { public string Name; }
Person john = new Person { Name = "John" };
Person alias = john;  // SAME OBJECT
alias.Name = "Jane";
Console.WriteLine(john.Name); // "Jane" (shared)

// BOXING (value → object)
int x = 42;
object obj = x;  // BOXING (heap allocation)
int y = (int)obj;  // UNBOXING

// Nullable value type
int? nullableInt = null;  // Nullable<int>

// VALUE TYPES: int, double, bool, char, struct, enum
// REFERENCE TYPES: class, interface, delegate, object, string',
      'typescript', '// JavaScript/TypeScript: primitives are values, objects are references

// PRIMITIVES (value-like)
let a = 10;
let b = a;  // Copy
b = 20;
console.log(a); // 10

// OBJECTS (reference)
const obj1 = { x: 10 };
const obj2 = obj1;  // Same reference
obj2.x = 20;
console.log(obj1.x); // 20 (shared)'
    ),
    'Value vs Reference Types:

VALUE TYPE
├─ Data copied
├─ Stack (usually)
├─ int, struct, enum
└─ Not nullable (default)

int a = 10;
int b = a;  → COPY
b = 20;
a still 10 ✓

[Stack]
a: 10
b: 20

REFERENCE TYPE  
├─ Pointer copied
├─ Heap
├─ class, array, string
└─ Nullable

Person p1 = new Person();
Person p2 = p1;  → SAME OBJECT
p2.Name = "X";
p1.Name also "X" ✓

[Stack]      [Heap]
p1 ────┐
       ├───→ Person { Name: "X" }
p2 ────┘',
    106
  ) ON CONFLICT DO NOTHING;

  -- Generics
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Generics',
    'Generics = placeholders for types. List<T> means "list of some type T". List<int>, List<string> - same code, different types. Type-safe, no casting, no boxing.',
    'Generics: type parameters (T, TKey, TValue) allowing classes, methods, and interfaces to work with any type while maintaining type safety. Compiler generates specialized code for each type used. Benefits: type safety, performance (no boxing for value types), code reuse.',
    'Generics let you write code that works with any type without losing type safety. List<T> is generic - you specify the type when you use it: List<int>, List<Person>. Key benefits: (1) Type safety at compile time - List<int>.Add("string") won not compile. (2) No casting needed - you get int out, not object. (3) No boxing for value types - List<int> stores ints directly, not boxed. (4) Code reuse - one List<T> implementation works for all types. Common generic types: List<T>, Dictionary<TKey, TValue>, IEnumerable<T>. You can make your own generic classes and methods. Type parameter naming: T for single type, TKey/TValue for key-value, TResult for return type.',
    to_jsonb(ARRAY[
      'Not understanding T is a placeholder',
      'Confusing generic methods with regular overloads',
      'Not using constraints when needed',
      'Boxing value types with non-generic collections (ArrayList)',
      'Thinking generics are runtime polymorphism (they are compile-time)',
      'Poor naming of type parameters'
    ]),
    jsonb_build_object(
      'csharp', '// GENERIC CLASS
public class Box<T> {
    private T _item;
    
    public void Put(T item) => _item = item;
    public T Get() => _item;
}

Box<int> intBox = new Box<int>();
intBox.Put(42);
int value = intBox.Get(); // No cast needed, type-safe

Box<string> stringBox = new Box<string>();
stringBox.Put("Hello");
// stringBox.Put(123); // ← Compile error ✓

// GENERIC METHOD
public T Max<T>(T a, T b) where T : IComparable<T> {
    return a.CompareTo(b) > 0 ? a : b;
}

int maxInt = Max(10, 20);
string maxStr = Max("apple", "banana");

// MULTIPLE TYPE PARAMETERS
public class Pair<TFirst, TSecond> {
    public TFirst First { get; set; }
    public TSecond Second { get; set; }
}

var pair = new Pair<int, string> { 
    First = 1, 
    Second = "one" 
};

// Common generic types
List<int> numbers = new List<int>();
Dictionary<string, Person> people = new Dictionary<string, Person>();
IEnumerable<Product> products = GetProducts();',
      'typescript', '// TypeScript generics
class Box<T> {
    private item: T;
    
    put(item: T): void {
        this.item = item;
    }
    
    get(): T {
        return this.item;
    }
}

const intBox = new Box<number>();
intBox.put(42);
const value = intBox.get(); // number

// Generic function
function max<T>(a: T, b: T, compare: (x: T, y: T) => number): T {
    return compare(a, b) > 0 ? a : b;
}

// Generic constraints
interface HasLength {
    length: number;
}

function logLength<T extends HasLength>(item: T): void {
    console.log(item.length);
}'
    ),
    'Generics:

Box<T>  ← T is placeholder

Box<int>        Box<string>
Put(42)         Put("Hi")
Get() → int     Get() → string

Type-safe, no casting!

WITHOUT generics (old way):
ArrayList list = new ArrayList();
list.Add(42);  // Boxing!
int x = (int)list[0];  // Casting!

WITH generics:
List<int> list = new List<int>();
list.Add(42);  // No boxing
int x = list[0];  // No cast

Benefits:
✓ Type safety
✓ No boxing
✓ No casting
✓ Code reuse',
    107
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Added Batch 1: Critical OOP & C# fundamentals (5 terms so far)';
END $$;

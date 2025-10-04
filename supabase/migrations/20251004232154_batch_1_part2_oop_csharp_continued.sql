/*
  # Batch 1 Part 2: More OOP & C# Fundamentals
  
  Adds: Constraints, Exception, IDisposable/using, async/await
*/

DO $$
DECLARE
  cat_oop_id uuid;
BEGIN
  SELECT id INTO cat_oop_id FROM categories WHERE slug = 'oop';

  -- Generic Constraints
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Generic Constraints',
    'Constraints limit what types T can be. where T : class means T must be a class. where T : IComparable means T must be comparable. Ensures T has what you need.',
    'Generic constraints: where clauses that restrict which types can be used as type arguments. Common constraints: class (reference type), struct (value type), new() (parameterless constructor), BaseClass (inheritance), IInterface (implementation).',
    'Constraints solve the problem: what if my generic code needs specific capabilities from T? where T : IComparable<T> ensures T can be compared. where T : class ensures T is a reference type (can be null). where T : new() ensures you can call new T(). Multiple constraints: where T : class, IDisposable, new(). Common interview scenario: "I want to sort generic items" - need where T : IComparable<T>. Without constraints, you can only use object methods on T.',
    to_jsonb(ARRAY[
      'Forgetting to add constraints when T needs specific methods',
      'Wrong constraint order (class must be first)',
      'Not knowing new() must be last',
      'Using constraints when not needed (over-constraining)',
      'Confusion about struct constraint (means value type, not struct specifically)'
    ]),
    jsonb_build_object(
      'csharp', '// CLASS constraint (reference type)
public class Container<T> where T : class {
    private T _item;
    public T Item {
        get => _item;
        set => _item = value ?? throw new ArgumentNullException();
    }
}

// STRUCT constraint (value type)
public class ValueContainer<T> where T : struct {
    public T Value { get; set; }
}

// INTERFACE constraint
public T Max<T>(T a, T b) where T : IComparable<T> {
    return a.CompareTo(b) > 0 ? a : b;
}

// NEW() constraint (must have parameterless constructor)
public T CreateInstance<T>() where T : new() {
    return new T();
}

// BASE CLASS constraint
public class EntityRepo<T> where T : BaseEntity {
    public void Save(T entity) {
        entity.UpdateTimestamp(); // BaseEntity method
    }
}

// MULTIPLE constraints (order matters!)
public class Factory<T> 
    where T : class, IDisposable, new() 
{
    public T Create() {
        T instance = new T();
        return instance;
    }
}

// Common constraints:
// where T : class          → reference type
// where T : struct         → value type
// where T : IInterface     → implements interface
// where T : BaseClass      → inherits from base
// where T : new()          → has parameterless constructor
// where T : U              → T derives from U',
      'typescript', '// TypeScript uses structural typing
// Constraints via extends

interface Comparable<T> {
    compareTo(other: T): number;
}

function max<T extends Comparable<T>>(a: T, b: T): T {
    return a.compareTo(b) > 0 ? a : b;
}

// Constructor constraint
interface Constructable<T> {
    new(): T;
}

function createInstance<T>(ctor: Constructable<T>): T {
    return new ctor();
}'
    ),
    'Generic Constraints:

WITHOUT constraint:
void Process<T>(T item) {
    // Can only use object methods
    item.ToString();
}

WITH constraint:
void Process<T>(T item) 
    where T : IComparable<T> {
    // Can compare!
    if (item.CompareTo(...) > 0) { }
}

Common constraints:
where T : class        → reference
where T : struct       → value
where T : IInterface   → capability
where T : new()        → creatable
where T : BaseClass    → inheritance

Order for multiple:
where T : class, IDisposable, new()
          ↑       ↑              ↑
          1st     middle         last',
    108
  ) ON CONFLICT DO NOTHING;

  -- Exception
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'Exception',
    'Exception = error signal. When something goes wrong, throw an exception. Calling code can catch it and handle it, or let it bubble up. Stops normal flow immediately.',
    'Exception: object representing an error condition, thrown via throw keyword, caught via try-catch. Interrupts normal execution flow, unwinds the stack until caught, executes finally blocks, supports custom exception types inheriting from Exception.',
    'Exception handling is how .NET manages errors. throw new Exception() stops execution and searches up the call stack for a catch block. try-catch-finally: try contains risky code, catch handles specific exception types, finally always runs (cleanup). Key types: Exception (base), ArgumentException, InvalidOperationException, NullReferenceException. Best practices: (1) Catch specific exceptions, not just Exception. (2) Use finally or using for cleanup. (3) Do not swallow exceptions silently. (4) Throw meaningful exceptions with good messages. (5) Do not use exceptions for control flow (slow). Interview tip: explain try-catch-finally, when to create custom exceptions, why catching Exception is usually bad.',
    to_jsonb(ARRAY[
      'Catching Exception (too broad)',
      'Empty catch blocks (swallowing errors)',
      'Using exceptions for control flow (performance)',
      'Not providing useful error messages',
      'Forgetting finally runs even if exception thrown',
      'Re-throwing with throw ex (loses stack trace - use throw)'
    ]),
    jsonb_build_object(
      'csharp', '// THROWING exceptions
public void Withdraw(decimal amount) {
    if (amount <= 0)
        throw new ArgumentException("Amount must be positive", nameof(amount));
    
    if (amount > Balance)
        throw new InvalidOperationException("Insufficient funds");
    
    Balance -= amount;
}

// CATCHING exceptions
try {
    Withdraw(-100);
}
catch (ArgumentException ex) {
    Console.WriteLine($"Bad argument: {ex.Message}");
}
catch (InvalidOperationException ex) {
    Console.WriteLine($"Cannot withdraw: {ex.Message}");
}
finally {
    // Always runs, even if exception
    Console.WriteLine("Transaction attempt completed");
}

// RETHROWING (preserve stack trace)
try {
    SomeMethod();
}
catch (Exception) {
    // Log error
    throw; // ← Correct (preserves stack trace)
    // throw ex; ← WRONG (resets stack trace)
}

// CUSTOM EXCEPTION
public class InsufficientFundsException : Exception {
    public decimal RequestedAmount { get; }
    public decimal AvailableBalance { get; }
    
    public InsufficientFundsException(decimal requested, decimal available)
        : base($"Cannot withdraw {requested}. Balance: {available}") {
        RequestedAmount = requested;
        AvailableBalance = available;
    }
}

// Common exception types:
// ArgumentException, ArgumentNullException
// InvalidOperationException
// NotImplementedException
// NullReferenceException (avoid by checking nulls)',
      'typescript', '// JavaScript/TypeScript exceptions
function withdraw(amount: number): void {
    if (amount <= 0) {
        throw new Error("Amount must be positive");
    }
    if (amount > balance) {
        throw new Error("Insufficient funds");
    }
    balance -= amount;
}

// Try-catch
try {
    withdraw(-100);
} catch (error) {
    if (error instanceof Error) {
        console.log(error.message);
    }
} finally {
    console.log("Always runs");
}

// Custom error class
class InsufficientFundsError extends Error {
    constructor(
        public requested: number,
        public available: number
    ) {
        super(`Cannot withdraw ${requested}`);
        this.name = "InsufficientFundsError";
    }
}'
    ),
    'Exception Flow:

Normal flow:
Method A → Method B → Method C
         ← return  ← return

Exception thrown:
Method A → Method B → Method C
                      throw! ↓
         ← unwind ← unwind

try {
    Method C(); // throws
}
catch (SpecificEx ex) {
    // Handle error
}
finally {
    // Always runs (cleanup)
}

Stack unwinding:
Main()
  └─ MethodA()
      └─ MethodB()
          └─ MethodC() → throw!
      catch here? ✓
  or catch here?
or catch here?
or crash ✗',
    109
  ) ON CONFLICT DO NOTHING;

  -- IDisposable and using
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'IDisposable / using',
    'IDisposable = cleanup contract. Dispose() releases unmanaged resources (files, connections). using statement ensures Dispose() is called automatically, even if exception occurs.',
    'IDisposable: interface with Dispose() method for deterministic cleanup of unmanaged resources. using statement: syntactic sugar for try-finally that calls Dispose(). Implements the dispose pattern for releasing resources (file handles, database connections, network sockets) that garbage collector cannot clean automatically.',
    'IDisposable solves: how to clean up resources that are not managed by GC? File streams, database connections, sockets need explicit cleanup. Implement IDisposable with public Dispose() method. using statement guarantees Dispose() is called even if exception thrown - it compiles to try-finally. Key pattern: using (var stream = new FileStream(...)) { } ensures stream.Dispose() runs. Modern C# 8: using var stream = ... (declaration using). Common IDisposable types: FileStream, SqlConnection, HttpClient, StreamReader. Best practices: (1) Always use using with IDisposable. (2) Dispose once. (3) Make Dispose() idempotent. Interview: explain why GC is not enough, what using compiles to.',
    to_jsonb(ARRAY[
      'Forgetting to dispose IDisposable objects',
      'Not using using statement (manual try-finally)',
      'Disposing objects still in use elsewhere',
      'Thinking GC handles all cleanup (it does not)',
      'Calling Dispose() multiple times without guarding',
      'Not implementing IDisposable when holding unmanaged resources'
    ]),
    jsonb_build_object(
      'csharp', '// IDisposable interface
public interface IDisposable {
    void Dispose();
}

// USING STATEMENT (recommended)
using (var stream = new FileStream("file.txt", FileMode.Open)) {
    // Use stream
} // stream.Dispose() automatically called here

// Equivalent to:
FileStream stream = new FileStream("file.txt", FileMode.Open);
try {
    // Use stream
}
finally {
    stream?.Dispose(); // Always called
}

// C# 8+ declaration using
using var connection = new SqlConnection(connString);
connection.Open();
// Dispose called at end of scope

// IMPLEMENTING IDisposable
public class MyResource : IDisposable {
    private FileStream _stream;
    private bool _disposed = false;
    
    public void Dispose() {
        if (_disposed) return; // Idempotent
        
        _stream?.Dispose();
        _disposed = true;
    }
}

// Multiple using
using (var reader = new StreamReader("input.txt"))
using (var writer = new StreamWriter("output.txt")) {
    string line;
    while ((line = reader.ReadLine()) != null) {
        writer.WriteLine(line);
    }
} // Both disposed in reverse order

// Common IDisposable types:
// FileStream, StreamReader/Writer
// SqlConnection, SqlCommand
// HttpClient
// Timer
// CancellationTokenSource',
      'typescript', '// TypeScript does not have IDisposable
// Use try-finally pattern or explicit cleanup

class FileHandle {
    private handle: number;
    
    open(path: string): void {
        // Open file
    }
    
    close(): void {
        // Close file
    }
}

const file = new FileHandle();
try {
    file.open("file.txt");
    // Use file
} finally {
    file.close(); // Always called
}

// Modern: using Symbol.dispose (TC39 proposal)
// Not yet standard'
    ),
    'IDisposable Pattern:

WITHOUT using:
FileStream stream = new FileStream(...);
// Use stream
stream.Dispose(); // ✗ What if exception?

WITH using:
using (var stream = new FileStream(...)) {
    // Use stream
} // Dispose() ALWAYS called ✓

Compiles to:
FileStream stream = ...;
try {
    // Use stream
}
finally {
    stream?.Dispose(); ✓
}

Why needed?
GC cleans managed memory ✓
GC does NOT close files ✗
GC does NOT close connections ✗
GC does NOT release locks ✗

→ Need IDisposable for unmanaged resources',
    110
  ) ON CONFLICT DO NOTHING;

  -- async/await
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop_id,
    'async / await',
    'async/await = cooperative async. await pauses method execution without blocking the thread, letting it do other work. When operation completes, method resumes. Avoids thread blocking.',
    'async/await: language feature for asynchronous programming over Task<T>. async marks method as asynchronous, returns Task or Task<T>. await suspends method execution, yields thread back to pool, resumes when awaited task completes. Non-blocking, scalable, maintains sequential-looking code.',
    'async/await enables non-blocking I/O without callback hell. Key concepts: (1) async method returns Task<T>. (2) await pauses execution, frees thread. (3) Thread returns when await completes. (4) Code after await is continuation. Critical: await does NOT create new thread - it releases thread back to pool. Perfect for I/O (database, HTTP, file) - thread waits for nothing. Do not use for CPU-bound work (use Task.Run). Method signature: async Task<T> for result, async Task for void (avoid async void except event handlers). Always await async calls in async methods. ConfigureAwait(false) avoids capturing context. Interview: explain how await frees thread, difference from blocking, when to use async.',
    to_jsonb(ARRAY[
      'Using async void (hard to handle errors, avoid)',
      'Blocking on async code (.Result, .Wait() - deadlock risk)',
      'Not awaiting async methods (fire-and-forget, lost exceptions)',
      'Using async for CPU-bound work (use Task.Run instead)',
      'Not understanding await releases thread',
      'async all the way - mix of sync/async causes issues'
    ]),
    jsonb_build_object(
      'csharp', '// ASYNC METHOD
public async Task<string> GetDataAsync(string url) {
    using var client = new HttpClient();
    
    // await pauses here, releases thread
    string result = await client.GetStringAsync(url);
    
    // Continues here when complete
    return result.ToUpper();
}

// CALLING async method
public async Task ProcessAsync() {
    string data = await GetDataAsync("https://api.example.com");
    Console.WriteLine(data);
}

// MULTIPLE async operations
public async Task<int> GetTotalAsync() {
    Task<int> task1 = GetValue1Async();
    Task<int> task2 = GetValue2Async();
    
    // Both run concurrently
    await Task.WhenAll(task1, task2);
    
    return task1.Result + task2.Result;
}

// BLOCKING (BAD)
// NEVER do this - deadlock risk!
var result = GetDataAsync(url).Result; // ✗ Blocks thread
GetDataAsync(url).Wait(); // ✗ Blocks thread

// CORRECT
var result = await GetDataAsync(url); // ✓ Non-blocking

// async void (avoid except event handlers)
private async void Button_Click(object sender, EventArgs e) {
    // OK for event handlers only
    await ProcessAsync();
}

// ConfigureAwait
public async Task<string> GetDataAsync(string url) {
    using var client = new HttpClient();
    
    // Do not capture synchronization context
    string result = await client
        .GetStringAsync(url)
        .ConfigureAwait(false);
    
    return result;
}',
      'typescript', '// async/await in TypeScript
async function getData(url: string): Promise<string> {
    const response = await fetch(url);
    const text = await response.text();
    return text.toUpperCase();
}

// Calling async function
async function process(): Promise<void> {
    const data = await getData("https://api.example.com");
    console.log(data);
}

// Multiple concurrent operations
async function getTotal(): Promise<number> {
    const [val1, val2] = await Promise.all([
        getValue1(),
        getValue2()
    ]);
    return val1 + val2;
}

// Error handling
async function safeGet(url: string): Promise<string | null> {
    try {
        return await getData(url);
    } catch (error) {
        console.error(error);
        return null;
    }
}'
    ),
    'async/await:

BLOCKING (old way):
Thread starts
  ↓ Call web API
  ↓ WAIT... (thread blocked ✗)
  ↓ Response arrives
  ↓ Continue
Thread ends

NON-BLOCKING (async/await):
Thread starts
  ↓ await HTTP call
  ↓ Thread RELEASED ✓
     (can handle other requests)
     
  ↓ Response arrives
  ↓ Thread from pool
  ↓ Continue
Thread ends

Code:
async Task<string> GetAsync() {
    var result = await httpClient
        .GetStringAsync(url);
        // ↑ Thread released here
        
    return result; // Resumes here
}

Benefits:
✓ No thread blocking
✓ Scalable (more concurrent requests)
✓ Sequential-looking code
✓ Thread reused while waiting',
    111
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Completed Batch 1: Added 9 critical OOP & C# terms';
END $$;

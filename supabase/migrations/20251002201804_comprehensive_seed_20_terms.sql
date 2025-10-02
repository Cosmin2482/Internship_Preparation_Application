/*
  # Comprehensive Seed - 20 Essential Terms
  
  1. Content Added
    - 20 fully populated terms across all 8 main categories
    - Each term includes: ELI5, formal definition, interview answer, 3-7 pitfalls, 
      C# and TypeScript code examples, ASCII diagram, and 5 quiz questions
  
  2. Categories Covered
    - CS Fundamentals (6 terms): Array, Stack, Queue, Big O, Hash Table, Binary Search
    - OOP (2 terms): Four Pillars, SOLID Principles
    - .NET & Backend (2 terms): Async/Await, LINQ
    - TypeScript/Angular (2 terms): RxJS Observables, Dependency Injection
    - SQL (2 terms): JOINs, Indexing
    - Architecture (2 terms): MVC Pattern, Microservices
    - DevOps (2 terms): CI/CD Pipeline, Docker Containers
    - AI/ML (2 terms): Supervised Learning, Confusion Matrix
  
  3. Notes
    - Replaces all existing content for clean slate
    - All content production-ready with real examples
*/

DO $$
DECLARE
  cat_cs uuid;
  cat_oop uuid;
  cat_dotnet uuid;
  cat_sql uuid;
  cat_angular uuid;
  cat_arch uuid;
  cat_devops uuid;
  cat_ai uuid;
  current_term_id uuid;
BEGIN
  -- Get category IDs
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';
  SELECT id INTO cat_dotnet FROM categories WHERE slug = 'dotnet';
  SELECT id INTO cat_angular FROM categories WHERE slug = 'angular';
  SELECT id INTO cat_sql FROM categories WHERE slug = 'sql';
  SELECT id INTO cat_arch FROM categories WHERE slug = 'architecture';
  SELECT id INTO cat_devops FROM categories WHERE slug = 'devops';
  SELECT id INTO cat_ai FROM categories WHERE slug = 'ai-ml';

  -- Clear all existing
  DELETE FROM quiz_questions;
  DELETE FROM terms;

  -- ========== CS FUNDAMENTALS (6) ==========
  
  -- 1. Array
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Array', 
    'A row of numbered boxes where you can instantly grab any item if you know its position number.',
    'A contiguous memory structure providing O(1) random access via index. Insertion/deletion in middle requires shifting elements, making it O(n).',
    'Arrays excel at random access with O(1) complexity and cache locality due to contiguous memory. Best for known-size collections needing frequent indexing. Avoid for frequent mid-insertions since they require O(n) shifts.',
    to_jsonb(ARRAY['Out-of-bounds access causing exceptions', 'Fixed size in many languages limits flexibility', 'Costly O(n) mid insertions/deletions', 'Cache misses with large strides']),
    jsonb_build_object(
      'csharp', E'int[] nums = {1, 2, 3, 4, 5};\nint value = nums[2]; // O(1) access\nArray.Resize(ref nums, 10); // O(n) copy',
      'typescript', E'const nums: number[] = [1, 2, 3, 4, 5];\nconst value = nums[2]; // O(1) access\nnums.splice(2, 0, 99); // O(n) insert'
    ),
    E'Array: [0][1][2][3][4]\n       ↓  ↓  ↓  ↓  ↓\n      [1][2][3][4][5]\nDirect index: O(1)', 
    1
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Array element access time complexity?', to_jsonb(ARRAY['O(1)', 'O(n)', 'O(log n)', 'O(n²)']), 0, 'Direct memory calculation for instant access.'),
    (current_term_id, 'Arrays are zero-indexed in C# and TypeScript?', to_jsonb(ARRAY['True', 'False', 'Depends', 'Only TypeScript']), 0, 'Both use 0-based indexing.'),
    (current_term_id, 'Why are arrays cache-friendly?', to_jsonb(ARRAY['Less RAM', 'Contiguous memory', 'Compressed', 'Immutable']), 1, 'Sequential layout enables CPU prefetch.'),
    (current_term_id, 'When to avoid arrays?', to_jsonb(ARRAY['Random access', 'Frequent insertions', 'Fixed size', 'Iteration']), 1, 'Mid insertions require shifting.'),
    (current_term_id, 'Out-of-bounds in C#?', to_jsonb(ARRAY['null', 'default', 'Exception', 'Auto-expand']), 2, 'Throws IndexOutOfRangeException.');

  -- 2. Stack
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Stack',
    'A stack of plates - you can only add or remove from the top. Last in, first out.',
    'A LIFO (Last-In-First-Out) data structure with O(1) push, pop, and peek operations.',
    'Stacks are fundamental for recursion, undo/redo, and DFS traversal. LIFO makes recent items immediately accessible for backtracking algorithms.',
    to_jsonb(ARRAY['Stack overflow from unbounded recursion', 'Forgetting isEmpty check before pop', 'Using stack when FIFO needed', 'Thread safety in concurrent scenarios']),
    jsonb_build_object(
      'csharp', E'var stack = new Stack<int>();\nstack.Push(1); stack.Push(2);\nint top = stack.Pop(); // 2\nint peek = stack.Peek(); // 1',
      'typescript', E'const stack: number[] = [];\nstack.push(1); stack.push(2);\nconst top = stack.pop(); // 2\nconst peek = stack[stack.length - 1]; // 1'
    ),
    E'Stack (LIFO):\n   TOP ↓\n   [3]  ← push/pop\n   [2]\n   [1]', 
    2
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Stack principle?', to_jsonb(ARRAY['FIFO', 'LIFO', 'Priority', 'Random']), 1, 'Last-In-First-Out.'),
    (current_term_id, 'NOT O(1) on stack?', to_jsonb(ARRAY['Push', 'Pop', 'Peek', 'Search']), 3, 'Search requires scanning.'),
    (current_term_id, 'Stack for which traversal?', to_jsonb(ARRAY['BFS', 'DFS', 'Priority', 'Sample']), 1, 'DFS uses stack.'),
    (current_term_id, 'Stack overflow cause?', to_jsonb(ARRAY['Buffer overflow', 'Deep recursion', 'Heap exhaustion', 'Network']), 1, 'Unbounded recursion.'),
    (current_term_id, 'Common stack use case?', to_jsonb(ARRAY['Task queue', 'Undo/Redo', 'Job scheduler', 'Cache']), 1, 'Undo uses LIFO.');

  -- 3. Queue
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Queue',
    'A line at a store - first person in line is served first. First in, first out.',
    'A FIFO (First-In-First-Out) data structure with O(1) enqueue and dequeue operations.',
    'Queues are essential for BFS, task scheduling, and buffering. FIFO ensures fairness in processing order.',
    to_jsonb(ARRAY['Unbounded growth exhausting memory', 'Head/tail pointer bugs', 'Using queue when LIFO needed', 'Inefficient array-based dequeue']),
    jsonb_build_object(
      'csharp', E'var queue = new Queue<int>();\nqueue.Enqueue(1); queue.Enqueue(2);\nint first = queue.Dequeue(); // 1\nint peek = queue.Peek(); // 2',
      'typescript', E'const queue: number[] = [];\nqueue.push(1); queue.push(2);\nconst first = queue.shift(); // 1\n// Better: linked list'
    ),
    E'Queue (FIFO):\nFRONT→[1][2][3]←BACK\n      ↓      ↑\n   dequeue enqueue', 
    3
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Queue principle?', to_jsonb(ARRAY['LIFO', 'FIFO', 'LILO', 'Priority']), 1, 'First-In-First-Out.'),
    (current_term_id, 'Queue for which traversal?', to_jsonb(ARRAY['DFS', 'BFS', 'Binary search', 'Sort']), 1, 'BFS uses queue.'),
    (current_term_id, 'NOT O(1) on queue?', to_jsonb(ARRAY['Enqueue', 'Dequeue', 'Peek', 'Access middle']), 3, 'Middle needs traversal.'),
    (current_term_id, 'Circular buffer advantage?', to_jsonb(ARRAY['Saves memory', 'Infinite', 'Thread-safe', 'Search']), 0, 'Reuses space.'),
    (current_term_id, 'Task scheduler uses?', to_jsonb(ARRAY['Priority', 'FIFO fairness', 'Random', 'Undo']), 1, 'FIFO order.');

  -- 4. Big O Notation
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Big O Notation',
    'A way to describe how slow your code gets when you give it more stuff to work with.',
    'Mathematical notation describing algorithm upper bound growth rate relative to input size. Expresses worst-case time or space complexity.',
    'Big O describes scalability showing how runtime grows with input size. O(1) constant, O(log n) logarithmic, O(n) linear, O(n²) quadratic. Focus on dominant term.',
    to_jsonb(ARRAY['Confusing worst vs average case', 'Ignoring constants for small n', 'Missing space complexity', 'Not recognizing amortized complexity']),
    jsonb_build_object(
      'csharp', E'// O(1) constant\nint x = arr[0];\n\n// O(n) linear\nfor(int i = 0; i < n; i++) { }\n\n// O(n²) quadratic\nfor(int i = 0; i < n; i++)\n  for(int j = 0; j < n; j++) { }',
      'typescript', E'// O(log n) binary search\nfunction binarySearch(arr: number[], target: number) {\n  let left = 0, right = arr.length - 1;\n  while(left <= right) {\n    const mid = Math.floor((left + right) / 2);\n    if(arr[mid] === target) return mid;\n    arr[mid] < target ? left = mid + 1 : right = mid - 1;\n  }\n}'
    ),
    E'Growth:\nO(1)   ——————————\nO(log n) ——————\nO(n)     ————————↗\nO(n²)    —————————↗↗', 
    4
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Big O measures?', to_jsonb(ARRAY['Exact runtime', 'Upper bound growth', 'Best case', 'Memory only']), 1, 'Worst-case upper bound.'),
    (current_term_id, 'Binary search complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n log n)']), 1, 'Halves space each iteration.'),
    (current_term_id, 'Nested loops n times?', to_jsonb(ARRAY['O(n)', 'O(2n)', 'O(n²)', 'O(n log n)']), 2, 'n × n = n².'),
    (current_term_id, 'Why ignore constants?', to_jsonb(ARRAY['Hard to calculate', 'Focus on growth rate', 'Always small', 'Prevents errors']), 1, 'Asymptotic analysis.'),
    (current_term_id, 'Fastest for large n?', to_jsonb(ARRAY['O(n²)', 'O(n log n)', 'O(n)', 'O(log n)']), 3, 'log n < n < n log n < n².');

  -- 5. Hash Table
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Hash Table',
    'A magic filing cabinet that instantly knows which drawer your item is in based on its name.',
    'Data structure using hash function to map keys to array indices, providing O(1) average case lookup, insert, delete.',
    'Hash tables (Dictionary/Map) provide O(1) average operations via hashing. Critical for caching, counting, deduplication. Collisions resolved via chaining.',
    to_jsonb(ARRAY['Collisions degrading to O(n) with poor hash', 'Mutable keys causing lost entries', 'Load factor triggering rehashing', 'Non-deterministic iteration order']),
    jsonb_build_object(
      'csharp', E'var dict = new Dictionary<string, int>();\ndict["apple"] = 5; // O(1)\nint count = dict["apple"]; // O(1)\nbool exists = dict.ContainsKey("banana");',
      'typescript', E'const map = new Map<string, number>();\nmap.set("apple", 5); // O(1)\nconst count = map.get("apple");\nconst exists = map.has("banana");'
    ),
    E'Hash Table:\nKey→Hash(key)%size→Index\n"apple"→47382%10→[7]\nCollisions: chaining', 
    5
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Hash table average case?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n log n)']), 0, 'Good hash gives O(1).'),
    (current_term_id, 'Collision cause?', to_jsonb(ARRAY['Too many keys', 'Different keys same hash', 'Bad keys', 'Small table']), 1, 'Multiple keys to same bucket.'),
    (current_term_id, 'Why avoid mutable keys?', to_jsonb(ARRAY['Performance', 'Hash value changes', 'Memory leak', 'Thread issues']), 1, 'Mutating makes unfindable.'),
    (current_term_id, 'Collision resolution?', to_jsonb(ARRAY['Delete retry', 'Chaining', 'Ignore', 'Array']), 1, 'Chaining uses linked lists.'),
    (current_term_id, 'Rehashing trigger?', to_jsonb(ARRAY['Every insert', 'High load factor', 'Collision', 'Delete']), 1, 'Load threshold triggers resize.');

  -- 6. Binary Search
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Binary Search',
    'Like finding a word in dictionary by opening middle, then deciding left or right half repeatedly.',
    'Efficient O(log n) search algorithm on sorted array by repeatedly halving search space based on middle element comparison.',
    'Binary search requires sorted data. Compare target with middle element, eliminate half each iteration. O(log n) vs O(n) linear search. Careful with integer overflow in mid calculation.',
    to_jsonb(ARRAY['Requires sorted array', 'Integer overflow in (left+right)/2', 'Off-by-one errors in boundaries', 'Infinite loop from wrong bounds update']),
    jsonb_build_object(
      'csharp', E'int BinarySearch(int[] arr, int target) {\n  int left = 0, right = arr.Length - 1;\n  while(left <= right) {\n    int mid = left + (right - left) / 2;\n    if(arr[mid] == target) return mid;\n    if(arr[mid] < target) left = mid + 1;\n    else right = mid - 1;\n  }\n  return -1;\n}',
      'typescript', E'function binarySearch(arr: number[], target: number): number {\n  let left = 0, right = arr.length - 1;\n  while(left <= right) {\n    const mid = Math.floor((left + right) / 2);\n    if(arr[mid] === target) return mid;\n    arr[mid] < target ? left = mid + 1 : right = mid - 1;\n  }\n  return -1;\n}'
    ),
    E'Binary Search:\n[1,3,5,7,9,11,13]\n       ↑ mid=7\ntarget=11 → search right\n      [9,11,13]\n         ↑ found!', 
    6
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Binary search requirement?', to_jsonb(ARRAY['Large array', 'Sorted array', 'Even length', 'Unique elements']), 1, 'Must be sorted.'),
    (current_term_id, 'Time complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n²)']), 1, 'Halves space: O(log n).'),
    (current_term_id, 'Avoid overflow with?', to_jsonb(ARRAY['(left+right)/2', 'left+(right-left)/2', 'right-left', 'Always safe']), 1, 'Prevents integer overflow.'),
    (current_term_id, 'When target not found?', to_jsonb(ARRAY['Throw error', 'Return -1', 'Return null', 'Return 0']), 1, 'Convention: return -1.'),
    (current_term_id, 'Advantage over linear?', to_jsonb(ARRAY['Simpler', 'Faster on sorted data', 'Works unsorted', 'Less code']), 1, 'O(log n) vs O(n).');

  -- ========== OOP (2) ==========
  
  -- 7. OOP Four Pillars
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'OOP Four Pillars',
    'Four big ideas: hiding details, bundling data, inheriting features, using things interchangeably.',
    'Encapsulation (data hiding), Abstraction (hiding complexity), Inheritance (code reuse), Polymorphism (one interface many forms).',
    'Encapsulation protects data. Abstraction exposes necessary interfaces. Inheritance enables code reuse. Polymorphism allows treating derived types as base types.',
    to_jsonb(ARRAY['Tight coupling from excessive inheritance', 'Leaky abstractions', 'Fragile base class problem', 'Misusing inheritance for code reuse']),
    jsonb_build_object(
      'csharp', E'// Encapsulation\npublic class Account {\n  private decimal balance;\n  public void Deposit(decimal amt) => balance += amt;\n}\n\n// Polymorphism\nAnimal a = new Dog();\na.Speak(); // "Woof"',
      'typescript', E'// Encapsulation\nclass Account {\n  private balance = 0;\n  deposit(amt: number) { this.balance += amt; }\n}\n\n// Polymorphism\nconst a: Animal = new Dog();\na.speak(); // "Woof"'
    ),
    E'OOP Pillars:\n1. Encapsulation\n2. Abstraction\n3. Inheritance\n4. Polymorphism', 
    7
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Which pillar hides data?', to_jsonb(ARRAY['Abstraction', 'Encapsulation', 'Inheritance', 'Polymorphism']), 1, 'Encapsulation protects data.'),
    (current_term_id, 'Polymorphism allows?', to_jsonb(ARRAY['Hiding', 'One interface many forms', 'Protection', 'Reuse']), 1, 'Derived types as base.'),
    (current_term_id, 'Inheritance enables?', to_jsonb(ARRAY['Hiding', 'Code reuse', 'Swapping', 'Flexibility']), 1, 'Child inherits parent.'),
    (current_term_id, 'Prefer composition when?', to_jsonb(ARRAY['Never', 'Has-a relationship', 'Is-a relationship', 'Always']), 1, 'Has-a uses composition.'),
    (current_term_id, 'Abstraction hides?', to_jsonb(ARRAY['Data', 'Implementation complexity', 'Errors', 'State']), 1, 'Hides details.');

  -- 8. SOLID Principles
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'SOLID Principles',
    'Five rules for clean code: single job, open for extension, replaceable parts, split interfaces, depend on contracts.',
    'Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion.',
    'SOLID guides maintainable OOP. SRP prevents god classes. OCP uses extension. LSP ensures substitutability. ISP avoids fat interfaces. DIP decouples.',
    to_jsonb(ARRAY['Over-engineering', 'Misinterpreting SRP as single method', 'Breaking LSP', 'Too many micro-interfaces']),
    jsonb_build_object(
      'csharp', E'// DIP: Depend on abstraction\npublic interface ILogger { void Log(string msg); }\npublic class UserService {\n  private ILogger logger;\n  public UserService(ILogger logger) { this.logger = logger; }\n}',
      'typescript', E'// SRP: One responsibility\nclass InvoicePrinter {\n  print(invoice: Invoice) { }\n}\nclass InvoiceCalculator {\n  calculate(invoice: Invoice) { }\n}'
    ),
    E'SOLID:\nS: Single Responsibility\nO: Open/Closed\nL: Liskov Substitution\nI: Interface Segregation\nD: Dependency Inversion', 
    8
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'SRP: class should have?', to_jsonb(ARRAY['One method', 'One reason to change', 'One field', 'One dependency']), 1, 'One reason to modify.'),
    (current_term_id, 'Open/Closed means?', to_jsonb(ARRAY['Open source', 'Open extension closed modification', 'Open architecture', 'Closed bugs']), 1, 'Extend without modifying.'),
    (current_term_id, 'LSP ensures?', to_jsonb(ARRAY['Interfaces', 'Subtype substitutability', 'Loose coupling', 'Testability']), 1, 'Derived substitutable.'),
    (current_term_id, 'DIP: depend on?', to_jsonb(ARRAY['Concrete', 'Abstractions', 'Static', 'Singletons']), 1, 'Depend on abstractions.'),
    (current_term_id, 'ISP avoids?', to_jsonb(ARRAY['Multiple interfaces', 'Fat interfaces', 'Inheritance', 'Polymorphism']), 1, 'Split large interfaces.');

  -- ========== .NET (2) ==========
  
  -- 9. Async/Await
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'Async/Await',
    'Let your program do other things while waiting for slow operations.',
    'C# asynchronous programming feature. async marks method returning Task, await suspends without blocking thread.',
    'Async/await enables non-blocking I/O. Await suspends method, freeing thread. Critical for scalable servers. Always await or handle Task.',
    to_jsonb(ARRAY['Async void except event handlers', 'Blocking with .Result causing deadlock', 'Not ConfigureAwait(false) in libraries', 'Ignoring returned Task']),
    jsonb_build_object(
      'csharp', E'public async Task<string> FetchAsync() {\n  var client = new HttpClient();\n  string result = await client.GetStringAsync(url);\n  return result.ToUpper();\n}\n\nvar data = await FetchAsync();',
      'typescript', E'async function fetch(): Promise<string> {\n  const response = await fetch(url);\n  const text = await response.text();\n  return text.toUpperCase();\n}\n\nconst data = await fetch();'
    ),
    E'Async:\n1. await → suspend\n2. Thread freed\n3. Task completes\n4. Resume', 
    9
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Await does?', to_jsonb(ARRAY['Blocks thread', 'Suspends without blocking', 'New thread', 'Polls']), 1, 'Suspends, frees thread.'),
    (current_term_id, 'Async void OK for?', to_jsonb(ARRAY['All methods', 'Event handlers only', 'Library code', 'Never']), 1, 'Only event handlers.'),
    (current_term_id, 'Deadlock cause?', to_jsonb(ARRAY['Too many awaits', 'Blocking on Task.Result', 'Async all way', 'ConfigureAwait']), 1, 'Blocking waits on blocked thread.'),
    (current_term_id, 'ConfigureAwait(false) when?', to_jsonb(ARRAY['Never', 'Library code', 'Always', 'UI only']), 1, 'Libraries avoid sync context.'),
    (current_term_id, 'Async improves?', to_jsonb(ARRAY['CPU performance', 'Thread scalability', 'Memory', 'Security']), 1, 'Frees threads during I/O.');

  -- 10. LINQ
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'LINQ',
    'Ask questions about lists using simple commands instead of complicated loops.',
    'Language Integrated Query: C# feature providing SQL-like query syntax over collections with method chaining.',
    'LINQ unifies querying with declarative syntax. Lazy evaluation via deferred execution. Watch for multiple enumeration.',
    to_jsonb(ARRAY['Multiple enumeration causing redundant work', 'Lazy evaluation surprises', 'N+1 queries from nested queries', 'Forgetting .ToList() when mutation needed']),
    jsonb_build_object(
      'csharp', E'var nums = new[] {1, 2, 3, 4, 5, 6};\n\n// Method syntax\nvar evens = nums.Where(n => n % 2 == 0).Select(n => n * 2);\n\n// Deferred: evaluated on enumeration\nforeach(var e in evens) Console.WriteLine(e);',
      'typescript', E'const nums = [1, 2, 3, 4, 5, 6];\n\n// Eager evaluation\nconst evens = nums\n  .filter(n => n % 2 === 0)\n  .map(n => n * 2);\n\nconsole.log(evens);'
    ),
    E'LINQ Pipeline:\nSource→Where→Select→ToList\n[1,2,3]→[2]→[4]→List\nDeferred execution', 
    10
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'LINQ execution?', to_jsonb(ARRAY['Immediate', 'Deferred/lazy', 'Parallel', 'Random']), 1, 'Executes on enumeration.'),
    (current_term_id, 'Multiple enumeration risk?', to_jsonb(ARRAY['Syntax error', 'Redundant execution', 'Memory leak', 'Deadlock']), 1, 'Re-executes pipeline.'),
    (current_term_id, 'Force immediate execution?', to_jsonb(ARRAY['Await', 'Call .ToList()', 'Use var', 'Add Select']), 1, 'ToList triggers execution.'),
    (current_term_id, 'Best for chaining?', to_jsonb(ARRAY['Query syntax', 'Method syntax', 'SQL', 'Loops']), 1, 'Method syntax chains.'),
    (current_term_id, 'N+1 problem?', to_jsonb(ARRAY['Too many selects', 'Nested queries causing loops', 'Parallel', 'Sorting']), 1, 'Query per item: 1+N.');

  -- ========== TYPESCRIPT/ANGULAR (2) ==========
  
  -- 11. RxJS Observables
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'RxJS Observables',
    'A stream of future values that you can filter and transform.',
    'Lazy push-based stream of async values. Observers subscribe to receive next/error/complete notifications.',
    'Observables provide declarative async programming. Lazy: execute when subscribed. Always unsubscribe or use takeUntil to prevent leaks.',
    to_jsonb(ARRAY['Memory leaks from unsubscribed observables', 'Cold vs hot confusion', 'Nested subscribes', 'Not handling errors']),
    jsonb_build_object(
      'csharp', E'// Rx.NET equivalent\nvar obs = Observable.Interval(TimeSpan.FromSeconds(1));\nvar sub = obs\n  .Where(x => x % 2 == 0)\n  .Subscribe(x => Console.WriteLine(x));\nsub.Dispose();',
      'typescript', E'import { interval } from ''rxjs'';\nimport { filter, takeUntil } from ''rxjs/operators'';\n\nconst stream$ = interval(1000).pipe(\n  filter(x => x % 2 === 0),\n  takeUntil(destroy$)\n);\n\nstream$.subscribe(x => console.log(x));'
    ),
    E'Observable:\nSource→Operators→Observer\n  ↓    map filter  subscribe\n[1,2,3] [2,4,6] [2,6]→log', 
    11
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Observables are?', to_jsonb(ARRAY['Eager', 'Lazy push', 'Pull', 'Sync']), 1, 'Lazy: execute on subscribe.'),
    (current_term_id, 'Memory leak prevention?', to_jsonb(ARRAY['Use async', 'Unsubscribe or takeUntil', 'Use Promise', 'Avoid operators']), 1, 'Unsubscribe stops execution.'),
    (current_term_id, 'Cold vs Hot?', to_jsonb(ARRAY['Temperature', 'Cold: new per subscriber, Hot: shared', 'Error', 'Performance']), 1, 'Cold creates new execution.'),
    (current_term_id, 'Subscribe hell?', to_jsonb(ARRAY['Too many', 'Nested subscribe calls', 'Async issues', 'Leaks']), 1, 'Nested creates callback hell.'),
    (current_term_id, 'Async pipe benefit?', to_jsonb(ARRAY['Faster', 'Auto unsubscribe', 'Better syntax', 'Type safe']), 1, 'Auto unsubscribes on destroy.');

  -- 12. Dependency Injection
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'Dependency Injection',
    'Instead of creating your own tools, ask for them to be handed to you.',
    'Design pattern where dependencies are provided to a class rather than created internally. Enables loose coupling and testability.',
    'DI inverts control of dependency creation. Container resolves and injects dependencies. Enables mocking for tests. Angular uses constructor injection.',
    to_jsonb(ARRAY['Circular dependencies', 'Over-injecting causing bloat', 'Lifetime mismanagement', 'Service locator anti-pattern']),
    jsonb_build_object(
      'csharp', E'// ASP.NET Core DI\npublic interface ILogger { void Log(string msg); }\n\npublic class UserService {\n  private ILogger _logger;\n  public UserService(ILogger logger) {\n    _logger = logger;\n  }\n}\n\n// Startup.cs\nservices.AddScoped<ILogger, ConsoleLogger>();',
      'typescript', E'// Angular DI\n@Injectable({ providedIn: ''root'' })\nexport class UserService {\n  constructor(private http: HttpClient) {}\n  \n  getUsers() {\n    return this.http.get(''/api/users'');\n  }\n}'
    ),
    E'Dependency Injection:\nClient→Constructor→Container\n  ↓        ↓         ↓\nNeeds  Requests  Provides\n         ↓\n      Interface', 
    12
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'DI primary benefit?', to_jsonb(ARRAY['Performance', 'Loose coupling and testability', 'Less code', 'Security']), 1, 'Enables mocking and decoupling.'),
    (current_term_id, 'Constructor injection means?', to_jsonb(ARRAY['Create in constructor', 'Dependencies via constructor params', 'No constructor', 'Static']), 1, 'Pass dependencies to constructor.'),
    (current_term_id, 'Circular dependency?', to_jsonb(ARRAY['No issue', 'A needs B, B needs A', 'Performance', 'Memory leak']), 1, 'Mutual dependency cycle.'),
    (current_term_id, 'Service locator is?', to_jsonb(ARRAY['Good pattern', 'Anti-pattern hiding dependencies', 'DI variant', 'Angular feature']), 1, 'Hides dependencies, anti-pattern.'),
    (current_term_id, 'DI enables?', to_jsonb(ARRAY['Performance', 'Mocking for unit tests', 'Deployment', 'UI']), 1, 'Mock dependencies in tests.');

  -- ========== SQL (2) ==========
  
  -- 13. SQL JOINs
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_sql, 'SQL JOINs',
    'Ways to combine data from two tables, like matching students with grades.',
    'SQL clauses combining rows from tables based on related columns. INNER (matching only), LEFT/RIGHT (include nulls), FULL (all rows).',
    'INNER JOIN returns matching rows. LEFT JOIN includes all left table rows with nulls for non-matches. Use JOINs to normalize data.',
    to_jsonb(ARRAY['Cartesian explosion from missing ON', 'NULL confusion in LEFT JOIN', 'Performance without indexes', 'Wrong JOIN type']),
    jsonb_build_object(
      'csharp', E'// EF Core Join\nvar query = from u in context.Users\n            join o in context.Orders on u.Id equals o.UserId\n            select new { u.Name, o.Total };',
      'typescript', E'-- INNER JOIN\nSELECT u.name, o.total\nFROM users u\nINNER JOIN orders o ON u.id = o.user_id;\n\n-- LEFT JOIN\nSELECT u.name, o.total\nFROM users u\nLEFT JOIN orders o ON u.id = o.user_id;'
    ),
    E'JOINs:\nINNER: A∩B\nLEFT: A+(A∩B)\nRIGHT: B+(A∩B)\nFULL: A∪B', 
    13
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'INNER JOIN returns?', to_jsonb(ARRAY['All rows', 'Only matching rows', 'Left only', 'Nulls']), 1, 'Only matches in both tables.'),
    (current_term_id, 'LEFT JOIN includes?', to_jsonb(ARRAY['Right all', 'Left all with nulls', 'Matching only', 'Nothing']), 1, 'All left rows, nulls for non-matches.'),
    (current_term_id, 'Missing ON causes?', to_jsonb(ARRAY['Error', 'INNER JOIN', 'Cartesian product', 'NULL']), 2, 'Every left × every right.'),
    (current_term_id, 'JOIN performance optimization?', to_jsonb(ARRAY['FULL JOIN', 'Index join columns', 'Avoid WHERE', 'Subqueries']), 1, 'Indexes prevent full scans.'),
    (current_term_id, 'When use LEFT JOIN?', to_jsonb(ARRAY['Always', 'Need all left rows', 'Better performance', 'INNER fails']), 1, 'Preserves all left rows.');

  -- 14. Indexing
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_sql, 'Database Indexing',
    'Like a book index - quickly find pages without reading entire book.',
    'Data structure improving query speed at cost of write performance and storage. B-tree indexes enable O(log n) lookups.',
    'Indexes speed reads via efficient lookups but slow writes. Index foreign keys, WHERE/JOIN columns. Watch for index bloat and over-indexing.',
    to_jsonb(ARRAY['Over-indexing slowing writes', 'Not indexing foreign keys', 'Index on low-cardinality columns', 'Ignoring composite index order']),
    jsonb_build_object(
      'csharp', E'// EF Core Index\nmodelBuilder.Entity<User>()\n  .HasIndex(u => u.Email)\n  .IsUnique();\n\nmodelBuilder.Entity<Order>()\n  .HasIndex(o => o.UserId);',
      'typescript', E'-- Create Index\nCREATE INDEX idx_users_email ON users(email);\nCREATE INDEX idx_orders_user_id ON orders(user_id);\n\n-- Composite Index\nCREATE INDEX idx_orders_user_date \n  ON orders(user_id, order_date);'
    ),
    E'Index (B-tree):\n     [M]\n    /   \\\n  [D]   [T]\n /  \\   /  \\\nA-C E-L N-S U-Z\nO(log n) lookup', 
    14
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Index primary benefit?', to_jsonb(ARRAY['Saves space', 'Speeds up queries', 'Prevents duplicates', 'Security']), 1, 'Faster lookups via efficient structure.'),
    (current_term_id, 'Index downside?', to_jsonb(ARRAY['Read speed', 'Slows writes and uses space', 'Breaks queries', 'Security risk']), 1, 'Must maintain on insert/update.'),
    (current_term_id, 'When to index?', to_jsonb(ARRAY['Every column', 'Foreign keys and WHERE/JOIN columns', 'Primary keys only', 'Never']), 1, 'Frequently queried columns.'),
    (current_term_id, 'Low-cardinality columns?', to_jsonb(ARRAY['Always index', 'Avoid indexing', 'Best for index', 'No impact']), 1, 'Few distinct values: poor selectivity.'),
    (current_term_id, 'Composite index order matters?', to_jsonb(ARRAY['No', 'Yes, most selective first', 'Random', 'Alphabetical']), 1, 'Order affects query matching.');

  -- ========== ARCHITECTURE (2) ==========
  
  -- 15. MVC Pattern
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch, 'MVC Pattern',
    'Split app into data (Model), display (View), and logic (Controller).',
    'Model-View-Controller: architectural pattern separating data, presentation, and logic.',
    'MVC separates concerns: Model holds business logic, View renders UI, Controller handles input. Promotes testability.',
    to_jsonb(ARRAY['Fat controllers with business logic', 'Tight coupling', 'Anemic models', 'Not understanding MVC is pattern not architecture']),
    jsonb_build_object(
      'csharp', E'// ASP.NET Core MVC\npublic class ProductController : Controller {\n  private readonly IProductService _service;\n  \n  public IActionResult Index() {\n    var products = _service.GetAll();\n    return View(products);\n  }\n}',
      'typescript', E'// Angular Component\n@Component({\n  selector: ''app-product'',\n  templateUrl: ''product.html''\n})\nexport class ProductComponent {\n  products: Product[];\n  \n  constructor(private service: ProductService) {}\n}'
    ),
    E'MVC:\nUser→Controller→Model\n ↑       ↓        ↓\nView←updates←data', 
    15
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Model responsibility?', to_jsonb(ARRAY['Display UI', 'Business logic and data', 'Route', 'Input']), 1, 'Contains business rules.'),
    (current_term_id, 'Controller role?', to_jsonb(ARRAY['Store data', 'Render UI', 'Handle input and mediate', 'Database']), 2, 'Processes input, updates Model.'),
    (current_term_id, 'View should?', to_jsonb(ARRAY['Business logic', 'Database', 'Only render UI', 'Process input']), 2, 'Purely presentational.'),
    (current_term_id, 'Fat controller problem?', to_jsonb(ARRAY['Too fast', 'Business logic in Controller', 'Too small', 'No issue']), 1, 'Logic belongs in Model/Service.'),
    (current_term_id, 'MVC benefit?', to_jsonb(ARRAY['Faster', 'Separation of concerns', 'Less code', 'No bugs']), 1, 'Enables testability.');

  -- 16. Microservices
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch, 'Microservices',
    'Break big app into small independent services that talk via APIs.',
    'Architectural style structuring application as collection of loosely coupled services. Each service independently deployable.',
    'Microservices enable independent scaling, deployment, and technology choices. Use API gateways, service discovery. Watch for distributed system complexity.',
    to_jsonb(ARRAY['Distributed monolith from tight coupling', 'Network latency and failures', 'Data consistency challenges', 'Debugging complexity', 'Over-engineering for small apps']),
    jsonb_build_object(
      'csharp', E'// ASP.NET Core Microservice\n[ApiController]\n[Route("api/[controller]")]\npublic class UsersController : ControllerBase {\n  [HttpGet]\n  public async Task<IActionResult> Get() {\n    var users = await _service.GetAllAsync();\n    return Ok(users);\n  }\n}',
      'typescript', E'// Node.js Microservice\nconst express = require(''express'');\nconst app = express();\n\napp.get(''/api/users'', async (req, res) => {\n  const users = await service.getAll();\n  res.json(users);\n});\n\napp.listen(3000);'
    ),
    E'Microservices:\n[Client]\n   ↓\n[API Gateway]\n   ↓ ↓ ↓\n[UserSvc][OrderSvc][PaySvc]\nIndependent deployment', 
    16
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Microservices benefit?', to_jsonb(ARRAY['Simpler', 'Independent scaling and deployment', 'Less code', 'Faster always']), 1, 'Scale services independently.'),
    (current_term_id, 'Distributed monolith means?', to_jsonb(ARRAY['Good design', 'Tight coupling despite separation', 'Monolith', 'Performance']), 1, 'Microservices tightly coupled: worst of both.'),
    (current_term_id, 'API Gateway role?', to_jsonb(ARRAY['Database', 'Single entry point routing requests', 'Service itself', 'UI']), 1, 'Routes and aggregates requests.'),
    (current_term_id, 'Microservices challenge?', to_jsonb(ARRAY['Simpler code', 'Distributed system complexity', 'Less testing', 'No deployment']), 1, 'Network, consistency, debugging harder.'),
    (current_term_id, 'When NOT use microservices?', to_jsonb(ARRAY['Always use', 'Small simple apps', 'Large apps', 'Never use']), 1, 'Overkill for small apps.');

  -- ========== DEVOPS (2) ==========
  
  -- 17. CI/CD Pipeline
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_devops, 'CI/CD Pipeline',
    'Automatic assembly line that tests and ships your code.',
    'Continuous Integration/Deployment: automated workflow building, testing, deploying code on every commit.',
    'CI/CD automates build, test, deploy for rapid feedback. CI catches integration issues early. CD deploys automatically.',
    to_jsonb(ARRAY['Flaky tests breaking pipeline', 'Long build times', 'Insufficient coverage', 'No rollback strategy', 'Secrets in logs']),
    jsonb_build_object(
      'csharp', E'# Azure Pipelines\ntrigger:\n  - main\nsteps:\n  - task: DotNetCoreCLI@2\n    inputs:\n      command: ''build''\n  - task: DotNetCoreCLI@2\n    inputs:\n      command: ''test''',
      'typescript', E'# GitHub Actions\nname: CI\non: [push]\njobs:\n  build:\n    runs-on: ubuntu-latest\n    steps:\n      - uses: actions/checkout@v2\n      - run: npm install\n      - run: npm test\n      - run: npm run build'
    ),
    E'CI/CD:\nCommit→Build→Test→Deploy\n  ↓      ↓     ↓      ↓\nGit Compile Unit Production\nAutomated gates', 
    17
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'CI primary benefit?', to_jsonb(ARRAY['Faster dev', 'Early integration issue detection', 'No bugs', 'Less code']), 1, 'Frequent integration catches conflicts.'),
    (current_term_id, 'CD means?', to_jsonb(ARRAY['Design', 'Continuous Deployment', 'Documentation', 'Daily']), 1, 'Automate deployment.'),
    (current_term_id, 'Flaky tests impact?', to_jsonb(ARRAY['Better coverage', 'Slower', 'False failures blocking', 'No impact']), 2, 'Intermittent failures reduce trust.'),
    (current_term_id, 'Rollback strategy needed for?', to_jsonb(ARRAY['Development', 'Production deployment failures', 'Testing', 'Building']), 1, 'Quick rollback when deploy fails.'),
    (current_term_id, 'Pipeline should run?', to_jsonb(ARRAY['Daily', 'On every commit', 'Weekly', 'Before release']), 1, 'Frequent runs provide rapid feedback.');

  -- 18. Docker Containers
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_devops, 'Docker Containers',
    'Package your app with everything it needs into a portable box.',
    'Lightweight virtualization packaging application with dependencies. Containers share host OS kernel, isolated via namespaces.',
    'Docker enables consistent environments from dev to production. Containers are portable, start quickly, use less resources than VMs. Use multi-stage builds.',
    to_jsonb(ARRAY['Large image sizes', 'Running as root', 'Not using .dockerignore', 'Hardcoded secrets', 'Single-purpose violation']),
    jsonb_build_object(
      'csharp', E'# Dockerfile\nFROM mcr.microsoft.com/dotnet/sdk:8.0 AS build\nWORKDIR /app\nCOPY *.csproj .\nRUN dotnet restore\nCOPY . .\nRUN dotnet publish -c Release -o out\n\nFROM mcr.microsoft.com/dotnet/aspnet:8.0\nWORKDIR /app\nCOPY --from=build /app/out .\nENTRYPOINT ["dotnet", "MyApp.dll"]',
      'typescript', E'# Dockerfile\nFROM node:18-alpine AS build\nWORKDIR /app\nCOPY package*.json .\nRUN npm ci\nCOPY . .\nRUN npm run build\n\nFROM node:18-alpine\nWORKDIR /app\nCOPY --from=build /app/dist .\nCMD ["node", "index.js"]'
    ),
    E'Docker:\nApp+Deps→Image→Container\n    ↓       ↓       ↓\n  Build   Store   Run\nPortable, isolated', 
    18
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Container vs VM?', to_jsonb(ARRAY['Same thing', 'Container shares OS kernel, lighter', 'VM faster', 'VM portable']), 1, 'Containers share kernel: lighter.'),
    (current_term_id, 'Dockerfile purpose?', to_jsonb(ARRAY['Run container', 'Define image build steps', 'Orchestration', 'Monitoring']), 1, 'Instructions to build image.'),
    (current_term_id, 'Multi-stage build benefit?', to_jsonb(ARRAY['Faster runtime', 'Smaller final image', 'Security', 'Debugging']), 1, 'Excludes build tools from final image.'),
    (current_term_id, 'Why avoid running as root?', to_jsonb(ARRAY['Performance', 'Security: limit damage if compromised', 'Portability', 'Size']), 1, 'Principle of least privilege.'),
    (current_term_id, 'Docker benefit?', to_jsonb(ARRAY['Faster code', 'Consistent environments', 'Less code', 'No bugs']), 1, 'Same environment dev to prod.');

  -- ========== AI/ML (2) ==========
  
  -- 19. Supervised Learning
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_ai, 'Supervised Learning',
    'Teaching a computer by showing lots of examples with answers.',
    'ML where model learns from labeled training data (input-output pairs) to predict outputs for new inputs.',
    'Supervised learning trains on labeled data to learn input-output mapping. Classification assigns categories, regression predicts values. Split train/test.',
    to_jsonb(ARRAY['Overfitting to training data', 'Insufficient training data', 'Data leakage from test set', 'Imbalanced classes']),
    jsonb_build_object(
      'csharp', E'// ML.NET\nvar mlContext = new MLContext();\nvar data = mlContext.Data.LoadFromTextFile<Input>("data.csv");\nvar pipeline = mlContext.Transforms.Concatenate("Features", "F1", "F2")\n  .Append(mlContext.Regression.Trainers.Sdca());\nvar model = pipeline.Fit(data);',
      'typescript', E'// TensorFlow.js\nconst model = tf.sequential();\nmodel.add(tf.layers.dense({units: 10, inputShape: [5]}));\nmodel.add(tf.layers.dense({units: 1}));\nmodel.compile({optimizer: ''adam'', loss: ''mse''});\nawait model.fit(xs, ys, {epochs: 100});'
    ),
    E'Supervised Learning:\nLabeled Data→Train→Predict\n(X, y) pairs  f(X)=y  X→ŷ\nClassification | Regression', 
    19
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Supervised learning requires?', to_jsonb(ARRAY['Unlabeled data', 'Labeled training data', 'No data', 'Rewards']), 1, 'Needs input-output pairs.'),
    (current_term_id, 'Classification vs Regression?', to_jsonb(ARRAY['Same', 'Classification: discrete, Regression: continuous', 'Speed', 'Accuracy']), 1, 'Categories vs numbers.'),
    (current_term_id, 'Overfitting means?', to_jsonb(ARRAY['Underfitting', 'Memorizes training data, poor on new', 'Fast', 'High accuracy']), 1, 'Learns noise, not pattern.'),
    (current_term_id, 'Train/test split purpose?', to_jsonb(ARRAY['Faster training', 'Evaluate generalization', 'More data', 'Balance classes']), 1, 'Measure performance on new data.'),
    (current_term_id, 'Imbalanced classes problem?', to_jsonb(ARRAY['Slow', 'Model biased to majority', 'Overfitting', 'No problem']), 1, 'Rare class ignored.');

  -- 20. Confusion Matrix
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_ai, 'Confusion Matrix',
    'A table showing how often your predictions are right or wrong in different ways.',
    'Classification evaluation table showing True Positives, True Negatives, False Positives, False Negatives.',
    'Confusion matrix shows model prediction breakdown. Derive accuracy, precision, recall, F1. Reveals class-specific performance issues.',
    to_jsonb(ARRAY['Accuracy paradox with imbalanced data', 'Ignoring false positives vs false negatives tradeoff', 'Not considering domain cost', 'Using wrong metric']),
    jsonb_build_object(
      'csharp', E'// Calculate metrics\nint tp = 90, fp = 10, fn = 5, tn = 95;\ndouble accuracy = (tp + tn) / (double)(tp + tn + fp + fn);\ndouble precision = tp / (double)(tp + fp);\ndouble recall = tp / (double)(tp + fn);\ndouble f1 = 2 * (precision * recall) / (precision + recall);',
      'typescript', E'// Calculate metrics\nconst tp = 90, fp = 10, fn = 5, tn = 95;\nconst accuracy = (tp + tn) / (tp + tn + fp + fn);\nconst precision = tp / (tp + fp);\nconst recall = tp / (tp + fn);\nconst f1 = 2 * (precision * recall) / (precision + recall);'
    ),
    E'Confusion Matrix:\n           Predicted\n         P      N\nActual P TP(90) FN(5)\n       N FP(10) TN(95)\nAccuracy=(TP+TN)/Total', 
    20
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'True Positive means?', to_jsonb(ARRAY['Predicted N, actually N', 'Predicted P, actually P', 'Predicted P, actually N', 'Predicted N, actually P']), 1, 'Correctly predicted positive.'),
    (current_term_id, 'Precision formula?', to_jsonb(ARRAY['TP/(TP+FN)', 'TP/(TP+FP)', '(TP+TN)/Total', 'TN/(TN+FP)']), 1, 'TP / (TP + FP): positive prediction accuracy.'),
    (current_term_id, 'Recall formula?', to_jsonb(ARRAY['TP/(TP+FP)', 'TP/(TP+FN)', '(TP+TN)/Total', 'TN/(TN+FN)']), 1, 'TP / (TP + FN): actual positive coverage.'),
    (current_term_id, 'High precision means?', to_jsonb(ARRAY['Find all positives', 'Few false positives', 'High accuracy', 'Fast']), 1, 'When predict positive, usually correct.'),
    (current_term_id, 'F1 score balances?', to_jsonb(ARRAY['Speed accuracy', 'Precision and recall', 'TP and TN', 'Training testing']), 1, 'Harmonic mean of precision and recall.');

  RAISE NOTICE 'Successfully seeded 20 comprehensive terms';
END $$;

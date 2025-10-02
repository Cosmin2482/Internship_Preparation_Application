-- Quick seed execution
DO $$
DECLARE
  cat_cs uuid;
  cat_oop uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';

  -- Array (update existing)
  DELETE FROM quiz_questions WHERE term_id IN (SELECT id FROM terms WHERE term = 'Array');
  DELETE FROM terms WHERE term = 'Array';
  
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Array',
    'Row of numbered boxes, instant access by index.',
    'Contiguous memory with O(1) random access; insert/delete mid O(n).',
    'Arrays provide O(1) access and better cache locality, but costly mid-insertions. Choose arrays for random access patterns and known size.',
    to_jsonb(ARRAY['Out-of-bounds access', 'Costly mid inserts', 'Fixed size in many languages']),
    jsonb_build_object('csharp', 'int[] nums = {1,2,3};
var x = nums[1]; // O(1)', 'typescript', 'const nums: number[] = [1,2,3];
const x = nums[1]; // O(1)'),
    '[0][1][2][3]
Access: O(1)', 1
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Array access time complexity?', to_jsonb(ARRAY['O(1)', 'O(n)', 'O(log n)', 'O(n²)']), 0, 'Direct memory calculation.'),
    (current_term_id, 'Arrays are zero-indexed?', to_jsonb(ARRAY['Yes', 'No', 'Sometimes', 'Depends']), 0, 'C# and TypeScript use 0-indexing.'),
    (current_term_id, 'Why cache-friendly?', to_jsonb(ARRAY['Less RAM', 'Contiguous memory', 'Compress data', 'Immutable']), 1, 'Sequential memory layout.'),
    (current_term_id, 'When to avoid?', to_jsonb(ARRAY['Random access', 'Frequent insertions', 'Known size', 'Iteration']), 1, 'Insertions are O(n).'),
    (current_term_id, 'Out-of-bounds in C#?', to_jsonb(ARRAY['Null', 'Default', 'Exception', 'Auto-expand']), 2, 'Throws IndexOutOfRangeException.');

  -- Stack
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Stack',
    'Last in, first out (LIFO).',
    'Push/pop/peek O(1) operations following LIFO.',
    'Fundamental for recursion, undo operations, DFS traversal. LIFO makes recent items immediately accessible.',
    to_jsonb(ARRAY['Stack overflow from recursion', 'Forgetting isEmpty check', 'Using when FIFO needed']),
    jsonb_build_object('csharp', 'var st = new Stack<int>();
st.Push(1); st.Push(2);
var top = st.Pop(); // 2', 'typescript', 'const st: number[] = [];
st.push(1); st.push(2);
const top = st.pop(); // 2'),
    'TOP ↓
[3][2][1]
LIFO', 4
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Stack principle?', to_jsonb(ARRAY['FIFO', 'LIFO', 'Priority', 'Random']), 1, 'Last-In-First-Out.'),
    (current_term_id, 'NOT O(1)?', to_jsonb(ARRAY['Push', 'Pop', 'Peek', 'Search']), 3, 'Search is O(n).'),
    (current_term_id, 'Stack for:', to_jsonb(ARRAY['BFS', 'DFS', 'Priority', 'Sample']), 1, 'DFS uses stack.'),
    (current_term_id, 'Stack overflow?', to_jsonb(ARRAY['Buffer', 'Recursion', 'Heap', 'Network']), 1, 'Deep recursion.'),
    (current_term_id, 'Use case:', to_jsonb(ARRAY['Queue', 'Undo/Redo', 'Scheduler', 'Cache']), 1, 'Undo/Redo stacks.');

  -- Queue  
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Queue',
    'First in, first out (FIFO).',
    'Enqueue/dequeue O(1) operations following FIFO.',
    'Essential for BFS, task scheduling, buffering. FIFO ensures fairness.',
    to_jsonb(ARRAY['Capacity growth', 'Head/tail bugs', 'Using when LIFO needed']),
    jsonb_build_object('csharp', 'var q = new Queue<int>();
q.Enqueue(1); q.Enqueue(2);
var first = q.Dequeue(); // 1', 'typescript', 'const q: number[] = [];
q.push(1); q.push(2);
const first = q.shift(); // 1'),
    'FRONT→[1][2][3]←BACK
FIFO', 5
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Queue principle?', to_jsonb(ARRAY['LIFO', 'FIFO', 'LILO', 'Priority']), 1, 'First-In-First-Out.'),
    (current_term_id, 'Queue for:', to_jsonb(ARRAY['DFS', 'BFS', 'Binary search', 'Sort']), 1, 'BFS uses queue.'),
    (current_term_id, 'NOT O(1)?', to_jsonb(ARRAY['Enqueue', 'Dequeue', 'Peek', 'Access middle']), 3, 'Middle access is O(n).'),
    (current_term_id, 'Circular buffer:', to_jsonb(ARRAY['Saves memory', 'Infinite', 'Thread-safe', 'Search']), 0, 'Reuses space.'),
    (current_term_id, 'Task scheduler:', to_jsonb(ARRAY['Priority', 'FIFO fairness', 'Random', 'Undo']), 1, 'FIFO order.');

  -- Set
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Set',
    'Unique items only.',
    'Collection enforcing uniqueness; O(1) avg hash-backed operations.',
    'Efficient membership testing, duplicate removal. HashSet for O(1) avg.',
    to_jsonb(ARRAY['Hash collisions', 'Mutable keys', 'No order in HashSet']),
    jsonb_build_object('csharp', 'var s = new HashSet<int>{1,2,2,3};
// {1,2,3}
bool has = s.Contains(2);', 'typescript', 'const s = new Set([1,2,2,3]);
// {1,2,3}
const has = s.has(2);'),
    'HashSet {1,2,3,4}
O(1) avg ops', 7
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Set guarantees?', to_jsonb(ARRAY['Order', 'Uniqueness', 'Index access', 'Immutability']), 1, 'Unique elements.'),
    (current_term_id, 'HashSet complexity?', to_jsonb(ARRAY['O(1) worst', 'O(1) average', 'O(log n)', 'O(n)']), 1, 'Average O(1).'),
    (current_term_id, 'Collisions matter when?', to_jsonb(ARRAY['Never', 'Always', 'Poor hash', 'Strings only']), 2, 'Bad hashing.'),
    (current_term_id, 'Mutable keys problem?', to_jsonb(ARRAY['Performance', 'Hash changes', 'Thread safety', 'Memory']), 1, 'Hash becomes invalid.'),
    (current_term_id, 'Remove duplicates?', to_jsonb(ARRAY['Sort scan', 'Use Set', 'Nested loops', 'Binary search']), 1, 'Set enforces uniqueness.');

  -- Linked List Doubly
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Linked List (Doubly)',
    'Nodes with next and previous pointers.',
    'Bidirectional traversal; more memory per node.',
    'O(1) deletion with node reference. Use for deques and LRU caches.',
    to_jsonb(ARRAY['More memory', 'Pointer bugs', 'Not cache-friendly']),
    jsonb_build_object('csharp', 'class DNode<T> {
  public T Val;
  public DNode<T>? Next, Prev;
}', 'typescript', 'class DNode<T> {
  val: T;
  next: DNode<T>|null;
  prev: DNode<T>|null;
}'),
    'null←[P|D|N]↔[P|D|N]→null
Bidirectional O(1) delete', 3
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Advantage?', to_jsonb(ARRAY['Less memory', 'Bidirectional', 'O(1) search', 'Cache']), 1, 'Prev pointers.'),
    (current_term_id, 'Delete with ref?', to_jsonb(ARRAY['O(1)', 'O(n)', 'O(log n)', 'Impossible']), 0, 'Update pointers.'),
    (current_term_id, 'Memory vs singly?', to_jsonb(ARRAY['Same', 'Double', 'Slightly more', 'Half']), 2, 'One extra pointer.'),
    (current_term_id, 'LRU cache uses why?', to_jsonb(ARRAY['Sorted', 'O(1) reorder', 'Less memory', 'Thread-safe']), 1, 'Quick moves.'),
    (current_term_id, 'Deque benefit?', to_jsonb(ARRAY['Sorted', 'O(1) both ends', 'O(1) search', 'Compact']), 1, 'Both-end ops.');

  -- BST
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Binary Search Tree',
    'Left < node < right.',
    'Binary tree where left < node < right; ops O(h).',
    'O(log n) when balanced, O(n) when skewed. Inorder gives sorted order.',
    to_jsonb(ARRAY['Unbalanced → O(n)', 'Duplicate strategy', 'Complex deletion']),
    jsonb_build_object('csharp', 'bool Search(Node n, int x) {
  if(n==null) return false;
  if(x==n.Val) return true;
  return x<n.Val ? Search(n.L,x) : Search(n.R,x);
}', 'typescript', 'function search(n:Node|null, x:number) {
  if(!n) return false;
  if(x===n.val) return true;
  return x<n.val ? search(n.left,x) : search(n.right,x);
}'),
    '  5
 / \
3   7
Left<Node<Right', 10
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'BST property?', to_jsonb(ARRAY['Max heap', 'Left<Node<Right', 'Complete', 'Level sorted']), 1, 'Recursive property.'),
    (current_term_id, 'Inorder gives?', to_jsonb(ARRAY['Random', 'Sorted ascending', 'Level order', 'Descending']), 1, 'Left-Root-Right.'),
    (current_term_id, 'Worst height?', to_jsonb(ARRAY['O(log n)', 'O(n)', 'O(1)', 'O(n log n)']), 1, 'Skewed tree.'),
    (current_term_id, 'Balanced BST?', to_jsonb(ARRAY['O(1) ops', 'O(log n) height', 'O(n) space', 'Immutable']), 1, 'AVL, Red-Black.'),
    (current_term_id, 'Delete two children?', to_jsonb(ARRAY['Remove', 'Replace successor', 'Rotate', 'Impossible']), 1, 'Use successor.');

  -- Heap
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Heap / Priority Queue',
    'Get highest priority fast.',
    'Binary heap; insert/extract O(log n); peek O(1).',
    'Efficient for scheduling, Dijkstra, K largest problems.',
    to_jsonb(ARRAY['0 vs 1-based index', 'Build is O(n)', 'Not sorted']),
    jsonb_build_object('csharp', 'var pq = new PriorityQueue<string,int>();
pq.Enqueue("task1", 5);
pq.Enqueue("task2", 1);
var top = pq.Dequeue(); // task2', 'typescript', '// No built-in PQ in TS
class MinHeap {
  insert(val: number) { }
  extractMin() { }
}'),
    '  1
 / \
3   2
Root=min', 11
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Min-heap property?', to_jsonb(ARRAY['Parent>child', 'Parent<child', 'Left<Right', 'Sorted']), 1, 'Parent ≤ children.'),
    (current_term_id, 'Extract complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n log n)']), 1, 'Bubble down.'),
    (current_term_id, 'Build heap?', to_jsonb(ARRAY['O(log n)', 'O(n)', 'O(n log n)', 'O(n²)']), 1, 'Bottom-up O(n).'),
    (current_term_id, 'Heap is NOT?', to_jsonb(ARRAY['Complete', 'Fully sorted', 'Efficient', 'Array-based']), 1, 'Only root is min/max.'),
    (current_term_id, 'Use for?', to_jsonb(ARRAY['Sorted iteration', 'K largest', 'Binary search', 'Hash']), 1, 'K largest via min-heap.');

  -- Graph
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Graph Basics',
    'Nodes and edges.',
    'Vertices/edges; adjacency list vs matrix.',
    'List for sparse O(V+E); matrix for O(V²) but O(1) edge query.',
    to_jsonb(ARRAY['Forgetting visited', 'Matrix wastes space', 'Directed handling']),
    jsonb_build_object('csharp', 'var adj = new Dictionary<int, List<int>>();
adj[1] = new List<int>{2, 3};
adj[2] = new List<int>{4};', 'typescript', 'const graph: Record<string, string[]> = {
  "A": ["B", "C"],
  "B": ["D"]
};'),
    'A→B
↓  ↓
C→D
List: O(V+E)', 12
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'List vs matrix sparse?', to_jsonb(ARRAY['Matrix', 'List better', 'Same', 'Depends']), 1, 'List saves space.'),
    (current_term_id, 'Track visited why?', to_jsonb(ARRAY['Optimization', 'Avoid cycles', 'Memory', 'Thread']), 1, 'Prevent loops.'),
    (current_term_id, 'Directed vs undirected?', to_jsonb(ARRAY['Same', 'Direction matters', 'Faster', 'More space']), 1, 'One-way edges.'),
    (current_term_id, 'Matrix advantage?', to_jsonb(ARRAY['O(1) edge check', 'Less space', 'Fast traverse', 'Dynamic']), 0, 'O(1) lookup.'),
    (current_term_id, 'Weighted graph?', to_jsonb(ARRAY['Boolean', 'Edge weights', 'Set', 'Stack']), 1, 'Store weights.');

  -- OOP Pillars
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'OOP Pillars',
    'Hide details, contracts, reuse, vary behavior.',
    'Encapsulation, Abstraction, Inheritance, Polymorphism.',
    'Encapsulation: private fields. Abstraction: interfaces. Inheritance: derive classes. Polymorphism: override methods.',
    to_jsonb(ARRAY['Leaky encapsulation', 'Deep inheritance', 'Misusing inheritance']),
    jsonb_build_object('csharp', '// Encapsulation
class Account {
  private decimal _balance;
}
// Polymorphism
abstract class Shape { public abstract double Area(); }
class Circle : Shape { }', 'typescript', 'class Account {
  #balance: number = 0;
  get balance() { return this.#balance; }
}'),
    'OOP: Encapsulation
Abstraction
Inheritance
Polymorphism', 1
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Encapsulation achieves?', to_jsonb(ARRAY['Reuse', 'Hiding details', 'Inheritance', 'Performance']), 1, 'Hide internals.'),
    (current_term_id, 'Abstraction focuses?', to_jsonb(ARRAY['Implementation', 'Essential features', 'Memory', 'Threading']), 1, 'What not how.'),
    (current_term_id, 'Inheritance enables?', to_jsonb(ARRAY['Hiding', 'Code reuse', 'Encryption', 'Parallel']), 1, 'Reuse via is-a.'),
    (current_term_id, 'Polymorphism allows?', to_jsonb(ARRAY['Variables', 'Different implementations', 'Speed', 'Memory']), 1, 'Override methods.'),
    (current_term_id, 'Leaky encapsulation?', to_jsonb(ARRAY['Private fields', 'Public fields', 'Abstract', 'Static']), 1, 'Exposing internals.');

END $$;

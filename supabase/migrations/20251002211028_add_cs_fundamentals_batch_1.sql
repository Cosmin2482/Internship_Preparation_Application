/*
  # Add CS Fundamentals Batch 1
  
  1. New Terms Added (10)
    - Linked List (Singly)
    - Linked List (Doubly)
    - Deque
    - Set
    - Tree Basics
    - Binary Search Tree
    - Heap/Priority Queue
    - Graph Basics
    - BFS Traversal
    - DFS Traversal
  
  2. Content
    - Each term includes: ELI5, formal definition, interview answer, 3-7 pitfalls,
      C# and TypeScript code examples, ASCII diagram, and 5 quiz questions
*/

DO $$
DECLARE
  cat_cs uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';

  -- Linked List (Singly)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Linked List (Singly)',
    'A chain of boxes where each box points to the next one. Easy to insert, but you must walk the chain.',
    'Linear data structure where each node contains data and pointer to next node. O(1) insert/delete at known position, O(n) search.',
    'Singly linked lists excel at insertions/deletions when you have the position. Unlike arrays, no shifting needed. Trade-off: no random access, O(n) to find element. Use for stacks, queues, or when frequent insertions matter.',
    to_jsonb(ARRAY['Memory leaks from lost references', 'Null reference exceptions', 'Off-by-one errors in traversal', 'Losing head reference']),
    jsonb_build_object(
      'csharp', E'public class Node<T> {\n  public T Data { get; set; }\n  public Node<T> Next { get; set; }\n}\n\npublic class LinkedList<T> {\n  private Node<T> head;\n  \n  public void AddFirst(T data) {\n    var node = new Node<T> { Data = data, Next = head };\n    head = node; // O(1)\n  }\n}',
      'typescript', E'class Node<T> {\n  data: T;\n  next: Node<T> | null = null;\n}\n\nclass LinkedList<T> {\n  private head: Node<T> | null = null;\n  \n  addFirst(data: T): void {\n    const node = new Node<T>();\n    node.data = data;\n    node.next = this.head;\n    this.head = node; // O(1)\n  }\n}'
    ),
    E'Singly Linked List:\nhead → [A|→] → [B|→] → [C|→] → null\nInsert at head: O(1)\nSearch: O(n)',
    21
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Linked list search complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n²)']), 2, 'Must traverse from head: O(n).'),
    (current_term_id, 'Advantage over array?', to_jsonb(ARRAY['Random access', 'O(1) insert at known position', 'Cache-friendly', 'Less memory']), 1, 'No shifting elements needed.'),
    (current_term_id, 'Main disadvantage?', to_jsonb(ARRAY['Too fast', 'No random access', 'Too much memory', 'Thread-safe']), 1, 'Must traverse to access element.'),
    (current_term_id, 'Inserting at head complexity?', to_jsonb(ARRAY['O(1)', 'O(n)', 'O(log n)', 'O(n²)']), 0, 'Just update head pointer.'),
    (current_term_id, 'Common bug?', to_jsonb(ARRAY['Too fast', 'Null reference from lost node', 'Array bounds', 'Stack overflow']), 1, 'Forgetting null checks.');

  -- Linked List (Doubly)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Linked List (Doubly)',
    'Like singly linked list but each box points both forward and backward.',
    'Linear structure where each node has data, next pointer, and previous pointer. O(1) insert/delete at known position, bidirectional traversal.',
    'Doubly linked lists allow backward traversal and easier deletion since you have previous pointer. Trade-off: double the pointer storage. Useful for LRU caches, browser history, undo/redo.',
    to_jsonb(ARRAY['More complex pointer management', 'Double memory for pointers', 'Circular reference bugs', 'Forgetting to update both prev and next']),
    jsonb_build_object(
      'csharp', E'public class DNode<T> {\n  public T Data { get; set; }\n  public DNode<T> Next { get; set; }\n  public DNode<T> Prev { get; set; }\n}\n\npublic void Remove(DNode<T> node) {\n  if(node.Prev != null) node.Prev.Next = node.Next;\n  if(node.Next != null) node.Next.Prev = node.Prev;\n}',
      'typescript', E'class DNode<T> {\n  data: T;\n  next: DNode<T> | null = null;\n  prev: DNode<T> | null = null;\n}\n\nfunction remove<T>(node: DNode<T>): void {\n  if(node.prev) node.prev.next = node.next;\n  if(node.next) node.next.prev = node.prev;\n}'
    ),
    E'Doubly Linked List:\nnull ← [A|⇄] ⇄ [B|⇄] ⇄ [C] → null\nBidirectional traversal\nEasier deletion',
    22
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Doubly vs singly main difference?', to_jsonb(ARRAY['Faster', 'Bidirectional traversal', 'Less memory', 'Simpler']), 1, 'Can traverse backward.'),
    (current_term_id, 'Memory overhead?', to_jsonb(ARRAY['None', 'One extra pointer per node', 'Double the data', 'Triple memory']), 1, 'Prev pointer adds overhead.'),
    (current_term_id, 'Deletion advantage?', to_jsonb(ARRAY['None', 'Easier with prev pointer', 'Faster search', 'Less bugs']), 1, 'No need to find previous node.'),
    (current_term_id, 'Common use case?', to_jsonb(ARRAY['Sorting', 'LRU cache', 'Binary search', 'Hashing']), 1, 'LRU needs fast remove and reinsert.'),
    (current_term_id, 'Complexity of removal at known node?', to_jsonb(ARRAY['O(1)', 'O(n)', 'O(log n)', 'O(n²)']), 0, 'Just update pointers: O(1).');

  -- Deque
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Deque (Double-Ended Queue)',
    'A line where you can add or remove from either end - front or back.',
    'Data structure supporting O(1) insert/delete at both ends. Combines stack and queue capabilities.',
    'Deque allows efficient operations at both ends, unlike queue (back only) or stack (top only). Useful for sliding window problems, palindrome checks, and algorithms needing both FIFO and LIFO access.',
    to_jsonb(ARRAY['More complex than simple queue/stack', 'Implementation complexity with circular buffer', 'Choosing when to use vs simpler structures', 'Index management bugs']),
    jsonb_build_object(
      'csharp', E'// C# uses LinkedList<T> as deque\nvar deque = new LinkedList<int>();\ndeque.AddFirst(1); // O(1) front\ndeque.AddLast(2);  // O(1) back\nint front = deque.First.Value;\ndeque.RemoveFirst(); // O(1)\ndeque.RemoveLast();  // O(1)',
      'typescript', E'// TypeScript array methods as deque\nconst deque: number[] = [];\ndeque.unshift(1); // O(n) front (inefficient)\ndeque.push(2);    // O(1) back\nconst front = deque.shift(); // O(n)\nconst back = deque.pop();    // O(1)\n// Better: use custom deque implementation'
    ),
    E'Deque:\nFRONT ⇄ [1][2][3][4] ⇄ BACK\n    ↕               ↕\n  push/pop      push/pop\nBoth ends: O(1)',
    23
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Deque allows?', to_jsonb(ARRAY['Front only', 'Back only', 'Both ends operations', 'Middle only']), 2, 'Insert/delete at both ends.'),
    (current_term_id, 'Operations complexity?', to_jsonb(ARRAY['O(1) one end only', 'O(1) both ends', 'O(n) both', 'O(log n)']), 1, 'Efficient at both ends.'),
    (current_term_id, 'Deque vs Queue?', to_jsonb(ARRAY['Same', 'Deque adds front operations', 'Queue faster', 'Queue more memory']), 1, 'Deque is superset of queue.'),
    (current_term_id, 'Sliding window use case?', to_jsonb(ARRAY['Never', 'Yes, add back remove front', 'Only arrays', 'Only stacks']), 1, 'Deque maintains window efficiently.'),
    (current_term_id, 'Implementation typically uses?', to_jsonb(ARRAY['Array only', 'Doubly linked list or circular buffer', 'Stack', 'Hash table']), 1, 'Needs efficient both-end access.');

  -- Set (expanding on earlier entry)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Set Operations',
    'A collection of unique items with fast lookup, and operations like union, intersection, difference.',
    'Unordered collection enforcing uniqueness with O(1) average add/remove/contains. Supports set operations: union, intersection, difference, subset.',
    'Sets efficiently track unique elements and membership. Use for deduplication, checking existence, or mathematical set operations. HashSet gives O(1) average, SortedSet gives O(log n) but maintains order.',
    to_jsonb(ARRAY['Mutable elements breaking hash', 'No ordering in HashSet', 'Hash collisions degrading performance', 'Comparing sets incorrectly']),
    jsonb_build_object(
      'csharp', E'var a = new HashSet<int>{1, 2, 3};\nvar b = new HashSet<int>{2, 3, 4};\n\na.UnionWith(b);        // {1,2,3,4}\na.IntersectWith(b);   // {2,3}\na.ExceptWith(b);      // {1}\nbool subset = a.IsSubsetOf(b);',
      'typescript', E'const a = new Set([1, 2, 3]);\nconst b = new Set([2, 3, 4]);\n\nconst union = new Set([...a, ...b]); // {1,2,3,4}\nconst intersect = new Set([...a].filter(x => b.has(x))); // {2,3}\nconst diff = new Set([...a].filter(x => !b.has(x))); // {1}'
    ),
    E'Set Operations:\nA = {1,2,3}  B = {2,3,4}\nUnion: {1,2,3,4}\nIntersect: {2,3}\nDifference A-B: {1}',
    24
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Set guarantees?', to_jsonb(ARRAY['Order', 'Uniqueness', 'Sorting', 'Indexing']), 1, 'No duplicates allowed.'),
    (current_term_id, 'Union of A and B?', to_jsonb(ARRAY['Common elements', 'All elements from both', 'A minus B', 'B minus A']), 1, 'Combines all unique elements.'),
    (current_term_id, 'Intersection finds?', to_jsonb(ARRAY['All elements', 'Common elements only', 'Different elements', 'Empty set']), 1, 'Elements in both sets.'),
    (current_term_id, 'HashSet vs SortedSet?', to_jsonb(ARRAY['Same', 'HashSet O(1) unordered, SortedSet O(log n) ordered', 'SortedSet faster', 'HashSet ordered']), 1, 'Trade-off: speed vs order.'),
    (current_term_id, 'When to use Set?', to_jsonb(ARRAY['Need duplicates', 'Need uniqueness and fast lookup', 'Need ordering', 'Need indexing']), 1, 'Deduplication and membership.');

  -- Tree Basics
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Tree Basics',
    'A structure like a family tree - one root at top, branches below, nodes can have children.',
    'Hierarchical data structure with root node and child nodes forming parent-child relationships. No cycles. Each node has at most one parent.',
    'Trees organize hierarchical data. Root is top, leaves have no children. Binary tree: max 2 children per node. Use for file systems, DOM, org charts. Depth is levels, height is max depth.',
    to_jsonb(ARRAY['Confusing depth vs height', 'Stack overflow from deep recursion', 'Not handling empty tree', 'Forgetting to check null nodes']),
    jsonb_build_object(
      'csharp', E'public class TreeNode<T> {\n  public T Data { get; set; }\n  public List<TreeNode<T>> Children { get; set; }\n}\n\npublic int Height(TreeNode<T> node) {\n  if(node == null) return 0;\n  return 1 + node.Children.Max(c => Height(c));\n}',
      'typescript', E'class TreeNode<T> {\n  data: T;\n  children: TreeNode<T>[] = [];\n}\n\nfunction height<T>(node: TreeNode<T> | null): number {\n  if(!node) return 0;\n  return 1 + Math.max(...node.children.map(c => height(c)), 0);\n}'
    ),
    E'Tree:\n      [A]       ← root\n     /   \\\n   [B]   [C]    ← children\n   / \\     \\\n [D] [E]   [F]  ← leaves\nHeight: 3',
    25
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Root node is?', to_jsonb(ARRAY['Bottom node', 'Top node with no parent', 'Leaf node', 'Any node']), 1, 'Starting point at top.'),
    (current_term_id, 'Leaf node has?', to_jsonb(ARRAY['One child', 'Two children', 'No children', 'Parent only']), 2, 'Terminal nodes.'),
    (current_term_id, 'Binary tree max children?', to_jsonb(ARRAY['One', 'Two', 'Three', 'Unlimited']), 1, 'Binary = max 2 per node.'),
    (current_term_id, 'Tree depth vs height?', to_jsonb(ARRAY['Same', 'Depth: node level, Height: max depth', 'Opposite', 'Unrelated']), 1, 'Depth from root, height to deepest leaf.'),
    (current_term_id, 'Trees contain cycles?', to_jsonb(ARRAY['Yes', 'No, would be graph', 'Sometimes', 'Only balanced trees']), 1, 'No cycles by definition.');

  -- Binary Search Tree
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Binary Search Tree (BST)',
    'A binary tree where left children are smaller, right children are bigger. Makes searching fast.',
    'Binary tree where for each node: left subtree values < node < right subtree values. Enables O(log n) search/insert/delete when balanced.',
    'BSTs maintain sorted order with efficient operations. O(log n) for balanced trees, degrades to O(n) if unbalanced (becomes linked list). In-order traversal yields sorted sequence. Use for ordered data with frequent lookups.',
    to_jsonb(ARRAY['Unbalanced tree degrading to O(n)', 'Not maintaining BST property during insertion', 'Deletion complexity (node with 2 children)', 'Duplicate handling ambiguity']),
    jsonb_build_object(
      'csharp', E'public class BSTNode {\n  public int Value;\n  public BSTNode Left, Right;\n}\n\npublic bool Search(BSTNode node, int target) {\n  if(node == null) return false;\n  if(target == node.Value) return true;\n  return target < node.Value \n    ? Search(node.Left, target)\n    : Search(node.Right, target);\n}',
      'typescript', E'class BSTNode {\n  value: number;\n  left: BSTNode | null = null;\n  right: BSTNode | null = null;\n}\n\nfunction search(node: BSTNode | null, target: number): boolean {\n  if(!node) return false;\n  if(target === node.value) return true;\n  return target < node.value \n    ? search(node.left, target)\n    : search(node.right, target);\n}'
    ),
    E'BST:\n      [5]\n     /   \\\n   [3]   [7]\n   / \\   / \\\n [1] [4][6][9]\nLeft < Node < Right',
    26
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'BST property?', to_jsonb(ARRAY['Any order', 'Left < Node < Right', 'Left > Node > Right', 'Always balanced']), 1, 'Maintains sorted order.'),
    (current_term_id, 'Balanced BST search complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n²)']), 1, 'Halves search space each level.'),
    (current_term_id, 'Unbalanced BST worst case?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'Same as balanced']), 2, 'Degenerates to linked list.'),
    (current_term_id, 'In-order traversal of BST yields?', to_jsonb(ARRAY['Random order', 'Sorted sequence', 'Reverse order', 'Level order']), 1, 'Left-Node-Right gives sorted.'),
    (current_term_id, 'BST vs Hash Table?', to_jsonb(ARRAY['BST always faster', 'Hash O(1) avg but BST maintains order', 'Same performance', 'Hash slower']), 1, 'Trade-off: speed vs order.');

  -- Heap/Priority Queue
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Heap / Priority Queue',
    'A tree where parent is always bigger (max heap) or smaller (min heap) than children. Get min/max fast.',
    'Complete binary tree maintaining heap property: parent ≥ children (max heap) or parent ≤ children (min heap). O(1) peek, O(log n) insert/extract.',
    'Heaps efficiently maintain min/max element. Used in priority queues, sorting (heapsort), finding k-largest elements. Implemented as array for cache efficiency. Always complete tree for balance.',
    to_jsonb(ARRAY['Confusing heap with heap memory', 'Not maintaining heap property during operations', 'Index calculation bugs in array implementation', 'Choosing min vs max heap incorrectly']),
    jsonb_build_object(
      'csharp', E'var minHeap = new PriorityQueue<int, int>();\nminHeap.Enqueue(5, 5); // O(log n)\nminHeap.Enqueue(1, 1);\nint min = minHeap.Peek(); // O(1) → 1\nint extracted = minHeap.Dequeue(); // O(log n)\n\n// Custom comparer for max heap\nvar maxHeap = new PriorityQueue<int, int>(Comparer<int>.Create((a,b) => b.CompareTo(a)));',
      'typescript', E'// TypeScript no built-in heap, manual implementation\nclass MinHeap {\n  private heap: number[] = [];\n  \n  insert(val: number): void {\n    this.heap.push(val);\n    this.bubbleUp(this.heap.length - 1);\n  }\n  \n  extractMin(): number {\n    const min = this.heap[0];\n    this.heap[0] = this.heap.pop()!;\n    this.bubbleDown(0);\n    return min;\n  }\n}'
    ),
    E'Min Heap:\n      [1]       ← min at root\n     /   \\\n   [3]   [2]\n   / \\\n [7] [5]\nParent ≤ Children\nArray: [1,3,2,7,5]',
    27
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Heap property (min heap)?', to_jsonb(ARRAY['Parent > Children', 'Parent ≤ Children', 'Sorted array', 'Balanced']), 1, 'Root is minimum.'),
    (current_term_id, 'Peek min/max complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n log n)']), 0, 'Root is always min/max.'),
    (current_term_id, 'Insert complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n log n)']), 1, 'Bubble up through tree height.'),
    (current_term_id, 'Heap implemented as?', to_jsonb(ARRAY['Linked list', 'Array for cache efficiency', 'Hash table', 'Graph']), 1, 'Array: parent=i, children=2i+1, 2i+2.'),
    (current_term_id, 'Use case?', to_jsonb(ARRAY['Sorted iteration', 'Priority queue for task scheduling', 'Random access', 'Hashing']), 1, 'Always process highest priority first.');

  -- Graph Basics
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Graph Basics',
    'Dots (nodes) connected by lines (edges). Can be one-way or two-way streets.',
    'Set of vertices/nodes connected by edges. Directed (one-way) or undirected (two-way). Weighted or unweighted. Represented as adjacency list or matrix.',
    'Graphs model relationships: social networks, maps, dependencies. Directed has edge direction, undirected is bidirectional. Adjacency list: space-efficient O(V+E), good for sparse. Adjacency matrix: O(V²) space, O(1) edge lookup.',
    to_jsonb(ARRAY['Choosing wrong representation (list vs matrix)', 'Not handling disconnected components', 'Cycle detection bugs', 'Directed vs undirected confusion']),
    jsonb_build_object(
      'csharp', E'// Adjacency List\nvar graph = new Dictionary<int, List<int>>();\ngraph[0] = new List<int>{1, 2};\ngraph[1] = new List<int>{2};\ngraph[2] = new List<int>{0, 3};\n\n// Check if edge exists: O(degree)\nbool hasEdge = graph[0].Contains(1);',
      'typescript', E'// Adjacency List\nconst graph = new Map<number, number[]>();\ngraph.set(0, [1, 2]);\ngraph.set(1, [2]);\ngraph.set(2, [0, 3]);\n\n// Check if edge exists\nconst hasEdge = graph.get(0)?.includes(1);'
    ),
    E'Graph:\n  (A)─────(B)\n   │       │\n   │       │\n  (C)─────(D)\nDirected: A→B (one-way)\nUndirected: A─B (two-way)',
    28
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Directed vs undirected?', to_jsonb(ARRAY['Same', 'Directed has edge direction', 'Directed faster', 'Undirected simpler']), 1, 'One-way vs two-way edges.'),
    (current_term_id, 'Adjacency list space?', to_jsonb(ARRAY['O(V)', 'O(V+E)', 'O(V²)', 'O(E²)']), 1, 'Stores vertices and edges.'),
    (current_term_id, 'Adjacency matrix space?', to_jsonb(ARRAY['O(V)', 'O(E)', 'O(V²)', 'O(V+E)']), 2, 'V×V matrix for all possible edges.'),
    (current_term_id, 'When use adjacency matrix?', to_jsonb(ARRAY['Sparse graphs', 'Dense graphs, need O(1) edge lookup', 'Always', 'Never']), 1, 'Dense graphs benefit from O(1) lookup.'),
    (current_term_id, 'Graph use case?', to_jsonb(ARRAY['Sorting', 'Social networks, maps, dependencies', 'Binary search', 'Hashing']), 1, 'Models relationships.');

  -- BFS Traversal
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'BFS Traversal',
    'Explore level by level - visit all neighbors before going deeper. Like ripples in water.',
    'Graph/tree traversal using queue. Visit all nodes at depth d before depth d+1. O(V+E) time, O(V) space for queue.',
    'BFS explores breadth-first using queue. Finds shortest path in unweighted graphs. Use for level-order traversal, shortest path, detecting cycles. Space trade-off: queue can be large for wide graphs.',
    to_jsonb(ARRAY['Not marking visited nodes causing infinite loop', 'Using stack instead of queue (would be DFS)', 'Forgetting to handle disconnected components', 'Memory issues with wide graphs']),
    jsonb_build_object(
      'csharp', E'public void BFS(int start) {\n  var visited = new HashSet<int>();\n  var queue = new Queue<int>();\n  \n  queue.Enqueue(start);\n  visited.Add(start);\n  \n  while(queue.Count > 0) {\n    int node = queue.Dequeue();\n    Console.WriteLine(node);\n    \n    foreach(int neighbor in graph[node]) {\n      if(!visited.Contains(neighbor)) {\n        visited.Add(neighbor);\n        queue.Enqueue(neighbor);\n      }\n    }\n  }\n}',
      'typescript', E'function bfs(start: number, graph: Map<number, number[]>): void {\n  const visited = new Set<number>();\n  const queue: number[] = [start];\n  visited.add(start);\n  \n  while(queue.length > 0) {\n    const node = queue.shift()!;\n    console.log(node);\n    \n    for(const neighbor of graph.get(node) || []) {\n      if(!visited.has(neighbor)) {\n        visited.add(neighbor);\n        queue.push(neighbor);\n      }\n    }\n  }\n}'
    ),
    E'BFS:\n      1       ← level 0\n    /   \\\n   2     3    ← level 1\n  / \\   /\n 4   5 6      ← level 2\nVisit order: 1,2,3,4,5,6\nUses Queue (FIFO)',
    29
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'BFS uses which structure?', to_jsonb(ARRAY['Stack', 'Queue', 'Heap', 'Array']), 1, 'Queue for FIFO level-order.'),
    (current_term_id, 'BFS time complexity?', to_jsonb(ARRAY['O(V)', 'O(E)', 'O(V+E)', 'O(V²)']), 2, 'Visit all vertices and edges.'),
    (current_term_id, 'BFS finds shortest path in?', to_jsonb(ARRAY['Weighted graphs', 'Unweighted graphs', 'Never', 'Trees only']), 1, 'Shortest in unweighted graphs.'),
    (current_term_id, 'Why mark nodes visited?', to_jsonb(ARRAY['Performance', 'Prevent infinite loop', 'Save memory', 'Sorting']), 1, 'Avoid revisiting in cycles.'),
    (current_term_id, 'BFS vs DFS for shortest path?', to_jsonb(ARRAY['DFS better', 'BFS finds shortest in unweighted', 'Same', 'Neither']), 1, 'BFS explores level by level.');

  -- DFS Traversal
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'DFS Traversal',
    'Go as deep as possible before backtracking. Like exploring a maze by going down each path fully.',
    'Graph/tree traversal using stack (or recursion). Explores depth before breadth. O(V+E) time, O(h) space for recursion stack.',
    'DFS explores depth-first using stack or recursion. Useful for topological sort, cycle detection, maze solving, generating permutations. Space-efficient O(h) vs BFS O(w). Can cause stack overflow with deep recursion.',
    to_jsonb(ARRAY['Stack overflow from deep recursion', 'Not marking visited causing infinite loop', 'Using queue instead of stack (would be BFS)', 'Missing backtracking in some algorithms']),
    jsonb_build_object(
      'csharp', E'public void DFS(int node, HashSet<int> visited) {\n  visited.Add(node);\n  Console.WriteLine(node);\n  \n  foreach(int neighbor in graph[node]) {\n    if(!visited.Contains(neighbor)) {\n      DFS(neighbor, visited); // Recursion uses implicit stack\n    }\n  }\n}\n\n// Iterative with explicit stack\npublic void DFSIterative(int start) {\n  var stack = new Stack<int>();\n  var visited = new HashSet<int>();\n  stack.Push(start);\n  \n  while(stack.Count > 0) {\n    int node = stack.Pop();\n    if(visited.Add(node)) {\n      Console.WriteLine(node);\n      foreach(int neighbor in graph[node])\n        stack.Push(neighbor);\n    }\n  }\n}',
      'typescript', E'function dfs(node: number, visited: Set<number>, graph: Map<number, number[]>): void {\n  visited.add(node);\n  console.log(node);\n  \n  for(const neighbor of graph.get(node) || []) {\n    if(!visited.has(neighbor)) {\n      dfs(neighbor, visited, graph);\n    }\n  }\n}\n\n// Iterative\nfunction dfsIterative(start: number, graph: Map<number, number[]>): void {\n  const stack = [start];\n  const visited = new Set<number>();\n  \n  while(stack.length > 0) {\n    const node = stack.pop()!;\n    if(!visited.has(node)) {\n      visited.add(node);\n      console.log(node);\n      stack.push(...(graph.get(node) || []));\n    }\n  }\n}'
    ),
    E'DFS:\n      1       \n    /   \\\n   2     5    \n  / \\     \\\n 3   4     6  \nVisit order: 1,2,3,4,5,6\nUses Stack/Recursion',
    30
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'DFS uses which structure?', to_jsonb(ARRAY['Queue', 'Stack or recursion', 'Heap', 'Array']), 1, 'Stack for LIFO depth-first.'),
    (current_term_id, 'DFS time complexity?', to_jsonb(ARRAY['O(V)', 'O(E)', 'O(V+E)', 'O(V²)']), 2, 'Visit all vertices and edges.'),
    (current_term_id, 'DFS space complexity?', to_jsonb(ARRAY['O(1)', 'O(h) where h is height', 'O(V)', 'O(E)']), 1, 'Recursion stack depth.'),
    (current_term_id, 'DFS risk?', to_jsonb(ARRAY['Too fast', 'Stack overflow from deep recursion', 'Too much memory always', 'Too slow']), 1, 'Deep graphs exhaust stack.'),
    (current_term_id, 'DFS use case?', to_jsonb(ARRAY['Shortest path', 'Topological sort, cycle detection', 'Level-order', 'Min distance']), 1, 'Good for path-based algorithms.');

  RAISE NOTICE 'Added 10 CS Fundamentals terms';
END $$;

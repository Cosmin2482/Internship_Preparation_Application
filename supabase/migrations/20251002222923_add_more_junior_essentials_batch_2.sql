/*
  # Add More Junior Level Essentials - Batch 2
  
  1. New Terms (20 terms)
    More CS, OOP, .NET, SQL, TypeScript/Angular essentials
    Topics: Insertion/Selection Sort, Exceptions, Testing, TypeScript utilities, Angular routing, etc.
*/

DO $$
DECLARE
  cat_cs uuid;
  cat_oop uuid;
  cat_dotnet uuid;
  cat_sql uuid;
  cat_angular uuid;
  cat_arch uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';
  SELECT id INTO cat_dotnet FROM categories WHERE slug = 'dotnet';
  SELECT id INTO cat_sql FROM categories WHERE slug = 'sql';
  SELECT id INTO cat_angular FROM categories WHERE slug = 'angular';
  SELECT id INTO cat_arch FROM categories WHERE slug = 'architecture';

  -- Insertion Sort
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Insertion Sort',
    'Build sorted portion one item at a time by inserting each into correct position.',
    'Sorting algorithm building sorted array by inserting each element into proper position. O(n²) worst/average, O(n) best case (already sorted).',
    'Insertion sort efficient for small or nearly sorted arrays. Iterates through array, inserting each element into sorted portion. Stable, in-place, O(n²) typical but O(n) best case. Good for online sorting (streaming data).',
    to_jsonb(ARRAY['Using on large datasets (too slow)', 'Not recognizing O(n) best case advantage', 'Off-by-one errors in shifting', 'Not considering for nearly sorted data']),
    jsonb_build_object(
      'csharp', E'void InsertionSort(int[] arr) {\n  for(int i = 1; i < arr.Length; i++) {\n    int key = arr[i];\n    int j = i - 1;\n    \n    // Shift elements right to make space\n    while(j >= 0 && arr[j] > key) {\n      arr[j + 1] = arr[j];\n      j--;\n    }\n    arr[j + 1] = key; // Insert key\n  }\n}\n\n// Best case O(n): already sorted\n// Worst case O(n²): reverse sorted\n// Stable: maintains relative order',
      'typescript', E'function insertionSort(arr: number[]): void {\n  for(let i = 1; i < arr.length; i++) {\n    const key = arr[i];\n    let j = i - 1;\n    \n    // Shift elements right\n    while(j >= 0 && arr[j] > key) {\n      arr[j + 1] = arr[j];\n      j--;\n    }\n    arr[j + 1] = key;\n  }\n}\n\n// Good for small or nearly sorted arrays'
    ),
    E'Insertion Sort:\n[5|3,8,1,9] sorted | unsorted\nInsert 3: [3,5|8,1,9]\nInsert 8: [3,5,8|1,9]\nInsert 1: [1,3,5,8|9]\nInsert 9: [1,3,5,8,9]\n\nO(n²) average, O(n) best\nStable, in-place',
    100
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Insertion sort time complexity?', to_jsonb(ARRAY['Always O(n)', 'O(n²) average, O(n) best', 'O(n log n)', 'O(n³)']), 1, 'Best when already sorted: O(n).'),
    (current_term_id, 'Insertion sort is stable?', to_jsonb(ARRAY['Yes', 'No', 'Sometimes', 'Depends']), 0, 'Preserves relative order of equal elements.'),
    (current_term_id, 'When use insertion sort?', to_jsonb(ARRAY['Large datasets', 'Small or nearly sorted arrays', 'Never', 'Always']), 1, 'Efficient for small n or almost sorted.'),
    (current_term_id, 'Insertion sort space?', to_jsonb(ARRAY['O(1) in-place', 'O(n)', 'O(log n)', 'O(n²)']), 0, 'Sorts in-place, no extra array.'),
    (current_term_id, 'Best case scenario?', to_jsonb(ARRAY['Reverse sorted', 'Already sorted (O(n))', 'Random', 'All equal']), 1, 'Just verifies order, no shifts needed.');

  -- Selection Sort
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Selection Sort',
    'Repeatedly find minimum element and put it at beginning of unsorted portion.',
    'Sorting algorithm selecting minimum from unsorted portion and swapping to front. O(n²) all cases. Not stable but in-place.',
    'Selection sort finds minimum in unsorted portion and swaps to sorted portion. Always O(n²) even if sorted. Fewer swaps than bubble sort (O(n) swaps). Not stable. Simple but inefficient.',
    to_jsonb(ARRAY['Thinking it has good best case (always O(n²))', 'Using on large data', 'Expecting stability', 'Not recognizing minimal swaps advantage']),
    jsonb_build_object(
      'csharp', E'void SelectionSort(int[] arr) {\n  for(int i = 0; i < arr.Length - 1; i++) {\n    int minIdx = i;\n    \n    // Find minimum in unsorted portion\n    for(int j = i + 1; j < arr.Length; j++) {\n      if(arr[j] < arr[minIdx]) {\n        minIdx = j;\n      }\n    }\n    \n    // Swap minimum to front\n    if(minIdx != i) {\n      (arr[i], arr[minIdx]) = (arr[minIdx], arr[i]);\n    }\n  }\n}\n\n// Always O(n²)\n// O(n) swaps (fewer than bubble)\n// Not stable',
      'typescript', E'function selectionSort(arr: number[]): void {\n  for(let i = 0; i < arr.length - 1; i++) {\n    let minIdx = i;\n    \n    // Find min in unsorted\n    for(let j = i + 1; j < arr.length; j++) {\n      if(arr[j] < arr[minIdx]) {\n        minIdx = j;\n      }\n    }\n    \n    // Swap\n    if(minIdx !== i) {\n      [arr[i], arr[minIdx]] = [arr[minIdx], arr[i]];\n    }\n  }\n}'
    ),
    E'Selection Sort:\n[3,5,1,9,2] Find min (1), swap\n[1,5,3,9,2] Find min (2), swap\n[1,2,3,9,5] Find min (3), already there\n[1,2,3,9,5] Find min (5), swap\n[1,2,3,5,9] Done\n\nAlways O(n²)\nO(n) swaps',
    101
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Selection sort complexity?', to_jsonb(ARRAY['O(n) best', 'O(n²) all cases', 'O(n log n)', 'O(n²) worst only']), 1, 'Always O(n²) even if sorted.'),
    (current_term_id, 'Selection sort is stable?', to_jsonb(ARRAY['Yes', 'No, unstable', 'Sometimes', 'Depends']), 1, 'Long-range swaps break stability.'),
    (current_term_id, 'Selection sort swaps?', to_jsonb(ARRAY['O(n²)', 'O(n) swaps maximum', 'O(1)', 'O(n log n)']), 1, 'One swap per pass: n swaps.'),
    (current_term_id, 'Selection vs bubble sort?', to_jsonb(ARRAY['Same', 'Selection has fewer swaps', 'Bubble faster', 'No difference']), 1, 'Selection: O(n) swaps, Bubble: O(n²) swaps.'),
    (current_term_id, 'When use selection sort?', to_jsonb(ARRAY['Production code', 'When swap cost high, data small', 'Large datasets', 'Always']), 1, 'Minimal swaps useful when swap expensive.');

  -- Exceptions & Handling
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Exception Handling',
    'Catch and handle errors gracefully instead of crashing the program.',
    'Exceptions: objects representing errors. try-catch-finally: try code, catch handles exceptions, finally always runs. Throw exceptions for exceptional conditions.',
    'Use exceptions for unexpected errors, not control flow. try block contains risky code. catch blocks handle specific exceptions. finally always executes (cleanup). throw raises exception. Use specific exception types, add context.',
    to_jsonb(ARRAY['Using exceptions for control flow', 'Catching Exception (too broad)', 'Empty catch blocks swallowing errors', 'Not logging exceptions', 'Forgetting finally for cleanup', 'Throwing exceptions in finally']),
    jsonb_build_object(
      'csharp', E'public User GetUser(int id) {\n  try {\n    var user = _repository.GetById(id);\n    if(user == null) \n      throw new NotFoundException($"User {id} not found");\n    return user;\n  }\n  catch(DbException ex) {\n    _logger.LogError(ex, "Database error getting user {Id}", id);\n    throw; // Re-throw to let caller handle\n  }\n  catch(NotFoundException) {\n    _logger.LogWarning("User {Id} not found", id);\n    throw;\n  }\n  catch(Exception ex) {\n    _logger.LogError(ex, "Unexpected error");\n    throw new ApplicationException("Failed to get user", ex);\n  }\n  finally {\n    // Always runs: cleanup connections, etc.\n    _repository.Dispose();\n  }\n}\n\n// Custom exception\npublic class NotFoundException : Exception {\n  public NotFoundException(string message) : base(message) { }\n}\n\n// Guard clauses vs exceptions\npublic void ProcessOrder(Order order) {\n  // Use ArgumentException for invalid arguments\n  if(order == null) \n    throw new ArgumentNullException(nameof(order));\n  if(order.Total < 0)\n    throw new ArgumentException("Total cannot be negative", nameof(order));\n  // ...\n}',
      'typescript', E'class NotFoundException extends Error {\n  constructor(message: string) {\n    super(message);\n    this.name = ''NotFoundException'';\n  }\n}\n\nasync function getUser(id: number): Promise<User> {\n  try {\n    const user = await repository.getById(id);\n    if(!user) {\n      throw new NotFoundException(`User ${id} not found`);\n    }\n    return user;\n  } catch(error) {\n    if(error instanceof NotFoundException) {\n      logger.warn(`User ${id} not found`);\n      throw error;\n    }\n    \n    logger.error(''Database error'', error);\n    throw new Error(''Failed to get user'');\n  } finally {\n    // Cleanup\n    await repository.close();\n  }\n}\n\n// Validation\nfunction processOrder(order: Order): void {\n  if(!order) throw new Error(''Order required'');\n  if(order.total < 0) throw new Error(''Invalid total'');\n  // ...\n}'
    ),
    E'Exception Handling:\ntry {\n  Risky code\n  ↓ error occurs\n  throw Exception\n}\ncatch (SpecificException ex) {\n  Handle error\n  Log it\n  ↓\n  throw; (or recover)\n}\nfinally {\n  Always runs: cleanup\n}\n\nDon''t swallow exceptions!',
    102
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'finally block runs?', to_jsonb(ARRAY['Only if no exception', 'Always, even with exception or return', 'Only with exception', 'Never']), 1, 'Guaranteed execution for cleanup.'),
    (current_term_id, 'Exceptions for?', to_jsonb(ARRAY['Control flow', 'Exceptional error conditions only', 'Validation always', 'All checks']), 1, 'Not for normal program flow.'),
    (current_term_id, 'Catch Exception?', to_jsonb(ARRAY['Best practice', 'Too broad, catch specific types', 'Required', 'Fastest']), 1, 'Catch specific exceptions, log details.'),
    (current_term_id, 'Empty catch block?', to_jsonb(ARRAY['Good practice', 'Anti-pattern: swallows errors', 'Required', 'Fast']), 1, 'Hides bugs, always log or handle.'),
    (current_term_id, 'throw vs throw ex?', to_jsonb(ARRAY['Same', 'throw preserves stack trace, throw ex resets it', 'throw ex better', 'No difference']), 1, 'Bare throw maintains original stack trace.');

  -- xUnit Testing
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'xUnit Testing Basics',
    'Write tests to automatically verify your code works correctly.',
    'xUnit: .NET testing framework. [Fact] for simple tests, [Theory] with [InlineData] for parameterized. Arrange-Act-Assert pattern. Use Moq for mocking dependencies.',
    'xUnit tests verify behavior. [Fact] single test, [Theory] parameterized tests. Arrange: setup. Act: execute. Assert: verify. Mock dependencies with Moq. Name tests clearly: MethodName_Scenario_ExpectedResult.',
    to_jsonb(ARRAY['Testing implementation not behavior', 'No arrange-act-assert structure', 'Poor test names', 'Not isolating dependencies', 'Testing too much in one test', 'Not testing edge cases']),
    jsonb_build_object(
      'csharp', E'using Xunit;\nusing Moq;\n\npublic class UserServiceTests {\n  // [Fact]: single test\n  [Fact]\n  public async Task GetUser_ValidId_ReturnsUser() {\n    // Arrange\n    var mockRepo = new Mock<IUserRepository>();\n    var expected = new User { Id = 1, Name = "Alice" };\n    mockRepo.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(expected);\n    var service = new UserService(mockRepo.Object);\n    \n    // Act\n    var result = await service.GetUserAsync(1);\n    \n    // Assert\n    Assert.NotNull(result);\n    Assert.Equal("Alice", result.Name);\n    mockRepo.Verify(r => r.GetByIdAsync(1), Times.Once);\n  }\n  \n  [Fact]\n  public async Task GetUser_InvalidId_ThrowsNotFoundException() {\n    // Arrange\n    var mockRepo = new Mock<IUserRepository>();\n    mockRepo.Setup(r => r.GetByIdAsync(999)).ReturnsAsync((User)null);\n    var service = new UserService(mockRepo.Object);\n    \n    // Act & Assert\n    await Assert.ThrowsAsync<NotFoundException>(\n      () => service.GetUserAsync(999)\n    );\n  }\n  \n  // [Theory]: parameterized test\n  [Theory]\n  [InlineData(1, true)]\n  [InlineData(-1, false)]\n  [InlineData(0, false)]\n  public void IsValidId_VariousInputs_ReturnsExpected(int id, bool expected) {\n    // Act\n    var result = UserService.IsValidId(id);\n    \n    // Assert\n    Assert.Equal(expected, result);\n  }\n}',
      'typescript', E'import { describe, it, expect, vi } from ''vitest'';\nimport { UserService } from ''./user.service'';\n\ndescribe(''UserService'', () => {\n  it(''getUser - valid id - returns user'', async () => {\n    // Arrange\n    const mockRepo = {\n      getById: vi.fn().mockResolvedValue({ id: 1, name: ''Alice'' })\n    };\n    const service = new UserService(mockRepo);\n    \n    // Act\n    const result = await service.getUser(1);\n    \n    // Assert\n    expect(result).toBeDefined();\n    expect(result.name).toBe(''Alice'');\n    expect(mockRepo.getById).toHaveBeenCalledWith(1);\n    expect(mockRepo.getById).toHaveBeenCalledTimes(1);\n  });\n  \n  it(''getUser - invalid id - throws error'', async () => {\n    // Arrange\n    const mockRepo = {\n      getById: vi.fn().mockResolvedValue(null)\n    };\n    const service = new UserService(mockRepo);\n    \n    // Act & Assert\n    await expect(service.getUser(999)).rejects.toThrow(''Not found'');\n  });\n  \n  // Parameterized\n  it.each([\n    [1, true],\n    [-1, false],\n    [0, false]\n  ])(''isValidId(%i) returns %s'', (id, expected) => {\n    expect(UserService.isValidId(id)).toBe(expected);\n  });\n});'
    ),
    E'xUnit Test Structure:\n[Fact] or [Theory]\npublic void TestName() {\n  // Arrange: setup\n  var mock = new Mock<IRepo>();\n  var sut = new Service(mock.Object);\n  \n  // Act: execute\n  var result = sut.Method();\n  \n  // Assert: verify\n  Assert.Equal(expected, result);\n  mock.Verify(...);\n}\n\nAAA: Arrange-Act-Assert',
    103
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, '[Fact] vs [Theory]?', to_jsonb(ARRAY['Same', '[Fact] single test, [Theory] parameterized', '[Theory] better', 'No difference']), 1, 'Theory runs test with multiple data sets.'),
    (current_term_id, 'AAA pattern?', to_jsonb(ARRAY['Always Assert Absolutely', 'Arrange-Act-Assert', 'All About Async', 'Automatic Action Assert']), 1, 'Standard test structure.'),
    (current_term_id, 'Moq.Setup does?', to_jsonb(ARRAY['Runs test', 'Configures mock behavior', 'Asserts result', 'Creates instance']), 1, 'Defines what mock returns.'),
    (current_term_id, 'mock.Verify checks?', to_jsonb(ARRAY['Return value', 'Method was called as expected', 'Exception', 'Type']), 1, 'Verifies interaction with dependency.'),
    (current_term_id, 'Good test name?', to_jsonb(ARRAY['Test1', 'MethodName_Scenario_ExpectedResult', 'DoTest', 'Main']), 1, 'Clear what is tested and expected outcome.');

  -- TypeScript Utility Types
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'TypeScript Utility Types',
    'Built-in type helpers like Partial (make all optional) and Pick (select specific properties).',
    'TypeScript utility types: Partial<T> (all optional), Required<T> (all required), Pick<T, K> (select props), Omit<T, K> (exclude props), Record<K, V> (key-value), Readonly<T> (immutable).',
    'Utility types transform existing types. Partial makes all props optional (updates). Required opposite. Pick/Omit create subsets. Record for key-value pairs. Readonly prevents mutation. Use for DRY type definitions.',
    to_jsonb(ARRAY['Not knowing built-in utilities exist', 'Manually recreating utility types', 'Overusing any instead of utilities', 'Not understanding when to use each']),
    jsonb_build_object(
      'csharp', E'// C# equivalents (no direct built-ins)\npublic class User {\n  public int Id { get; set; }\n  public string Name { get; set; }\n  public string Email { get; set; }\n}\n\n// Partial equivalent: nullable props\npublic class UpdateUserDto {\n  public string? Name { get; set; } // Optional\n  public string? Email { get; set; }\n}\n\n// Pick equivalent: specific props\npublic class UserSummary {\n  public int Id { get; set; }\n  public string Name { get; set; }\n}\n\n// Readonly equivalent: init-only\npublic class ReadonlyUser {\n  public int Id { get; init; }\n  public string Name { get; init; }\n}',
      'typescript', E'interface User {\n  id: number;\n  name: string;\n  email: string;\n  age: number;\n}\n\n// Partial: all optional (for updates)\ntype UpdateUser = Partial<User>;\n// { id?: number; name?: string; email?: string; age?: number }\n\n// Required: all required\ntype CompleteUser = Required<User>;\n\n// Pick: select specific properties\ntype UserSummary = Pick<User, ''id'' | ''name''>;\n// { id: number; name: string }\n\n// Omit: exclude properties\ntype UserWithoutEmail = Omit<User, ''email''>;\n// { id: number; name: string; age: number }\n\n// Record: key-value type\ntype UserMap = Record<number, User>; // { [id: number]: User }\ntype Status = Record<''pending'' | ''active'' | ''inactive'', boolean>;\n\n// Readonly: immutable\ntype ImmutableUser = Readonly<User>;\nconst user: ImmutableUser = { id: 1, name: ''Alice'', email: ''a@b.c'', age: 25 };\n// user.name = ''Bob''; // Error: readonly\n\n// ReturnType: extract function return type\nfunction getUser(): User { return {...}; }\ntype UserType = ReturnType<typeof getUser>; // User\n\n// Usage example\nfunction updateUser(id: number, updates: Partial<User>) {\n  // updates can have any subset of User properties\n}'
    ),
    E'TypeScript Utilities:\nPartial<T>   → all optional\nRequired<T>  → all required\nPick<T, K>   → select props\nOmit<T, K>   → exclude props\nRecord<K, V> → key-value map\nReadonly<T>  → immutable\n\nDRY: Don''t repeat type definitions',
    104
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Partial<User> makes?', to_jsonb(ARRAY['Required', 'All properties optional', 'Readonly', 'Picks some']), 1, 'All props become optional with ?.'),
    (current_term_id, 'Pick<User, "id" | "name">?', to_jsonb(ARRAY['Removes id and name', 'Selects only id and name', 'Makes optional', 'All properties']), 1, 'Creates type with only specified props.'),
    (current_term_id, 'Omit<User, "email">?', to_jsonb(ARRAY['Only email', 'All except email', 'Makes optional', 'Readonly']), 1, 'Excludes specified properties.'),
    (current_term_id, 'Record<string, number>?', to_jsonb(ARRAY['Array', 'Object with string keys, number values', 'Function', 'Class']), 1, 'Key-value type: { [key: string]: number }.'),
    (current_term_id, 'Readonly<T> prevents?', to_jsonb(ARRAY['Reading', 'Mutation/modification', 'Creation', 'Deletion']), 1, 'All properties become readonly.');

  -- Angular Lifecycle Hooks
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'Angular Lifecycle Hooks',
    'Special methods that run at key moments in a component''s life: creation, changes, destruction.',
    'Lifecycle hooks: ngOnInit (after input binding), ngOnChanges (when inputs change), ngOnDestroy (cleanup), ngAfterViewInit (after view ready), ngDoCheck (custom change detection).',
    'Lifecycle hooks let you tap into component phases. ngOnInit for initialization after inputs set. ngOnChanges detects input changes. ngOnDestroy for cleanup (unsubscribe). ngAfterViewInit when view ready. Don''t use constructor for async or DOM access.',
    to_jsonb(ARRAY['Heavy logic in constructor', 'Not unsubscribing in ngOnDestroy', 'Accessing ViewChild in ngOnInit', 'Mutating inputs in ngOnChanges', 'Not understanding hook execution order']),
    jsonb_build_object(
      'csharp', E'// Blazor equivalent (C# components)\npublic class UserComponent : ComponentBase {\n  [Parameter] public int UserId { get; set; }\n  \n  private User user;\n  private IDisposable subscription;\n  \n  // OnInitialized: after parameters set (like ngOnInit)\n  protected override async Task OnInitializedAsync() {\n    user = await UserService.GetByIdAsync(UserId);\n  }\n  \n  // OnParametersSet: when parameters change (like ngOnChanges)\n  protected override async Task OnParametersSetAsync() {\n    if(UserId > 0) {\n      user = await UserService.GetByIdAsync(UserId);\n    }\n  }\n  \n  // OnAfterRender: after rendering (like ngAfterViewInit)\n  protected override void OnAfterRender(bool firstRender) {\n    if(firstRender) {\n      // DOM is ready, can call JS interop\n    }\n  }\n  \n  // Dispose: cleanup (like ngOnDestroy)\n  public void Dispose() {\n    subscription?.Dispose();\n  }\n}',
      'typescript', E'import { Component, OnInit, OnChanges, OnDestroy, AfterViewInit, Input, ViewChild } from ''@angular/core'';\n\n@Component({\n  selector: ''app-user'',\n  template: `<div #userContainer>{{user?.name}}</div>`\n})\nexport class UserComponent implements OnInit, OnChanges, AfterViewInit, OnDestroy {\n  @Input() userId!: number;\n  @ViewChild(''userContainer'') container!: ElementRef;\n  \n  user?: User;\n  private subscription?: Subscription;\n  \n  constructor(private userService: UserService) {\n    // Simple initialization only\n    console.log(''Constructor: component created'');\n  }\n  \n  // Runs after @Input() properties set\n  ngOnInit(): void {\n    console.log(''ngOnInit: load data'');\n    this.subscription = this.userService.getUser(this.userId)\n      .subscribe(user => this.user = user);\n  }\n  \n  // Runs when @Input() changes\n  ngOnChanges(changes: SimpleChanges): void {\n    console.log(''ngOnChanges:'', changes);\n    if(changes[''userId''] && !changes[''userId''].firstChange) {\n      // Reload data when userId changes\n      this.loadUser();\n    }\n  }\n  \n  // After view initialized (ViewChild available)\n  ngAfterViewInit(): void {\n    console.log(''ngAfterViewInit: DOM ready'');\n    console.log(this.container.nativeElement); // Now available\n  }\n  \n  // Cleanup before destroy\n  ngOnDestroy(): void {\n    console.log(''ngOnDestroy: cleanup'');\n    this.subscription?.unsubscribe(); // Prevent memory leak\n  }\n  \n  private loadUser(): void {\n    this.userService.getUser(this.userId)\n      .subscribe(user => this.user = user);\n  }\n}'
    ),
    E'Lifecycle Order:\nconstructor\n    ↓\nngOnChanges (first time)\n    ↓\nngOnInit (once)\n    ↓\nngDoCheck\n    ↓\nngAfterContentInit\n    ↓\nngAfterViewInit\n    ↓\nngOnChanges (on input changes)\n    ↓\nngOnDestroy (cleanup)',
    105
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'ngOnInit purpose?', to_jsonb(ARRAY['Constructor', 'Initialize after inputs set', 'Destroy', 'Template ready']), 1, 'Initialization logic, inputs available.'),
    (current_term_id, 'ngOnDestroy for?', to_jsonb(ARRAY['Initialization', 'Cleanup: unsubscribe, clear timers', 'Input changes', 'View ready']), 1, 'Prevent memory leaks.'),
    (current_term_id, 'ngOnChanges detects?', to_jsonb(ARRAY['All changes', '@Input() property changes', 'Constructor', 'Methods']), 1, 'Runs when input bindings change.'),
    (current_term_id, 'ViewChild available in?', to_jsonb(ARRAY['constructor', 'ngOnInit', 'ngAfterViewInit', 'ngOnDestroy']), 2, 'View elements ready after view init.'),
    (current_term_id, 'Constructor should?', to_jsonb(ARRAY['Load data', 'Simple initialization only', 'Subscribe', 'Access DOM']), 1, 'Lightweight, no async or DOM access.');

  RAISE NOTICE 'Added 10 more junior essential terms (batch 2)';
END $$;

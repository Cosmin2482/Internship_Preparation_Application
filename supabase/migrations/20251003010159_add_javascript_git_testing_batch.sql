/*
  # Add JavaScript, Git, and Testing Terms
  
  Add: Promises, Callbacks, DOM, Git workflow, Testing concepts
*/

DO $$
DECLARE
  cat_cs uuid;
  cat_devops uuid;
  cat_dotnet uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';
  SELECT id INTO cat_devops FROM categories WHERE slug = 'devops';
  SELECT id INTO cat_dotnet FROM categories WHERE slug = 'dotnet';

  -- JavaScript Promises
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'JavaScript Promises & Async/Await',
    'Promise = object representing eventual completion/failure of async operation. Async/await makes promises look synchronous.',
    'Promise: object with states (pending, fulfilled, rejected). Async/await: syntactic sugar over promises for cleaner async code.',
    'Promises handle async operations. States: pending → fulfilled/rejected. Chain with .then()/.catch() or use async/await. Async function returns Promise, await pauses until resolved. Better than callback hell.',
    to_jsonb(ARRAY['Not handling rejections', 'Forgetting await', 'Mixing callbacks with promises', 'Not understanding Promise.all for parallel', 'Async function without await']),
    jsonb_build_object(
      'csharp', E'// C# async/await (similar concept)\npublic async Task<User> GetUserAsync(int id) {\n  try {\n    var response = await _httpClient.GetAsync($"/api/users/{id}");\n    response.EnsureSuccessStatusCode();\n    return await response.Content.ReadFromJsonAsync<User>();\n  } catch(HttpRequestException ex) {\n    _logger.LogError(ex, "Failed to fetch user");\n    throw;\n  }\n}\n\n// Parallel execution\npublic async Task LoadDataAsync() {\n  var userTask = GetUserAsync(1);\n  var ordersTask = GetOrdersAsync(1);\n  \n  await Task.WhenAll(userTask, ordersTask);\n  \n  var user = await userTask;\n  var orders = await ordersTask;\n}',
      'typescript', E'// Promise basics\nconst promise = new Promise<number>((resolve, reject) => {\n  setTimeout(() => {\n    const success = true;\n    if(success) {\n      resolve(42); // Fulfilled\n    } else {\n      reject(new Error("Failed")); // Rejected\n    }\n  }, 1000);\n});\n\n// Using .then()/.catch()\npromise\n  .then(result => console.log(result))\n  .catch(error => console.error(error));\n\n// Async/await (cleaner)\nasync function fetchUser(id: number): Promise<User> {\n  try {\n    const response = await fetch(`/api/users/${id}`);\n    if(!response.ok) throw new Error("Failed");\n    return await response.json();\n  } catch(error) {\n    console.error("Error:", error);\n    throw error;\n  }\n}\n\n// Sequential vs Parallel\nasync function loadData() {\n  // Sequential (slow)\n  const user = await fetchUser(1);   // Wait\n  const posts = await fetchPosts(1); // Then wait\n  \n  // Parallel (fast)\n  const [user2, posts2] = await Promise.all([\n    fetchUser(1),\n    fetchPosts(1)\n  ]); // Both at same time\n}\n\n// Promise.race - first to complete\nconst fastest = await Promise.race([\n  fetchFromServer1(),\n  fetchFromServer2()\n]);'
    ),
    E'Promises:\nPending → Fulfilled (resolve)\n        → Rejected (reject)\n\nasync function getData() {\n  const result = await fetch(url);\n  return result.json();\n}\n\nPromise.all([p1, p2]) = parallel\nPromise.race([p1, p2]) = first',
    150
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Promise states?', to_jsonb(ARRAY['On/Off', 'Pending, Fulfilled, Rejected', 'True/False', 'Success/Fail']), 1, 'Three states of async operation.'),
    (current_term_id, 'async function returns?', to_jsonb(ARRAY['Value', 'Promise', 'void', 'undefined']), 1, 'Always returns Promise.'),
    (current_term_id, 'await does?', to_jsonb(ARRAY['Blocks thread', 'Pauses function until Promise resolves', 'Creates Promise', 'Nothing']), 1, 'Waits for Promise result.'),
    (current_term_id, 'Promise.all for?', to_jsonb(ARRAY['Sequential', 'Parallel execution, wait for all', 'First result', 'Error handling']), 1, 'Run multiple promises concurrently.'),
    (current_term_id, 'Handle Promise rejection?', to_jsonb(ARRAY['Ignore', '.catch() or try-catch with await', 'Nothing needed', 'Always succeeds']), 1, 'Must handle errors.');

  -- Callback Hell
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Callbacks & Callback Hell',
    'Callback = function passed as argument to execute later. Callback Hell = deeply nested callbacks hard to read.',
    'Callback: function passed to another function to be executed later. Callback Hell: nested callbacks creating pyramid of doom, solved by Promises/async-await.',
    'Callbacks handle async in older JS. Pass function to execute after operation completes. Nested callbacks become unreadable (callback hell). Solution: Promises flatten structure, async/await makes it look synchronous.',
    to_jsonb(ARRAY['Callback hell (deeply nested)', 'Not handling errors in callbacks', 'Losing "this" context', 'Mixing callbacks with promises']),
    jsonb_build_object(
      'csharp', E'// C# doesn''t have callback hell problem\n// Uses Tasks/async-await from start\npublic async Task ProcessDataAsync() {\n  var data1 = await FetchData1Async();\n  var data2 = await ProcessAsync(data1);\n  var data3 = await SaveAsync(data2);\n  return data3; // Clean, readable\n}',
      'typescript', E'// Callback Hell (bad)\ngetUser(1, (user) => {\n  getOrders(user.id, (orders) => {\n    getOrderDetails(orders[0].id, (details) => {\n      getShipping(details.id, (shipping) => {\n        console.log(shipping); // 4 levels deep!\n      });\n    });\n  });\n});\n\n// Promises (better)\ngetUser(1)\n  .then(user => getOrders(user.id))\n  .then(orders => getOrderDetails(orders[0].id))\n  .then(details => getShipping(details.id))\n  .then(shipping => console.log(shipping))\n  .catch(error => console.error(error));\n\n// Async/await (best)\nasync function processOrder() {\n  try {\n    const user = await getUser(1);\n    const orders = await getOrders(user.id);\n    const details = await getOrderDetails(orders[0].id);\n    const shipping = await getShipping(details.id);\n    console.log(shipping);\n  } catch(error) {\n    console.error(error);\n  }\n}'
    ),
    E'Callback Hell:\nfunc1(data, (result1) => {\n  func2(result1, (result2) => {\n    func3(result2, (result3) => {\n      func4(result3, (result4) => {\n        // Pyramid of Doom!\n      });\n    });\n  });\n});\n\nSolution: Promises/Async-Await',
    151
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Callback is?', to_jsonb(ARRAY['Variable', 'Function passed to execute later', 'Class', 'Loop']), 1, 'Function as argument.'),
    (current_term_id, 'Callback Hell problem?', to_jsonb(ARRAY['Too fast', 'Deeply nested, unreadable code', 'No problem', 'Too slow']), 1, 'Pyramid of doom.'),
    (current_term_id, 'Solution to callback hell?', to_jsonb(ARRAY['More callbacks', 'Promises and async/await', 'Nothing', 'Loops']), 1, 'Flatten async code.'),
    (current_term_id, 'Async/await vs callbacks?', to_jsonb(ARRAY['Same', 'Async/await cleaner, more readable', 'Callbacks better', 'No difference']), 1, 'Syntactic sugar over promises.'),
    (current_term_id, 'Error handling callbacks?', to_jsonb(ARRAY['Automatic', 'Must check in each callback', 'No errors', 'Try-catch']), 1, 'Manual error checking needed.');

  -- DOM Manipulation
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'DOM (Document Object Model)',
    'DOM = tree structure representing HTML. JavaScript can manipulate DOM to change page dynamically.',
    'DOM: API for HTML/XML documents as tree structure. Nodes represent elements, attributes, text. JavaScript can query, create, modify, delete DOM elements.',
    'DOM represents page as tree of objects. document.querySelector() finds elements, .innerHTML/.textContent modify content, .addEventListener() handles events. Modern frameworks abstract DOM manipulation for efficiency (Virtual DOM).',
    to_jsonb(ARRAY['Direct DOM manipulation in React/Angular (use framework methods)', 'Not sanitizing user input (XSS)', 'Memory leaks from event listeners', 'Excessive DOM queries (cache references)', 'innerHTML with untrusted data']),
    jsonb_build_object(
      'csharp', E'// Blazor equivalent (C# components)\n@page "/counter"\n\n<h1>Counter</h1>\n<p>Count: @count</p>\n<button @onclick="Increment">Click me</button>\n\n@code {\n  private int count = 0;\n  \n  private void Increment() {\n    count++;\n    // StateHasChanged() implicit\n  }\n}\n\n// Direct DOM in Blazor (rare)\n@inject IJSRuntime JS\n\nawait JS.InvokeVoidAsync("console.log", "Hello");',
      'typescript', E'// DOM Query\nconst button = document.querySelector(''button'');\nconst heading = document.getElementById(''title'');\nconst items = document.querySelectorAll(''.item'');\n\n// Modify content\nheading.textContent = "New Title";\nheading.innerHTML = "<strong>Bold Title</strong>";\n\n// Modify attributes\nbutton.setAttribute(''disabled'', ''true'');\nbutton.classList.add(''active'');\nbutton.style.color = ''red'';\n\n// Create elements\nconst newDiv = document.createElement(''div'');\nnewDiv.textContent = "Hello";\nnewDiv.className = "box";\ndocument.body.appendChild(newDiv);\n\n// Event listeners\nbutton.addEventListener(''click'', (event) => {\n  console.log(''Clicked!'', event.target);\n});\n\n// Remove element\nconst oldElement = document.getElementById(''old'');\noldElement.remove();\n\n// XSS danger (DON''T DO THIS)\nconst userInput = getUserInput();\nelement.innerHTML = userInput; // UNSAFE!\n\n// Safe way\nelement.textContent = userInput; // Escapes HTML'
    ),
    E'DOM Tree:\ndocument\n  ↓\n<html>\n  ↓\n<body>\n  ↓\n<div id="app">\n  ↓\n<button>Click</button>\n\nJavaScript manipulates this tree',
    152
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'DOM is?', to_jsonb(ARRAY['Database', 'Tree representation of HTML document', 'Server', 'Framework']), 1, 'API for HTML structure.'),
    (current_term_id, 'querySelector returns?', to_jsonb(ARRAY['All elements', 'First matching element', 'Array', 'Nothing']), 1, 'Single element or null.'),
    (current_term_id, 'innerHTML vs textContent?', to_jsonb(ARRAY['Same', 'innerHTML parses HTML, textContent is plain text', 'textContent faster', 'No difference']), 1, 'textContent safer (no XSS).'),
    (current_term_id, 'addEventListener for?', to_jsonb(ARRAY['Create element', 'Handle user events (click, input, etc)', 'Query DOM', 'Remove element']), 1, 'Event handling.'),
    (current_term_id, 'XSS risk with?', to_jsonb(ARRAY['textContent', 'innerHTML with untrusted data', 'querySelector', 'addEventListener']), 1, 'innerHTML can execute scripts.');

  -- Git Comprehensive
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_devops, 'Git Branch, Merge & Pull Request',
    'Branch = separate line of development. Merge = combine branches. Pull Request = propose changes for review before merge.',
    'Branch: pointer to commit, allows parallel work. Merge: integrate changes from one branch to another. Pull Request: code review workflow before merging.',
    'Branches enable parallel work without conflicts. Main/master is stable, create feature branches for work. Merge brings changes together. PR enables code review, discussion, CI checks before merging. Merge conflicts happen when same lines modified.',
    to_jsonb(ARRAY['Working directly on main/master', 'Not pulling before starting work', 'Large long-lived branches', 'Force push to shared branches', 'Not resolving merge conflicts properly']),
    jsonb_build_object(
      'csharp', E'// Git workflow in development\n// Not C# specific, but common in .NET projects\n\n// Feature branch workflow:\n// 1. Start from main\ngit checkout main\ngit pull origin main\n\n// 2. Create feature branch\ngit checkout -b feature/add-user-api\n\n// 3. Work and commit\ngit add .\ngit commit -m "Add user API endpoints"\n\n// 4. Push to remote\ngit push origin feature/add-user-api\n\n// 5. Create Pull Request on GitHub/Azure DevOps\n// - Team reviews code\n// - CI runs tests\n// - Discuss changes\n\n// 6. After approval, merge to main\n// (usually via PR UI)\n\n// 7. Update local main\ngit checkout main\ngit pull origin main\n\n// 8. Delete feature branch\ngit branch -d feature/add-user-api',
      'typescript', E'// Git Commands\n\n// Clone repository\ngit clone https://github.com/user/repo.git\ncd repo\n\n// Check status\ngit status\n\n// Create and switch to branch\ngit checkout -b feature/new-component\n// Or separate commands:\ngit branch feature/new-component\ngit checkout feature/new-component\n\n// Make changes, stage, commit\ngit add src/components/NewComponent.tsx\ngit commit -m "feat: add new component"\n\n// Push to remote\ngit push origin feature/new-component\n\n// Update from main\ngit checkout main\ngit pull origin main\ngit checkout feature/new-component\ngit merge main  // Or: git rebase main\n\n// Resolve merge conflicts\n// 1. Git marks conflicts in files:\n// <<<<<<< HEAD\n// Your changes\n// =======\n// Their changes\n// >>>>>>> main\n// 2. Edit files to resolve\n// 3. Stage resolved files\ngit add resolved-file.tsx\ngit commit -m "Merge main into feature"\n\n// Pull Request flow\n// 1. Push branch: git push origin feature/...\n// 2. Open PR on GitHub\n// 3. Code review\n// 4. Merge via UI\n\n// Common commands\ngit log --oneline        // View history\ngit diff                 // See changes\ngit branch -a            // List all branches\ngit remote -v            // Show remotes'
    ),
    E'Git Branch Flow:\n\nmain: ●——●——●——●——●——●\n           ↓       ↑\nfeature:   ●——●——● (merge)\n           Work  PR approved\n\nPull Request:\n  Developer → Push branch → PR\n  Team → Review → Approve\n  CI → Tests pass → Merge\n\nMerge Conflict:\n  File changed in both branches\n  → Manual resolution needed',
    160
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Git branch purpose?', to_jsonb(ARRAY['Delete code', 'Parallel development without conflicts', 'Backup', 'Nothing']), 1, 'Separate line of work.'),
    (current_term_id, 'Merge does?', to_jsonb(ARRAY['Delete branch', 'Combine changes from branches', 'Create branch', 'Push']), 1, 'Integrate branch changes.'),
    (current_term_id, 'Pull Request for?', to_jsonb(ARRAY['Download', 'Code review before merging', 'Delete', 'Backup']), 1, 'Review and discussion.'),
    (current_term_id, 'Merge conflict when?', to_jsonb(ARRAY['Never', 'Same lines modified in both branches', 'Always', 'On create']), 1, 'Conflicting changes need manual resolution.'),
    (current_term_id, 'Best practice?', to_jsonb(ARRAY['Work on main', 'Feature branches + PR + code review', 'No branches', 'Force push']), 1, 'Structured workflow prevents issues.');

  -- Unit Testing
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_dotnet, 'Unit Testing & Integration Testing',
    'Unit Test = test small piece (function/method) in isolation. Integration Test = test multiple parts working together.',
    'Unit Test: automated test of single unit (method/class) with mocked dependencies. Integration Test: tests multiple units/systems together.',
    'Unit tests fast, isolated, test logic. Mock dependencies with Moq. AAA pattern: Arrange-Act-Assert. Integration tests slower, test real interactions (DB, APIs). Both critical for quality. TDD: write tests first.',
    to_jsonb(ARRAY['Testing implementation not behavior', 'No tests for edge cases', 'Tests depending on each other', 'Not mocking dependencies in unit tests', 'Integration tests without cleanup']),
    jsonb_build_object(
      'csharp', E'// Unit Test with xUnit and Moq\nusing Xunit;\nusing Moq;\n\npublic class OrderServiceTests {\n  [Fact]\n  public async Task CreateOrder_ValidInput_ReturnsOrder() {\n    // Arrange - setup\n    var mockRepo = new Mock<IOrderRepository>();\n    var expectedOrder = new Order { Id = 1, Total = 100 };\n    mockRepo.Setup(r => r.AddAsync(It.IsAny<Order>()))\n            .ReturnsAsync(expectedOrder);\n    \n    var service = new OrderService(mockRepo.Object);\n    \n    // Act - execute\n    var result = await service.CreateOrderAsync(new CreateOrderDto());\n    \n    // Assert - verify\n    Assert.NotNull(result);\n    Assert.Equal(1, result.Id);\n    mockRepo.Verify(r => r.AddAsync(It.IsAny<Order>()), Times.Once);\n  }\n  \n  [Theory]\n  [InlineData(-10)]\n  [InlineData(0)]\n  public void ValidateTotal_InvalidAmount_ThrowsException(decimal amount) {\n    var service = new OrderService(null);\n    Assert.Throws<ArgumentException>(() => \n      service.ValidateTotal(amount));\n  }\n}\n\n// Integration Test\npublic class OrdersIntegrationTests : IClassFixture<WebApplicationFactory<Program>> {\n  private readonly HttpClient _client;\n  \n  public OrdersIntegrationTests(WebApplicationFactory<Program> factory) {\n    _client = factory.CreateClient();\n  }\n  \n  [Fact]\n  public async Task GetOrders_ReturnsSuccessAndOrders() {\n    // Calls real API + database\n    var response = await _client.GetAsync("/api/orders");\n    response.EnsureSuccessStatusCode();\n    var orders = await response.Content.ReadFromJsonAsync<List<Order>>();\n    Assert.NotNull(orders);\n  }\n}',
      'typescript', E'// Unit Test with Jest/Vitest\nimport { describe, it, expect, vi } from ''vitest'';\nimport { OrderService } from ''./order.service'';\n\ndescribe(''OrderService'', () => {\n  it(''createOrder - valid input - returns order'', async () => {\n    // Arrange\n    const mockRepo = {\n      add: vi.fn().mockResolvedValue({ id: 1, total: 100 })\n    };\n    const service = new OrderService(mockRepo);\n    \n    // Act\n    const result = await service.createOrder({ items: [] });\n    \n    // Assert\n    expect(result).toBeDefined();\n    expect(result.id).toBe(1);\n    expect(mockRepo.add).toHaveBeenCalledTimes(1);\n  });\n  \n  it.each([\n    [-10],\n    [0]\n  ])(''validateTotal(%i) throws error'', (amount) => {\n    const service = new OrderService(null);\n    expect(() => service.validateTotal(amount)).toThrow();\n  });\n});\n\n// Integration Test (E2E)\nimport { test, expect } from ''@playwright/test'';\n\ntest(''create order flow'', async ({ page }) => {\n  await page.goto(''http://localhost:3000'');\n  await page.click(''button:has-text("Add to Cart")'');\n  await page.click(''button:has-text("Checkout")'');\n  await expect(page.locator(''.confirmation'')).toBeVisible();\n});'
    ),
    E'Testing Pyramid:\n    /\\    E2E (few, slow)\n   /  \\   \n  /────\\  Integration (some)\n /──────\\ \n/────────\\ Unit (many, fast)\n\nAAA Pattern:\n  Arrange → Setup\n  Act     → Execute\n  Assert  → Verify',
    161
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Unit test scope?', to_jsonb(ARRAY['Entire system', 'Single unit (method/class) isolated', 'Database', 'UI']), 1, 'Small, focused, fast.'),
    (current_term_id, 'Integration test?', to_jsonb(ARRAY['Single unit', 'Multiple components/systems together', 'Only UI', 'Nothing']), 1, 'Tests interactions.'),
    (current_term_id, 'AAA pattern?', to_jsonb(ARRAY['Arrange-Act-Assert', 'Always-Always-Always', 'Abstract-Act-Apply', 'None']), 0, 'Standard test structure.'),
    (current_term_id, 'Mock dependencies for?', to_jsonb(ARRAY['Slow tests', 'Isolate unit under test', 'Nothing', 'Integration only']), 1, 'Control behavior, test in isolation.'),
    (current_term_id, 'Unit vs Integration speed?', to_jsonb(ARRAY['Same', 'Unit fast, Integration slower', 'Integration faster', 'No difference']), 1, 'Unit tests very fast, run frequently.');

  RAISE NOTICE 'Added JavaScript, Git, and Testing terms';
END $$;

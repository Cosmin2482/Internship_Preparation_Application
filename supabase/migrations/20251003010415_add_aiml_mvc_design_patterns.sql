/*
  # Add AI/ML, MVC, Design Patterns
  
  Add: Classification vs Regression, Clustering, LLMs, MVC detailed, Design Patterns
*/

DO $$
DECLARE
  cat_ai uuid;
  cat_arch uuid;
  cat_oop uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_ai FROM categories WHERE slug = 'ai-ml';
  SELECT id INTO cat_arch FROM categories WHERE slug = 'architecture';
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';

  -- Classification vs Regression
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_ai, 'Classification vs Regression',
    'Classification = predict category (cat/dog, spam/not spam). Regression = predict number (price, temperature).',
    'Classification: supervised learning predicting discrete classes. Regression: supervised learning predicting continuous values.',
    'Classification outputs categories (binary or multiclass). Examples: spam detection, image recognition. Regression outputs numbers. Examples: house price prediction, sales forecasting. Both supervised learning requiring labeled training data.',
    to_jsonb(ARRAY['Wrong algorithm for problem type', 'Imbalanced classes in classification', 'Not normalizing features for regression', 'Overfitting on small datasets']),
    jsonb_build_object(
      'csharp', E'// ML.NET Classification\nusing Microsoft.ML;\n\npublic class SpamData {\n  public string Message { get; set; }\n  public bool IsSpam { get; set; } // Binary classification\n}\n\nvar mlContext = new MLContext();\nvar data = mlContext.Data.LoadFromTextFile<SpamData>("spam.csv");\n\n// Classification pipeline\nvar pipeline = mlContext.Transforms.Text\n  .FeaturizeText("Features", nameof(SpamData.Message))\n  .Append(mlContext.BinaryClassification.Trainers\n    .SdcaLogisticRegression());\n\nvar model = pipeline.Fit(data);\n\n// Predict\nvar prediction = model.Transform(testData);\n\n// ML.NET Regression\npublic class HouseData {\n  public float Size { get; set; }\n  public float Price { get; set; } // Continuous value\n}\n\nvar regressionPipeline = mlContext.Regression.Trainers\n  .Sdca(labelColumnName: "Price", maximumNumberOfIterations: 100);',
      'typescript', E'// Classification Example (conceptual)\ninterface Email {\n  text: string;\n  isSpam: boolean; // Category: true/false\n}\n\n// Training data\nconst trainingData: Email[] = [\n  { text: "Win free money!", isSpam: true },\n  { text: "Meeting at 3pm", isSpam: false },\n  // ...\n];\n\n// Model predicts category\nfunction classifyEmail(text: string): boolean {\n  // Returns true (spam) or false (not spam)\n  return model.predict(text);\n}\n\n// Regression Example\ninterface House {\n  size: number;      // Feature\n  bedrooms: number;  // Feature\n  price: number;     // Continuous target\n}\n\n// Training data\nconst houses: House[] = [\n  { size: 1500, bedrooms: 3, price: 300000 },\n  { size: 2000, bedrooms: 4, price: 400000 },\n  // ...\n];\n\n// Model predicts number\nfunction predictPrice(size: number, bedrooms: number): number {\n  // Returns continuous value: $350,000\n  return model.predict(size, bedrooms);\n}'
    ),
    E'Classification vs Regression:\n\nClassification:\n  Input → Model → Category\n  Email → [Model] → Spam/Not Spam\n  Image → [Model] → Cat/Dog/Bird\n  \nRegression:\n  Input → Model → Number\n  House → [Model] → $350,000\n  Data → [Model] → Temperature: 72.5°F\n\nBoth: Supervised Learning',
    50
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Classification predicts?', to_jsonb(ARRAY['Number', 'Category/class', 'Both', 'Nothing']), 1, 'Discrete categories.'),
    (current_term_id, 'Regression predicts?', to_jsonb(ARRAY['Category', 'Continuous numeric value', 'Text', 'Image']), 1, 'Numbers on continuous scale.'),
    (current_term_id, 'Spam detection is?', to_jsonb(ARRAY['Regression', 'Classification (binary)', 'Clustering', 'Nothing']), 1, 'Two categories: spam or not.'),
    (current_term_id, 'House price prediction is?', to_jsonb(ARRAY['Classification', 'Regression', 'Clustering', 'Unsupervised']), 1, 'Continuous value prediction.'),
    (current_term_id, 'Both are?', to_jsonb(ARRAY['Unsupervised', 'Supervised learning with labels', 'Reinforcement', 'Random']), 1, 'Need labeled training data.');

  -- Clustering
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_ai, 'Clustering (Unsupervised Learning)',
    'Clustering = group similar data together without labels. Algorithm finds patterns and creates groups automatically.',
    'Clustering: unsupervised learning grouping similar data points. No labels needed. Common: K-Means, Hierarchical, DBSCAN.',
    'Clustering finds natural groupings in data. K-Means: specify K clusters, algorithm assigns points. Use for customer segmentation, anomaly detection, data exploration. No ground truth labels required.',
    to_jsonb(ARRAY['Wrong number of clusters (K)', 'Not scaling features', 'Expecting perfect clusters in noisy data', 'Using wrong distance metric']),
    jsonb_build_object(
      'csharp', E'// ML.NET K-Means Clustering\nusing Microsoft.ML;\n\npublic class CustomerData {\n  public float Age { get; set; }\n  public float Income { get; set; }\n  public float SpendingScore { get; set; }\n}\n\nvar mlContext = new MLContext();\nvar data = mlContext.Data.LoadFromEnumerable(customers);\n\n// K-Means clustering (3 clusters)\nvar pipeline = mlContext.Transforms\n  .Concatenate("Features", nameof(CustomerData.Age), \n               nameof(CustomerData.Income),\n               nameof(CustomerData.SpendingScore))\n  .Append(mlContext.Clustering.Trainers.KMeans(\n    featureColumnName: "Features",\n    numberOfClusters: 3));\n\nvar model = pipeline.Fit(data);\n\n// Predict cluster\nvar predictions = model.Transform(data);\n// Each customer assigned to cluster 0, 1, or 2',
      'typescript', E'// K-Means Clustering (conceptual)\ninterface Customer {\n  age: number;\n  income: number;\n  spendingScore: number;\n}\n\nconst customers: Customer[] = [\n  { age: 25, income: 40000, spendingScore: 70 },\n  { age: 50, income: 80000, spendingScore: 30 },\n  // ...\n];\n\n// K-Means algorithm\nfunction kMeansClustering(data: Customer[], k: number) {\n  // 1. Randomly initialize K centroids\n  // 2. Assign each point to nearest centroid\n  // 3. Recalculate centroids as mean of assigned points\n  // 4. Repeat until convergence\n  \n  return clusters; // Returns K groups\n}\n\n// Result: customers grouped by similarity\nconst clusters = kMeansClustering(customers, 3);\n// Cluster 0: Young, low income, high spending\n// Cluster 1: Middle age, high income, low spending\n// Cluster 2: Old, medium income, medium spending'
    ),
    E'Clustering (K-Means):\n\nData points:\n  • • •   • • •\n    •       •\n  • • •   • • •\n\nAfter K-Means (K=2):\n  [• • •]  [• • •]\n    [•]      [•]\n  [• • •]  [• • •]\n  Group 1   Group 2\n\nUnsupervised: no labels needed',
    51
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Clustering is?', to_jsonb(ARRAY['Supervised', 'Unsupervised grouping of similar data', 'Classification', 'Regression']), 1, 'No labels, finds patterns.'),
    (current_term_id, 'K-Means K means?', to_jsonb(ARRAY['Features', 'Number of clusters to create', 'Data points', 'Iterations']), 1, 'Specify how many groups.'),
    (current_term_id, 'Clustering uses?', to_jsonb(ARRAY['Labeled data', 'Unlabeled data', 'Only numbers', 'Text only']), 1, 'No ground truth needed.'),
    (current_term_id, 'Use case for clustering?', to_jsonb(ARRAY['Spam detection', 'Customer segmentation, pattern discovery', 'Price prediction', 'Image labeling']), 1, 'Find natural groups.'),
    (current_term_id, 'K-Means assigns?', to_jsonb(ARRAY['Labels', 'Each point to nearest cluster', 'Random', 'Nothing']), 1, 'Based on distance to centroids.');

  -- LLMs
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_ai, 'LLMs & AI Copilots',
    'LLM = Large Language Model (GPT, Gemini) trained on massive text. AI Copilots use LLMs to help write code, debug, explain.',
    'LLM: neural network trained on vast text data for generation, completion, understanding. AI Copilots: tools (GitHub Copilot, Cursor, Bolt) using LLMs for coding assistance.',
    'LLMs like GPT-4 generate human-like text. Trained on internet-scale data. AI copilots use LLMs for code completion, debugging, explanation, boilerplate generation. Prompt engineering key: clear instructions yield better results.',
    to_jsonb(ARRAY['Trusting output blindly (hallucinations)', 'Poor prompts giving bad results', 'Not reviewing generated code', 'Security: exposing secrets to LLM', 'Over-reliance without understanding']),
    jsonb_build_object(
      'csharp', E'// Using AI Copilots for C# development\n\n// GitHub Copilot example:\n// You type comment, Copilot suggests code\n\n// Calculate factorial recursively\npublic int Factorial(int n) {\n  // Copilot suggests:\n  if(n <= 1) return 1;\n  return n * Factorial(n - 1);\n}\n\n// Cursor AI: chat with codebase\n// "Find all API endpoints that don\'t have auth"\n// "Explain this LINQ query"\n// "Refactor this to use async/await"\n\n// Prompt Engineering examples:\n// Bad: "code"\n// Good: "Write a C# method that validates email format using regex"\n\n// Bad: "fix bug"\n// Good: "This method throws NullReferenceException when user is null. Add null check."\n\n// AI tools:\n// - GitHub Copilot: inline suggestions\n// - Cursor: AI-powered IDE\n// - ChatGPT/GPT-4: problem solving\n// - Gemini: Google\'s LLM\n// - Bolt.new: AI web app builder\n// - Lovable.dev: AI full-stack builder',
      'typescript', E'// Prompt Engineering for better results\n\n// Poor prompt:\n// "make function"\n\n// Good prompt:\n// "Create a TypeScript async function that fetches \n//  user data from /api/users/:id, handles errors,\n//  and returns typed User object or null"\n\nasync function fetchUser(id: number): Promise<User | null> {\n  try {\n    const res = await fetch(`/api/users/${id}`);\n    if(!res.ok) return null;\n    return await res.json();\n  } catch(error) {\n    console.error(error);\n    return null;\n  }\n}\n\n// AI Copilot capabilities:\n// ✓ Code completion\n// ✓ Generate boilerplate\n// ✓ Explain complex code\n// ✓ Find bugs\n// ✓ Write tests\n// ✓ Refactor code\n// ✓ Generate documentation\n\n// Limitations:\n// ✗ Can hallucinate (make up facts)\n// ✗ May suggest insecure code\n// ✗ Not always optimal solutions\n// ✗ Needs review by human'
    ),
    E'LLM Flow:\nPrompt → [LLM Model] → Generated Text/Code\n\nAI Copilots:\n  GitHub Copilot\n  Cursor AI\n  ChatGPT/GPT-4\n  Gemini\n  Bolt.new\n  Lovable.dev\n\nPrompt Engineering:\n  Clear + Context = Better Results',
    52
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'LLM is?', to_jsonb(ARRAY['Database', 'Large Language Model for text generation', 'Framework', 'Library']), 1, 'Neural network trained on text.'),
    (current_term_id, 'AI Copilots help with?', to_jsonb(ARRAY['Nothing', 'Code completion, debugging, explanation', 'Only UI', 'Database only']), 1, 'Coding assistance using LLMs.'),
    (current_term_id, 'Prompt engineering?', to_jsonb(ARRAY['Random text', 'Clear instructions for better AI results', 'Database queries', 'API calls']), 1, 'How you ask matters.'),
    (current_term_id, 'LLM hallucination?', to_jsonb(ARRAY['Good feature', 'Model makes up false information', 'Bug fix', 'Speed improvement']), 1, 'Can generate incorrect facts.'),
    (current_term_id, 'Using AI copilots?', to_jsonb(ARRAY['Trust blindly', 'Always review generated code', 'Copy paste everything', 'No need to understand']), 1, 'Human review essential.');

  -- MVC Pattern Detailed
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch, 'MVC (Model-View-Controller)',
    'MVC = design pattern separating concerns. Model=data, View=UI, Controller=logic connecting them.',
    'MVC: architectural pattern. Model: data and business logic. View: presentation/UI. Controller: handles requests, coordinates Model and View.',
    'MVC separates concerns for maintainability. Controller receives request, calls Model for data, selects View for response. Model independent of UI. View displays data from Model. Clear responsibilities, testable, scalable.',
    to_jsonb(ARRAY['Fat controllers with business logic', 'Models with UI logic', 'Views with business logic', 'Tight coupling between layers', 'Not understanding unidirectional flow']),
    jsonb_build_object(
      'csharp', E'// ASP.NET Core MVC\n\n// Model - data and business logic\npublic class Product {\n  public int Id { get; set; }\n  public string Name { get; set; }\n  public decimal Price { get; set; }\n}\n\npublic class ProductService { // Business logic\n  private readonly IProductRepository _repo;\n  \n  public async Task<List<Product>> GetAllAsync() {\n    return await _repo.GetAllAsync();\n  }\n}\n\n// Controller - handles requests\npublic class ProductsController : Controller {\n  private readonly ProductService _service;\n  \n  public ProductsController(ProductService service) {\n    _service = service;\n  }\n  \n  // GET /products\n  public async Task<IActionResult> Index() {\n    var products = await _service.GetAllAsync();\n    return View(products); // Pass to View\n  }\n  \n  // GET /products/5\n  public async Task<IActionResult> Details(int id) {\n    var product = await _service.GetByIdAsync(id);\n    if(product == null) return NotFound();\n    return View(product);\n  }\n}\n\n// View (Razor) - presentation\n@model List<Product>\n<h1>Products</h1>\n<table>\n  @foreach(var product in Model) {\n    <tr>\n      <td>@product.Name</td>\n      <td>@product.Price</td>\n    </tr>\n  }\n</table>',
      'typescript', E'// MVC in TypeScript (conceptual)\n\n// Model\ninterface Product {\n  id: number;\n  name: string;\n  price: number;\n}\n\nclass ProductModel {\n  private products: Product[] = [];\n  \n  async getAll(): Promise<Product[]> {\n    // Business logic, data access\n    return this.products;\n  }\n  \n  async getById(id: number): Promise<Product | null> {\n    return this.products.find(p => p.id === id) || null;\n  }\n}\n\n// Controller\nclass ProductsController {\n  constructor(private model: ProductModel) {}\n  \n  async index(req: Request, res: Response) {\n    const products = await this.model.getAll();\n    res.render(''products/index'', { products }); // View\n  }\n  \n  async details(req: Request, res: Response) {\n    const product = await this.model.getById(req.params.id);\n    if(!product) return res.status(404).send();\n    res.render(''products/details'', { product });\n  }\n}\n\n// View (template)\n// <h1>Products</h1>\n// {{#each products}}\n//   <div>{{name}}: ${{price}}</div>\n// {{/each}}'
    ),
    E'MVC Pattern:\n\n[User Request]\n      ↓\n[Controller]\n   ↓     ↓\n[Model] [View]\n   ↓       ↓\nData    HTML\n   ↓       ↓\n   └───→[Response]\n\nSeparation of Concerns:\n  Model: Business logic\n  View: Presentation\n  Controller: Coordination',
    70
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Model responsibility?', to_jsonb(ARRAY['UI', 'Data and business logic', 'HTTP requests', 'Nothing']), 1, 'Data layer.'),
    (current_term_id, 'View responsibility?', to_jsonb(ARRAY['Business logic', 'Presentation/UI only', 'Database', 'Everything']), 1, 'Display data, no logic.'),
    (current_term_id, 'Controller responsibility?', to_jsonb(ARRAY['UI design', 'Handle requests, coordinate Model/View', 'Database queries', 'CSS']), 1, 'Orchestration layer.'),
    (current_term_id, 'MVC benefit?', to_jsonb(ARRAY['Slower', 'Separation of concerns, testable', 'More code', 'Complicated']), 1, 'Clean architecture.'),
    (current_term_id, 'Fat controller?', to_jsonb(ARRAY['Good practice', 'Anti-pattern: too much logic in controller', 'Required', 'Fast']), 1, 'Move logic to services/models.');

  -- Design Patterns: Singleton
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_oop, 'Design Patterns: Singleton, Factory, Observer',
    'Singleton=one instance only. Factory=creates objects without "new". Observer=notify objects when something changes.',
    'Design Patterns: reusable solutions to common problems. Singleton: ensure single instance. Factory: encapsulate object creation. Observer: publish-subscribe for loose coupling.',
    'Singleton for global shared resource (logger, config). Factory for flexible object creation. Observer for event-driven systems. Patterns improve maintainability, but can be overused.',
    to_jsonb(ARRAY['Overusing patterns (YAGNI)', 'Singleton global state issues', 'Not thread-safe Singleton', 'Factory over-engineering', 'Observer memory leaks from unsubscribed']),
    jsonb_build_object(
      'csharp', E'// Singleton Pattern\npublic sealed class Logger {\n  private static Logger _instance;\n  private static readonly object _lock = new object();\n  \n  private Logger() { } // Private constructor\n  \n  public static Logger Instance {\n    get {\n      if(_instance == null) {\n        lock(_lock) { // Thread-safe\n          if(_instance == null) {\n            _instance = new Logger();\n          }\n        }\n      }\n      return _instance;\n    }\n  }\n  \n  public void Log(string message) {\n    Console.WriteLine($"[LOG] {message}");\n  }\n}\n// Usage: Logger.Instance.Log("Hello");\n\n// Factory Pattern\npublic interface IVehicle { void Drive(); }\n\npublic class Car : IVehicle {\n  public void Drive() => Console.WriteLine("Car driving");\n}\n\npublic class Bike : IVehicle {\n  public void Drive() => Console.WriteLine("Bike riding");\n}\n\npublic class VehicleFactory {\n  public static IVehicle Create(string type) {\n    return type switch {\n      "car" => new Car(),\n      "bike" => new Bike(),\n      _ => throw new ArgumentException()\n    };\n  }\n}\n// Usage: var vehicle = VehicleFactory.Create("car");\n\n// Observer Pattern\npublic class EventBus {\n  private List<Action<string>> _subscribers = new();\n  \n  public void Subscribe(Action<string> handler) {\n    _subscribers.Add(handler);\n  }\n  \n  public void Publish(string message) {\n    foreach(var handler in _subscribers) {\n      handler(message);\n    }\n  }\n}\n// Usage:\nvar bus = new EventBus();\nbus.Subscribe(msg => Console.WriteLine($"A: {msg}"));\nbus.Subscribe(msg => Console.WriteLine($"B: {msg}"));\nbus.Publish("Event!"); // Both subscribers notified',
      'typescript', E'// Singleton\nclass Logger {\n  private static instance: Logger;\n  \n  private constructor() {} // Private\n  \n  static getInstance(): Logger {\n    if(!Logger.instance) {\n      Logger.instance = new Logger();\n    }\n    return Logger.instance;\n  }\n  \n  log(message: string): void {\n    console.log(`[LOG] ${message}`);\n  }\n}\n// Usage: Logger.getInstance().log("Hello");\n\n// Factory\ninterface Vehicle {\n  drive(): void;\n}\n\nclass Car implements Vehicle {\n  drive() { console.log("Car driving"); }\n}\n\nclass Bike implements Vehicle {\n  drive() { console.log("Bike riding"); }\n}\n\nclass VehicleFactory {\n  static create(type: string): Vehicle {\n    if(type === "car") return new Car();\n    if(type === "bike") return new Bike();\n    throw new Error("Unknown type");\n  }\n}\n\n// Observer\nclass EventBus {\n  private subscribers: ((msg: string) => void)[] = [];\n  \n  subscribe(handler: (msg: string) => void): void {\n    this.subscribers.push(handler);\n  }\n  \n  publish(message: string): void {\n    this.subscribers.forEach(h => h(message));\n  }\n}\n\nconst bus = new EventBus();\nbus.subscribe(msg => console.log(`A: ${msg}`));\nbus.publish("Event!");'
    ),
    E'Design Patterns:\n\nSingleton:\n  [Logger.Instance] ← only one\n  Global access point\n\nFactory:\n  type → [Factory] → Object\n  Encapsulates creation\n\nObserver:\n  [Publisher]\n       ↓\n  [Subscribers] all notified\n  Loose coupling',
    124
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Singleton ensures?', to_jsonb(ARRAY['Many instances', 'Only one instance exists', 'No instances', 'Two instances']), 1, 'Global single instance.'),
    (current_term_id, 'Factory pattern for?', to_jsonb(ARRAY['Singleton', 'Encapsulate object creation', 'Destroy objects', 'Nothing']), 1, 'Flexible instantiation.'),
    (current_term_id, 'Observer pattern?', to_jsonb(ARRAY['Database', 'Publish-subscribe for events', 'Singleton', 'Factory']), 1, 'Notify multiple objects of changes.'),
    (current_term_id, 'Singleton constructor?', to_jsonb(ARRAY['Public', 'Private to prevent external instantiation', 'Protected', 'Static']), 1, 'Only class can create instance.'),
    (current_term_id, 'When use patterns?', to_jsonb(ARRAY['Always', 'When solving common recurring problems', 'Never', 'Random']), 1, 'Don''t over-engineer, use when needed.');

  RAISE NOTICE 'Added AI/ML, MVC, and Design Patterns';
END $$;

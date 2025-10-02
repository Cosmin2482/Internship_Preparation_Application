/*
  # Romanian Terms - Comprehensive Batch
  
  Add essential terms for .NET, SQL, HTTP, Data Structures, Algorithms, Agile in Romanian
*/

DO $$
DECLARE
  cat_romanian uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_romanian FROM categories WHERE slug = 'romanian';

  -- ASP.NET Core
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'ASP.NET Core și Controller',
    'ASP.NET Core = framework pentru web APIs. Controller = clasă care primește requesturi HTTP și returnează răspunsuri.',
    'ASP.NET Core = platform cross-platform pentru aplicații web. Controller = clasă care gestionează requesturi și răspunsuri HTTP cu metode (actions).',
    'Controller primește requesturi pe rute specifice, procesează datele, apelează servicii, returnează răspunsuri (JSON, HTML). [ApiController] oferă convenții automate (validare, binding).',
    to_jsonb(ARRAY['Logică de business în controller', 'Nu folosești async', 'Status codes greșite', 'Nu folosești [ApiController]']),
    jsonb_build_object(
      'csharp', E'[ApiController]\n[Route("api/[controller]")]\npublic class AngajatiController : ControllerBase {\n  private readonly IAngajatService _service;\n  \n  public AngajatiController(IAngajatService service) {\n    _service = service;\n  }\n  \n  // GET /api/angajati\n  [HttpGet]\n  public async Task<ActionResult<List<Angajat>>> GetToti() {\n    var angajati = await _service.GetToateAsync();\n    return Ok(angajati);\n  }\n  \n  // GET /api/angajati/5\n  [HttpGet("{id}")]\n  public async Task<ActionResult<Angajat>> Get(int id) {\n    var angajat = await _service.GetByIdAsync(id);\n    if(angajat == null) return NotFound();\n    return Ok(angajat);\n  }\n  \n  // POST /api/angajati\n  [HttpPost]\n  public async Task<ActionResult<Angajat>> Create(CreateAngajatDto dto) {\n    var angajat = await _service.CreateAsync(dto);\n    return CreatedAtAction(nameof(Get), new { id = angajat.Id }, angajat);\n  }\n}',
      'typescript', E'// Express echivalent\nimport express from ''express'';\n\nconst app = express();\napp.use(express.json());\n\n// GET /api/angajati\napp.get(''/api/angajati'', async (req, res) => {\n  const angajati = await service.getAll();\n  res.json(angajati);\n});\n\n// GET /api/angajati/:id\napp.get(''/api/angajati/:id'', async (req, res) => {\n  const angajat = await service.getById(req.params.id);\n  if(!angajat) return res.status(404).json({ error: ''Not found'' });\n  res.json(angajat);\n});\n\n// POST /api/angajati\napp.post(''/api/angajati'', async (req, res) => {\n  const angajat = await service.create(req.body);\n  res.status(201).json(angajat);\n});'
    ),
    E'ASP.NET Flow:\nHTTP Request → Routing → Controller → Service → Repository → Database',
    210
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Ce e Controller?', to_jsonb(ARRAY['Database', 'Clasă pentru requesturi HTTP', 'UI', 'Testing']), 1, 'Gestionează HTTP.'),
    (current_term_id, '[ApiController] oferă?', to_jsonb(ARRAY['Nimic', 'Validare automată, binding', 'Securitate', 'Database']), 1, 'Convenții API.'),
    (current_term_id, 'Controller ar trebui să conțină?', to_jsonb(ARRAY['Business logic', 'Doar handling request/response', 'SQL queries', 'HTML']), 1, 'Thin controller.'),
    (current_term_id, 'GET vs POST?', to_jsonb(ARRAY['Același lucru', 'GET citește, POST creează', 'POST citește', 'Nu există diferență']), 1, 'HTTP verbs.'),
    (current_term_id, 'Status code pentru creare?', to_jsonb(ARRAY['200', '201 Created', '404', '500']), 1, 'POST success.');

  -- Dependency Injection
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'Dependency Injection (DI)',
    'Nu creezi obiectele manual cu "new", le primești "injectate" din exterior. Loose coupling și testabilitate.',
    'DI = pattern unde dependențele sunt furnizate (injectate) în loc să fie create intern. ASP.NET Core are DI built-in.',
    'În loc de "new Service()", primești serviciul prin constructor. Avantaje: testabil (mock), loose coupling, configurare centralizată. Registered în Program.cs cu AddScoped/AddSingleton/AddTransient.',
    to_jsonb(ARRAY['Nu înțelegi lifetime-uri (Scoped/Singleton/Transient)', 'Circular dependencies', 'Service locator anti-pattern', 'Nu folosești interfețe']),
    jsonb_build_object(
      'csharp', E'// Program.cs - Înregistrare servicii\nbuilder.Services.AddScoped<IAngajatService, AngajatService>();\nbuilder.Services.AddScoped<IAngajatRepository, AngajatRepository>();\nbuilder.Services.AddDbContext<AppDbContext>();\n\n// Lifetime-uri:\n// Transient: instanță nouă la fiecare cerere\n// Scoped: o instanță per request HTTP\n// Singleton: o singură instanță pentru toată aplicația\n\n// Controller - Injectare prin constructor\npublic class AngajatiController : ControllerBase {\n  private readonly IAngajatService _service;\n  private readonly ILogger<AngajatiController> _logger;\n  \n  // DI injectează automat\n  public AngajatiController(\n    IAngajatService service,\n    ILogger<AngajatiController> logger) {\n    _service = service; // Nu faci "new"!\n    _logger = logger;\n  }\n  \n  [HttpGet]\n  public async Task<IActionResult> Get() {\n    _logger.LogInformation("Getting angajati");\n    var angajati = await _service.GetToateAsync();\n    return Ok(angajati);\n  }\n}\n\n// Service\npublic class AngajatService : IAngajatService {\n  private readonly IAngajatRepository _repo;\n  \n  public AngajatService(IAngajatRepository repo) {\n    _repo = repo; // Injectat!\n  }\n}',
      'typescript', E'// DI în TypeScript (manual sau cu framework)\nclass AngajatService {\n  constructor(private repo: IAngajatRepository) {\n    // Repo injectat, nu creezi cu new\n  }\n  \n  async getAll(): Promise<Angajat[]> {\n    return this.repo.getAll();\n  }\n}\n\n// Angular DI (built-in)\n@Injectable({ providedIn: ''root'' })\nexport class AngajatService {\n  constructor(\n    private http: HttpClient,\n    private logger: LoggerService\n  ) { } // Angular injectează automat\n}'
    ),
    E'Dependency Injection:\n[Controller]\n    ↓ injectează\n[IService] ← interfață\n    ↓ implementare\n[Service]\n    ↓ injectează\n[IRepository]\n\nBeneficii:\n- Testabil (mock)\n- Loose coupling\n- Configurare centralizată',
    211
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Ce e DI?', to_jsonb(ARRAY['Design pattern', 'Dependențe injectate, nu create', 'Database', 'Framework']), 1, 'Furnizare dependențe.'),
    (current_term_id, 'Avantaj DI?', to_jsonb(ARRAY['Mai rapid', 'Testabilitate și loose coupling', 'Mai puțin cod', 'Nimic']), 1, 'Easy mock pentru teste.'),
    (current_term_id, 'Scoped lifetime?', to_jsonb(ARRAY['O instanță forever', 'O instanță per HTTP request', 'Nouă la fiecare injectare', 'Nu există']), 1, 'Per request în web apps.'),
    (current_term_id, 'Singleton lifetime?', to_jsonb(ARRAY['Nouă mereu', 'O singură instanță global', 'Per request', 'Per controller']), 1, 'Shared global.'),
    (current_term_id, 'Unde înregistrezi servicii?', to_jsonb(ARRAY['Controller', 'Program.cs (Startup)', 'Database', 'HTML']), 1, 'DI container setup.');

  -- SQL SELECT & JOIN
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'SQL: SELECT și JOIN',
    'SELECT = extrage date din tabel. JOIN = combină date din mai multe tabele legate prin chei.',
    'SELECT = interogare pentru citire. JOIN = combine rows from multiple tables. INNER JOIN = doar matching, LEFT JOIN = toate din stânga + match.',
    'SELECT cu WHERE filtrează. JOIN-uri leagă tabele prin Foreign Key. INNER JOIN = intersecție. LEFT JOIN = tot din stânga chiar dacă nu e match. Use pentru rapoarte cu date din multiple tabele.',
    to_jsonb(ARRAY['SELECT * (inefficient)', 'JOIN fără ON condition', 'Confuzie INNER vs LEFT', 'N+1 query problem', 'Nu folosești alias-uri']),
    jsonb_build_object(
      'csharp', E'// Entity Framework LINQ (echivalent SQL)\nvar query = from a in context.Angajati\n            join d in context.Departamente\n              on a.DepartamentId equals d.Id\n            where a.Varsta > 25\n            select new {\n              Nume = a.Nume,\n              Departament = d.Nume,\n              Salariu = a.Salariu\n            };\n\nvar result = await query.ToListAsync();\n\n// Sau cu metode\nvar result2 = await context.Angajati\n  .Where(a => a.Varsta > 25)\n  .Join(context.Departamente,\n    a => a.DepartamentId,\n    d => d.Id,\n    (a, d) => new {\n      Nume = a.Nume,\n      Departament = d.Nume\n    })\n  .ToListAsync();',
      'typescript', E'-- SELECT simplu\nSELECT nume, varsta, salariu\nFROM angajati\nWHERE varsta > 25;\n\n-- INNER JOIN (doar matching)\nSELECT a.nume, a.salariu, d.nume AS departament\nFROM angajati a\nINNER JOIN departamente d ON a.departament_id = d.id\nWHERE a.varsta > 25;\n\n-- LEFT JOIN (toți din stânga)\nSELECT a.nume, d.nume AS departament\nFROM angajati a\nLEFT JOIN departamente d ON a.departament_id = d.id;\n-- Include și angajați fără departament\n\n-- GROUP BY\nSELECT d.nume, COUNT(*) as nr_angajati, AVG(a.salariu) as salariu_mediu\nFROM angajati a\nJOIN departamente d ON a.departament_id = d.id\nGROUP BY d.nume\nHAVING COUNT(*) > 5;'
    ),
    E'SQL JOINs:\nINNER JOIN:\n  A ∩ B (doar match)\n\nLEFT JOIN:\n  A + match din B\n  (toate din A)\n\nangajati JOIN departamente\n  ON angajat.dept_id = dept.id',
    215
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'SELECT face?', to_jsonb(ARRAY['Șterge', 'Extrage date', 'Inserează', 'Actualizează']), 1, 'Query pentru citire.'),
    (current_term_id, 'INNER JOIN returnează?', to_jsonb(ARRAY['Tot', 'Doar rânduri cu match', 'Prima tabelă', 'Nimic']), 1, 'Intersecție.'),
    (current_term_id, 'LEFT JOIN include?', to_jsonb(ARRAY['Doar match', 'Tot din stânga + match din dreapta', 'Tot din dreapta', 'Nimic']), 1, 'Toate din left table.'),
    (current_term_id, 'GROUP BY pentru?', to_jsonb(ARRAY['Filtrare', 'Agregare (COUNT, SUM, AVG)', 'Sortare', 'Join']), 1, 'Grupare și calcule.'),
    (current_term_id, 'PRIMARY KEY e?', to_jsonb(ARRAY['Optional', 'Identificator unic per rând', 'Foreign key', 'Index']), 1, 'Unique identifier.');

  -- HTTP & REST
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'HTTP Methods și Status Codes',
    'HTTP Methods = verbe pentru acțiuni (GET=citește, POST=creează). Status Codes = răspuns numeric (200=OK, 404=Not Found).',
    'HTTP Methods: GET (retrieve), POST (create), PUT (replace), PATCH (partial update), DELETE (remove). Status: 2xx success, 4xx client error, 5xx server error.',
    'GET safe & idempotent. POST creează, non-idempotent. PUT replace complet, idempotent. DELETE idempotent. Status codes: 200 OK, 201 Created, 400 Bad Request, 401 Unauthorized, 404 Not Found, 500 Internal Error.',
    to_jsonb(ARRAY['GET pentru modificări', 'Status codes greșite', 'Nu înțelegi idempotență', 'POST vs PUT confuzie']),
    jsonb_build_object(
      'csharp', E'[ApiController]\n[Route("api/produse")]\npublic class ProduseController : ControllerBase {\n  // GET /api/produse - 200 OK\n  [HttpGet]\n  public IActionResult GetTot() => Ok(produse);\n  \n  // GET /api/produse/5 - 200 OK sau 404 Not Found\n  [HttpGet("{id}")]\n  public IActionResult Get(int id) {\n    var produs = produse.Find(p => p.Id == id);\n    if(produs == null) return NotFound();\n    return Ok(produs);\n  }\n  \n  // POST /api/produse - 201 Created\n  [HttpPost]\n  public IActionResult Create(Produs produs) {\n    produse.Add(produs);\n    return CreatedAtAction(nameof(Get), new { id = produs.Id }, produs);\n  }\n  \n  // PUT /api/produse/5 - 204 No Content\n  [HttpPut("{id}")]\n  public IActionResult Update(int id, Produs produs) {\n    return NoContent();\n  }\n  \n  // DELETE /api/produse/5 - 204 No Content\n  [HttpDelete("{id}")]\n  public IActionResult Delete(int id) {\n    return NoContent();\n  }\n}',
      'typescript', E'// HTTP Status Codes\n// 2xx Success\n200 OK          // Request successful\n201 Created     // Resource created (POST)\n204 No Content  // Success, no body (DELETE, PUT)\n\n// 3xx Redirect\n301 Moved Permanently\n302 Found (temporary redirect)\n\n// 4xx Client Error\n400 Bad Request      // Invalid data\n401 Unauthorized     // Not authenticated\n403 Forbidden        // Not authorized\n404 Not Found        // Resource nu există\n\n// 5xx Server Error\n500 Internal Server Error\n503 Service Unavailable'
    ),
    E'HTTP Methods:\nGET    /users     → Citește (200)\nPOST   /users     → Creează (201)\nPUT    /users/5   → Replace (204)\nPATCH  /users/5   → Update parțial (204)\nDELETE /users/5   → Șterge (204)\n\nIdempotent: același rezultat dacă repeți',
    220
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'GET method pentru?', to_jsonb(ARRAY['Create', 'Retrieve/citire', 'Delete', 'Update']), 1, 'Safe și idempotent.'),
    (current_term_id, 'POST e idempotent?', to_jsonb(ARRAY['Da', 'Nu, creează de fiecare dată', 'Uneori', 'Depinde']), 1, 'Fiecare POST = resursă nouă.'),
    (current_term_id, '404 înseamnă?', to_jsonb(ARRAY['Success', 'OK', 'Not Found', 'Server error']), 2, 'Resursa nu există.'),
    (current_term_id, '201 pentru?', to_jsonb(ARRAY['OK', 'Created (POST success)', 'Error', 'Redirect']), 1, 'Resursă creată cu succes.'),
    (current_term_id, '500 e?', to_jsonb(ARRAY['Client error', 'Server error (bug)', 'Success', 'Not found']), 1, 'Internal server error.');

  -- Data Structures compacte
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'Structuri de Date: Array, Stack, Queue, Hash Table',
    'Array=listă fixă. Stack=LIFO (ultimul intrat, primul ieșit). Queue=FIFO (primul intrat, primul ieșit). Hash Table=cheie-valoare rapid.',
    'Array: acces O(1) prin index. Stack: push/pop O(1), LIFO. Queue: enqueue/dequeue O(1), FIFO. Hash Table: lookup O(1) amortizat prin hashing.',
    'Array pentru date indexate. Stack pentru undo/back. Queue pentru task queue. Hash Table pentru lookup rapid prin chei. Alege bazat pe pattern de acces: random=array, LIFO=stack, FIFO=queue, key-based=hash.',
    to_jsonb(ARRAY['Array fix când ai nevoie dinamic', 'Stack overflow', 'Queue fără limite', 'Hash collisions negestionate']),
    jsonb_build_object(
      'csharp', E'// Array\nint[] numere = {1, 2, 3, 4, 5};\nConsole.WriteLine(numere[2]); // O(1) acces\n\n// Stack (LIFO)\nvar stack = new Stack<int>();\nstack.Push(1); // Adaugă\nstack.Push(2);\nint top = stack.Pop(); // Scoate ultimul (2)\nint peek = stack.Peek(); // Privește fără să scoți (1)\n\n// Queue (FIFO)\nvar queue = new Queue<int>();\nqueue.Enqueue(1); // Adaugă la coadă\nqueue.Enqueue(2);\nint first = queue.Dequeue(); // Scoate primul (1)\n\n// Dictionary (Hash Table)\nvar dict = new Dictionary<string, int>();\ndict["Ion"] = 100;\ndict["Maria"] = 200;\nint scor = dict["Ion"]; // O(1) lookup\nbool exists = dict.ContainsKey("Ion");',
      'typescript', E'// Array\nconst numere = [1, 2, 3, 4, 5];\nconsole.log(numere[2]); // O(1)\n\n// Stack (cu array)\nconst stack: number[] = [];\nstack.push(1); // LIFO\nstack.push(2);\nconst top = stack.pop(); // 2\n\n// Queue (cu array - inefficient)\nconst queue: number[] = [];\nqueue.push(1); // FIFO\nqueue.push(2);\nconst first = queue.shift(); // O(n)!\n\n// Map (Hash Table)\nconst map = new Map<string, number>();\nmap.set("Ion", 100);\nmap.set("Maria", 200);\nconst scor = map.get("Ion"); // O(1)\nconst exists = map.has("Ion");'
    ),
    E'Structuri de Date:\nArray: [1][2][3][4] → acces O(1)\nStack: [1,2,3] push→ [1,2,3,4] pop→ [1,2,3] (LIFO)\nQueue: [1,2,3] enqueue→ [1,2,3,4] dequeue→ [2,3,4] (FIFO)\nHash: {"Ion":100, "Maria":200} → O(1) lookup',
    225
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Stack e?', to_jsonb(ARRAY['FIFO', 'LIFO - Last In First Out', 'Random access', 'Hash']), 1, 'Ultimul intrat, primul ieșit.'),
    (current_term_id, 'Queue e?', to_jsonb(ARRAY['LIFO', 'FIFO - First In First Out', 'Random', 'Stack']), 1, 'Primul intrat, primul ieșit.'),
    (current_term_id, 'Hash Table complexitate lookup?', to_jsonb(ARRAY['O(n)', 'O(1) amortizat', 'O(log n)', 'O(n²)']), 1, 'Very fast key-based access.'),
    (current_term_id, 'Array acces prin index?', to_jsonb(ARRAY['O(n)', 'O(1)', 'O(log n)', 'O(n²)']), 1, 'Direct memory access.'),
    (current_term_id, 'Use case Stack?', to_jsonb(ARRAY['Database', 'Undo feature, back button', 'Sorting', 'Search']), 1, 'LIFO pattern - undo/browser history.');

  -- Agile/Scrum
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'Agile și Scrum Basics',
    'Agile=dezvoltare iterativă, flexibilă. Scrum=framework Agile cu sprinturi, daily standups, retrospective.',
    'Agile: filozofie iterativă, livrare incrementală. Scrum: roluri (PO, SM, Dev Team), evenimente (Sprint Planning, Daily, Review, Retro), artifacts (Backlog, Sprint Backlog, Increment).',
    'Sprint=2-3 săptămâni, echipa committed la tasks. Daily standup 15 min: ce-am făcut, ce fac, blockers. Sprint Review=demo. Retrospective=ce îmbunătățim. Product Owner prioritizează backlog.',
    to_jsonb(ARRAY['Standup devine status report lung', 'Skip retro', 'Overcommit în sprint', 'PO indisponibil', 'Nu înțelegi Definition of Done']),
    jsonb_build_object(
      'csharp', E'// Scrum Events (nu e cod, e proces)\n\n// Sprint Planning (2-4h)\n// - PO prezintă backlog prioritizat\n// - Team alege stories pentru sprint\n// - Definește Sprint Goal\n\n// Daily Standup (15 min, aceeași oră)\n// - Ce am făcut ieri?\n// - Ce fac azi?\n// - Blockers?\n\n// Sprint Review (1-2h)\n// - Demo working software\n// - Feedback stakeholders\n\n// Retrospective (1h)\n// - Ce a mers bine?\n// - Ce îmbunătățim?\n// - Action items\n\n// User Story format:\n// "Ca [rol], vreau [feature], pentru a [beneficiu]"\n// Exemplu:\n// "Ca utilizator, vreau să resetez parola,\n//  pentru a-mi recăpăta accesul dacă o uit"\n\n// Definition of Done:\n// - Cod complet\n// - Unit tests >80%\n// - Code review aprobat\n// - Integration tests pass\n// - Documentation actualizată\n// - Deployed pe staging\n// - PO acceptat',
      'typescript', E'// Scrum Roles\n\n// Product Owner:\n// - Prioritizează backlog\n// - Define features\n// - Accept/reject work\n// - Disponibil pentru întrebări\n\n// Scrum Master:\n// - Facilitează ceremonii\n// - Elimină blockers\n// - Coach echipa\n// - Protejează echipa de interruptions\n\n// Dev Team:\n// - Self-organizing\n// - Cross-functional\n// - Estimează și committed la work\n// - Livrează increment\n\n// Sprint Flow:\n// Planning → Daily Standups → Review → Retro\n//    ↓           (15 min)        ↓       ↓\n// Sprint Goal                  Demo   Improve\n//    ↓\n// Sprint Backlog → Working Increment'
    ),
    E'Scrum Sprint (2 săptămâni):\n┌─────────────────────────┐\n│ Sprint Planning         │ Start\n├─────────────────────────┤\n│ Daily Standup (×10)     │ Zilnic 15min\n├─────────────────────────┤\n│ Development Work        │ Coding\n├─────────────────────────┤\n│ Sprint Review           │ Demo\n├─────────────────────────┤\n│ Retrospective           │ Improve\n└─────────────────────────┘ End\n   → Next Sprint',
    230
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Sprint típic durează?', to_jsonb(ARRAY['1 zi', '2-3 săptămâni', '6 luni', '1 an']), 1, 'Ciclu iterativ scurt.'),
    (current_term_id, 'Daily standup durată?', to_jsonb(ARRAY['5 min', '15 minute', '1 oră', '2 ore']), 1, 'Sync rapid, nu status report lung.'),
    (current_term_id, 'Product Owner face?', to_jsonb(ARRAY['Coding', 'Prioritizează backlog, definește features', 'Testing', 'Deploy']), 1, 'Ce se construiește.'),
    (current_term_id, 'Retrospective pentru?', to_jsonb(ARRAY['Demo', 'Echipa reflectă și îmbunătățește procesul', 'Planning', 'Coding']), 1, 'Continuous improvement.'),
    (current_term_id, 'Definition of Done include?', to_jsonb(ARRAY['Doar cod', 'Cod + teste + review + deployed', 'Planning', 'Nimic']), 1, 'Criteria pentru "gata".');

  RAISE NOTICE 'Added comprehensive Romanian terms batch';
END $$;

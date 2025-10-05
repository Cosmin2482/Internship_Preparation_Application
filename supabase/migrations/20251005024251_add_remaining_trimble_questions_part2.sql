/*
  # Add Remaining Trimble Interview Questions - Part 2

  This migration adds the remaining questions from the comprehensive Trimble interview guide,
  including more coding challenges, technical questions, and practical scenarios.
*/

INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
-- More Technical Questions
(
  'Cum ai implementa o aplicație mică de to-do list (arhitectură și tehnologii)?',
  'Arhitectură Full-Stack: Frontend (React/Angular): 1) Components: TodoList (listă), TodoItem (item individual), TodoForm (adăugare). 2) State management: useState/Context API sau Redux. 3) API calls: fetch/axios către backend. Backend (.NET): 1) API RESTful: GET /api/todos (listă), POST /api/todos (create), PUT /api/todos/:id (update), DELETE /api/todos/:id (delete). 2) DbContext + EF Core pentru baza de date. 3) DTO-uri pentru validare. Database: SQL (tabela todos: id, title, completed, created_at). Deployment: Frontend pe Netlify/Vercel, Backend pe Azure App Service, DB pe Azure SQL. Features: CRUD complet, marcare completat/incomplet, filtrare (All/Active/Completed), persistență în DB.',
  'Coding Challenges',
  'hard',
  275
),
(
  'Ce e mai important: codul perfect sau codul livrat la timp?',
  'Răspuns echilibrat (evită extremele): "Depinde de context, dar în general: CODUL FUNCȚIONAL LIVRAT LA TIMP, cu calitate acceptabilă. Raționament: 1) Perfect code nu există - poți optimiza la infinit. 2) Shipping e o skill - codul nelivrat = valoare 0 pentru client. 3) Feedback real > speculații (livrezi MVP, primești feedback, iterezi). DAR: 1) Nu sacrific securitatea (SQL injection, XSS - NICIODATĂ compromise). 2) Nu sacrific testabilitatea critică (bug-uri în producție costă mult mai mult). 3) Refactoring se face continuu (technical debt controlat). Best practice: 80/20 rule - 80% corect rapid, 20% polish ulterior. În interviu arată că înțelegi tradeoff-urile și că poți lua decizii pragmatice."',
  'Coding Challenges',
  'medium',
  276
),
(
  'Dacă un coleg îți zice că e sigur că ai greșit, dar tu crezi că ai dreptate, ce faci?',
  'Abordare matură și profesională: 1) Ascult cu minte deschisă: "Poate chiar am greșit - ego-ul nu ajută." 2) Cer detalii: "Arată-mi exact unde crezi că e problema." 3) Verific împreună: Rulăm codul, verificăm outputul, căutăm documentația. 4) Dacă eu am dreptate: Explic calm cu argumente/date, nu defensiv. "Uite aici în documentație scrie X." 5) Dacă el are dreptate: Recunosc, mulțumesc, corectez. "Ai dreptate, mersi că ai observat!" 6) Dacă e neclar: Propun să întrebăm un al treilea (senior, documentație oficială). NU: Nu devin defensiv, nu ridic tonul, nu transform în conflict personal. Obiectivul e codul corect, nu câștigatul unei dispute. Acest răspuns arată maturitate și colaborare.',
  'Coding Challenges',
  'medium',
  277
),
(
  'Cum ai testa o aplicație care calculează prețul biletelor la metrou?',
  'Gândire de QA/Testing: Cazuri de test: 1) Happy path: Input valid (2 stații, distanță normală) → Output preț corect. 2) Edge cases: - Distanță 0 (aceeași stație) → preț minim sau eroare. - Distanță maximă (capăt la capăt) → preț maxim corect. - 1 stație → preț minim. 3) Invalid inputs: - Stații inexistente → eroare clară. - Input NULL → nu crash, returnează eroare. - Text în loc de număr → validare. 4) Business logic: - Reduceri (student, pensionar) → preț calculat corect. - Zone tarifate diferit → verificare corectă. 5) Performance: 1000 cereri/secundă → nu degradare. 6) Integrare: Dacă folosește API extern (date despre stații) → mock API în teste. Abordare: Unit tests (logica de calcul), Integration tests (cu DB real de stații), E2E tests (UI → backend → DB).',
  'Coding Challenges',
  'hard',
  278
),
(
  'Ce te-ar face să alegi să rămâi la Trimble după internship?',
  'Factori de decizie (arată că ai gândit): 1) Învățare continuă: "Dacă simt că învăț constant, lucrez cu mentori buni și tehnologii moderne." 2) Impact: "Dacă văd că contribuțiile mele ajung în producție și au impact real (feedback de la users)." 3) Cultură: "Dacă echipa e colaborativă, suportivă și mă simt inclus - nu micromanagement sau cultură toxică." 4) Oportunitate de creștere: "Dacă există un plan clar de dezvoltare (junior → mid → senior) și nu stagnez." 5) Work-life balance: "Dacă pot performa la maxim fără burn-out (deadlines realiste, respect pentru timp liber)." 6) Proiecte interesante: "Dacă lucrez la features challenging, nu doar bug-uri plictisitoare." Concluzie: "În esență, dacă după 6 luni de internship simt că Trimble investește în mine și eu pot crește aici, aș vrea să rămân long-term."',
  'Trimble Specific',
  'medium',
  279
),
(
  'Ce înseamnă Machine Learning și cum diferă de programarea tradițională?',
  'Diferențe fundamentale: Programare tradițională: Scrii REGULI explicite. Ex: if (temp > 30) { print("Cald"); }. Tu defineși logica, pas cu pas. Machine Learning: Algoritmul ÎNVAȚĂ REGULILE din date. Dai exemple (input + output corect), și modelul învață pattern-urile. Ex: Dai 10,000 imagini de pisici etichetate "pisică", modelul învață să recunoască pisici noi. Când se folosește: Programare clasică: Logică clară, reguli fixe (calculatoare, CRUD apps). ML: Pattern-uri complexe, date masive, reguli greu de codificat explicit (recunoaștere imagini, recomandări Netflix, spam detection). Exemplu: Spam filter - clasic: if (contains "viagra") spam → prea simplu. ML: învață din 100k emails ce pattern-uri indică spam (cuvinte, structură, expeditor).',
  'AI & ML',
  'medium',
  280
),
(
  'Ce e un model de clasificare în ML?',
  'Clasificare = task-ul de a atribui o categorie (clasă) unui input. Binary classification: 2 clase (Ex: Email e spam SAU not spam). Multi-class: 3+ clase (Ex: Imagine e pisică/câine/pasăre). Cum funcționează: 1) Training: Modelul învață din date etichetate (input + label corect). 2) Prediction: Dată o nouă imagine, modelul spune "pisică" cu 95% probabilitate. Algoritmi comuni: Logistic Regression, Decision Trees, Random Forest, Neural Networks. Evaluare: Accuracy (% correct predictions), Precision, Recall, F1-Score. Exemplu real: Trimble ar putea folosi clasificare pentru a categoriza automat tipuri de materiale în modele BIM (oțel/beton/lemn) bazat pe proprietăți.',
  'AI & ML',
  'medium',
  281
),
(
  'Ce e un dataset în contextul ML?',
  'Dataset = colecția de date folosită pentru antrenarea și testarea unui model ML. Structură: Rows (samples/examples) x Columns (features). Ex: Dataset de case: Rows = 10,000 case. Columns = suprafață, nr camere, locație, preț (target). Tipuri: 1) Training set (70-80%): Pe asta învaț modelul. 2) Validation set (10-15%): Pentru tuning hyperparametri. 3) Test set (10-15%): Pentru evaluare finală (date COMPLET nevăzute). Features = variabilele input (suprafață, camere). Target/Label = ce vrei să prezici (preț). Calitatea dataset-ului e CRITICĂ: "Garbage in, garbage out." Dataset mic/biased → model prost. Best practice: Date diverse, reprezentative, curate (fără duplicates/NULL-uri excesive).',
  'AI & ML',
  'medium',
  282
),
(
  'Ce e data mining și cum se folosește?',
  'Data Mining = procesul de descoperire a pattern-urilor, corelațiilor și insight-urilor ascunse în seturi mari de date. Diferență față de ML: Data Mining e EXPLORATORIU (descoperi ce e în date), ML e PREDICTIV (construiești model să prezici). Tehnici: 1) Association rules (Market Basket Analysis): "Clienții care cumpără bere cumpără și chips în 70% din cazuri." 2) Clustering (grupare): Segmentare clienți în categorii (premium, casual, bargain hunters). 3) Anomaly detection: Detectare fraude (tranzacții neobișnuite). 4) Pattern recognition: Descoperire trends (vânzări cresc vinerea). Tools: SQL queries, Python (pandas, scikit-learn), Tableau. Exemplu Trimble: Analiza proiectelor BIM pentru a descoperi ce materiale sunt cel mai des folosite împreună (optimizare supply chain).',
  'AI & ML',
  'medium',
  283
),
(
  'Cum ai structura un mic API de login (arhitectură și securitate)?',
  'Arhitectură Backend: 1) POST /api/auth/register: Body: { email, password }. Hash password (bcrypt/Argon2), salvează în DB (tabela users: id, email, password_hash). 2) POST /api/auth/login: Body: { email, password }. Verifică email există, compară hash. Dacă valid, generează JWT token (include user_id, role în claims, expiră în 1h). Returnează token. 3) Protecție endpoints: GET /api/profile - verifică JWT în Authorization header. Decode, validează signature, verifică expirare. Dacă valid, execută request. Securitate: 1) HTTPS mandatory. 2) Rate limiting (previne brute force: max 5 login attempts/min). 3) Hash passwords (NICIODATĂ plain text). 4) JWT secret strong (256-bit random). 5) Token expiration (1h access token + refresh token). 6) Validare input (email format, password strength). 7) SQL parametrizat (previne injection).',
  'Security',
  'hard',
  284
),
(
  'Ce sunt endpoints în contextul unui API?',
  'Endpoint = URL specific care expune o funcționalitate a API-ului. Format: HTTP Method + Path. Exemplu RESTful API pentru users: 1) GET /api/users - Returnează lista tuturor users (sau paginat). 2) GET /api/users/123 - Returnează detalii despre user-ul cu id=123. 3) POST /api/users - Creează un user nou (body: { name, email }). 4) PUT /api/users/123 - Actualizează complet user 123. 5) PATCH /api/users/123 - Actualizează parțial user 123. 6) DELETE /api/users/123 - Șterge user 123. Fiecare endpoint are: Input (params, query, body), Processing (business logic), Output (response + status code). Best practice: Endpoints consistente, predictibile, documentate (Swagger/OpenAPI).',
  'Client-Server & HTTP',
  'easy',
  285
),
(
  'Ce este JSON și cum se folosește în API-uri?',
  'JSON (JavaScript Object Notation) = format lightweight de schimb de date, ușor de citit de oameni și mașini. Structură: 1) Objects: { "key": "value" }. 2) Arrays: [ "item1", "item2" ]. 3) Types: string, number, boolean, null, object, array. Exemplu: { "id": 123, "name": "George", "active": true, "skills": ["C#", "React"] }. Folosire în API-uri: Request body (POST/PUT): Client trimite JSON cu date. Content-Type: application/json. Response body: Server răspunde cu JSON. Avantaje: 1) Ușor de parse (native în JS). 2) Mai compact decât XML. 3) Suport universal (toate limbajele). Alternative: XML (mai verbose), Protocol Buffers (binary, mai rapid dar mai puțin human-readable).',
  'Client-Server & HTTP',
  'easy',
  286
),
(
  'Ce e .gitignore și la ce se folosește?',
  '.gitignore = fișier special în repository-ul Git care specifică ce fișiere/foldere să fie IGNORATE (nu trackuite, nu commituite). Folosire: 1) Fișiere generate (build artifacts): bin/, obj/, dist/, node_modules/. 2) Fișiere locale (IDE settings): .vscode/, .idea/, *.suo. 3) Secrete: .env (API keys, connection strings). 4) Fișiere temporare: *.log, *.tmp. 5) Dependințe (node_modules/ - se reinstalează cu npm install). Format: # comentariu, *.log (toate .log files), /temp (folder temp în root), !important.log (excepție). Beneficii: 1) Repo mai curat, mai mic. 2) Previne commit accidental de secrete. 3) Evită conflicte pe fișiere generate diferit pe fiecare mașină. Template: GitHub oferă template-uri .gitignore pentru fiecare limbaj.',
  'Git',
  'easy',
  287
),
(
  'Ai folosit vreodată GitHub pentru colaborare? Cum?',
  'Răspuns personalizat (adaptează): "Da, am colaborat pe GitHub în [context: proiecte facultate / contribuții open-source / proiecte personale în echipă]. Workflow: 1) Fork/Clone repository. 2) Creez branch pentru feature: git checkout -b feature/add-login. 3) Fac commit-uri cu mesaje clare: git commit -m feat: add login form. 4) Push branch: git push origin feature/add-login. 5) Deschid Pull Request pe GitHub cu descriere clară (ce schimbă, de ce, screenshot-uri). 6) Colegi fac code review - comentează, cer schimbări. 7) Aplic feedback-ul, commit, push (PR-ul se updatează automat). 8) După aprobare + tests pass, facem merge în main. 9) Delete branch. Tools: GitHub Issues pentru bug tracking, Projects pentru organizare, Actions pentru CI/CD."',
  'Git',
  'medium',
  288
),
(
  'Ce ai folosi pentru a monitoriza o aplicație în producție?',
  'Monitoring Stack: 1) Application Performance Monitoring (APM): Azure Application Insights (pentru Trimble - .NET + Azure). Monitorizează: response times, error rates, dependencies (DB, API calls). 2) Logging: Centralizat (ex: Serilog + Azure Log Analytics sau ELK Stack). Log: errors, warnings, important events. 3) Metrics: CPU, memory, disk usage (Azure Monitor). Alerte când threshold-uri sunt depășite. 4) Uptime monitoring: Ping aplicația la interval (ex: UptimeRobot) - alertă dacă e down. 5) User analytics (optional): Comportament users (Google Analytics, Mixpanel). Alerting: Slack/Email când error rate > 5% sau response time > 2s. Dashboard: Grafana sau Azure dashboards pentru vizualizare real-time. Scop: Detectare probleme ÎNAINTE ca userii să se plângă.',
  'Cloud',
  'medium',
  289
),
(
  'Ce e un version control system și de ce e important?',
  'Version Control System (VCS) = sistem care trackuiește schimbările în cod de-a lungul timpului. Exemplu: Git (distribuit), SVN (centralizat). Beneficii: 1) Istoric complet: Poți vedea cine a schimbat ce și când (git log, git blame). 2) Revert changes: Dacă un commit introduce bug, poți face rollback (git revert). 3) Branching: Lucrezi pe features izolat, fără a afecta main branch. 4) Colaborare: Mai mulți devs lucrează simultan fără să-și suprascrie codul. 5) Backup: Codul e pe server remote (GitHub, Azure Repos) - dacă laptopul moare, codul e safe. 6) Code review: Pull Requests permit revizuire înainte de merge. 7) CI/CD integration: Automat trigger build/deploy la commit. Fără VCS = HAOS (copiezi cod pe USB, "final_v2_FINAL.zip", pierderi de cod).',
  'Git',
  'easy',
  290
),
(
  'Ce diferență e între Angular și React?',
  'Angular: Framework COMPLET (batteries included). Opinionated (structură clară). TypeScript by default. Two-way data binding ([(ngModel)]). Dependency Injection built-in. RxJS pentru async (Observables). Curba de învățare: Steep (multe concepte). Ideal pentru: Enterprise apps mari, echipe mari. React: Library pentru UI (mai minimalist). Unopinionated (tu alegi structura). JavaScript + JSX (sau TypeScript). One-way data flow (props down, events up). State management extern (Redux, Context). Hooks pentru state și lifecycle. Curba de învățare: Gentilă la început. Ideal pentru: Apps de orice mărime, flexibilitate. Similitudini: Ambele component-based, virtual DOM (React) / change detection (Angular), folosite în producție la scară mare. La Trimble: Ambele sunt menționate în job description, deci fie vei învăța pe cea pe care nu o știi.',
  'Diferențe Tehnice',
  'medium',
  291
),
(
  'Ce e DOM virtual în React?',
  'Virtual DOM = reprezentare lightweight în memorie a DOM-ului real. Concept: 1) React ține o copie a DOM-ului în JavaScript (Virtual DOM). 2) Când state-ul se schimbă, React: - Recreează Virtual DOM-ul cu noua stare. - Compară (diffing) cu Virtual DOM-ul vechi. - Calculează ce EXACT s-a schimbat (minimal set of changes). - Updatează doar acele părți în Real DOM (reconciliation). Beneficiu: Manipularea Real DOM-ului e LENTĂ (browser reflow/repaint). Virtual DOM face bulk updates eficiente, evitând updates inutile. Exemplu: Dacă ai o listă de 1000 items și schimbi text-ul unuia, React updatează doar acel item în Real DOM, nu toată lista. Rezultat: Performanță mult mai bună decât manipulare directă DOM (ex: jQuery).',
  'React',
  'medium',
  292
);

-- Add more Interview Tips as special entries
INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
(
  'SFAT: Cum să te pregătești cu o zi înainte de interviu?',
  'Checklist final (24h înainte): 1) TEHNICĂ: Reia fundamentele - OOP (4 piloni), SQL (JOINs), async/await, HTTP methods, status codes. 2) CODING: Rezolvă 2-3 probleme simple (FizzBuzz, Two Sum, Palindrome) ca să-ți încălzești mintea. 3) COMPORTAMENTAL: Pregătește 3 povești STAR (proiect de care ești mândru, situație dificilă, eșec + învățare). 4) COMPANIE: Recitește despre Trimble (produse BIM, valori, tehnologii). 5) ÎNTREBĂRI: Pregătește 3-5 întrebări inteligente pentru intervievator (vezi lista din ghid). 6) LOGISTICĂ: Verifică link Zoom/Teams, testează camera/microfonul, alege loc liniștit. 7) ODIHNĂ: Culcă-te la timp (7-8h somn), mănâncă bine. 8) MINDSET: Respiră, ai încredere - ești pregătit! 9) BACKUP: Ai la îndemână: CV-ul, notițe cu proiecte, sticlă de apă.',
  'Trimble Specific',
  'easy',
  293
),
(
  'SFAT: Ce întrebări să pui intervievatorului la sfârșitul interviului?',
  'Întrebări BUNE (arată interes și research): 1) "Cu ce tehnologii voi lucra zi de zi în echipă?" (arată că vrei detalii concrete). 2) "Cum structurează echipa sprinturile Scrum? Care e lungimea unui sprint?" (arată cunoștințe Agile). 3) "Cum arată o zi tipică pentru un intern în echipa voastră?" (realistic expectations). 4) "Ce concepte BIM voi învăța? Există training dedicat?" (curiozitate pentru domeniul lor). 5) "Cum sprijină Trimble învățarea și dezvoltarea internilor? (mentorat, cursuri?)" (arată că vrei să crești). 6) "Care sunt așteptările pentru intern după primele 3 luni?" (goal-oriented). 7) "Ce calități au internii care au reușit să fie angajați full-time?" (arată ambiție). EVITĂ: "Câți bani câștig?" (prea devreme), "Când e interviul final?" (nerăbdare), "Nu am întrebări" (dezinteres).',
  'Trimble Specific',
  'easy',
  294
),
(
  'SFAT: Termeni-cheie să îi folosești natural în interviu (buzzwords eficiente)',
  'Termeni tehnici de menționat natural (nu forțat): 1) BIM (Building Information Modeling) - "Sunt fascinat de cum BIM transformă industria construcțiilor." 2) Sprint - "În proiectele anterioare am lucrat în sprinturi de 2 săptămâni." 3) User Story - "Am învățat să scriu user stories clare cu acceptance criteria." 4) Azure - "Sunt entuziasmat să învăț Azure în profunzime pentru cloud deployment." 5) CI/CD - "Înțeleg importanța pipeline-urilor CI/CD pentru livrare rapidă și sigură." 6) Pull Request - "Sunt confortabil cu workflow-ul de PR și code review." 7) Dependency Injection - "Am folosit DI în Angular pentru services." 8) Async/Await - "Am experiență cu programare asincronă în C#." 9) REST API - "Am construit API-uri RESTful pentru proiectele mele." 10) Retrospective - "Apreciez valoarea retrospectivelor pentru îmbunătățire continuă." IMPORTANT: Folosește-i doar dacă ÎNȚELEGI conceptul, nu ca papagal!',
  'Trimble Specific',
  'easy',
  295
),
(
  'SFAT: Boostere finale de încredere înainte de interviu',
  'Mentalitate câștigătoare: 1) "Știu MAI MULT decât cred" - Aplicația ta de studiu acoperă 90% din subiectele tehnice posibile. 2) "E OK să nu știu totul" - E un INTERNSHIP, nu rol senior. Se așteaptă să te învețe. Onestitatea ("Nu știu X, dar sunt entuziasmat să învăț") e mai bună decât fake-uirea. 3) "Entuziasmul > Cunoștințe perfecte" - Angajatorii caută atitudine, curiozitate, fit cultural, nu roboți care știu totul. 4) "Pune întrebări" - Arată implicare, nu teamă. "Puteți să clarificați X?" e semn de inteligență. 5) "Fii tu însuți" - Autenticitatea bate scriptul memorat. 6) "Eșecul nu e finalul" - Dacă nu merge acum, e lecție pentru următorul interviu. 7) "Respiră" - Înainte de răspuns, ia 2 secunde să gândești. E OK să faci pauză. TU POȚI! Ai muncit pentru asta. Arată-le pasiunea ta! 💪🚀',
  'Trimble Specific',
  'easy',
  296
);

COMMIT;

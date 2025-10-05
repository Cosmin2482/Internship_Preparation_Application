/*
  # Add Comprehensive Trimble Interview Guide

  1. New Categories for Questions:
    - **Trimble Specific** - Questions about company, motivation, BIM
    - **Technical General** - General technical questions
    - **Diferențe Tehnice** - "What's the difference between X and Y" questions
    - **Client-Server & HTTP** - Architecture and HTTP questions
    - **Coding Challenges** - Practical coding questions
    - **AI & Productivity** - AI-assisted coding questions

  2. New Questions Added:
    - 50+ new behavioral questions
    - 40+ new technical questions
    - 30+ comparison questions
    - Interview tips and strategies

  3. Security
    - All questions follow existing RLS policies
*/

-- Add new Trimble-specific interview questions
INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
-- Trimble Specific Questions
(
  'Spune-mi câteva lucruri despre tine.',
  'Răspuns structurat: 1) Prezentare scurtă (nume, anul de studiu). 2) Pasiune pentru tehnologie (ex: "Sunt pasionat de a construi aplicații care rezolvă probleme reale"). 3) Experiență relevantă (proiecte, cursuri, joburi anterioare). 4) De ce Trimble (conectează pasiunea ta cu munca lor în BIM/construcții). Exemplu: "Sunt student în anul X la Informatică, pasionat de development full-stack. Am experiență cu C#, .NET și React din proiecte personale și job-uri anterioare. Mă atrage Trimble pentru că combinați tehnologia cu impact real în industria construcțiilor, și vreau să contribui la produse care ajută inginerii să lucreze mai eficient."',
  'Trimble Specific',
  'easy',
  200
),
(
  'De ce ai aplicat la Trimble?',
  'Răspuns personalizat și sincer: 1) Impact real - "Vreau să lucrez la produse care au impact tangibil în construcții și inginerie, nu doar cod abstract". 2) Tehnologie diversă - "Stack-ul vostru (C#, Angular, Azure, BIM) combină perfect backend puternic cu frontend modern". 3) Învățare - "Programul de internship oferă rotație între echipe și mentorat, perfect pentru dezvoltarea mea". 4) Cultură - "Valorile Trimble - inovație, colaborare, continuous learning - rezonează cu mine". Nu spune doar "pentru bani" sau "pentru experiență" - arată că ai cercetat compania!',
  'Trimble Specific',
  'medium',
  201
),
(
  'Ce știi despre Trimble și produsele lor?',
  'Răspuns documentat: "Trimble este lider global în tehnologie pentru construcții, agricultură, transport și geospațial. În BIM & Engineering, dezvoltați software pentru arhitecți și ingineri să vizualizeze și să colaboreze pe proiecte 3D (Building Information Modeling). Produse precum Tekla (pentru structuri din oțel și beton) și SketchUp (modelare 3D) sunt folosite de profesioniști din întreaga lume. Ceea ce mă impresionează e integrarea între hardware (stații totale, scanere laser) și software pentru fluxuri complete de lucru în construcții." Arată că ai cercetat produsele lor, nu doar pagina de carieră!',
  'Trimble Specific',
  'medium',
  202
),
(
  'Ce te-a atras la acest internship?',
  'Combinație de factori: 1) Program structurat - "Rotația între echipe îmi permite să învăț multiple aspecte ale development-ului". 2) Tehnologii moderne - "Lucrul cu Azure, CI/CD și Agile practices în producție". 3) Impact - "Să contribui la produse folosite de milioane de ingineri". 4) Cultură de învățare - "Mentorat, code reviews și feedback constant". 5) Oportunitate post-internship - "Posibilitatea de a fi angajat full-time după performanță bună". Fii specific, nu generic!',
  'Trimble Specific',
  'easy',
  203
),
(
  'Cum te vezi peste 2-3 ani?',
  'Răspuns ambițios dar realist: "În 2-3 ani vreau să fiu un dezvoltator mid-level solid, cu experiență hands-on în development full-stack. Specific, vreau să: 1) Stăpânesc backend (.NET, Azure, baze de date) și frontend (React/Angular). 2) Contribui independent la features complexe, nu doar bug-uri. 3) Mentorez juniori/interns. 4) Înțeleg și contribui la decizii de arhitectură. 5) Cunosc industria construcțiilor și cum tehnologia o transformă. Ideal, aș vrea să continui la Trimble dacă internship-ul merge bine, crescând de la intern la junior, apoi mid." Arată că ai un plan, nu doar "să văd ce-o fi".',
  'Trimble Specific',
  'medium',
  204
),
(
  'Care sunt punctele tale forte?',
  'Alege 2-3 strengths RELEVANTE pentru job și dă EXEMPLE: 1) "Învăț rapid - am învățat C# și .NET în 3 luni pentru un proiect, construind un API REST funcțional". 2) "Rezolvare de probleme - când aplicația mea avea memory leaks, am folosit profiling tools și am identificat problema în 2 zile". 3) "Colaborare - în echipă, comunic deschis, cer feedback și ajut colegii blocați". NU spune: "Sunt perfecționist" (red flag), "Lucrez bine sub presiune" (clișeu fără dovadă). ÎNTOTDEAUNA dă exemple concrete!',
  'Trimble Specific',
  'medium',
  205
),
(
  'Care sunt punctele tale slabe și cum lucrezi la ele?',
  'Alege o slăbiciune REALĂ dar NON-CRITICĂ și arată cum lucrezi la ea: Exemplu bun: "Uneori îmi ia timp să cer ajutor când sunt blocat - tind să încerc singur prea mult. Am învățat să-mi setez o limită: dacă după 2 ore nu progresez, întreb un coleg sau mentor. Recent, asta mi-a salvat 4 ore pe un bug de SQL." Exemplu slab: "Sunt prea perfecționist" (clișeu), "Lucrez prea mult" (insincer). STRUCTURĂ: 1) Recunoaște slăbiciunea. 2) Arată awareness. 3) Explică ce faci activ să o îmbunătățești.',
  'Trimble Specific',
  'medium',
  206
),
(
  'Povestește-mi o situație în care ai lucrat în echipă și ai avut o neînțelegere.',
  'Folosește metoda STAR: Situation: "În proiectul de la facultate, eu voiam să folosim React, colegul meu insista pe Angular." Task: "Trebuia să decidem rapid ca să nu pierdem timp." Action: "Am propus: hai să facem un POC (Proof of Concept) mic în ambele framework-uri (2 zile fiecare) și să comparăm: complexitate, learning curve, performanță. Am prezentat apoi pro/contra obiectiv echipei." Result: "Am ales Angular pentru că se potrivea mai bine cu experiența echipei. Colegul a apreciat că am luat decizia pe bază de date, nu emoții. Proiectul a fost livrat la timp." Învățăminte: "Am învățat că dezacordurile tehnice se rezolvă cu date și comunicare, nu cu orgoliu."',
  'Trimble Specific',
  'hard',
  207
),
(
  'Cum reacționezi când nu știi ceva tehnic?',
  'Proces structurat: 1) "Recunosc onest că nu știu (nu inventez)". 2) "Caut documentația oficială sau tutoriale verificate". 3) "Încerc un exemplu mic/POC izolat ca să înțeleg conceptul". 4) "Dacă după 1-2 ore sunt blocat, întreb un coleg/mentor cu întrebări specifice, nu vagi". 5) "Documentez ce am învățat pentru referință viitoare". Exemplu: "Când am trebuit să învăț async/await în C#, am citit documentația Microsoft, am scris un program mic cu API calls, și când nu înțelegeam Task.WhenAll, am întrebat pe un forum. Acum folosesc async natural în proiecte."',
  'Trimble Specific',
  'medium',
  208
),
(
  'Cum te motivezi când ai o sarcină plictisitoare?',
  'Răspuns matur: 1) "Înțeleg că sarcinile plictisitoare (ex: bug fixing, documentație) fac parte din job și sunt necesare pentru calitatea produsului". 2) "Îmi setez mini-obiective - ex: rezolv 3 bug-uri până la pauză, apoi reward". 3) "Găsesc provocări în ele - ex: cât de rapid pot fixa un bug, sau pot automatiza taskul plictisitor?". 4) "Alternez cu sarcini interesante când e posibil". 5) "Mă gândesc la impactul final - un bug fix înseamnă un user fericit". Nu spune: "Nu am sarcini plictisitoare" (nesinceritate) sau "Amân până nu mai pot" (red flag).',
  'Trimble Specific',
  'medium',
  209
),
(
  'Dă-mi un exemplu de proiect personal sau universitar de care ești mândru.',
  'Structură STAR detaliată: 1) Context: "Am construit o aplicație full-stack de movie database". 2) Challenge: "Trebuia să integrez un API extern (TMDB), să gestionez autentificarea și să optimizez performanța pentru 1000+ filme". 3) Acțiuni concrete: "Backend: C# + .NET + EF Core. Frontend: React + TypeScript. Am implementat caching pentru API calls, JWT auth și testare cu xUnit". 4) Rezultat: "Aplicația rulează smooth, timpul de încărcare sub 2 secunde, deploy pe Azure". 5) Ce am învățat: "Am învățat despre rate limiting, error handling în API-uri externe și importance of caching". Fii SPECIFIC cu tehnologii și cifre!',
  'Trimble Specific',
  'medium',
  210
),
(
  'Ce știi despre BIM (Building Information Modeling)?',
  'Răspuns pentru intern (nu trebuie expert): "BIM înseamnă Building Information Modeling - crearea de modele 3D digitale ale clădirilor care conțin nu doar geometrie, ci și date despre materiale, costuri, programare. E folosit de arhitecți, ingineri și constructori pentru a vizualiza, simula și colabora pe proiecte înaintea construcției fizice. Formate comune: IFC, RVT (Revit), DWG. Trimble are produse precum Tekla pentru structuri și SketchUp pentru modelare 3D. Sunt entuziasmat să învăț cum se integrează software-ul cu procesele reale din construcții - combinația dintre 3D graphics, baze de date și colaborare e fascinantă!" Arată curiozitate, nu expertiză!',
  'Trimble Specific',
  'medium',
  211
),
(
  'Cum te simți să lucrezi într-un mediu internațional, cu colegi din SUA, Germania etc.?',
  'Răspuns pozitiv și motivat: "Sunt entuziasmat de asta! Lucrul cu echipe internaționale aduce perspective diverse și best practices din diferite culturi de development. Am experiență cu comunicare în engleză din [cursuri online / colaborări GitHub / etc.]. Înțeleg că poate însemna flexibility în program pentru meeting-uri în timezone-uri diferite, și sunt deschis la asta. De asemenea, văd asta ca pe o oportunitate de a învăța cum se lucrează în companii globale și de a-mi îmbunătăți abilitățile de comunicare cross-cultural. Sunt confortabil cu async communication (Slack, emails) și sync meetings (Zoom, Teams)."',
  'Trimble Specific',
  'easy',
  212
);

-- Technical General Questions (C++, C#, OOP)
INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
(
  'Ce diferență este între C și C++?',
  'C este un limbaj procedural (funcții, structuri, pointeri). C++ e o extensie Object-Oriented a lui C, adăugând: 1) Clase și obiecte (OOP). 2) Inheritance și Polymorphism. 3) Templates (generics). 4) Exception handling (try-catch). 5) STL (Standard Template Library - vector, map, etc.). 6) Namespaces. 7) Function overloading. C e mai rapid și mai low-level (kernel development, embedded systems). C++ oferă abstracție mai înaltă (game engines, aplicații desktop, software complex). Ambele compilează la machine code și folosesc pointeri, dar C++ e mai expresiv și mai safe (RAII, smart pointers).',
  'Technical General',
  'medium',
  213
),
(
  'Ce e un pointer? Ce e un reference în C++?',
  'Pointer: Variabilă care stochează adresa de memorie a altei variabile. Se folosește cu * și & (ex: int* ptr = &x). Poți face pointer arithmetic (ptr++), poți avea NULL pointers, și poți realoca. Reference: Alias (prenume) pentru o variabilă existentă. Se declară cu & (ex: int& ref = x). Odată inițializat, nu poate fi reasignat (întotdeauna referă aceeași variabilă). Nu poate fi NULL. Diferențe: Pointer e flexibil dar periculos (memory leaks, segfaults). Reference e safe dar rigid. Reference se folosește des pentru parametri de funcție (evită copii).',
  'Technical General',
  'medium',
  214
),
(
  'Ce e un constructor? Dar un destructor?',
  'Constructor: Metodă specială care se apelează automat când creezi un obiect. Inițializează starea obiectului. Nume = numele clasei, fără tip de return. Ex (C++): class Car { public: Car(string color) { this->color = color; } }. Destructor: Metodă specială care se apelează automat când obiectul e distrus (iese din scope sau e deleted). Eliberează resurse (memory, file handles, connections). Nume = ~NumeClasă(). Ex: ~Car() { delete[] buffer; }. În C++, destructorul e CRITIC pentru memory management. În C#/Java, ai Garbage Collector, deci destructorul e mai rar necesar.',
  'Technical General',
  'medium',
  215
),
(
  'Cum se gestionează memoria în C++?',
  'Manual memory management: 1) new - alocă pe heap (ex: int* p = new int(5)). 2) delete - eliberează (ex: delete p). 3) new[] și delete[] pentru array-uri. 4) Stack vs Heap: variabilele locale sunt pe stack (auto-cleanup), obiectele dinamice pe heap (trebuie delete manual). 5) Memory leaks: dacă uiți delete, memoria rămâne alocată forever. 6) Smart Pointers (C++11+): unique_ptr, shared_ptr - eliberează automat memoria (RAII pattern). 7) Valgrind/AddressSanitizer - tools pentru detectarea leaks. Best practice: Folosește smart pointers, evită raw pointers când e posibil.',
  'Technical General',
  'hard',
  216
),
(
  'Ce diferență e între let, const și var în JavaScript?',
  'var: (vechi, evită-l) Function-scoped, poate fi redeclarat, hoisted (mutat sus). const: Block-scoped, nu poate fi reasignat (dar obiectele pot fi mutate). Trebuie inițializat la declarare. let: Block-scoped, poate fi reasignat, nu poate fi redeclarat în același scope. Best practice: Folosește const by default (imutabilitate), let când trebuie reasignare, NICIODATĂ var. Exemplu: const API_URL = "..." (nu se schimbă). let counter = 0; counter++ (se schimbă).',
  'Technical General',
  'easy',
  217
),
(
  'Ce e o promisiune (Promise) în JavaScript?',
  'Promise este un obiect care reprezintă rezultatul viitor al unei operații asincrone. Are 3 stări: 1) Pending (în așteptare). 2) Fulfilled (rezolvată cu succes - .then()). 3) Rejected (eșuată - .catch()). Exemplu: fetch(url).then(response => response.json()).then(data => console.log(data)).catch(error => console.error(error)). Promise-urile rezolvă "callback hell" (iad de callback-uri imbricate) și permit chaining. Modern, folosim async/await care e syntax sugar peste Promises.',
  'Technical General',
  'medium',
  218
),
(
  'Ce e TypeScript și care e diferența față de JavaScript?',
  'TypeScript = JavaScript + Type System. Adaugă: 1) Tipuri statice (string, number, boolean, custom types). 2) Interfaces pentru contracte. 3) Generics. 4) Enums. 5) Type checking la compile-time (prinde errori înainte de runtime). TypeScript se compilează la JavaScript (transpilează). Avantaje: Cod mai sigur, autocomplete mai bun, refactoring mai ușor, documentație în cod. Dezavantaj: Overhead de configurare. Exemplu: function add(a: number, b: number): number { return a + b; } - TypeScript garantează că primești numbers, nu strings.',
  'Technical General',
  'medium',
  219
),
(
  'Ce sunt interfaces în TypeScript?',
  'Interface = contract care definește structura unui obiect (ce proprietăți și metode trebuie să aibă). NU conține implementare, doar semnături. Exemplu: interface User { id: number; name: string; email: string; }. O clasă sau obiect poate implementa interfața: class Admin implements User { ... }. Beneficii: Type safety, documentație clară, permet schimbarea implementării fără a afecta codul client. Diferență față de Type: Interface se poate extinde (extend), Type e mai flexibil pentru union types.',
  'Technical General',
  'medium',
  220
),
(
  'Ce e DOM-ul și cum îl manipulăm?',
  'DOM (Document Object Model) = reprezentarea arbore a paginii HTML în memorie, creată de browser. Fiecare element HTML devine un nod în arbore. Manipulare: JavaScript poate accesa și modifica DOM-ul: 1) document.getElementById("myDiv") - selectează element. 2) element.innerHTML = "text" - schimbă conținut. 3) element.style.color = "red" - schimbă stil. 4) document.createElement("div") - creează element nou. 5) parent.appendChild(child) - adaugă element. Framework-uri (React, Angular) abstractizează manipularea directă a DOM-ului folosind Virtual DOM sau change detection.',
  'Technical General',
  'medium',
  221
),
(
  'Ce e o funcție pură (pure function)?',
  'Funcție pură = funcție care: 1) Returnează același output pentru același input (deterministic). 2) NU are side effects (nu modifică starea externă, nu face API calls, nu scrie în console, etc.). Exemplu pur: function add(a, b) { return a + b; }. Exemplu impur: let counter = 0; function increment() { counter++; return counter; } (modifică starea externă). Beneficii: Ușor de testat, predictibil, ușor de cache-uit (memoization). Programarea funcțională (FP) se bazează pe funcții pure.',
  'Technical General',
  'medium',
  222
),
(
  'Ce e un closure în JavaScript?',
  'Closure = funcție care "capturează" variabilele din scope-ul în care a fost definită, chiar dacă acel scope nu mai există. Exemplu: function outer() { let count = 0; return function inner() { count++; return count; }; } const increment = outer(); increment(); // 1, increment(); // 2. Funcția inner are acces la count chiar după ce outer() s-a terminat. Folosit pentru: encapsulare (private variables), factory functions, callbacks.',
  'Technical General',
  'hard',
  223
);

-- Angular Specific Questions
INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
(
  'Ce e un component în Angular?',
  'Component = blocul fundamental de UI în Angular. Combină: 1) Template (HTML) - ce se afișează. 2) Class (TypeScript) - logica. 3) Styles (CSS/SCSS) - cum arată. 4) Metadata (@Component decorator) - selector, template, styles. Exemplu: @Component({ selector: "app-user", templateUrl: "./user.component.html" }) export class UserComponent { name = "George"; }. Component-urile sunt reutilizabile și pot fi imbricate (component tree). Fiecare component e o clasă TypeScript decorată cu @Component.',
  'Angular',
  'easy',
  224
),
(
  'Cum se face data binding în Angular?',
  'Angular oferă 4 tipuri de data binding: 1) Interpolation: {{ variable }} - afișează variabila în template. 2) Property Binding: [property]="value" - setează proprietatea unui element (ex: [disabled]="isDisabled"). 3) Event Binding: (event)="handler()" - ascultă evenimente (ex: (click)="onClick()"). 4) Two-way Binding: [(ngModel)]="variable" - sincronizare bidirecțională (ex: input-uri). Exemplu complet: <input [(ngModel)]="username" /> {{ username }} - ce scrii în input apare instant sub el.',
  'Angular',
  'medium',
  225
),
(
  'Ce e un service și de ce îl folosim în Angular?',
  'Service = clasă TypeScript care conține logică de business reutilizabilă, fără legătură cu UI. Se folosește pentru: 1) API calls (HTTP requests). 2) State management (date partajate între componente). 3) Business logic (calculații, validări). 4) Logging, authentication, etc. Services sunt singleton (o singură instanță în toată aplicația) dacă sunt providedIn: "root". Se injectează în componente prin Dependency Injection: constructor(private userService: UserService) {}. Scop: separarea logicii de prezentare, reutilizare, testare mai ușoară.',
  'Angular',
  'medium',
  226
),
(
  'Ce e un observable în Angular (RxJS)?',
  'Observable = stream de date async (poate emite 0, 1 sau multiple valori în timp). E core în RxJS (Reactive Extensions for JavaScript). Exemplu: HTTP call returnează Observable: this.http.get(url).subscribe(data => console.log(data)). Diferență față de Promise: Promise emite 1 valoare și se termină. Observable poate emite multiple (ex: WebSocket, events). Operators: map, filter, mergeMap pentru transformarea stream-urilor. Trebuie să faci .subscribe() ca să primești datele (și unsubscribe() ca să eviți memory leaks).',
  'Angular',
  'hard',
  227
),
(
  'Ce sunt lifecycle hooks în Angular (de ex. ngOnInit)?',
  'Lifecycle hooks = metode speciale apelate de Angular în momente cheie ale vieții unui component: 1) ngOnInit() - se apelează odată după crearea componentului (aici faci API calls). 2) ngOnChanges() - se apelează când se schimbă input-urile (@Input). 3) ngOnDestroy() - se apelează înainte de distrugerea componentului (cleanup: unsubscribe, clear timers). 4) ngAfterViewInit() - după inițializarea view-ului. Cele mai folosite: ngOnInit (initialization) și ngOnDestroy (cleanup). Scop: control asupra comportamentului componentului în diferite faze.',
  'Angular',
  'medium',
  228
),
(
  'Cum ai face un formular în Angular?',
  'Două abordări: 1) Template-driven forms: Simplu, logic în template. Folosești ngModel și validări în HTML. Ex: <input [(ngModel)]="user.name" required />. 2) Reactive forms: Mai puternic, logică în component. Folosești FormGroup și FormControl. Ex: this.userForm = new FormGroup({ name: new FormControl("", Validators.required) }). Reactive forms oferă mai mult control, testare mai ușoară și validări custom. Template-driven e mai rapid pentru formulare simple. Best practice pentru Trimble: Reactive forms pentru formulare complexe.',
  'Angular',
  'medium',
  229
),
(
  'Ce sunt modules și routing în Angular?',
  'Module (NgModule): Organizează aplicația în blocuri funcționale. @NgModule decorator specifică: declarations (componente), imports (alte module), providers (services). AppModule e module-ul root. Routing: Navigarea între view-uri (componente) fără page reload. Se configurează în RouterModule: const routes = [{ path: "users", component: UsersComponent }]. <router-outlet> în template marchează unde se încarcă componentul. Navigare: this.router.navigate(["/users"]) sau <a routerLink="/users">. Lazy loading: Încarcă module-uri doar când sunt necesare (optimizare performanță).',
  'Angular',
  'hard',
  230
);

-- Diferențe Tehnice (Comparison Questions)
INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
(
  'Care e diferența dintre class și interface?',
  'Class: Blueprint pentru obiecte, POATE avea implementare (cod), poate avea fields (variabile de instanță), poate avea constructori. Se folosește cu "new" pentru a crea obiecte. Interface: Contract pur, DOAR semnături de metode (fără implementare în limbaje ca C#/Java, cu implementare default în C# 8+), nu poate avea fields (doar properties). O clasă poate implementa multiple interfețe dar moșteni doar o clasă (în C#/Java). Când: Interfață pentru contracte/plug-in-uri (IRepository, ILogger), Clasă pentru entități cu stare și comportament (User, Order).',
  'Diferențe Tehnice',
  'medium',
  231
),
(
  'Care e diferența dintre abstract class și interface?',
  'Abstract Class: Poate avea metode implementate ȘI abstracte. Poate avea fields, constructori. O clasă poate moșteni DOAR o abstract class. Folosită pentru cod comun între clase înrudite. Interface: Doar semnături (sau implementări default în C# 8+). Nu poate avea fields. O clasă poate implementa MULTIPLE interfețe. Folosită pentru contracte flexibile. Când: Abstract class când ai cod comun și relație "is-a" puternică (ex: Animal cu metoda eat() implementată). Interface când vrei capabilități multiple ("can-do") - IFlyable, ISwimmable.',
  'Diferențe Tehnice',
  'medium',
  232
),
(
  'Care e diferența dintre GET și POST?',
  'GET: Cere date de la server (READ). Parametri în URL (?id=123). Idempotent (poți apela de N ori, același rezultat). Safe (nu modifică datele). Poate fi cached. Limită de lungime URL (~2000 chars). POST: Trimite date către server (CREATE). Parametri în body (JSON, form data). NU e idempotent (de fiecare dată creează resursă nouă). NU e safe. NU poate fi cached. Fără limită de mărime. Când: GET pentru listări, citiri. POST pentru creări, login, upload files.',
  'Diferențe Tehnice',
  'easy',
  233
),
(
  'Care e diferența dintre PUT și PATCH?',
  'PUT: Înlocuiește COMPLET resursa. Trimite toate câmpurile. Idempotent (apelat de N ori = același rezultat). Ex: PUT /users/123 { name: "George", email: "g@mail.com", age: 25 } - TOATE câmpurile. PATCH: Actualizează PARȚIAL resursa. Trimite doar câmpurile modificate. Idempotent (de obicei). Ex: PATCH /users/123 { age: 26 } - doar age se schimbă, restul rămân. Când: PUT când înlocuiești tot obiectul. PATCH când modifici 1-2 câmpuri (eficient, mai puțină date).',
  'Diferențe Tehnice',
  'medium',
  234
),
(
  'Care e diferența dintre == și === în JavaScript?',
  '== (loose equality): Compară valori, face type coercion (conversie automată de tipuri). Ex: 5 == "5" e true (string-ul e convertit la number). === (strict equality): Compară valori ȘI tipuri, fără conversie. Ex: 5 === "5" e false (types diferite). Best practice: FOLOSEȘTE MEREU === și !== ca să eviți bug-uri subtile. Exemplu clasic: 0 == false e true, dar 0 === false e false. === e predictibil și sigur.',
  'Diferențe Tehnice',
  'easy',
  235
),
(
  'Care e diferența dintre stack și heap în memory management?',
  'Stack: Memorie LIFO (Last In, First Out). Stochează: variabile locale, parametri funcție, return addresses. Alocare/dealocare AUTOMATĂ (când funcția se termină). Rapid dar LIMITAT în mărime (de obicei câteva MB). Stack overflow dacă recursia e prea adâncă. Heap: Memorie dinamică pentru obiecte mari. Alocare manuală (new/malloc) sau Garbage Collector. Mai LENT dar MULT mai mare. Memory leaks dacă nu eliberezi. Când: Stack pentru variabile mici, temporare. Heap pentru obiecte mari, alocări dinamice, date care supraviețuiesc funcției.',
  'Diferențe Tehnice',
  'hard',
  236
),
(
  'Care e diferența dintre compile time și runtime?',
  'Compile Time: Faza când codul sursă e tradus în cod executabil (sau bytecode). Compilatorul verifică: sintaxă, tipuri (în limbaje statically typed), referințe. Erorile de compilare OPRESC crearea executabilului. Ex: type mismatch, metoda lipsă. Runtime: Faza când programul RULEAZĂ. Aici apar: excepții, null reference errors, logic bugs, performance issues. Erorile de runtime CREAZĂ crash-uri sau comportament greșit. Când: Compile time = verificări statice, siguranță timpurie. Runtime = comportament dinamic, user input, API calls.',
  'Diferențe Tehnice',
  'medium',
  237
),
(
  'Care e diferența dintre synchronous și asynchronous?',
  'Synchronous (sincrон): Execuție SECVENȚIALĂ, pas cu pas. Fiecare operație așteaptă finalizarea precedentei. Blocking (blochează thread-ul). Ex: console.log("1"); console.log("2"); // 1, apoi 2. Asynchronous (async): Execuție NON-BLOCKING. Operațiile lungi (API call, DB query, file read) rulează "în background" fără a bloca thread-ul. Folosește: callbacks, Promises, async/await. Ex: fetch(url).then(data => console.log(data)) - codul continuă în timp ce fetch-ul așteaptă. Când: Sync pentru operații rapide. Async pentru I/O (network, disk, DB) ca să nu înghețe UI-ul sau serverul.',
  'Diferențe Tehnice',
  'medium',
  238
),
(
  'Care e diferența dintre frontend și backend?',
  'Frontend: Ce vede și interacționează user-ul. Rulează în BROWSER. Tehnologii: HTML, CSS, JavaScript, React, Angular, Vue. Responsabilități: UI, UX, validări client-side, afișare date. Backend: Logica de business, date, securitate. Rulează pe SERVER. Tehnologii: C#, Java, Node.js, Python, SQL. Responsabilități: API-uri, autentificare, baze de date, business logic, integrări externe. Comunicare: Frontend face requests (HTTP) către Backend, Backend răspunde cu date (JSON). Full-stack developer = cunoaște ambele.',
  'Diferențe Tehnice',
  'easy',
  239
),
(
  'Care e diferența dintre HTTP și HTTPS?',
  'HTTP (HyperText Transfer Protocol): Protocol de comunicare client-server. Date trimise în PLAIN TEXT (necriptate). Vulnerabil la: man-in-the-middle attacks, sniffing. Port 80. HTTPS (HTTP Secure): HTTP + SSL/TLS encryption. Date CRIPTATE în tranzit. Certificat digital (issued by CA - Certificate Authority) validează identitatea serverului. Port 443. Beneficii: Securitate, confidențialitate, SEO boost (Google preferă HTTPS), trustworthiness (lacat verde în browser). Când: HTTPS pentru ORICE site de producție, mai ales cu login/plăți. HTTP doar pentru dev local.',
  'Diferențe Tehnice',
  'easy',
  240
),
(
  'Care e diferența dintre object și class?',
  'Class: Blueprint/Template/Șablon pentru obiecte. Definește proprietăți și metode. Ex: class Car { string color; void Drive() {} }. NU ocupă memorie (e doar definiție). Object: Instanță CONCRETĂ a unei clase. Creat cu "new". Ex: Car myCar = new Car(); myCar.color = "red";. OCUPĂ memorie (are valori reale). Analogie: Class = rețeta prăjiturii. Object = prăjitura gata făcută. O clasă poate avea INFINITE obiecte.',
  'Diferențe Tehnice',
  'easy',
  241
),
(
  'Care e diferența dintre inheritance și composition?',
  'Inheritance (Moștenire): Relație "is-a". O clasă moștenește de la alta. Ex: Dog is-a Animal. Dog moștenește eat() de la Animal. Avantaj: Reutilizarea codului. Dezavantaj: Cuplare strânsă, ierarhii rigide. Composition (Compoziție): Relație "has-a". O clasă CONȚINE instanțe ale altora. Ex: Car has-a Engine. Car { private Engine engine; }. Avantaj: Flexibilitate, decuplare. Dezavantaj: Mai mult cod de setup. Best practice: "Favor composition over inheritance" (prefer compoziția). Moștenire doar pentru relații clare "is-a".',
  'Diferențe Tehnice',
  'medium',
  242
);

-- Client-Server & HTTP Deep Dive
INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
(
  'Ce este Dependency Injection (DI)?',
  'Dependency Injection = design pattern unde o clasă NU-și creează singură dependențele, ci le PRIMEȘTE din exterior (de obicei prin constructor). Scop: Decuplare, testabilitate. Exemplu FĂRĂ DI: class UserService { private UserRepo repo = new UserRepo(); } - tight coupling. CU DI: class UserService { constructor(private IUserRepo repo) {} } - Framework-ul (Angular, .NET) injectează repo automat. Beneficii: 1) Testare ușoară (injectezi mock). 2) Schimbi implementarea fără să modifici clasa. 3) Cod mai curat. DI e CORE în Angular și ASP.NET Core.',
  'Client-Server & HTTP',
  'hard',
  243
),
(
  'Explică arhitectura Client–Server.',
  'Arhitectură cu două roluri: CLIENT: Cere servicii/date (browser, aplicație mobilă, Postman). Inițiază cererea. RULEAZĂ de obicei pe device-ul user-ului. SERVER: Furnizează servicii/date (backend, API, baze de date). Răspunde la cereri. RULEAZĂ pe mașini remote (cloud, datacenter). Comunicare: Prin protocol (HTTP, WebSocket, gRPC). Request-Response cycle: 1) Clientul trimite request (GET /users). 2) Serverul procesează (query DB, business logic). 3) Serverul trimite response (200 OK + JSON). Exemplu: Browser (client) cere pagina Google → Server Google răspunde cu HTML.',
  'Client-Server & HTTP',
  'easy',
  244
),
(
  'Ce se întâmplă când accesezi un site web (de la A la Z)?',
  'Flow complet: 1) User scrie URL în browser (ex: trimble.com). 2) Browser face DNS lookup (trimble.com → IP address 104.16.123.45). 3) Browser trimite HTTP GET request la IP-ul respectiv, port 80/443. 4) Request trece prin: router-ul tău → ISP → internet → server Trimble. 5) Serverul Trimble procesează cererea (verifică ruta, interogare DB, generează HTML). 6) Serverul trimite HTTP Response (status 200, headers, body cu HTML/CSS/JS). 7) Browser-ul primește răspunsul, parsează HTML, descarcă CSS/JS/imagini (requests suplimentare). 8) Browser renderizează pagina (DOM + CSSOM → Render Tree → Paint). 9) User vede pagina.',
  'Client-Server & HTTP',
  'hard',
  245
),
(
  'Ce este un API?',
  'API (Application Programming Interface) = set de reguli/endpoints prin care aplicații comunică între ele. Exemplu: Trimble BIM API oferă endpoints pentru a accesa modele 3D. REST API = API care folosește HTTP și principii REST. Endpoint = URL specific pentru o resursă (ex: GET /api/users/123). Request: Clientul cere ceva. Response: Serverul răspunde. Format: De obicei JSON. Exemplu concret: Weather API - trimiți GET la api.weather.com/current?city=Bucuresti, primești { "temp": 25, "condition": "sunny" }. APIs permit integrarea între sisteme diferite.',
  'Client-Server & HTTP',
  'easy',
  246
),
(
  'Ce este REST și cum se leagă de arhitectura client–server?',
  'REST (Representational State Transfer) = stil arhitectural pentru API-uri. Principii: 1) Client-Server separation. 2) Stateless (fiecare request conține toată informația necesară). 3) Cacheable (responses pot fi cached). 4) Uniform Interface (endpoints consistente). 5) Resurse identificate prin URI (/api/users/123). 6) Metode HTTP standard (GET, POST, PUT, DELETE). Exemplu RESTful: GET /api/projects - listă proiecte. POST /api/projects - creează proiect. GET /api/projects/5 - detalii proiect. PUT /api/projects/5 - update proiect. DELETE /api/projects/5 - șterge proiect. REST face API-urile predictibile și scalabile.',
  'Client-Server & HTTP',
  'medium',
  247
),
(
  'Ce e HTTP și cum funcționează?',
  'HTTP (HyperText Transfer Protocol) = protocol de comunicare între client și server. Request-Response: 1) Client trimite REQUEST: Metodă (GET/POST), URL (/api/users), Headers (Authorization, Content-Type), Body (opțional, JSON). 2) Server trimite RESPONSE: Status Code (200, 404, 500), Headers (Content-Type, Set-Cookie), Body (HTML, JSON, etc.). Stateless: Fiecare request e independent (server nu "își amintește" request-ul anterior, de aceea există cookies/tokens). Versiuni: HTTP/1.1 (cel mai folosit), HTTP/2 (mai rapid, multiplexing), HTTP/3 (bazat pe UDP/QUIC).',
  'Client-Server & HTTP',
  'medium',
  248
),
(
  'Care sunt principalele metode HTTP și când le folosești?',
  'GET: Citește date. Safe, idempotent. Ex: GET /api/users - listă users. POST: Creează resursă. NOT idempotent. Ex: POST /api/users + body { name: "George" } - creează user. PUT: Înlocuiește resursă. Idempotent. Ex: PUT /api/users/123 + body complet - update total. PATCH: Actualizare parțială. Ex: PATCH /api/users/123 + { email: "new@mail.com" }. DELETE: Șterge resursă. Idempotent. Ex: DELETE /api/users/123. HEAD: Ca GET dar fără body (doar headers). OPTIONS: Verifică metodele suportate (CORS preflight).',
  'Client-Server & HTTP',
  'medium',
  249
),
(
  'Ce înseamnă codurile HTTP 200, 404, 500?',
  '200 OK: Cerere reușită, server răspunde cu date. Ex: GET /api/users → 200 + listă users. 404 Not Found: Resursa cerută nu există. Ex: GET /api/users/999 când user 999 nu există. 500 Internal Server Error: Eroare NEPREVĂZUTĂ pe server (bug, DB down, exception uncaught). Client-ul n-are vină. Ex: Bug în cod → 500. Alte importante: 201 Created (POST reușit), 204 No Content (DELETE reușit), 400 Bad Request (request malformat), 401 Unauthorized (lipsă auth), 403 Forbidden (nu ai permisiune), 422 Unprocessable Entity (validare eșuată).',
  'Client-Server & HTTP',
  'easy',
  250
),
(
  'Ce e un header HTTP și dă exemple.',
  'Header = metadată trimisă în request/response. Format: Key: Value. Request Headers (client → server): Authorization: Bearer token123 (autentificare). Content-Type: application/json (tipul body-ului). Accept: application/json (ce tip de răspuns vrea clientul). User-Agent: Chrome/120 (ce browser). Response Headers (server → client): Content-Type: application/json (tipul răspunsului). Set-Cookie: sessionId=abc (setează cookie). Cache-Control: max-age=3600 (cât timp să cache-uiască). Access-Control-Allow-Origin: * (CORS). Headers permit: autentificare, content negotiation, caching, CORS.',
  'Client-Server & HTTP',
  'medium',
  251
);

-- AI & Productivity Questions
INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
(
  'Ce părere ai despre folosirea ChatGPT / Copilot în procesul de dezvoltare?',
  'Răspuns echilibrat: "Văd AI-ul ca pe un tool puternic de PRODUCTIVITATE, nu o cârjă. Beneficii: 1) Accelerează scrierea boilerplate code (constructori, getters, interfaces). 2) Ajută la debugging (explică errori, sugerează soluții). 3) Învățare (explică concepte noi rapid). 4) Explorare API-uri noi. DAR: 1) Verific mereu codul generat - AI face greșeli sau generează cod învechit/nesigur. 2) NU mă bazez pe AI pentru logica complexă sau arhitectură. 3) Înțeleg TOTDEAUNA codul pe care-l comit. 4) AI nu înlocuiește fundamentele - trebuie să știu OOP, algoritmi, best practices. În internship, aș folosi AI ca asistent, dar prioritatea e să învăț deep, nu să copiez orbește."',
  'AI & Productivity',
  'medium',
  252
),
(
  'Cum te-ai folosi de AI ca să accelerezi dezvoltarea unui proiect?',
  'Strategii concrete: 1) Code generation: Generez componente boilerplate (Angular components, C# DTOs, API endpoints skeleton). 2) Documentation: Cer AI să scrie JSDoc/XML comments pentru funcții complexe. 3) Testing: Generez unit tests skeletons pentru coverage rapid. 4) Debugging: Când am un error stack trace confuz, îl dau la AI pentru explicație rapidă. 5) Learning: Când întâlnesc un concept nou (ex: RxJS operators), cer AI să-mi explice cu exemple. 6) Refactoring: Sugestii de îmbunătățire cod (ex: "cum pot optimiza această funcție?"). CE NU fac: Nu las AI să scrie logica de business critică fără revizuire atentă.',
  'AI & Productivity',
  'medium',
  253
),
(
  'Care crezi că e riscul în a folosi AI fără control uman?',
  'Riscuri majore: 1) Cod greșit/buggy: AI poate genera cod care compilează dar e logic greșit sau are vulnerabilități. 2) Security issues: Poate genera SQL queries vulnerabile la injection, sau expune secrete în cod. 3) Licensing problems: AI a fost antrenat pe cod open-source; codul generat poate avea IP issues. 4) Technical debt: Cod generat rapid dar prost structurat creează debt pe termen lung. 5) Degradarea skill-urilor: Dependența de AI poate preveni învățarea profundă a conceptelor. 6) Hallucinations: AI inventează API-uri inexistente sau documentație falsă. Soluția: Human review ÎNTOTDEAUNA, teste, code reviews, static analysis tools.',
  'AI & Productivity',
  'hard',
  254
),
(
  'Ce tehnologii AI ai încercat personal?',
  'Răspuns personalizat (adaptează la experiența ta): "Am folosit: 1) GitHub Copilot pentru autocomplete în VS Code - ajută mult la boilerplate și sugestii de variable names. 2) ChatGPT pentru debugging (când am erori complexe) și pentru a învăța concepte noi rapid (ex: mi-a explicat async/await în C# cu exemple clare). 3) Claude pentru code reviews și refactoring suggestions. 4) Am experimentat cu [dacă ai făcut]: Cursor IDE, Gemini Code Assist. Ce am învățat: AI e excelent pentru accelerarea task-urilor repetitive, dar fundamental knowledge (OOP, algoritmi, arhitectură) trebuie să vină de la mine. În internship, aș fi deschis să învăț tool-urile AI pe care le folosiți la Trimble."',
  'AI & Productivity',
  'easy',
  255
),
(
  'Dacă ai face un proiect asistat de AI, cum l-ai documenta?',
  'Documentație responsabilă: 1) Source transparency: Marchez în comments unde AI a generat cod (ex: // AI-generated boilerplate, reviewed and modified). 2) Review notes: Documentez ce am modificat din output-ul AI și DE CE (ex: "AI genera SQL vulnerabil, am schimbat cu parametrized query"). 3) Testing coverage: Toate funcțiile AI-generated trebuie să aibă unit tests scrise de MINE (ca să verific corectitudinea). 4) README: Menționez că am folosit AI tools pentru accelerare, dar că tot codul e verificat și înțeles. 5) Code comments: Explic logica complexă în comments, nu las cod "magic" generat de AI fără explicație. Scopul: Transparență și maintainability pentru colegii din echipă.',
  'AI & Productivity',
  'medium',
  256
);

-- Additional Important Questions
INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
(
  'Ce este Cloud Computing și ce avantaje oferă?',
  'Cloud Computing = furnizarea de resurse IT (servere, stocare, baze de date, rețea, software) prin internet, on-demand, pay-as-you-go. Provideri: AWS, Azure, Google Cloud. Modele: 1) IaaS (Infrastructure): VM-uri, rețele (ex: Azure VMs). 2) PaaS (Platform): Mediu de development gata (ex: Azure App Service). 3) SaaS (Software): Aplicații gata (ex: Office 365). Avantaje: 1) Scalare automată (crește/scade resurse după trafic). 2) Cost eficient (plătești doar ce folosești). 3) Disponibilitate (99.9% uptime). 4) Acces global. 5) Mentenanță minimă (provider se ocupă de hardware). Dezavantaje: Dependență de provider, costuri pe termen lung.',
  'Cloud',
  'medium',
  257
),
(
  'Ce este CI/CD?',
  'CI/CD = Continuous Integration / Continuous Delivery (sau Deployment). CI (Continuous Integration): Dezvoltatorii integrează codul frecvent (zilnic) în repository-ul central. La fiecare commit/push, un pipeline automat: 1) Build-uiește proiectul. 2) Rulează testele (unit, integration). 3) Raportează erorile. Scop: Prinde bug-uri devreme. CD (Continuous Delivery): După CI, codul e automat deploy-at în staging/production (dacă testele trec). Scop: Releases frecvente, rapide, sigure. Tools: Azure DevOps, Jenkins, GitHub Actions, GitLab CI. Beneficii: Feedback rapid, calitate mai bună, risc redus la deploy.',
  'Cloud',
  'medium',
  258
),
(
  'Ce este un container (Docker)?',
  'Container = pachet lightweight care conține aplicația + toate dependențele (libraries, runtime, configurări). Izolat de sistemul host. Docker = platformă pentru creare, distribuire și rulare containere. Diferență față de VM: Container partajează kernel-ul OS-ului host (mai rapid, mai mic). VM are OS complet (mai greu). Dockerfile = rețeta pentru a construi container (ex: FROM node:18, COPY ., RUN npm install). Docker Image = șablonul (blueprint). Docker Container = instanța care rulează. Beneficii: 1) "Works on my machine" problem rezolvat. 2) Deploy consistent. 3) Scalare ușoară (Kubernetes orchestrează N containere).',
  'Cloud',
  'medium',
  259
),
(
  'Ce este un pipeline de build?',
  'Pipeline de build = secvență automată de pași care transformă codul sursă în aplicație deployabilă. Pași tipici: 1) Source: Preia codul din Git (trigger: commit/push). 2) Build: Compilează codul (ex: dotnet build, npm run build). 3) Test: Rulează unit tests, integration tests, linting. 4) Package: Creează artifact (ex: .dll, .zip, Docker image). 5) Deploy: Pune artifact-ul pe server (staging sau production). 6) Notify: Alertă echipa (email, Slack) dacă build-ul eșuează. Tools: Azure Pipelines (YAML config), Jenkins, GitHub Actions. Beneficii: Automatizare, consistență, feedback rapid.',
  'Cloud',
  'medium',
  260
),
(
  'Ce știi despre Scrum și Agile?',
  'Agile = metodologie de development bazată pe: iterații scurte, feedback constant, adaptabilitate. Principii: Working software > documentație, colaborare > negociere, răspuns la schimbare > plan rigid. Scrum = framework Agile specific. Roluri: 1) Product Owner (prioritizează features). 2) Scrum Master (facilitează procesul). 3) Development Team (construiește produsul). Ceremonies: 1) Sprint (ciclu de 2 săptămâni cu obiectiv clar). 2) Sprint Planning (planificarea task-urilor). 3) Daily Standup (sync de 15 min: ce am făcut, ce fac, ce mă blochează). 4) Sprint Review (demo la stakeholders). 5) Retrospective (ce-am învățat, cum ne îmbunătățim). Artifacts: Product Backlog, Sprint Backlog.',
  'Agile',
  'medium',
  261
),
(
  'Ce este o user story în Agile?',
  'User Story = descriere scurtă a unei funcționalități din perspectiva utilizatorului. Format standard: "Ca [rol], vreau [obiectiv], astfel încât [beneficiu]." Exemplu: "Ca arhitect, vreau să export modelul 3D în format PDF, astfel încât să pot partaja cu clientul fără softul Trimble." Include: 1) Acceptance Criteria (condiții de acceptare - când e "Done"). 2) Story Points (estimare complexitate - 1, 2, 3, 5, 8, 13). 3) Priority (High/Medium/Low). User stories se pun în Product Backlog și se aleg pentru Sprinturi. Beneficii: Focus pe valoarea pentru user, nu pe implementare tehnică.',
  'Agile',
  'easy',
  262
),
(
  'Cum ai prioritiza task-urile într-un sprint Agile?',
  'Criteriile de prioritizare: 1) Business Value: Ce aduce cel mai mult beneficiu user-ului/companiei? 2) Dependencies: Există task-uri blocante (altele depind de ele)? 3) Risk: Task-uri cu risc înalt (tehnologie nouă, integrare complexă) se fac DEVREME în sprint. 4) Urgency: Deadline-uri externe (demo, release). 5) Effort: Balansează task-uri mari cu mici (să nu ai doar grele). Practică: 1) Iau task-urile din Sprint Backlog (deja prioritizate de Product Owner). 2) Încep cu cele High Priority + High Risk (fail fast). 3) Comunic cu echipa în Daily Standup dacă sunt blocat. 4) Updatez task-urile în tool (Jira, Azure Boards).',
  'Agile',
  'medium',
  263
),
(
  'Ce se întâmplă într-un daily standup?',
  'Daily Standup (Daily Scrum) = întâlnire zilnică de 15 minute, de obicei dimineața, în picioare (să fie scurtă). Format: Fiecare membru răspunde la 3 întrebări: 1) Ce am făcut ieri? (ex: "Am finalizat API endpoint pentru users"). 2) Ce fac astăzi? (ex: "Lucrez la frontend component pentru login"). 3) Ce mă blochează? (ex: "Aștept code review pe PR-ul #45" sau "Nu înțeleg cum funcționează OAuth flow"). Scop: Sincronizare rapidă, identificare blockers, transparență. NU e: status report pentru manager, discuție tehnică detaliată (acelea se fac separat). Scrum Master facilitează și ajută la rezolvarea blockers.',
  'Agile',
  'easy',
  264
),
(
  'Care e diferența dintre sprint review și retrospective?',
  'Sprint Review: Focus pe PRODUS. Echipa demonstrează funcționalitățile dezvoltate în sprint către stakeholders (Product Owner, clienți, management). Se validează Acceptance Criteria. Feedback: "Feature X e grozav, dar aș vrea butonul mai mare." Decision: Accept/Reject user stories. Sprint Retrospective: Focus pe PROCES. Echipa discută intern (fără stakeholders) ce-a mers bine, ce nu și cum se îmbunătățește. Format: 1) Ce a mers bine? (keep doing). 2) Ce nu a mers? (stop doing). 3) Ce încercăm nou? (start doing). Ex: "Code reviews-urile au durat prea mult → să setăm SLA de 24h." Outcome: Action items pentru următorul sprint.',
  'Agile',
  'medium',
  265
);

-- Behavioral Deep Dive
INSERT INTO biblia_questions (question, correct_answer, category, difficulty, order_index)
VALUES
(
  'Cum te descurci când ai deadline-uri multiple?',
  'Abordare structurată: 1) Prioritizare: Matrice Urgență x Impact. Task-uri Urgent + High Impact = FIRST. Low Priority = negociez deadline sau delegat. 2) Comunicare: Informez manager-ul/echipa despre workload. NU promit imposibilul. 3) Time blocking: Aleg un task, lucrez focus 2h (fără distractions), apoi break. 4) Evit multitasking: Fac un task la un timp (context switching costă). 5) Buffer time: Estimări realiste + 20% buffer pentru neprevăzut. 6) Cer ajutor: Dacă sunt blocat sau overloaded, cer suport. Exemplu: "Săptămâna trecută aveam 3 bug-uri critice + 1 feature. Am prioritizat bug-urile (blocau producția), apoi feature. Am comunicat stakeholder-ului că feature-ul va fi gata cu 1 zi întârziere. Am livrat totul calitativ."',
  'HR Behavioral',
  'medium',
  266
),
(
  'Cum înveți o tehnologie nouă? (de exemplu TypeScript sau Snowflake)',
  'Proces de învățare: 1) Documentație oficială: Citesc intro și getting started (ex: TypeScript Handbook). 2) Tutorial hands-on: Urmăresc un tutorial video/scris și codific în paralel (learning by doing). 3) Proiect mic: Construiesc ceva simplu dar funcțional (ex: TODO app în TypeScript) ca să aplic conceptele. 4) Best practices: Citesc articole despre best practices și common pitfalls. 5) Comunitate: Caut pe Stack Overflow, Reddit când sunt blocat. 6) Revizuire: După 1 săptămână, recapitulez conceptele cheie. Exemplu real: "Când am învățat React, am făcut tutorial oficial, apoi am construit un Movie Database app. Am făcut greșeli (infinite loops în useEffect), am căutat soluții, și acum înțeleg lifecycle-ul componentelor."',
  'HR Behavioral',
  'medium',
  267
),
(
  'Dă-mi un exemplu când ai lucrat în echipă și a fost o situație dificilă. Cum ați rezolvat-o?',
  'Folosește STAR: Situation: "În proiectul de la facultate, un coleg a dispărut cu 2 săptămâni înainte de deadline. Task-ul lui (backend API) era nefăcut, iar noi dependeam de el." Task: "Trebuia să livrăm proiectul complet sau pierdeam nota." Action: "Am avut o întâlnire de urgență. Am împărțit task-ul colegului între mine și încă un membru. Eu am preluat partea de API (aveam experiență cu .NET), celălalt a preluat testele. Am lucrat extra 10h acea săptămână. Am comunicat profesorului situația (transparency)." Result: "Am livrat proiectul la timp cu 90% funcționalitate. Am primit nota bună. Profesorul a apreciat proactivitatea." Learning: "Am învățat importanța backup plans și comunicării timpurii când cineva nu livrează."',
  'HR Behavioral',
  'hard',
  268
),
(
  'Povestește despre un moment când ai eșuat. Ce ai învățat?',
  'Alege un eșec REAL dar recuperabil: Situation: "La primul meu proiect personal (Movie App), am lansat rapid fără testare. Userul a raportat că aplicația crash-uia când căuta filme cu caractere speciale (ex: *@#)." Task: "Trebuia să fixez urgent și să previn astfel de bug-uri în viitor." Action: "1) Am reprodus bug-ul local. 2) Am identificat problema: nu sanitizam input-ul user-ului. 3) Am implementat validare + escape characters. 4) Am scris unit tests pentru edge cases. 5) Am adăugat error handling global." Result: "Bug-ul a fost fixat în 2 zile. 0 crash-uri de atunci." Learning: "Am învățat că testing și input validation sunt NON-NEGOCIABILE. Acum scriu teste ÎNAINTE de lansare și gândesc la edge cases."',
  'HR Behavioral',
  'medium',
  269
),
(
  'Descrie o situație când ai avut un deadline strâns. Cum ai gestionat presiunea?',
  'STAR format: Situation: "La internship-ul anterior, am avut o cerință de client urgent: export CSV dintr-un raport complex. Deadline: 3 zile." Task: "Trebuia să implementez feature-ul, să testez și să deploiez fără să stric funcționalitatea existentă." Action: "1) Am planificat: Ziua 1 - backend (API endpoint), Ziua 2 - frontend + integrare, Ziua 3 - testing + deploy. 2) Am comunicat progress zilnic managerului. 3) Am evitat perfectionism - MVP funcțional, optimizări ulterioare. 4) Am cerut code review rapid de la un senior. 5) Am lucrat focus, fără distractii." Result: "Am livrat la timp. Feature-ul funcționa corect. Clientul mulțumit." Pressure management: "Am respirat, am împărțit task-ul în pași mici, și am comunicat constant. Presiunea m-a motivat, nu paralizat."',
  'HR Behavioral',
  'hard',
  270
),
(
  'Povestește despre un conflict cu un coleg/colegă. Cum l-ai rezolvat?',
  'Conflict PROFESIONAL (nu personal): Situation: "În echipa de la facultate, eu și un coleg nu eram de acord cum să structurăm baza de date. Eu voiam normalizare strictă (3NF), el voia tabele denormalizate pentru simplitate." Task: "Trebuia să decidem rapid ca să nu blocăm development-ul." Action: "1) Am discutat calm, fiecare prezentând argumentele (eu: data integrity, el: query performance). 2) Am căutat împreună pe Google best practices. 3) Am ajuns la compromis: normalizare pentru tabele critice (users, orders), denormalizare limitată pentru rapoarte. 4) Am documentat decizia." Result: "Ambii fericiți, proiectul a mers bine. Am învățat că există tradeoff-uri, nu întotdeauna o soluție e 100% corectă." Learning: "Conflictele tehnice se rezolvă cu date și compromis, nu orgoliu."',
  'HR Behavioral',
  'hard',
  271
),
(
  'Cum primești critici constructive? Dă un exemplu.',
  'Mentalitate pozitivă: Văd criticile ca oportunități de învățare, nu atacuri. Exemplu real: Situation: "În primul meu code review, un senior mi-a spus că funcțiile mele sunt prea lungi (100+ linii) și greu de înțeles." Reacție inițială: "Am simțit că nu-s suficient de bun." Acțiune: "1) Am respirat și am ascultat argumentele lui: funcții mici = testare ușoară, citibilitate, Single Responsibility. 2) Am pus întrebări clarificatoare: Cât de mici? Cum împart logica? 3) Am aplicat sugestia: am refactorizat funcția de 100 linii în 5 funcții de 20 linii fiecare. 4) Am cerut al doilea review." Result: "Codul a devenit mult mai clar. Senior-ul a apreciat receptivitatea. Am învățat o lecție valoroasă." Key: "Mulțumesc pentru feedback, clarific dacă nu înțeleg, și APLIC."',
  'HR Behavioral',
  'medium',
  272
),
(
  'De ce vrei să lucrezi ca intern la Trimble? (versiunea extinsă)',
  'Răspuns structurat și sincer: 1) Impact real: "Vreau să lucrez la software care are impact tangibil - produsele Trimble sunt folosite de ingineri și arhitecți să construiască clădiri, poduri, infrastructură. E fascinant cum codul meu ar putea contribui la proiecte reale." 2) Stack tehnologic: "Combinația C#/.NET (backend puternic), Angular/React (frontend modern), Azure (cloud), și BIM (3D modeling) e exact ce vreau să învăț. E un stack relevant și cerut pe piață." 3) Program structurat: "Rotația între echipe + mentorat + învățare Agile/CI-CD în producție e perfect pentru dezvoltarea mea ca junior." 4) Cultură: "Am citit despre cultura Trimble - inovație, continuous learning, colaborare internațională. Vreau să lucrez într-un mediu unde sunt încurajat să cresc." 5) Oportunitate: "Posibilitatea de angajare post-internship mă motivează să dau 100%."',
  'HR Behavioral',
  'hard',
  273
),
(
  'Unde te vezi peste 3-5 ani în cariera de developer? (versiunea extinsă)',
  'Viziune realistă și ambițioasă: "În 3-5 ani vreau să fiu un Mid-Senior Developer cu expertiză solidă în full-stack development. Specific: Anul 1-2 (Junior → Mid): 1) Stăpânesc .NET (C#, EF Core, API design). 2) Frontend modern (React sau Angular la nivel avansat). 3) Azure (deploy, CI/CD, monitoring). 4) Contribui independent la features complexe. 5) Mentorez interns. Anul 3-5 (Mid → Senior): 1) Particip la decizii de arhitectură. 2) Conduc module/features mici. 3) Expertiza într-un domeniu (ex: BIM integration, 3D rendering, cloud architecture). 4) Soft skills: comunicare tehnică, leadership. Ideal: Dacă internship-ul la Trimble merge bine, văd o cale clară de creștere aici. Vreau să devin cineva la care colegii vin cu întrebări tehnice și să contribui la produse de impact global."',
  'HR Behavioral',
  'hard',
  274
);

COMMIT;

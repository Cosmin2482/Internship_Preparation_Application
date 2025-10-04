/*
  # Translate JavaScript, React, Soft Skills Terms to Romanian
*/

DO $$
BEGIN
  -- Promises and Async/Await
  UPDATE terms SET
    eli5 = 'Promise = promisiune pentru rezultat viitor. Async/await = sintaxă mai curată pentru promises. Await așteaptă ca promise-ul să se rezolve.',
    formal_definition = 'Promise: obiect reprezentând eventual completion/failure a operației asincrone. Async/await: syntactic sugar peste promises. Async function returnează Promise, await suspendă execuția.',
    interview_answer = 'Promise reprezintă un rezultat viitor - pending, fulfilled, sau rejected. Then/catch pentru handling. Async/await face codul mai lizibil - await așteaptă promise-ul, codul arată sincron. Întotdeauna wrap în try-catch sau .catch() pentru error handling. Async functions returnează automat Promise.',
    pitfalls = to_jsonb(ARRAY[
      'Uiți .catch() sau try-catch',
      'Promise hell (nested)',
      'Nu înțelegi că async returnează Promise',
      'Fire-and-forget fără error handling',
      'Confuzie async/await vs promises'
    ]),
    diagram = 'Promises & Async/Await:

Promise:
fetch(url)
  .then(res => res.json())
  .then(data => console.log(data))
  .catch(err => console.error(err));

Async/Await:
try {
  const res = await fetch(url);
  const data = await res.json();
  console.log(data);
} catch(err) {
  console.error(err);
}

Același lucru, sintaxă diferită'
  WHERE term = 'Promises și Async/Await' AND language = 'ro';

  -- React Hooks
  UPDATE terms SET
    eli5 = 'Hooks = funcții speciale în React. useState pentru state, useEffect pentru side effects. Hooks doar în componente funcționale.',
    formal_definition = 'React Hooks: useState (state local), useEffect (side effects după render), useContext, useReducer, etc. Permit state și lifecycle în functional components.',
    interview_answer = 'useState creează state în functional components - returnează value și setter. UseEffect rulează după render - pentru API calls, subscriptions, DOM updates. Dependency array controlează când se re-execută - empty array = doar la mount. Cleanup prin return function pentru unsubscribe. Hooks au făcut functional components la fel de puternice ca class components.',
    pitfalls = to_jsonb(ARRAY[
      'Dependency array lipsă sau greșit',
      'Uiți cleanup în useEffect',
      'Infinite loops (dependency greșit)',
      'Hooks în condiții sau loops',
      'Stale closures',
      'Prea multe re-renders'
    ]),
    diagram = 'React Hooks:

useState:
const [count, setCount] = useState(0);
setCount(count + 1);

useEffect:
useEffect(() => {
  // Side effect
  const timer = setInterval(...);
  
  return () => {
    clearInterval(timer); // Cleanup
  };
}, [dependency]); // Când rulează

[] = mount/unmount
[dep] = când dep se schimbă
none = la fiecare render'
  WHERE term LIKE '%React Hooks%' AND language = 'ro';

  -- STAR Method
  UPDATE terms SET
    eli5 = 'STAR = Situație, Sarcină, Acțiune, Rezultat. Framework pentru răspunsuri la întrebări comportamentale în interviuri.',
    formal_definition = 'Metoda STAR: structurează răspunsuri comportamentale. Situație (context), Sarcină (provocarea ta), Acțiune (ce ai făcut TU), Rezultat (outcome + învățătură).',
    interview_answer = 'STAR mă ajută să răspund structurat la întrebări comportamentale. Situație - dau contextul (ce proiect, ce problemă). Sarcină - provocarea mea specifică. Acțiune - pașii MEI concreți (nu "noi", ci "eu"). Rezultat - outcome-ul și ce am învățat. Fii specific, onest, arată growth mindset. Pregătesc 5-10 povești STAR înainte de interviu.',
    pitfalls = to_jsonb(ARRAY[
      'Răspunsuri generice fără detalii',
      'Nu arăți ce ai făcut TU (doar "noi")',
      'Dai vina pe alții',
      'Nu menționezi învățături',
      'Povești prea lungi',
      'Nu pregătești exemple'
    ]),
    diagram = 'Metoda STAR:

[S]ituație
  ↓ Context, background
  
[T]arcină
  ↓ Provocarea ta
  
[A]cțiune
  ↓ Pașii tăi specifici
  (ce ai făcut TU)
  
[R]ezultat
  ↓ Outcome + Învățătură

Întrebări comune:
• Bug rezolvat?
• Ai cerut ajutor?
• Feedback primit?
• Deadline strâns?
• Conflict în echipă?'
  WHERE term = 'Metoda STAR pentru Interviuri' AND language = 'ro';

  -- Interview Tips
  UPDATE terms SET
    eli5 = 'Fraze cheie care arată înțelegere profundă. Cum răspunzi la întrebări dificile. Ce întrebi tu la interviu.',
    formal_definition = 'Fraze strategice demonstrând înțelegere tehnică, gândire critică, maturitate profesională. Pregătire pentru întrebări "capcană".',
    interview_answer = 'Fraze de aur: "Override pentru polimorfism, new doar ascunde", "PUT idempotent, PATCH parțial", "422 pentru validare, 409 pentru conflicte", "AsNoTracking pentru read-only". Pregătește: De ce compania asta, puncte forte/slabe, obiective 3 ani, întrebări pentru interviewer. Cercetează compania, pregătește povești STAR, cunoaște profund bazele.',
    pitfalls = to_jsonb(ARRAY[
      'Memorizezi fără înțelegere',
      'Generic "Sunt hardworking"',
      'Fără întrebări pentru interviewer',
      'Vorbești rău despre fostul job/colegii',
      'Nu cunoști básele despre companie'
    ]),
    diagram = 'Pregătire Interviu:

✓ Cercetează compania:
  - Produse/servicii
  - Tech stack
  - Știri recente
  
✓ Pregătește povești:
  - Bug rezolvat
  - Ajutor cerut
  - Feedback primit
  
✓ Cunoaște profund:
  - OOP 4 piloni
  - HTTP metode + coduri
  - SQL JOINs + indexuri
  
✓ Întrebări pentru ei:
  - Mentorship?
  - Proiecte tipice?
  - Code review process?'
  WHERE term = 'Sfaturi Interviu și Fraze de Aur' AND language = 'ro';

  -- Dependency Injection
  UPDATE terms SET
    eli5 = 'DI = nu creezi dependențele, le primești. Constructor primește ILogger, nu face new Logger(). Face codul testabil.',
    formal_definition = 'Dependency Injection: pattern unde dependențele sunt injectate în clasă în loc să fie create de clasă. Inversează controlul. Realizat prin constructor, properties, sau methods.',
    interview_answer = 'DI înseamnă că dependențele sunt injectate, nu create. Constructor primește ILogger, nu face new ConsoleLogger(). Beneficii: testabil (inject mock în tests), flexibil (schimb implementări fără modificări), loose coupling. ASP.NET Core are DI built-in. Înregistrez services în Program.cs, primesc în constructori.',
    pitfalls = to_jsonb(ARRAY[
      'New în constructor (tight coupling)',
      'Service locator anti-pattern',
      'Circular dependencies',
      'Property injection când ar trebui constructor',
      'Nu înțelegi lifetimes (Singleton/Scoped/Transient)'
    ]),
    diagram = 'Dependency Injection:

FĂRĂ DI (rău):
class UserService {
  private Logger logger;
  
  UserService() {
    logger = new ConsoleLogger(); ✗
  }
}
Tight coupling, non-testabil

CU DI (bun):
class UserService {
  private ILogger logger;
  
  UserService(ILogger logger) {
    this.logger = logger; ✓
  }
}
Loose coupling, testabil'
  WHERE term = 'Dependency Injection' AND language = 'ro';

  RAISE NOTICE 'Translated JS, React, Soft Skills terms to Romanian';
END $$;

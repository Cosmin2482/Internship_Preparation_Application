/*
  # Translate .NET, SQL, CS Fundamentals Terms to Romanian
*/

DO $$
BEGIN
  -- IEnumerable vs IQueryable
  UPDATE terms SET
    eli5 = 'IEnumerable = filtrare în memorie (LINQ to Objects). IQueryable = filtrare în baza de date (LINQ to SQL). IQueryable construiește SQL, IEnumerable filtrează în C#.',
    formal_definition = 'IEnumerable: execuție query in-memory. IQueryable: expression tree tradus în SQL, executat remote. IQueryable extinde IEnumerable.',
    interview_answer = 'Folosesc IQueryable pentru query-uri de bază de date - filtrele se traduc în SQL WHERE, eficient. IEnumerable încarcă toate datele apoi filtrează în memorie - lent pentru dataset-uri mari. IQueryable construiește expression tree, IEnumerable execută imediat după enumerare. IQueryable pentru EF Core, IEnumerable după ToList().',
    pitfalls = to_jsonb(ARRAY[
      'IEnumerable pentru DB queries (încarcă tot)',
      'Nu înțelegi deferred execution',
      'Multiple enumeration issues',
      'Tip greșit cauzeză probleme performanță'
    ]),
    diagram = 'IEnumerable vs IQueryable:

IQueryable (Database):
  query.Where(x => x.Age > 18)
       ↓
  Expression Tree
       ↓
  SQL: WHERE Age > 18
       ↓
  Database filtrează
  EFICIENT ✓

IEnumerable (Memory):
  query.ToList() // Încarcă TOT
       ↓
  .Where(x => x.Age > 18)
       ↓
  C# filtrează în memorie
  LENT pentru date mari ✗'
  WHERE term = 'IEnumerable vs IQueryable' AND language = 'ro';

  -- FirstOrDefault vs Single
  UPDATE terms SET
    eli5 = 'FirstOrDefault = primul sau null, ok cu multiple. Single = exact unul sau exception. SingleOrDefault = unul sau null, exception dacă multiple.',
    formal_definition = 'FirstOrDefault: returnează primul element sau default. Single: așteaptă exact unul, aruncă dacă zero sau multiple. SingleOrDefault: așteaptă zero sau unul, aruncă dacă multiple.',
    interview_answer = 'Folosesc FirstOrDefault când vreau primul match și nu contează dacă mai există. Single când aștept exact unul (aruncă dacă nu). SingleOrDefault când aștept zero sau unul (aruncă dacă multiple). Single/SingleOrDefault impun asumpția de unicitate.',
    pitfalls = to_jsonb(ARRAY[
      'Single când multiple posibile',
      'Nu verifici null la FirstOrDefault',
      'First fără OrDefault',
      'Alegere greșită cauzeză exceptions',
      'Diferența de performanță ignorată'
    ]),
    diagram = 'FirstOrDefault vs Single:

Date: [A, B, C, C]

FirstOrDefault(x => x == C):
  → C (primul)
  Ok cu multiple

Single(x => x == C):
  → Exception! (multiple)
  
SingleOrDefault(x => x == C):
  → Exception! (multiple)

Date: [A, B]

FirstOrDefault(x => x == Z):
  → null
  
Single(x => x == Z):
  → Exception! (none)'
  WHERE term = 'FirstOrDefault vs Single vs SingleOrDefault' AND language = 'ro';

  -- SQL Joins
  UPDATE terms SET
    eli5 = 'INNER JOIN = doar rânduri cu potriviri în ambele tabele. LEFT JOIN = tot din stânga + potriviri din dreapta. RIGHT JOIN = tot din dreapta + potriviri din stânga.',
    formal_definition = 'INNER JOIN: returnează rânduri când există potriviri în ambele tabele. LEFT JOIN: toate rândurile din tabelul stâng + potriviri din drept (NULL dacă lipsesc). RIGHT/FULL pentru opusul/combinație.',
    interview_answer = 'INNER JOIN când vreau doar înregistrările cu potriviri în ambele tabele - cel mai comun. LEFT JOIN când vreau TOT din prima tabelă și doar potriviri din a doua - exemplu users + orders lor (inclusiv useri fără orders). RIGHT JOIN rar folosit. FULL JOIN foarte rar. Join pe foreign key pentru relații.',
    pitfalls = to_jsonb(ARRAY[
      'INNER când ar trebui LEFT',
      'Performanță fără indexuri pe join columns',
      'Cartesian product (lipsește ON)',
      'Multiple joins fără înțelegere',
      'NULL handling în LEFT JOIN'
    ]),
    diagram = 'SQL Joins:

Users:        Orders:
id | name     id | user_id | total
1  | Ion     1  | 1       | 100
2  | Ana     2  | 1       | 50
3  | Dan     3  | 2       | 200

INNER JOIN:
1 | Ion | 100
1 | Ion | 50
2 | Ana | 200

LEFT JOIN:
1 | Ion | 100
1 | Ion | 50
2 | Ana | 200
3 | Dan | NULL'
  WHERE term = 'SQL JOIN-uri' AND language = 'ro';

  -- Big O
  UPDATE terms SET
    eli5 = 'Big O = cât de repede crește timpul când datele cresc. O(1) = constant (instant). O(n) = liniar (dublu date = dublu timp). O(n²) = pătratic (dublu date = de 4 ori mai mult timp).',
    formal_definition = 'Big O Notation descrie complexitatea timp/spațiu în cel mai rău caz. O(1) constant, O(log n) logaritmic, O(n) liniar, O(n log n) linearitmic, O(n²) pătratic, O(2^n) exponențial.',
    interview_answer = 'Big O descrie cât de bine scalează un algoritm. O(1) - access array by index, constant. O(log n) - binary search, foarte rapid. O(n) - iterare printr-o listă. O(n log n) - merge sort, quick sort. O(n²) - nested loops, evit pentru date mari. Important pentru performanță la scară - diferența dintre O(n) și O(n²) e uriașă la 1 milion elemente.',
    pitfalls = to_jsonb(ARRAY[
      'Confuzie worst case vs average case',
      'Ignori constante (O(2n) tot O(n))',
      'Nu înțelegi log n',
      'Optimizare prematură',
      'Nu măsori real, doar presupui'
    ]),
    diagram = 'Big O Complexity:

n=10    n=100   n=1000
O(1)     1      1       1
O(log n) 3      7       10
O(n)     10     100     1000
O(n log) 30     700     10000
O(n²)    100    10000   1000000

O(1)    ✓✓✓ Cel mai rapid
O(log n) ✓✓ Foarte rapid
O(n)     ✓  Ok
O(n²)    ✗  Lent pentru date mari'
  WHERE term = 'Complexitate Big O' AND language = 'ro';

  -- Async/Await
  UPDATE terms SET
    eli5 = 'Async/await = așteaptă fără a bloca thread-ul. UI rămâne responsive, thread-ul e liber să facă altceva în timp ce așteaptă I/O.',
    formal_definition = 'Async/await pattern pentru operații asincrone non-blocking. Async marchează metoda, await suspendă execuția fără a bloca thread-ul. Task returnează rezultat viitor.',
    interview_answer = 'Async/await rezolvă blocking pe I/O. Await eliberează thread-ul înapoi în pool în timp ce așteaptă. UI rămâne responsive. Folosesc pentru DB calls, HTTP requests, file I/O. Trebuie ConfigureAwait(false) în librării pentru deadlock prevention. Întotdeauna gestionez exceptions în metode async.',
    pitfalls = to_jsonb(ARRAY[
      'Async void (doar pentru event handlers)',
      'Deadlocks cu .Result sau .Wait()',
      'ConfigureAwait necunoscut',
      'Nu propagă async până la top',
      'Fire-and-forget fără error handling'
    ]),
    diagram = 'Async/Await:

Sincron (blocking):
Thread ocupat →→→→→ 5s
[====WAIT DB====]
UI înghețată ✗

Async (non-blocking):
Thread liber ↓
[~await DB~]
  ↓ Thread face altceva
  ↓ Thread e în pool
5s mai târziu ↑
Continuă
UI responsive ✓'
  WHERE term = 'Async/Await' AND language = 'ro';

  -- SOLID Principles
  UPDATE terms SET
    eli5 = 'SOLID = 5 principii pentru cod bun: S (o responsabilitate), O (deschis extend, închis modify), L (substitute classes), I (interfețe mici), D (depend pe abstracții).',
    formal_definition = 'SOLID: Single Responsibility (o clasă, o responsabilitate), Open/Closed (deschis extensie, închis modificare), Liskov Substitution (clase derivate substituibile), Interface Segregation (interfețe mici, specifice), Dependency Inversion (depend pe abstracții nu pe concret).',
    interview_answer = 'SOLID sunt 5 principii pentru OOP mentenabil. Single Responsibility - o clasă face UN lucru. Open/Closed - extind prin moștenire/interfețe, nu modific cod existent. Liskov - Dog poate înlocui Animal peste tot. Interface Segregation - multe interfețe mici, nu una mare. Dependency Inversion - clasele depind de ILogger, nu de ConsoleLogger concret. Fac codul testabil, extensibil, mentenabil.',
    pitfalls = to_jsonb(ARRAY[
      'Over-engineering în numele SOLID',
      'Nu înțelegi când să aplici fiecare',
      'LSP violations în ierarhii',
      'Fat interfaces (ISP violation)',
      'Aplici rigid fără context'
    ]),
    diagram = 'SOLID Principles:

S - Single Responsibility
    O clasă = 1 motiv să se schimbe

O - Open/Closed
    Deschis extensie
    Închis modificare

L - Liskov Substitution
    Derived substituie Base

I - Interface Segregation
    Multe interfețe mici

D - Dependency Inversion
    Depend pe abstracții'
  WHERE term = 'SOLID Principles' AND language = 'ro';

  RAISE NOTICE 'Translated .NET, SQL, CS terms to Romanian';
END $$;

import { useState } from 'react';
import { Search, Copy, Check, BookMarked } from 'lucide-react';

export function BibliaGiga() {
  const [searchTerm, setSearchTerm] = useState('');
  const [copiedId, setCopiedId] = useState<string | null>(null);

  const copyToClipboard = (text: string, id: string) => {
    navigator.clipboard.writeText(text);
    setCopiedId(id);
    setTimeout(() => setCopiedId(null), 2000);
  };

  const glossaryTerms = [
    {
      category: 'OOP - Concepte Fundamentale',
      items: [
        { term: 'Class (Clasă)', def: 'Un șablon/blueprint care definește structura și comportamentul obiectelor. Conține proprietăți (fields) și metode.' },
        { term: 'Object (Obiect)', def: 'O instanță concretă a unei clase. Creată cu operatorul `new`.' },
        { term: 'Encapsulation (Încapsulare)', def: 'Ascunderea detaliilor interne ale unui obiect și expunerea doar a ceea ce e necesar prin API public (metode publice).' },
        { term: 'Inheritance (Moștenire)', def: 'Mecanismul prin care o clasă derivată (child) preia proprietăți și metode de la o clasă de bază (parent).' },
        { term: 'Polymorphism (Polimorfism)', def: 'Capacitatea unui obiect de a lua multiple forme. Un obiect derivat poate fi tratat ca obiectul său de bază.' },
        { term: 'Abstraction (Abstractizare)', def: 'Ascunderea complexității implementării și expunerea doar a funcționalității esențiale prin interfețe sau clase abstracte.' },
        { term: 'Constructor', def: 'O metodă specială apelată automat când se creează un obiect nou. Inițializează proprietățile obiectului.' },
        { term: 'Destructor', def: 'Metodă specială în C++ apelată când un obiect este distrus. În C# există finalizatori (cu `~`).' },
        { term: 'Access Modifiers', def: 'Cuvinte cheie care controlează vizibilitatea: `public`, `private`, `protected`, `internal`.' },
        { term: 'Property (Proprietate)', def: 'Membru al clasei în C# care oferă un mod flexibil de a citi, scrie sau calcula valori cu `get` și `set`.' },
        { term: 'Method (Metodă)', def: 'Funcție definită într-o clasă care definește comportamentul obiectelor.' },
        { term: 'Static', def: 'Membru al clasei care aparține clasei însuși, nu instanței. Se accesează direct prin numele clasei.' },
        { term: 'Virtual', def: 'Cuvânt cheie care permite unei metode să fie suprascrisă în clase derivate.' },
        { term: 'Override', def: 'Cuvânt cheie folosit pentru a suprascrie o metodă virtuală din clasa de bază.' },
        { term: 'Abstract Class', def: 'Clasă care nu poate fi instanțiată direct și poate conține metode abstracte (fără implementare).' },
        { term: 'Interface (Interfață)', def: 'Contract care definește semnăturile metodelor pe care clasele trebuie să le implementeze. Nu conține implementare.' },
        { term: 'Sealed Class', def: 'Clasă care nu poate fi moștenită în C#.' },
        { term: 'Partial Class', def: 'Clasă în C# ale cărei definiție poate fi împărțită în mai multe fișiere.' },
      ]
    },
    {
      category: 'C# Fundamentals',
      items: [
        { term: 'Namespace', def: 'Grup logic de clase înrudite. Previne conflictele de nume.' },
        { term: 'Using Directive', def: 'Cuvânt cheie pentru a importa namespace-uri: `using System;`' },
        { term: 'Value Types', def: 'Tipuri care stochează date direct (int, bool, struct). Stocate pe stack.' },
        { term: 'Reference Types', def: 'Tipuri care stochează o referință către date (class, string, array). Stocate pe heap.' },
        { term: 'Nullable Types', def: 'Permite tipurilor valoare să conțină `null`: `int? x = null;`' },
        { term: 'Var', def: 'Cuvânt cheie pentru inferență de tip: `var x = 5;` (compilatorul deduce `int`).' },
        { term: 'Const', def: 'Variabilă constantă care nu poate fi modificată după inițializare.' },
        { term: 'Readonly', def: 'Câmp care poate fi setat doar în constructor sau la declarare.' },
        { term: 'String Interpolation', def: 'Sintaxă pentru inserarea variabilelor în string-uri: `$"Hello {name}"`' },
        { term: 'String Immutability', def: 'String-urile în C# sunt imutabile - orice modificare creează un string nou.' },
        { term: 'StringBuilder', def: 'Clasă pentru manipularea eficientă a string-urilor mutabile.' },
        { term: 'Delegate', def: 'Tip care reprezintă referințe către metode cu semnătură specifică.' },
        { term: 'Event', def: 'Mecanism prin care o clasă poate notifica alte clase când ceva se întâmplă.' },
        { term: 'Lambda Expression', def: 'Funcție anonimă scrisă compact: `(x, y) => x + y`' },
        { term: 'LINQ', def: 'Language Integrated Query - sintaxă pentru interogarea colecțiilor de date.' },
        { term: 'Extension Methods', def: 'Metode care "adaugă" funcționalitate la tipuri existente fără a le modifica.' },
        { term: 'Generics', def: 'Permite definirea claselor/metodelor cu parametri de tip: `List<T>`' },
        { term: 'Exception Handling', def: 'Gestionarea erorilor cu `try-catch-finally`.' },
        { term: 'Async/Await', def: 'Cuvinte cheie pentru programare asincronă non-blocantă.' },
        { term: 'Task', def: 'Reprezintă o operație asincronă care poate returna o valoare: `Task<T>`' },
      ]
    },
    {
      category: 'Advanced C# Concepts',
      items: [
        { term: 'IEnumerable', def: 'Interfață pentru colecții iterabile. Permite folosirea `foreach`.' },
        { term: 'ICollection', def: 'Extinde `IEnumerable` cu metode pentru adăugare/ștergere și proprietatea `Count`.' },
        { term: 'IList', def: 'Extinde `ICollection` cu acces prin index: `list[0]`' },
        { term: 'Array', def: 'Colecție de dimensiune fixă de elemente de același tip.' },
        { term: 'List<T>', def: 'Colecție dinamică generică care poate crește sau scădea.' },
        { term: 'Dictionary<K,V>', def: 'Colecție de perechi cheie-valoare pentru căutări rapide.' },
        { term: 'HashSet<T>', def: 'Colecție de valori unice, fără duplicate.' },
        { term: 'Queue<T>', def: 'Colecție FIFO (First In First Out).' },
        { term: 'Stack<T>', def: 'Colecție LIFO (Last In First Out).' },
        { term: 'Tuple', def: 'Structură care poate conține multiple valori de tipuri diferite.' },
        { term: 'Record', def: 'Tip referință imutabil în C# 9+ cu egalitate bazată pe valoare.' },
        { term: 'Pattern Matching', def: 'Verificarea dacă o valoare are o anumită formă și extragerea informațiilor din ea.' },
        { term: 'Deconstruction', def: 'Descompunerea unui obiect în componentele sale: `var (x, y) = point;`' },
        { term: 'Indexer', def: 'Permite accesul la obiecte ca și la array-uri: `obj[index]`' },
        { term: 'Operator Overloading', def: 'Redefinirea comportamentului operatorilor pentru tipuri personalizate.' },
        { term: 'Implicit/Explicit', def: 'Operatori pentru conversii de tip personalizate.' },
        { term: 'Reflection', def: 'Capacitatea de a inspecta metadata tipurilor în timpul execuției.' },
        { term: 'Attributes', def: 'Metadata adăugată la cod pentru a oferi informații suplimentare.' },
        { term: 'Dynamic', def: 'Tip care bypass verificarea de tip la compilare.' },
        { term: 'Covariance/Contravariance', def: 'Permite conversii implicite pentru tipuri generice folosind `in` și `out`.' },
      ]
    },
    {
      category: '.NET & EF Core',
      items: [
        { term: 'ASP.NET Core', def: 'Framework open-source pentru dezvoltarea aplicațiilor web moderne.' },
        { term: 'Middleware', def: 'Componente software care procesează cereri HTTP în pipeline-ul ASP.NET.' },
        { term: 'Dependency Injection', def: 'Pattern de design în care dependențele sunt injectate în loc să fie create manual.' },
        { term: 'DbContext', def: 'Clasă principală în EF Core pentru interacțiunea cu baza de date.' },
        { term: 'Entity Framework Core', def: 'ORM (Object-Relational Mapper) pentru lucrul cu baze de date folosind obiecte C#.' },
        { term: 'Migration', def: 'Mecanism pentru versionarea și aplicarea schimbărilor schemei de bază de date.' },
        { term: 'Code First', def: 'Abordare în care definești modele C# și EF creează baza de date.' },
        { term: 'Database First', def: 'Abordare în care pornești de la o bază de date existentă și generezi modele.' },
        { term: 'LINQ to Entities', def: 'Folosirea LINQ pentru a interoga baza de date prin EF Core.' },
        { term: 'Lazy Loading', def: 'Date navigaționale încărcate automat când sunt accesate prima dată.' },
        { term: 'Eager Loading', def: 'Încărcarea datelor navigaționale explicit cu `.Include()`.' },
        { term: 'Explicit Loading', def: 'Încărcarea manuală a datelor navigaționale cu `.Load()`.' },
        { term: 'Navigation Properties', def: 'Proprietăți care definesc relații între entități.' },
        { term: 'Fluent API', def: 'API pentru configurarea EF Core prin cod în `OnModelCreating`.' },
        { term: 'Data Annotations', def: 'Atribute folosite pentru configurarea modelelor EF Core.' },
        { term: 'Repository Pattern', def: 'Pattern care abstractizează accesul la date și oferă o interfață consistentă.' },
        { term: 'Unit of Work', def: 'Pattern care menține o listă de obiecte afectate de o tranzacție de business.' },
        { term: 'Service Layer', def: 'Strat care conține logica de business între controller și repository.' },
        { term: 'DTO (Data Transfer Object)', def: 'Obiect folosit pentru transferul de date între straturi, fără logică de business.' },
        { term: 'AutoMapper', def: 'Bibliotecă pentru maparea automată între obiecte (ex: Entity la DTO).' },
      ]
    },
    {
      category: 'SQL & Databases',
      items: [
        { term: 'Primary Key', def: 'Coloană sau set de coloane care identifică unic fiecare rând într-o tabelă.' },
        { term: 'Foreign Key', def: 'Coloană care creează o relație cu primary key-ul din altă tabelă.' },
        { term: 'Index', def: 'Structură de date care îmbunătățește viteza de căutare în tabele.' },
        { term: 'JOIN', def: 'Operație care combină rânduri din două sau mai multe tabele.' },
        { term: 'INNER JOIN', def: 'Returnează doar rândurile care au match în ambele tabele.' },
        { term: 'LEFT JOIN', def: 'Returnează toate rândurile din tabelul stâng și match-urile din cel drept.' },
        { term: 'RIGHT JOIN', def: 'Returnează toate rândurile din tabelul drept și match-urile din cel stâng.' },
        { term: 'OUTER JOIN', def: 'Returnează rânduri când există match în una din tabele.' },
        { term: 'Normalization', def: 'Procesul de organizare a datelor pentru reducerea redundanței.' },
        { term: '1NF, 2NF, 3NF', def: 'Forme normale de normalizare a bazelor de date.' },
        { term: 'Transaction', def: 'Grup de operații de bază de date tratate ca o unitate atomică.' },
        { term: 'ACID', def: 'Atomicity, Consistency, Isolation, Durability - proprietăți ale tranzacțiilor.' },
        { term: 'Stored Procedure', def: 'Set de comenzi SQL stocate în baza de date care pot fi executate repetat.' },
        { term: 'View', def: 'Interogare SQL stocată care poate fi tratată ca o tabelă virtuală.' },
        { term: 'Trigger', def: 'Procedură care se execută automat când anumite evenimente apar în baza de date.' },
        { term: 'Aggregate Functions', def: 'Funcții care efectuează calcule pe un set de valori: `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`.' },
        { term: 'GROUP BY', def: 'Clauză SQL care grupează rânduri cu valori identice.' },
        { term: 'HAVING', def: 'Clauză care filtrează rezultate după `GROUP BY`.' },
        { term: 'Subquery', def: 'Interogare SQL cuibărită în interiorul altei interogări.' },
        { term: 'CTE (Common Table Expression)', def: 'Expresie temporară definită cu `WITH` pentru interogări complexe.' },
      ]
    },
    {
      category: 'HTTP & REST APIs',
      items: [
        { term: 'HTTP', def: 'HyperText Transfer Protocol - protocol pentru comunicare client-server pe web.' },
        { term: 'HTTPS', def: 'HTTP Secure - versiunea criptată a HTTP folosind SSL/TLS.' },
        { term: 'REST', def: 'Representational State Transfer - stil arhitectural pentru API-uri web.' },
        { term: 'RESTful', def: 'API care respectă principiile REST.' },
        { term: 'GET', def: 'Metodă HTTP pentru a citi/obține resurse. Idempotentă și safe.' },
        { term: 'POST', def: 'Metodă HTTP pentru a crea resurse noi.' },
        { term: 'PUT', def: 'Metodă HTTP pentru a actualiza complet o resursă existentă.' },
        { term: 'PATCH', def: 'Metodă HTTP pentru a actualiza parțial o resursă.' },
        { term: 'DELETE', def: 'Metodă HTTP pentru a șterge o resursă.' },
        { term: 'Status Code', def: 'Cod numeric care indică rezultatul unei cereri HTTP.' },
        { term: '200 OK', def: 'Cerere reușită.' },
        { term: '201 Created', def: 'Resursă creată cu succes.' },
        { term: '204 No Content', def: 'Cerere reușită fără conținut de returnat.' },
        { term: '400 Bad Request', def: 'Cerere invalidă din partea clientului.' },
        { term: '401 Unauthorized', def: 'Autentificare necesară.' },
        { term: '403 Forbidden', def: 'Client autentificat dar fără permisiuni.' },
        { term: '404 Not Found', def: 'Resursa nu a fost găsită.' },
        { term: '500 Internal Server Error', def: 'Eroare generală pe server.' },
        { term: 'Idempotence', def: 'Proprietate prin care multiple cereri identice au același efect ca o singură cerere.' },
        { term: 'Endpoint', def: 'URL care identifică o resursă specifică: `/api/users/123`' },
        { term: 'Request Body', def: 'Date trimise în corpul cererii (folosit cu POST/PUT).' },
        { term: 'Response Body', def: 'Date returnate în corpul răspunsului.' },
        { term: 'Headers', def: 'Metadata suplimentare trimise în cereri și răspunsuri.' },
        { term: 'Query Parameters', def: 'Parametri adăugați la URL: `/api/users?page=1&limit=10`' },
        { term: 'CORS', def: 'Cross-Origin Resource Sharing - mecanism care permite cereri între domenii diferite.' },
        { term: 'JWT', def: 'JSON Web Token - token compact pentru autentificare și schimb de informații.' },
        { term: 'OAuth', def: 'Protocol de autorizare pentru acces delegat sigur.' },
        { term: 'API Versioning', def: 'Gestionarea versiunilor API: `/api/v1/users`' },
        { term: 'Rate Limiting', def: 'Limitarea numărului de cereri pe care un client le poate face.' },
        { term: 'Pagination', def: 'Împărțirea rezultatelor mari în pagini mai mici.' },
      ]
    },
    {
      category: 'Testing',
      items: [
        { term: 'Unit Test', def: 'Test care verifică funcționalitatea unei singure unități de cod (metodă/clasă).' },
        { term: 'Integration Test', def: 'Test care verifică interacțiunea dintre multiple componente.' },
        { term: 'End-to-End Test', def: 'Test care verifică fluxul complet al aplicației din perspectiva utilizatorului.' },
        { term: 'AAA Pattern', def: 'Arrange-Act-Assert - structură standard pentru testele unitare.' },
        { term: 'Test Framework', def: 'Bibliotecă pentru scrierea și rularea testelor: xUnit, NUnit, MSTest.' },
        { term: 'Assertion', def: 'Verificare că rezultatul actual corespunde cu cel așteptat.' },
        { term: 'Mock', def: 'Obiect fals care simulează comportamentul unui obiect real în teste.' },
        { term: 'Stub', def: 'Implementare simplificată a unei dependențe care returnează date predefinite.' },
        { term: 'Fake', def: 'Implementare funcțională simplificată pentru testare (ex: InMemory database).' },
        { term: 'Test Coverage', def: 'Procentul de cod acoperit de teste.' },
        { term: 'TDD (Test-Driven Development)', def: 'Metodologie unde testele sunt scrise înaintea codului.' },
        { term: 'Mocking Framework', def: 'Bibliotecă pentru crearea mock-urilor: Moq, NSubstitute.' },
        { term: 'Test Fixture', def: 'Set de obiecte și date folosite ca bază pentru teste.' },
        { term: 'Setup/Teardown', def: 'Metode executate înainte/după fiecare test pentru pregătire și curățare.' },
        { term: 'Parameterized Test', def: 'Test care rulează de multiple ori cu seturi diferite de date.' },
        { term: 'Flaky Test', def: 'Test care eșuează sau reușește intermitent fără modificări de cod.' },
      ]
    }
  ];

  const filteredGlossary = searchTerm
    ? glossaryTerms.map(category => ({
        ...category,
        items: category.items.filter(item =>
          item.term.toLowerCase().includes(searchTerm.toLowerCase()) ||
          item.def.toLowerCase().includes(searchTerm.toLowerCase())
        )
      })).filter(category => category.items.length > 0)
    : glossaryTerms;

  return (
    <div className="max-w-7xl mx-auto">
      <div className="bg-gradient-to-r from-orange-600 to-red-600 rounded-xl p-8 mb-8 border-4 border-yellow-400 shadow-2xl">
        <div className="flex items-center gap-4 mb-4">
          <BookMarked size={48} className="text-white" />
          <div>
            <h1 className="text-4xl font-bold text-white">BIBLIA GIGA</h1>
            <p className="text-orange-100 text-lg">Ghidul complet în română pentru interviul Trimble</p>
          </div>
        </div>
        <p className="text-white text-lg leading-relaxed">
          Toate conceptele esențiale pentru interviul tău de internship, organizate pe categorii și explicate simplu.
          Folosește căutarea pentru a găsi rapid termenii pe care vrei să-i studiezi.
        </p>
      </div>

      <div className="bg-gray-800 rounded-xl p-6 mb-8 border border-gray-700">
        <div className="flex items-center gap-3 mb-4">
          <Search className="text-cyan-400" size={24} />
          <h2 className="text-2xl font-bold text-white">Caută în glosar</h2>
        </div>
        <input
          type="text"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          placeholder="Caută termeni sau definiții... (ex: 'async', 'OOP', 'REST')"
          className="w-full bg-gray-900 text-white px-4 py-3 rounded-lg border border-gray-600 focus:border-cyan-400 focus:outline-none"
        />
        {searchTerm && (
          <p className="text-gray-400 text-sm mt-2">
            {filteredGlossary.reduce((acc, cat) => acc + cat.items.length, 0)} rezultate găsite
          </p>
        )}
      </div>

      <div className="space-y-6">
        <div className="bg-gray-800 rounded-xl p-6 border border-gray-700">
          <h2 className="text-3xl font-bold text-white mb-2">Glosar Complet Tehnic</h2>
          <p className="text-gray-400">
            Toate conceptele de care ai nevoie pentru interviu, organizate pe categorii cu explicații clare în română
          </p>
        </div>

        {filteredGlossary.map((category, catIdx) => (
          <div
            key={catIdx}
            className="bg-gray-800 rounded-xl p-6 border border-gray-700"
          >
            <h3 className="text-2xl font-bold text-cyan-400 mb-4">{category.category}</h3>
            <div className="space-y-4">
              {category.items.map((item, itemIdx) => (
                <div key={itemIdx} className="bg-gray-900 rounded-lg p-4 border border-gray-700">
                  <h4 className="text-lg font-semibold text-white mb-2">{item.term}</h4>
                  <p className="text-gray-300 leading-relaxed">{item.def}</p>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>

      <div className="mt-12 bg-gradient-to-r from-green-600 to-teal-600 rounded-xl p-8 border border-green-400">
        <h2 className="text-3xl font-bold text-white mb-6">Sfaturi pentru Interviul Trimble</h2>

        <div className="space-y-6">
          <div className="bg-white/10 rounded-lg p-6">
            <h3 className="text-xl font-bold text-white mb-3">1. Despre această aplicație (arma ta secretă)</h3>
            <p className="text-white mb-3">Puncte gata de spus în interviu:</p>
            <ul className="list-disc list-inside space-y-2 text-white">
              <li>Am construit o platformă de studiu folosind React, TypeScript, și Supabase</li>
              <li>168 termeni tehnici, 751 întrebări de quiz, 15 laboratoare interactive de cod</li>
              <li>Integrare cu Gemini AI pentru evaluarea răspunsurilor și învățare adaptivă</li>
              <li>Arată automotivare, inițiativă și abilități full-stack complete</li>
            </ul>
          </div>

          <div className="bg-white/10 rounded-lg p-6">
            <h3 className="text-xl font-bold text-white mb-3">2. Când ți se blochează mintea în interviu</h3>
            <div className="space-y-3 text-white">
              <div>
                <p className="font-semibold mb-1">Câștigă timp:</p>
                <p>"Întrebare interesantă. Lăsați-mă să mă gândesc câteva secunde..."</p>
              </div>
              <div>
                <p className="font-semibold mb-1">Reset mental:</p>
                <p>Respiră adânc 3 secunde, cere clarificare, gândește cu voce tare procesul tău</p>
              </div>
              <div>
                <p className="font-semibold mb-1">Când nu știi ceva:</p>
                <p>"Nu am lucrat direct cu [X], dar înțeleg conceptul similar [Y] și aș aborda problema astfel..."</p>
              </div>
            </div>
          </div>

          <div className="bg-white/10 rounded-lg p-6">
            <h3 className="text-xl font-bold text-white mb-3">3. Fraze cu impact maxim (sună profesionist)</h3>
            <ul className="space-y-2 text-white">
              <li>• "Aleg override pentru polimorfism real; new e doar hiding și evit să-l folosesc"</li>
              <li>• "PUT e idempotent pentru actualizări; POST creează resurse noi"</li>
              <li>• "Folosesc 200 pentru succes, 201 pentru creare, 204 pentru ștergeri"</li>
              <li>• "Pun AsNoTracking în EF Core pentru query-uri read-only și performanță"</li>
              <li>• "Unit testele verifică o singură metodă izolat; integration testele verifică componente împreună"</li>
            </ul>
          </div>

          <div className="bg-white/10 rounded-lg p-6">
            <h3 className="text-xl font-bold text-white mb-3">4. Boostere de încredere (ești pregătit!)</h3>
            <ul className="space-y-2 text-white">
              <li>✅ Ai construit această aplicație GIGA de studiu - demonstrează inițiativă</li>
              <li>✅ Cunoști OOP, C#, SQL, TypeScript, React - toate cerute de Trimble</li>
              <li>✅ Ai experiență cu proiecte full-stack reale</li>
              <li>✅ Înțelegi concepte de arhitectură și best practices</li>
              <li>✅ Ei caută potențial și entuziasm, nu perfecțiune</li>
            </ul>
          </div>

          <div className="bg-white/10 rounded-lg p-6">
            <h3 className="text-xl font-bold text-white mb-3">5. Întrebări să le pui tu (arată interes)</h3>
            <ul className="space-y-2 text-white">
              <li>• "Ce tehnologii voi folosi în primele luni de internship?"</li>
              <li>• "Cum arată o zi tipică pentru un intern în echipa voastră?"</li>
              <li>• "Cum funcționează procesul de code review?"</li>
              <li>• "Ce oportunități de învățare și mentorat sunt disponibile?"</li>
              <li>• "Ce provocări tehnice interesante rezolvă echipa acum?"</li>
            </ul>
          </div>
        </div>

        <div className="mt-8 bg-white/20 rounded-lg p-6 text-center">
          <p className="text-2xl font-bold text-white mb-2">
            AI TOATE INSTRUMENTELE NECESARE!
          </p>
          <p className="text-lg text-white">
            Acum e timpul să le folosești cu încredere. SUCCES! 🚀
          </p>
        </div>
      </div>
    </div>
  );
}

/*
  # Translate OOP Terms Content to Romanian
  
  Translate eli5, formal_definition, interview_answer, pitfalls, diagrams for OOP terms
*/

DO $$
BEGIN
  -- 4 Pillars of OOP
  UPDATE terms SET
    eli5 = 'Cei 4 piloni: Encapsulare (ascunde detalii în clase), Abstractizare (arată doar ce e necesar), Moștenire (clase copil preiau de la părinte), Polimorfism (aceeași metodă, comportament diferit).',
    formal_definition = 'Cei 4 piloni OOP: Encapsulation (date private + metode publice), Abstraction (ascunde complexitatea), Inheritance (reutilizare prin moștenire), Polymorphism (o metodă, multe forme).',
    interview_answer = 'Cei 4 piloni sunt fundamentali: 1) Encapsulation - păstrezi datele private și oferi acces controlat prin metode publice. 2) Abstraction - ascunzi detalii complexe, expui doar interfața necesară. 3) Inheritance - clasele derivate moștenesc comportament de la clase de bază, reutilizezi cod. 4) Polymorphism - metodele override în clase derivate permit comportament diferit pentru aceeași metodă. Acești piloni fac codul modular, reutilizabil și ușor de întreținut.',
    pitfalls = to_jsonb(ARRAY[
      'A confunda abstractizarea cu encapsularea',
      'Moștenire excesivă în loc de compoziție',
      'A nu înțelege polimorfismul real (override vs new)',
      'Încapsulare slabă (totul public)',
      'A folosi moștenire doar pentru reutilizare cod'
    ]),
    diagram = 'Cei 4 Piloni OOP:

1. ENCAPSULARE
   [Date Private]
   ↓ Acces controlat
   [Metode Publice]

2. ABSTRACTIZARE
   [Interfață Simplă]
   ↓ Ascunde
   [Logică Complexă]

3. MOȘTENIRE
   [Părinte: Animal]
   ↓ moștenește
   [Copil: Dog, Cat]

4. POLIMORFISM
   Animal a = new Dog();
   a.Speak(); → Woof!
   Comportament dinamic'
  WHERE term = 'Cei 4 Piloni OOP' AND language = 'ro';

  -- Encapsulation
  UPDATE terms SET
    eli5 = 'Ascunzi detaliile interne ale unui obiect. Date private, acces doar prin metode publice. Ca o capsulă - interiorul e protejat.',
    formal_definition = 'Encapsulation înseamnă gruparea datelor (fields) și metodelor care operează pe acele date într-o singură unitate (clasă), restricționând accesul direct la date prin modificatori de acces.',
    interview_answer = 'Encapsulation înseamnă să păstrezi datele private și să expui doar metode publice pentru accesare. De exemplu, în C# folosesc fields private și properties publice. Beneficii: control asupra datelor, validare, flexibilitate la schimbări interne fără a afecta codul care folosește clasa.',
    pitfalls = to_jsonb(ARRAY[
      'Totul public - încalcă encapsularea',
      'Getters/Setters pentru toate fields automat',
      'Expui colecții mutabile direct',
      'Nu validezi în setters',
      'Încapsulare excesivă'
    ]),
    diagram = 'Encapsulare:

[Clasa Animal]
├─ name (private) ← Ascuns
├─ age (private)  ← Ascuns
├─ GetName()      ← Public
├─ SetAge(int)    ← Public
└─ Eat()          ← Public

Acces doar prin metode publice
Date protejate, controlate'
  WHERE term = 'Encapsulare' AND language = 'ro';

  -- Polimorfism
  UPDATE terms SET
    eli5 = 'Aceeași metodă, comportament diferit. Animal.Speak() - Dog face Woof, Cat face Meow. Decide la runtime ce metodă să apeleze.',
    formal_definition = 'Polymorphism permite obiectelor de clase diferite să răspundă diferit la aceeași metodă. Realizat prin method overriding (runtime) sau overloading (compile-time).',
    interview_answer = 'Polymorphism înseamnă o metodă, multe forme. Exemplu: Animal a = new Dog(); a.Speak() returnează Woof. Chiar dacă variabila e tip Animal, se apelează Dog.Speak() pentru că obiectul real e Dog. Realizez cu virtual/override în C#. Beneficii: cod flexibil, extensibil fără modificări.',
    pitfalls = to_jsonb(ARRAY[
      'Confuzie override vs new',
      'Uiți virtual în clasa de bază',
      'Casting greșit la runtime',
      'A nu înțelege binding dinamic vs static',
      'Performanță - polimorfismul e mai lent'
    ]),
    diagram = 'Polimorfism:

Animal animal1 = new Dog();
Animal animal2 = new Cat();

animal1.Speak(); → Woof!
animal2.Speak(); → Meow!

Runtime hotărăște ce Speak()
în funcție de obiectul real'
  WHERE term = 'Polimorfism' AND language = 'ro';

  -- Moștenire
  UPDATE terms SET
    eli5 = 'O clasă copil preia tot de la părinte. Dog moștenește de la Animal - are automat Eat(), Sleep(), plus propriile metode Bark().',
    formal_definition = 'Inheritance permite unei clase (derived/child) să moștenească membri de la o altă clasă (base/parent), promovând reutilizarea codului.',
    interview_answer = 'Inheritance înseamnă că o clasă derivată moștenește comportament de la clasa de bază. Dog moștene de la Animal - Dog capătă automat Eat(), Sleep(). Avantaje: reutilizare cod, ierarhie logică. Prefer compoziție peste moștenire când e posibil - moștenirea creează cuplare tare.',
    pitfalls = to_jsonb(ARRAY[
      'Ierarhii prea adânci',
      'Moștenire doar pentru reutilizare',
      'Diamond problem',
      'Încalcă Liskov Substitution',
      'Tight coupling'
    ]),
    diagram = 'Moștenire:

    [Animal]
    ├─ Eat()
    └─ Sleep()
         ↓ moștenește
    ┌────┴────┬────┐
  [Dog]    [Cat]  [Bird]
  +Bark()  +Meow() +Fly()

Toți au Eat(), Sleep()
Fiecare adaugă specific'
  WHERE term = 'Moștenire' AND language = 'ro';

  -- Interfaces vs Abstract Classes
  UPDATE terms SET
    eli5 = 'Interface = contract pur (ce trebuie făcut). Abstract class = șablon parțial (cod comun + părți de completat).',
    formal_definition = 'Interface definește un contract (metode fără implementare). Abstract class poate avea implementări parțiale, constructori, fields. O clasă poate implementa multiple interfețe dar moșteni doar o clasă abstractă.',
    interview_answer = 'Folosesc interface când vreau doar un contract - ce metode trebuie implementate. Abstract class când am cod comun de partajat. Prefer interfețe pentru flexibilitate, abstract classes pentru cod partajat.',
    pitfalls = to_jsonb(ARRAY[
      'Abstract class când interface ar fi suficient',
      'Interfețe prea mari',
      'A nu folosi composability',
      'Abstract class fără metode abstracte',
      'Confuzie când să folosești fiecare'
    ]),
    diagram = 'Interface vs Abstract:

INTERFACE IPayment
├─ Pay() ← contract
└─ Refund() ← fără cod

ABSTRACT CLASS Payment
├─ TransactionId ← field
├─ Log() ← implementat
└─ Process() ← abstract

Clasă: multe interfețe
      o singură abstract class'
  WHERE term = 'Interfețe vs Clase Abstracte' AND language = 'ro';

  RAISE NOTICE 'Translated OOP terms content to Romanian';
END $$;

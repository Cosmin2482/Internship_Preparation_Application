/*
  # Complete Romanian OOP Terms
  
  Add remaining 3 OOP pillars and other important OOP concepts in Romanian
*/

DO $$
DECLARE
  cat_romanian uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_romanian FROM categories WHERE slug = 'romanian';

  -- Moștenire (Inheritance)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'Moștenire (Inheritance)',
    'O clasă copil preia proprietățile și metodele clasei părinte. Economisești cod și creezi ierarhii logice.',
    'Moștenirea = mecanism prin care o clasă derivată preia atribute și metode de la clasa de bază. Keyword: ":" în C#.',
    'Moștenirea permite reutilizarea codului. Clasă copil are tot ce are părintele plus adăugiri proprii. Exemplu: Animal → Câine, Pisică. Ierarhia logică ajută la organizare.',
    to_jsonb(ARRAY['Ierarhii prea adânci', 'Moștenire în loc de compoziție', 'Suprascriere greșită', 'Nu înțelegi sealed', 'Confuzie cu interfețe']),
    jsonb_build_object(
      'csharp', E'public class Animal {\n  public string Nume { get; set; }\n  \n  public virtual void Mananca() {\n    Console.WriteLine($"{Nume} mănâncă.");\n  }\n  \n  public virtual void FaceSunet() {\n    Console.WriteLine("Sunet generic");\n  }\n}\n\npublic class Caine : Animal {\n  public string Rasa { get; set; }\n  \n  public override void FaceSunet() {\n    Console.WriteLine("Ham Ham!");\n  }\n  \n  public void Alearga() {\n    Console.WriteLine("Câinele aleargă!");\n  }\n}\n\nCaine rex = new Caine { Nume = "Rex", Rasa = "Labrador" };\nrex.Mananca();    // Moștenit\nrex.FaceSunet();  // Suprascris\nrex.Alearga();    // Propriu',
      'typescript', E'class Animal {\n  nume: string;\n  \n  mananca(): void {\n    console.log(`${this.nume} mănâncă`);\n  }\n  \n  faceSunet(): void {\n    console.log("Sunet generic");\n  }\n}\n\nclass Caine extends Animal {\n  rasa: string;\n  \n  faceSunet(): void {\n    console.log("Ham Ham!");\n  }\n  \n  alearga(): void {\n    console.log("Câinele aleargă!");\n  }\n}\n\nconst rex = new Caine();\nrex.nume = "Rex";\nrex.mananca();   // Moștenit\nrex.faceSunet(); // Suprascris'
    ),
    E'Moștenire:\n[Animal] → [Caine], [Pisica]\nReutilizare cod + ierarhie',
    202
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Ce e moștenirea?', to_jsonb(ARRAY['Copiezi cod', 'Copilul preia de la părinte', 'Polimorfism', 'Interfețe']), 1, 'Inheritance = copil preia de la părinte.'),
    (current_term_id, 'Keyword în C#?', to_jsonb(ARRAY['extends', ': (colon)', 'inherits', 'from']), 1, 'class Caine : Animal'),
    (current_term_id, 'Câți părinți direcți în C#?', to_jsonb(ARRAY['Nelimitat', 'Doar unul', 'Doi', 'Trei']), 1, 'Single inheritance pentru clase.'),
    (current_term_id, 'Ce face base()?', to_jsonb(ARRAY['Șterge', 'Apelează constructorul părintelui', 'Copiază', 'Nimic']), 1, 'Invocă constructorul părinte.'),
    (current_term_id, 'Avantaj?', to_jsonb(ARRAY['Lent', 'Reutilizare cod', 'Memorie', 'Nimic']), 1, 'Evită duplicarea codului.');

  -- Polimorfism
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'Polimorfism (Polymorphism)',
    'Același nume de metodă, implementări diferite. Câinele latră, pisica miaună - ambele "fac sunet".',
    'Polimorfismul = abilitatea unei metode de a avea comportamente diferite. Se realizează prin override (runtime) sau overload (compile-time).',
    'Polimorfism = "multe forme". Metodă rescrisă în copii. La runtime se apelează versiunea corectă. Permite cod flexibil și extensibil.',
    to_jsonb(ARRAY['Uiți virtual/override', 'Confunzi overload cu override', 'Runtime type checks în loc de polimorfism', 'Suprascrieri greșite']),
    jsonb_build_object(
      'csharp', E'public class Animal {\n  public virtual void FaceSunet() {\n    Console.WriteLine("Sunet generic");\n  }\n}\n\npublic class Caine : Animal {\n  public override void FaceSunet() {\n    Console.WriteLine("Ham Ham!");\n  }\n}\n\npublic class Pisica : Animal {\n  public override void FaceSunet() {\n    Console.WriteLine("Miau!");\n  }\n}\n\nList<Animal> animale = new List<Animal> {\n  new Caine(), new Pisica(), new Animal()\n};\n\nforeach(var animal in animale) {\n  animal.FaceSunet();\n}\n// Output: "Ham Ham!", "Miau!", "Sunet generic"',
      'typescript', E'class Animal {\n  faceSunet(): void {\n    console.log("Sunet generic");\n  }\n}\n\nclass Caine extends Animal {\n  faceSunet(): void {\n    console.log("Ham!");\n  }\n}\n\nclass Pisica extends Animal {\n  faceSunet(): void {\n    console.log("Miau!");\n  }\n}\n\nconst animale: Animal[] = [\n  new Caine(), new Pisica()\n];\n\nanimale.forEach(a => a.faceSunet());\n// "Ham!", "Miau!"'
    ),
    E'Polimorfism:\nAceeași metodă → comportamente diferite\nvirtual + override',
    203
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Ce e polimorfismul?', to_jsonb(ARRAY['Multe clase', 'Aceeași metodă, comportamente diferite', 'Moștenire', 'Încapsulare']), 1, 'Polymorphism = multe forme.'),
    (current_term_id, 'Keyword pentru runtime polymorphism?', to_jsonb(ARRAY['overload', 'virtual și override', 'static', 'abstract']), 1, 'virtual + override'),
    (current_term_id, 'Override vs overload?', to_jsonb(ARRAY['Nimic', 'Override: copil, Overload: parametri diferiți', 'Același lucru', 'Nu există']), 1, 'Override = polimorfism, overload = metode similare.'),
    (current_term_id, 'Când se decide metoda (override)?', to_jsonb(ARRAY['Compile-time', 'Runtime', 'Niciodată', 'La scriere']), 1, 'Runtime polymorphism.'),
    (current_term_id, 'Avantaj?', to_jsonb(ARRAY['Lent', 'Cod flexibil', 'Memorie', 'Nimic']), 1, 'Extensibil fără modificare.');

  -- Abstractizare
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'Abstractizare (Abstraction)',
    'Definești "ce" trebuie făcut, nu "cum". Contract: definești metodele, implementarea vine mai târziu.',
    'Abstractizarea = ascunderea detaliilor și expunerea funcționalității esențiale. Prin clase abstracte și interfețe.',
    'Concentrare pe esență. Clasă abstractă = implementare parțială. Interfață = contract pur. IVehicul definește Drive(), dar fiecare îl implementează diferit.',
    to_jsonb(ARRAY['Nu înțelegi diferența abstract class vs interface', 'Implementare în interfețe (pre-C# 8)', 'Over-engineering', 'Confuzie cu encapsulation']),
    jsonb_build_object(
      'csharp', E'// Interfață = contract\npublic interface IVehicul {\n  void Porneste();\n  void Opreste();\n}\n\n// Clasă abstractă = parțial\npublic abstract class Vehicul {\n  protected bool estePornit;\n  \n  public abstract void Porneste(); // Trebuie implementat\n  \n  public void Opreste() { // Implementat\n    estePornit = false;\n  }\n}\n\npublic class Masina : Vehicul, IVehicul {\n  public override void Porneste() {\n    estePornit = true;\n    Console.WriteLine("Mașina pornește!");\n  }\n}',
      'typescript', E'interface IVehicul {\n  porneste(): void;\n  opreste(): void;\n}\n\nabstract class Vehicul {\n  protected estePornit = false;\n  \n  abstract porneste(): void;\n  \n  opreste(): void {\n    this.estePornit = false;\n  }\n}\n\nclass Masina extends Vehicul {\n  porneste(): void {\n    this.estePornit = true;\n    console.log("Pornește!");\n  }\n}'
    ),
    E'Abstractizare:\nInterface = contract pur\nAbstract class = parțial implementat',
    204
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Ce e abstractizarea?', to_jsonb(ARRAY['Detalii complete', 'Esența fără detalii', 'Moștenire', 'Polimorfism']), 1, 'Ce, nu cum.'),
    (current_term_id, 'Abstract class vs interface?', to_jsonb(ARRAY['Nimic', 'Abstract poate avea implementare', 'Interface rapidă', 'Același lucru']), 1, 'Abstract = parțial, interface = contract.'),
    (current_term_id, 'Interfața conține?', to_jsonb(ARRAY['Implementare', 'Doar semnături', 'Logică', 'Date']), 1, 'Contract fără implementare.'),
    (current_term_id, 'Când abstract class?', to_jsonb(ARRAY['Niciodată', 'Cod comun + forțare', 'Întotdeauna', 'Pentru variabile']), 1, 'Bază comună parțială.'),
    (current_term_id, 'Beneficiu?', to_jsonb(ARRAY['Lent', 'Contract clar', 'Memorie', 'Nimic']), 1, 'Separare contract-implementare.');

  -- Constructor
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'Constructor și Destructor',
    'Constructor = metodă specială care creează obiectul și îl inițializează. Destructor = curățare (rar folosit în C# - Garbage Collector face treaba).',
    'Constructor = metodă apelată la instanțiere. Același nume cu clasa, fără tip return. Destructor în .NET gestionat de GC (Garbage Collector).',
    'Constructorul inițializează obiectul. Poți avea mai mulți (overloading). Destructor rar necesar în .NET - GC eliberează memoria automat. Folosește IDisposable pentru curățare resurse.',
    to_jsonb(ARRAY['Logică complexă în constructor', 'Nu validezi parametrii', 'Apelezi metode virtuale în constructor', 'Uiți să chainezi constructori', 'Excepții în constructor']),
    jsonb_build_object(
      'csharp', E'public class Angajat {\n  public string Nume { get; set; }\n  public int Varsta { get; set; }\n  \n  // Constructor implicit (parameterless)\n  public Angajat() : this("Necunoscut", 0) { }\n  \n  // Constructor cu parametri\n  public Angajat(string nume) : this(nume, 0) { }\n  \n  // Constructor principal\n  public Angajat(string nume, int varsta) {\n    if(string.IsNullOrEmpty(nume))\n      throw new ArgumentException(nameof(nume));\n    if(varsta < 0)\n      throw new ArgumentException(nameof(varsta));\n    \n    Nume = nume;\n    Varsta = varsta;\n    Console.WriteLine($"Creat: {Nume}, {Varsta} ani");\n  }\n  \n  // Destructor (rar folosit)\n  ~Angajat() {\n    // GC îl apelează\n    Console.WriteLine("Destructor apelat");\n  }\n}\n\nvar a1 = new Angajat();\nvar a2 = new Angajat("Ion");\nvar a3 = new Angajat("Maria", 25);',
      'typescript', E'class Angajat {\n  nume: string;\n  varsta: number;\n  \n  // Constructor cu parametri default\n  constructor(nume: string = "Necunoscut", varsta: number = 0) {\n    if(!nume) throw new Error("Nume invalid");\n    if(varsta < 0) throw new Error("Varsta invalida");\n    \n    this.nume = nume;\n    this.varsta = varsta;\n    console.log(`Creat: ${nume}`);\n  }\n}\n\nconst a1 = new Angajat();\nconst a2 = new Angajat("Ion");\nconst a3 = new Angajat("Maria", 25);'
    ),
    E'Constructor:\nnew Angajat("Ion", 30)\n  ↓\nConstructor rulează\n  ↓\nInițializează fields\n  ↓\nValidează\n  ↓\nObiect gata',
    205
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Ce face constructorul?', to_jsonb(ARRAY['Șterge', 'Inițializează obiectul', 'Copiază', 'Compară']), 1, 'Setup la creare.'),
    (current_term_id, 'Return type constructor?', to_jsonb(ARRAY['void', 'Class type', 'Fără return type', 'int']), 2, 'Metodă specială.'),
    (current_term_id, 'Constructor implicit?', to_jsonb(ARRAY['Niciodată', 'Auto-generat dacă lipsește', 'Obligatoriu', 'Cu parametri']), 1, 'Parameterless dacă nu definești.'),
    (current_term_id, 'Constructor chaining?', to_jsonb(ARRAY['Moștenire', 'Un constructor apelează altul (:this)', 'Clase multiple', 'Static']), 1, 'Reutilizare logică.'),
    (current_term_id, 'Destructor în C#?', to_jsonb(ARRAY['Obligatoriu', 'Rar, GC face treaba', 'Întotdeauna', 'Pentru fiecare clasă']), 1, 'Garbage Collector gestionează memoria.');

  RAISE NOTICE 'Added complete Romanian OOP terms';
END $$;

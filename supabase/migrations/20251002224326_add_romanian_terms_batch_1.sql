/*
  # Add Romanian IT Terms - Batch 1
  
  1. New Category: Termeni Români
  2. Add 5 comprehensive OOP terms in Romanian covering all 4 pillars
*/

DO $$
DECLARE
  cat_romanian uuid;
  current_term_id uuid;
BEGIN
  -- Create Romanian category
  INSERT INTO categories (name, slug, order_index)
  VALUES ('Termeni Români 🇷🇴', 'romanian', 10)
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO cat_romanian;
  
  IF cat_romanian IS NULL THEN
    SELECT id INTO cat_romanian FROM categories WHERE slug = 'romanian';
  END IF;

  -- Clasă și Obiect
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'Clasă și Obiect (Class & Object)',
    'Clasa este șablonul/blueprint-ul care definește cum arată și ce poate face un obiect. Obiectul este o instanță concretă creată după acel șablon.',
    'Clasă = șablon care definește atribute (câmpuri/fields) și comportamente (metode/methods). Obiect = instanță concretă a clasei cu valori specifice.',
    'Clasa este definiția, obiectul este realizarea. O clasă este ca o rețetă de prăjitură, obiectul este prăjitura făcută după rețetă. O clasă poate crea multe obiecte diferite.',
    to_jsonb(ARRAY['Confundarea clasei cu obiectul', 'Crearea prea multor clase inutile', 'Nu înțelegi că dintr-o clasă faci multe obiecte', 'Pui logică în constructor în loc să o pui în metode']),
    jsonb_build_object(
      'csharp', E'// Clasa = șablon\npublic class Angajat {\n  public string Nume { get; set; }\n  public int Varsta { get; set; }\n  public decimal Salariu { get; set; }\n  \n  public Angajat(string nume, int varsta, decimal salariu) {\n    Nume = nume;\n    Varsta = varsta;\n    Salariu = salariu;\n  }\n  \n  public void Lucreaza() {\n    Console.WriteLine($"{Nume} lucrează...");\n  }\n}\n\n// Obiecte = instanțe concrete\nAngajat ion = new Angajat("Ion Popescu", 30, 5000);\nAngajat maria = new Angajat("Maria Ionescu", 25, 4500);\n\nion.Lucreaza();',
      'typescript', E'class Angajat {\n  nume: string;\n  varsta: number;\n  salariu: number;\n  \n  constructor(nume: string, varsta: number, salariu: number) {\n    this.nume = nume;\n    this.varsta = varsta;\n    this.salariu = salariu;\n  }\n  \n  lucreaza(): void {\n    console.log(`${this.nume} lucrează...`);\n  }\n}\n\nconst ion = new Angajat("Ion", 30, 5000);\nion.lucreaza();'
    ),
    E'Clasă vs Obiect:\nClasă Angajat → Obiect ion, Obiect maria\nO clasă → multe obiecte',
    200
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Ce este o clasă?', to_jsonb(ARRAY['Un obiect concret', 'Un șablon pentru obiecte', 'O variabilă', 'O funcție']), 1, 'Clasa definește structura.'),
    (current_term_id, 'Ce este un obiect?', to_jsonb(ARRAY['O clasă', 'Instanța concretă a unei clase', 'O metodă', 'Un constructor']), 1, 'Obiectul = instanță creată cu new.'),
    (current_term_id, 'Câte obiecte faci dintr-o clasă?', to_jsonb(ARRAY['Doar unul', 'Câte vrei', 'Maxim 10', 'Depinde']), 1, 'Nelimitat, câte vrei.'),
    (current_term_id, 'Ce conține o clasă?', to_jsonb(ARRAY['Doar date', 'Atribute și metode', 'Doar metode', 'Nimic']), 1, 'Fields + methods.'),
    (current_term_id, 'Analogie pentru clasă?', to_jsonb(ARRAY['Prăjitură', 'Rețetă', 'Cuptor', 'Zahăr']), 1, 'Clasă = rețetă, obiect = prăjitură.');

  -- Încapsulare
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_romanian, 'Încapsulare (Encapsulation)',
    'Ascunzi detaliile interne și expui doar ce trebuie prin metode publice. E ca o cutie neagră.',
    'Încapsularea = ascunderea datelor private și expunerea lor controlată prin metode publice. Unul din cei 4 piloni OOP.',
    'Date sensibile sunt private, acces controlat prin metode. Previne modificări accidentale. Exemplu: cont bancar - balanța e privată, depui/retragi prin metode.',
    to_jsonb(ARRAY['Faci tot public', 'Nu validezi în setters', 'Expui câmpuri direct', 'Nu folosești access modifiers', 'Prea multă logică în getters']),
    jsonb_build_object(
      'csharp', E'public class ContBancar {\n  private decimal balanta; // Privat!\n  \n  public void Depune(decimal suma) {\n    if(suma <= 0) throw new ArgumentException();\n    balanta += suma;\n  }\n  \n  public decimal GetBalanta() => balanta;\n}\n\nvar cont = new ContBancar();\ncont.Depune(1000);\n// cont.balanta = 9999; // EROARE!',
      'typescript', E'class ContBancar {\n  private balanta: number = 0;\n  \n  depune(suma: number): void {\n    if(suma <= 0) throw new Error();\n    this.balanta += suma;\n  }\n  \n  getBalanta(): number {\n    return this.balanta;\n  }\n}'
    ),
    E'Încapsulare:\nPublic: Depune(), GetBalanta()\n  ↓\nPrivate: balanta (ascuns)',
    201
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Ce e încapsularea?', to_jsonb(ARRAY['Tot public', 'Ascunzi detalii, expui controlat', 'Moștenire', 'Polimorfism']), 1, 'Encapsulation = protecție date.'),
    (current_term_id, 'De ce private?', to_jsonb(ARRAY['Mai rapid', 'Protejezi de modificări', 'Obligatoriu', 'Nu are sens']), 1, 'Împiedică acces direct.'),
    (current_term_id, 'Avantaj properties?', to_jsonb(ARRAY['Nimic', 'Validare și control', 'Mai puțin cod', 'Viteză']), 1, 'Properties permit validare.'),
    (current_term_id, 'Access modifier pentru sensibil?', to_jsonb(ARRAY['public', 'private', 'protected', 'internal']), 1, 'Private = ascuns complet.'),
    (current_term_id, 'Încapsularea e pilon OOP?', to_jsonb(ARRAY['Da, 1 din 4', 'Nu', 'Optional', 'Design pattern']), 0, '4 piloni: Encapsulation, Abstraction, Inheritance, Polymorphism.');

  RAISE NOTICE 'Added Romanian terms batch 1';
END $$;

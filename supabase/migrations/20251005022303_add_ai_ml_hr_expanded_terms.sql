/*
  # Add Expanded AI/ML and HR Terms

  1. New AI/ML Terms Added:
    - **AI (Artificial Intelligence)** - Fundamental concept
    - **Machine Learning (ML)** - Core concept definition
    - **AI-Assisted Coding** - Modern development practice
    - **Data Mining** - Data analysis technique
    - **Hallucinations (AI)** - Critical AI limitation
    - **Feature Engineering** - ML preprocessing
    - **Training vs Test Data** - ML validation concept
    - **Bias in AI** - Ethics and fairness

  2. New HR/Soft Skills Terms Added:
    - **Growth Mindset** - Carol Dweck's concept
    - **Active Listening** - Communication skill
    - **Time Management** - Productivity skill
    - **Conflict Resolution** - Team collaboration
    - **Giving Feedback** - Professional communication
    - **Receiving Feedback** - Professional growth
    - **Work-Life Balance** - Wellbeing
    - **Continuous Learning** - Career development
    - **Delegation** - Leadership skill
    - **Emotional Intelligence (EQ)** - Soft skill fundamental

  3. Security
    - All terms follow existing RLS policies
    - Priority set to 'high' for critical terms, 'medium' for others
*/

-- Get category IDs
DO $$
DECLARE
  ai_ml_category_id uuid;
  hr_category_id uuid;
BEGIN
  SELECT id INTO ai_ml_category_id FROM categories WHERE slug = 'ai-ml';
  SELECT id INTO hr_category_id FROM categories WHERE slug = 'hr';

  -- AI/ML Terms
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, order_index, priority, tags, nice_to_know)
  VALUES
  (
    ai_ml_category_id,
    'Artificial Intelligence (AI)',
    'AI înseamnă calculatoare care pot face lucruri „inteligente" pe care le fac oamenii: să învețe, să rezolve probleme, să înțeleagă limbaj.',
    'Artificial Intelligence (AI) este ramura informaticii care se concentrează pe crearea de sisteme capabile să execute sarcini care necesită inteligență umană: învățare, raționament, percepție, înțelegere limbaj natural.',
    'AI este crearea de sisteme care pot învăța și se adapta. Spre deosebire de programarea tradițională (unde scrii reguli explicite), AI-ul învață pattern-uri din date. Include ML, Deep Learning, NLP, Computer Vision.',
    '["Nu confunda AI cu ML - AI e conceptul larg, ML e o tehnică specifică", "AI nu înseamnă conștiință - sunt doar algoritmi matematici", "Nu toate sistemele „smart\" folosesc AI real"]',
    '{}',
    8,
    'high',
    ARRAY['fundamental', 'must-know', 'interview-favorite'],
    'Întrebări tipice: "Care e diferența între AI și ML?" Răspuns scurt: AI e scopul (sisteme inteligente), ML e metoda (învățare din date).'
  ),
  (
    ai_ml_category_id,
    'Machine Learning (ML)',
    'Machine Learning înseamnă că învățăm calculatorul să învețe singur din exemple, fără să-i spunem exact ce să facă la fiecare pas.',
    'Machine Learning este o metodă de AI care permite sistemelor să învețe automat din date și să își îmbunătățească performanța fără a fi programate explicit pentru fiecare scenariu.',
    'ML e un subset al AI unde algoritmii învață pattern-uri din date. Spre deosebire de programarea clasică (if-else), ML-ul construiește modele statistice. Exemple: recomandări Netflix, spam detection, recunoaștere facială.',
    '["ML nu e magie - e statistică avansată", "Necesită date de calitate - garbage in, garbage out", "Un model bun pe training data poate fi prost pe date noi (overfitting)"]',
    '{
      "python": "from sklearn.linear_model import LogisticRegression\nmodel = LogisticRegression()\nmodel.fit(X_train, y_train)\npredictions = model.predict(X_test)"
    }',
    9,
    'high',
    ARRAY['fundamental', 'must-know', 'core-concept'],
    'La interviu: Explică diferența ML vs programare tradițională. "La programare clasică scriu reguli; la ML, algoritmul învață regulile din date."'
  ),
  (
    ai_ml_category_id,
    'AI-Assisted Coding',
    'Tool-uri ca GitHub Copilot, ChatGPT sau Claude care te ajută să scrii cod mai repede, sugerându-ți cod sau explicându-ți erori.',
    'AI-Assisted Coding se referă la folosirea modelelor de limbaj (LLMs) pentru a asista dezvoltatorii: autocompletare cod, generare de funcții, debugging, explicații, code review.',
    'Tool-uri moderne (Copilot, Cursor, ChatGPT) folosesc LLM-uri antrenate pe milioane de linii de cod. Ajută la: boilerplate code, traducere între limbaje, găsire bug-uri, explicații. Important: verify mereu codul generat!',
    '["Nu copia orb cod generat de AI - verifică logica", "AI poate genera cod învechit sau nesigur", "Nu înlocuiește înțelegerea fundamentelor", "Poate avea licensing issues dacă codul e copiat din surse protejate"]',
    '{}',
    10,
    'high',
    ARRAY['modern-dev', 'tools', 'productivity'],
    'La interviu pentru junior: "Folosesc AI ca asistent, dar verific mereu codul și înțeleg logica. Nu e cârjă, e tool de productivitate."'
  ),
  (
    ai_ml_category_id,
    'Data Mining',
    'Procesul de a căuta pattern-uri utile și informații ascunse în cantități mari de date, ca un detective care caută indicii.',
    'Data Mining este procesul de descoperire a pattern-urilor, anomaliilor, corelațiilor și relațiilor semnificative în seturi mari de date folosind metode statistice, ML și algoritmi de căutare.',
    'Data Mining combină statistică, ML și baze de date pentru a extrage knowledge din date. Diferă de ML: Data Mining e exploratorie (descoperi ce e în date), ML e predictiv (înveți să prezici). Aplicații: fraud detection, market basket analysis, customer segmentation.',
    '["Data Mining nu înseamnă întotdeauna ML - poate fi și statistică descriptivă", "Riscul de a găsi corelații false (spurious correlations)", "Privacy concerns - trebuie să respecti GDPR"]',
    '{}',
    11,
    'medium',
    ARRAY['data-science', 'analytics'],
    'Nu confunda cu ML: Data Mining = descoperire knowledge, ML = construire modele predictive. Adesea se folosesc împreună.'
  ),
  (
    ai_ml_category_id,
    'Hallucinations (AI)',
    'Când AI-ul inventează informații false dar sună convingător - ca și cum ar povesti cu încredere ceva complet inventat.',
    'Hallucinations sunt răspunsuri generate de modele AI (mai ales LLM-uri) care sunt plauzibile dar factual incorecte sau inventate, fără bază în datele de training.',
    'LLM-urile generează text predicând următorul token cel mai probabil, NU verificând adevărul. Pot inventa: API-uri inexistente, date false, referințe inexistente. Critical în producție: verify mereu output-ul AI, mai ales pentru decizii importante!',
    '["Nu te baza orb pe AI pentru facts - verifică sursele", "Hallucinations apar mai des la întrebări obscure sau date din afara training-ului", "Mai frecvente când AI-ul e forțat să răspundă vs să spună \"nu știu\""]',
    '{}',
    12,
    'high',
    ARRAY['ai-limitations', 'critical', 'safety'],
    'Întrebare de interviu: "Ce risc au LLM-urile în producție?" Răspuns: "Hallucinations - pot genera cod/informații false dar plauzibile. De aceea implementez verificări, teste și human review."'
  ),
  (
    ai_ml_category_id,
    'Feature Engineering',
    'Procesul de a transforma datele brute în „ingrediente" bune pe care algoritmul de ML să le poată folosi pentru a învăța mai bine.',
    'Feature Engineering este procesul de selecție, transformare și creare a variabilelor (features) dintr-un dataset pentru a îmbunătăți performanța modelelor de ML.',
    'E unul din cele mai importante aspecte în ML. Include: selecția feature-urilor relevante, normalizarea datelor, encoding categorical (one-hot), crearea de feature-uri compuse. Exemplu: din „data nașterii" poți crea „vârstă", „zi săptămână", „sezon".',
    '["Feature Engineering prost poate ruina chiar și cel mai bun model", "Riscul de data leakage - să nu folosești info din viitor în training", "Overfitting dacă creezi prea multe features"]',
    '{
      "python": "# Exemplu feature engineering\ndf[\"age\"] = 2024 - df[\"birth_year\"]\ndf[\"is_weekend\"] = df[\"day_of_week\"].isin([5, 6])\ndf = pd.get_dummies(df, columns=[\"category\"])  # one-hot encoding"
    }',
    13,
    'medium',
    ARRAY['ml-practice', 'data-science'],
    '"Feature engineering e 80% din munca în ML, modelul e 20%." La interviu arată că înțelegi că datele bune > model complex.'
  ),
  (
    ai_ml_category_id,
    'Training vs Test Data',
    'Training data = datele pe care învățăm calculatorul. Test data = datele pe care-l testăm după ce a învățat, ca să vedem dacă a învățat cu adevărat.',
    'Training data este setul de date folosit pentru antrenarea modelului ML. Test data este un set separat, nevăzut de model, folosit pentru evaluarea performanței reale.',
    'Împarți datele: 70-80% training, 20-30% test. Critical: test data trebuie să fie complet separat! Dacă modelul vede test data în training, obții false accuracy (data leakage). Validation set e opțional, pentru tuning hiperparametri.',
    '["Data leakage - cea mai comună greșeală începători", "Test data prea mic = evaluare nesigură", "Test data trebuie să fie reprezentativ pentru realitate"]',
    '{
      "python": "from sklearn.model_selection import train_test_split\nX_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)"
    }',
    14,
    'high',
    ARRAY['ml-fundamentals', 'validation', 'must-know'],
    'Întrebare interviu: "De ce test data trebuie separat?" Răspuns: "Pentru a evalua cum se comportă modelul pe date nevăzute. Dacă testez pe training data, obțin false confidence."'
  ),
  (
    ai_ml_category_id,
    'Bias in AI',
    'Când AI-ul ia decizii nedrepte pentru că a învățat din date care conțineau prejudecăți umane sau nu reprezentau toată lumea.',
    'Bias în AI apare când modelele ML produc rezultate sistematic nedrepte sau discriminatorii față de anumite grupuri, adesea datorită bias-ului din datele de training.',
    'Surse de bias: date de training nereprezentative, labels biased, algoritmi care amplifică inegalități existente. Exemple reale: sisteme de recrutare care discriminează femei, software de recunoaștere facială mai prost pe persoane de culoare. Critical pentru etică și legal.',
    '["Bias e subtil și greu de detectat", "Poate avea consecințe legale (discriminare)", "Nu dispare de la sine - trebuie detectat activ și corectat"]',
    '{}',
    15,
    'medium',
    ARRAY['ai-ethics', 'fairness', 'responsible-ai'],
    'La interviu arată awareness: "Un challenge în ML e bias-ul. Trebuie să validez că modelul e fair pentru toate grupurile și să folosesc date diverse."'
  );

  -- HR/Soft Skills Terms
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, order_index, priority, tags, nice_to_know)
  VALUES
  (
    hr_category_id,
    'Growth Mindset',
    'Credința că poți deveni mai bun la orice prin muncă și învățare, nu că talentul e fix de la naștere.',
    'Growth Mindset (concept Carol Dweck) este convingerea că abilitățile și inteligența pot fi dezvoltate prin efort, învățare și persistență, spre deosebire de Fixed Mindset (talentul e înnăscut).',
    'Growth Mindset înseamnă să vezi eșecurile ca oportunități de învățare, nu ca limită personală. La job: „Nu știu încă" vs „Nu pot". Cauți feedback, nu te temi de provocări. Essential pentru cariera în tech unde tehnologiile evoluează constant.',
    '["Growth Mindset nu înseamnă că orice e posibil instant", "Nu ignora realitatea - recunoaște punctele slabe dar lucrează la ele", "Efortul fără strategie nu e suficient"]',
    '{}',
    5,
    'high',
    ARRAY['career-growth', 'mindset', 'learning'],
    'La interviu când spui "Nu știu X" urmează cu "dar sunt entuziasmat să învăț" - demonstrează Growth Mindset.'
  ),
  (
    hr_category_id,
    'Active Listening',
    'Să asculți cu adevărat persoana care vorbește, nu doar să aștepți rândul tău să vorbești - să înțelegi, nu doar să auzi.',
    'Active Listening este tehnica de comunicare care implică concentrare totală, înțelegere, răspuns și reținere a informației comunicate, nu doar auzire pasivă.',
    'În echipă: Ascult colegul complet înainte să răspund, parafrazez pentru confirmare („Deci spui că..."), pun întrebări clarificatoare, evit întreruperile. Arată respect și previne misunderstandings. Critical în pair programming, code review, daily standup.',
    '["Să nu formulezi răspunsul în timpul ascultării", "Evită distracțiile (telefon, laptop)", "Nu presupune ce va spune - ascultă efectiv"]',
    '{}',
    6,
    'high',
    ARRAY['communication', 'teamwork', 'soft-skills'],
    'La interviu demonstrează Active Listening: parafrazează întrebările înainte să răspunzi ("Dacă înțeleg corect, mă întrebați despre...").'
  ),
  (
    hr_category_id,
    'Time Management',
    'Abilitatea de a-ți organiza timpul eficient: să știi ce e urgent, ce e important, și să nu te pierzi în task-uri neimportante.',
    'Time Management este procesul de planificare și control conștient al timpului petrecut pe activități specifice pentru a crește eficiența și productivitatea.',
    'Tehnici: Eisenhower Matrix (urgent/important), Pomodoro (25min focus + 5min pauză), time blocking. La development: estimări realiste, buffer pentru blockers, evită multitasking. Comunică deadline-uri realiste, nu promite imposibilul.',
    '["Perfectionism kills time management", "Meetings nestructurate consumă timp", "Să spui \"nu\" e o skill de time management"]',
    '{}',
    7,
    'high',
    ARRAY['productivity', 'organization', 'essential'],
    'Întrebare interviu: "Cum gestionezi multiple task-uri?" Răspuns: "Prioritizez după impact și urgență, comunic cu team lead, și folosesc time-blocking pentru deep work."'
  ),
  (
    hr_category_id,
    'Conflict Resolution',
    'Abilitatea de a rezolva neînțelegerile în echipă calm și constructiv, găsind soluții care funcționează pentru toată lumea.',
    'Conflict Resolution este procesul de rezolvare a dezacordurilor între indivizi sau grupuri prin comunicare, negociere și compromis, ajungând la o soluție acceptabilă.',
    'În echipă tehnic: Focus pe problemă, nu pe persoană. Ascultă ambele părți. Caută win-win. Exemplu: dezacord tehnic pe arhitectură - propui POC (Proof of Concept) pentru ambele abordări și compari obiectiv. Escaladează la lead doar când necesar.',
    '["Evită escaladarea prematură", "Nu lua conflictele personal", "Nu evita conflictele - rezolvă-le devreme"]',
    '{}',
    8,
    'medium',
    ARRAY['teamwork', 'communication', 'leadership'],
    'La interviu: "Cum gestionezi un dezacord tehnic?" Răspuns: "Ascult argumentele, prezint datele/tradeoff-urile, și dacă nu ajungem la consens, escaladez cu opțiuni clare."'
  ),
  (
    hr_category_id,
    'Giving Feedback',
    'Arta de a spune cuiva cum poate să se îmbunătățească, într-un mod constructiv care ajută, nu rănește.',
    'Giving Feedback este procesul de comunicare a observațiilor despre performanța cuiva, în mod clar, specific și constructiv, pentru a facilita îmbunătățirea.',
    'Feedback bun: Specific (nu generic), Timely (la momentul potrivit), Actionable (ce să schimbe), Balanced (pozitiv + îmbunătățiri). Exemplu: "În code review, am observat că funcția X are 5 responsabilități. Ce zici să o descompunem în funcții mici?"',
    '["Nu critica persoana - critică comportamentul/codul", "Nu da feedback public pentru lucruri negative", "Feedback vag (\"Trebuie să te îmbunătățești\") nu ajută"]',
    '{}',
    9,
    'medium',
    ARRAY['communication', 'leadership', 'code-review'],
    'În code review: "În loc de \"Codul e prost\", spune \"Aici aș sugera să folosim Strategy pattern pentru flexibility\". Arată DE CE și cum să îmbunătățească."'
  ),
  (
    hr_category_id,
    'Receiving Feedback',
    'Capacitatea de a asculta critici despre munca ta fără să te superi, și să le folosești pentru a deveni mai bun.',
    'Receiving Feedback este abilitatea de a accepta, procesa și aplica feedback-ul primit, fără reacții defensive, văzându-l ca oportunitate de creștere.',
    'Mindset corect: Feedback-ul e despre cod/proces, nu despre tine ca persoană. Ascultă complet, clarifică dacă nu înțelegi, mulțumește, apoi aplică. În code review: nu justifica defensiv, ci întreabă „Cum ai aborda tu problema?"',
    '["Nu lua feedback-ul personal", "Nu te justifica excesiv", "Nu ignora feedback-ul repetat"]',
    '{}',
    10,
    'high',
    ARRAY['growth', 'professionalism', 'must-have'],
    'La interviu când întreabă "Cum reacționezi la critici?": "Văd feedback-ul ca pe o șansă să cresc. Ascult, clarifică, și aplic. În code review-uri am învățat mult din sugestiile seniorilor."'
  ),
  (
    hr_category_id,
    'Work-Life Balance',
    'Echilibrul între munca ta și viața personală, să nu te arzi epuizându-te doar cu job-ul.',
    'Work-Life Balance reprezintă echilibrul sănătos între timpul/energia dedicată carierei și timpul pentru viață personală, familie, prieteni, hobby-uri și odihnă.',
    'Sustainable performance: Lucrezi eficient în program, nu burn-out peste program. Setezi boundaries: nu răspunzi la Slack la 11 PM (excepție emergențe reale). Comunici când ai prea mult workload. Tech e maraton, nu sprint - trebuie să fii sustenabil pe termen lung.',
    '["Hustle culture e toxic - burn-out-ul reduce productivitatea", "Nu demonstrezi valoare lucrând 14h/zi", "Boundaries nu înseamnă lipsă de dedicare"]',
    '{}',
    11,
    'medium',
    ARRAY['wellbeing', 'sustainability', 'culture'],
    'La interviu când întreabă "Cum gestionezi stress?": "Prioritizez task-urile, comunic când e prea mult, și mențin boundaries sănătoase. Performez mai bine când sunt odihnit."'
  ),
  (
    hr_category_id,
    'Continuous Learning',
    'Mentalitatea de a învăța mereu lucruri noi în carieră, să nu rămâi în urmă când tehnologiile evoluează.',
    'Continuous Learning este procesul activ și constant de dobândire a cunoștințelor noi, adaptare la schimbări și dezvoltare profesională pe parcursul întregii cariere.',
    'În tech: Tehnologiile evoluează rapid. Trebuie să îți actualizezi constant skill-urile. Metode: cursuri online, side projects, conferințe, citit documentații, tutoriale. Dedică 5-10h/săptămână învățării. Nu trebuie să știi totul, dar trebuie să știi cum să înveți.',
    '["Tutorial hell - evită să consumi pasiv fără să practici", "FOMO (Fear of Missing Out) - nu trebuie să înveți fiecare framework nou", "Learning fără aplicare e inutil"]',
    '{}',
    12,
    'high',
    ARRAY['career-growth', 'learning', 'essential'],
    'La interviu când întreabă "Cum te ții la curent?": "Dedic timp constant învățării - cursuri, side projects, documentații. Recent am învățat [X] prin [project/curs]."'
  ),
  (
    hr_category_id,
    'Delegation',
    'Abilitatea de a împărți munca în echipă și de a avea încredere că alții pot face task-uri, nu să faci totul singur.',
    'Delegation este procesul de atribuire a responsabilității și autorității pentru task-uri specifice către alți membri ai echipei, menținând accountability-ul final.',
    'Important pentru: seniors/leads, dar și juniors când lucrează în echipă. Nu înseamnă să arunci munca peste gard - înseamnă să alegi task-ul potrivit pentru persoana potrivită, să dai context clar și să oferi suport. Crește eficiența echipei și dezvoltă membrii.',
    '["Micromanagement = delegation prost făcut", "Nu delegi fără context și suport", "Nu delegi doar task-urile plictisitoare"]',
    '{}',
    13,
    'medium',
    ARRAY['leadership', 'teamwork', 'management'],
    'Chiar ca junior poți demonstra: "Când am văzut că colegul e blocat pe backend, i-am oferit să preiau task-ul de frontend pentru a balansa workload-ul echipei."'
  ),
  (
    hr_category_id,
    'Emotional Intelligence (EQ)',
    'Abilitatea de a înțelege emoțiile tale și ale altora, și de a folosi asta pentru a comunica și colabora mai bine.',
    'Emotional Intelligence (EQ) este capacitatea de a recunoaște, înțelege și gestiona propriile emoții, precum și de a percepe și influența emoțiile altora.',
    'Componente: Self-awareness (conștientizare proprie), Self-regulation (control emoțional), Empathy (înțelegere alții), Social skills. În tech: înțelegi când colegul e frustrat, nu reacționezi impulsiv la criză, comunici calm feedback-ul. EQ > IQ pentru succes pe termen lung.',
    '["EQ nu înseamnă să fii \"soft\" sau să ignori problemele", "Nu confunda empatie cu a fi de acord cu toată lumea", "EQ se dezvoltă - nu e fixed trait"]',
    '{}',
    14,
    'high',
    ARRAY['soft-skills', 'leadership', 'fundamental'],
    'La interviu: Demonstrează EQ prin exemplele tale - cum ai gestionat conflict, cum ai ajutat un coleg frustrat, cum ai primit critici calm.'
  );

END $$;

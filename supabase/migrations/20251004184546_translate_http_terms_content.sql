/*
  # Translate HTTP/REST Terms Content to Romanian
*/

DO $$
BEGIN
  -- HTTP Request & Response
  UPDATE terms SET
    eli5 = 'Cerere = ce trimite clientul (metodă, URL, headere, body). Răspuns = ce trimite serverul (status code, headere, date).',
    formal_definition = 'HTTP Request: metodă (GET/POST/PUT), URL, versiune, headere (metadate), body opțional. Response: status code (200/404), headere, body cu date. Protocol stateless.',
    interview_answer = 'Request conține: metodă HTTP (verb), path, versiune, headere (Content-Type, Authorization, Accept), body pentru POST/PUT. Response conține: status code (succes/eroare), headere (Content-Type, Cache-Control), body (JSON/HTML/text). Protocol stateless - fiecare request e independent. Headerele transportă metadate, body-ul datele efective.',
    pitfalls = to_jsonb(ARRAY[
      'Nu setezi Content-Type',
      'Uiți header Authorization',
      'Metodă greșită pentru operație',
      'Nu tratezi răspunsuri de eroare',
      'Ignori status codes',
      'Body în GET requests'
    ]),
    diagram = 'Cerere HTTP:
POST /api/users HTTP/1.1
Host: api.com
Content-Type: application/json
Authorization: Bearer token...

{"name":"Ion","age":30}

Răspuns HTTP:
HTTP/1.1 201 Created
Content-Type: application/json
Location: /api/users/123

{"id":123,"name":"Ion"}'
  WHERE term = 'Cerere și Răspuns HTTP' AND language = 'ro';

  -- HTTP Methods
  UPDATE terms SET
    eli5 = 'GET = citește date. POST = creează nou. PUT = înlocuiește complet. PATCH = modifică parțial. DELETE = șterge.',
    formal_definition = 'HTTP methods (verbs): GET (retrieve), POST (create), PUT (replace), PATCH (partial update), DELETE (remove). GET/HEAD/OPTIONS safe, GET/PUT/DELETE idempotent.',
    interview_answer = 'GET pentru citire (safe, idempotent, cacheable). POST pentru creare (nu e idempotent - creează multiplu la apeluri multiple). PUT pentru înlocuire completă (idempotent - același rezultat la apeluri repetate). PATCH pentru update parțial (poate fi idempotent). DELETE pentru ștergere (idempotent). Folosesc metoda corectă pentru semantică REST - face API-ul predictibil și confrom cu standardele.',
    pitfalls = to_jsonb(ARRAY[
      'POST pentru tot (ar trebui GET/PUT/DELETE)',
      'GET cu body (evită)',
      'DELETE fără confirmare',
      'PUT când ar trebui PATCH',
      'Nu înțelegi idempotența',
      'Metode în URL în loc de HTTP verb'
    ]),
    diagram = 'Metode HTTP:

GET /users/123
→ Citește (safe, idempotent)

POST /users
→ Creează (nu e idempotent)

PUT /users/123
→ Înlocuiește (idempotent)

PATCH /users/123
→ Modifică parțial

DELETE /users/123
→ Șterge (idempotent)'
  WHERE term = 'Metode HTTP (GET, POST, PUT, PATCH, DELETE)' AND language = 'ro';

  -- HTTP Status Codes
  UPDATE terms SET
    eli5 = '2xx = succes. 3xx = redirect. 4xx = eroare client. 5xx = eroare server. Fiecare cod are sens specific.',
    formal_definition = 'Status codes: 1xx Informational, 2xx Success (200 OK, 201 Created, 204 No Content), 3xx Redirection, 4xx Client Error (400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 422 Unprocessable), 5xx Server Error (500, 503).',
    interview_answer = '200 OK pentru succes general. 201 Created când creezi resurse (cu Location header). 204 No Content pentru DELETE sau update fără body. 400 Bad Request pentru sintaxă greșită. 401 când lipsește/e invalid token. 403 când user-ul e autentificat dar nu are permisiuni. 404 când resursa nu există. 422 pentru erori de validare. 409 pentru conflicte (ex: email duplicat). 500/503 pentru erori server. Codurile corecte fac API-ul intuitiv.',
    pitfalls = to_jsonb(ARRAY[
      '200 pentru tot (și pentru erori)',
      'Confuzie 401 vs 403',
      '404 vs 400 vs 422',
      'Nu folosești 201 pentru creare',
      'Nu incluzi Location header la 201',
      'Nu returnezi detalii eroare la 4xx'
    ]),
    diagram = 'Status Codes:

2xx SUCCES
├─ 200 OK (succes general)
├─ 201 Created (+ Location)
└─ 204 No Content

4xx EROARE CLIENT
├─ 400 Bad Request (sintaxă)
├─ 401 Unauthorized (auth)
├─ 403 Forbidden (permisiuni)
├─ 404 Not Found (resursă)
├─ 409 Conflict (duplicat)
└─ 422 Validation (validare)

5xx EROARE SERVER
├─ 500 Internal Error
└─ 503 Service Unavailable'
  WHERE term = 'Coduri de Status HTTP' AND language = 'ro';

  -- PUT vs PATCH
  UPDATE terms SET
    eli5 = 'PUT = înlocuiește tot (trimite tot obiectul). PATCH = modifică doar câteva câmpuri (trimite doar ce schimbi).',
    formal_definition = 'PUT = înlocuire completă a resursei (trebuie trimis tot payload-ul). PATCH = modificare parțială (trimite doar câmpurile de modificat). PUT idempotent, PATCH poate fi.',
    interview_answer = 'PUT înlocuiește complet - trebuie să trimiți toate câmpurile, chiar cele nemodificate. Câmpurile nelipsite devin null. Idempotent. PATCH modifică parțial - trimiți doar ce schimbi. Mai eficient, mai puțină bandwidth, mai puțin risc de a suprascrie accidental. PUT pentru înlocuire totală, PATCH pentru update-uri parțiale (cel mai comun în practică).',
    pitfalls = to_jsonb(ARRAY[
      'PUT când ar trebui PATCH',
      'PATCH fără validare',
      'PUT fără toate câmpurile obligatorii',
      'Nu înțelegi diferența',
      'Implementezi PATCH ca PUT',
      'Nu documentezi ce câmpuri sunt patchable'
    ]),
    diagram = 'PUT vs PATCH:

Resursă: {id:1, name:"Ion", age:30, email:"..."}

PUT /users/1
Body: {name:"Maria", age:25, email:"..."}
→ Înlocuiește COMPLET
→ Trebuie toate câmpurile

PATCH /users/1
Body: {age:26}
→ Modifică DOAR age
→ Restul rămâne neschimbat

PUT: înlocuire totală
PATCH: update parțial'
  WHERE term = 'PUT vs PATCH (Operații Update)' AND language = 'ro';

  -- Idempotency
  UPDATE terms SET
    eli5 = 'Idempotent = același rezultat dacă apelez o dată sau de 10 ori. GET, PUT, DELETE da. POST nu.',
    formal_definition = 'Idempotență: o operație care produce același rezultat indiferent câte ori e apelată. GET, PUT, DELETE, HEAD, OPTIONS sunt idempotente. POST nu e (creează resurse noi la fiecare apel).',
    interview_answer = 'Idempotența înseamnă că efectul e același indiferent de numărul de apeluri. GET e idempotent - citesc de 100 de ori, aceleași date. PUT e idempotent - setez vârsta la 30 de 10 ori, tot 30 rămâne. DELETE e idempotent - șterg o dată sau de 10 ori, resursa tot ștearsă e. POST NU e idempotent - creează resurse noi la fiecare apel. Important pentru retry logic și fiabilitate rețea.',
    pitfalls = to_jsonb(ARRAY[
      'A crede că idempotent = safe',
      'POST când ar trebui PUT',
      'A nu implementa idempotență corect',
      'Side effects în metode idempotente',
      'Confuzie cu cacheable',
      'A nu folosi idempotency keys pentru POST'
    ]),
    diagram = 'Idempotență:

GET /users/1 (x10)
→ Același user de 10 ori
IDEMPOTENT ✓

PUT /users/1 {age:30} (x10)
→ Age = 30 după 1 sau 10 apeluri
IDEMPOTENT ✓

DELETE /users/1 (x10)
→ User șters după 1 sau 10
IDEMPOTENT ✓

POST /users {name:"Ion"} (x10)
→ 10 useri creați!
NU E IDEMPOTENT ✗'
  WHERE term = 'Idempotență în HTTP' AND language = 'ro';

  -- 401 vs 403
  UPDATE terms SET
    eli5 = '401 = Cine ești? (nu ești autentificat, lipsește token). 403 = Te știu cine ești, dar nu ai voie (autentificat dar fără permisiuni).',
    formal_definition = '401 Unauthorized: autentificare lipsă sau invalidă (lipsește token, token expirat, credențiale greșite). 403 Forbidden: user autentificat dar fără permisiuni pentru acțiunea cerută.',
    interview_answer = '401 returnez când user-ul nu e autentificat - lipsește token, token expirat, sau credențiale invalide. Client trebuie să se logheze. 403 returnez când user-ul E autentificat dar nu are permisiuni - de ex user normal încearcă să șteargă utilizatori (doar admin poate). Diferența: 401 = problema e autentificarea, 403 = problema e autorizarea.',
    pitfalls = to_jsonb(ARRAY[
      'Folosești 401 când ar trebui 403',
      'Folosești 403 când ar trebui 401',
      'Nu incluzi WWW-Authenticate header la 401',
      'Nu explici motivul la 403',
      'Confuzie autentificare vs autorizare',
      'Expui prea multe detalii în mesaj'
    ]),
    diagram = '401 vs 403:

Request fără token
→ 401 Unauthorized
→ Loghează-te!

Request cu token valid
dar user normal
→ 403 Forbidden  
→ Nu ai permisiuni!

401 = AUTENTIFICARE
     (cine ești?)
     
403 = AUTORIZARE
     (ai voie?)'
  WHERE term = '401 Unauthorized vs 403 Forbidden' AND language = 'ro';

  RAISE NOTICE 'Translated HTTP terms content to Romanian';
END $$;

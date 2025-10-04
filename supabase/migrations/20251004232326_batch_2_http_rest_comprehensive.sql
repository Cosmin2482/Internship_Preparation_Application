/*
  # Batch 2: HTTP & REST Comprehensive Terms
  
  Adds missing HTTP & REST terms:
  - What is HTTP
  - Headers vs Body vs Query vs Cookies (comprehensive)
  - Content-Type header
  - Accept header
  - Authorization header
  - Location header
  - Safe methods
  - Pagination
*/

DO $$
DECLARE
  cat_arch_id uuid;
BEGIN
  SELECT id INTO cat_arch_id FROM categories WHERE slug = 'architecture';

  -- What is HTTP
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'What is HTTP?',
    'HTTP = HyperText Transfer Protocol. Rules for how browsers and servers talk. Client sends request (GET /page), server sends response (200 OK + HTML). Stateless, text-based.',
    'HTTP: application-layer protocol for distributed hypermedia systems. Client-server model: client initiates request (method, URL, headers, optional body), server responds (status code, headers, optional body). Stateless: each request independent. Built on TCP/IP. HTTP/1.1 persistent connections, HTTP/2 multiplexing, HTTP/3 over QUIC.',
    'HTTP is the foundation of web communication. Client sends HTTP request with method (GET, POST, etc.), path, headers, and optional body. Server responds with status code (200, 404, etc.), headers, and body. Key characteristics: (1) Stateless - server does not remember previous requests (use cookies/sessions for state). (2) Text-based protocol (human-readable). (3) Request-response model. (4) Built on reliable transport (TCP). Interview points: explain request/response anatomy, stateless nature, common methods and status codes. Versions: HTTP/1.1 (widely used), HTTP/2 (binary, multiplexed), HTTP/3 (QUIC, UDP-based).',
    to_jsonb(ARRAY[
      'Confusing HTTP with HTTPS (HTTPS = HTTP + TLS encryption)',
      'Not understanding stateless nature',
      'Thinking HTTP is only for HTML (it carries any data)',
      'Confusing HTTP methods with CRUD (close but not identical)',
      'Not knowing difference between HTTP versions',
      'Thinking HTTP is secure by default (need HTTPS for encryption)'
    ]),
    jsonb_build_object(
      'csharp', '// HTTP REQUEST (what client sends)
/*
GET /api/users/123 HTTP/1.1
Host: example.com
Accept: application/json
Authorization: Bearer token123

(no body for GET)
*/

// Making HTTP request in C#
using var client = new HttpClient();
client.DefaultRequestHeaders.Add("Authorization", "Bearer token123");

HttpResponseMessage response = await client
    .GetAsync("https://example.com/api/users/123");

if (response.IsSuccessStatusCode) {
    string json = await response.Content.ReadAsStringAsync();
}

// HTTP RESPONSE (what server sends)
/*
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 85

{"id": 123, "name": "John", "email": "john@example.com"}
*/

// POST request with body
var user = new { name = "Jane", email = "jane@example.com" };
var content = new StringContent(
    JsonSerializer.Serialize(user),
    Encoding.UTF8,
    "application/json"
);

var postResponse = await client
    .PostAsync("https://example.com/api/users", content);',
      'typescript', '// HTTP REQUEST
/*
GET /api/users/123 HTTP/1.1
Host: example.com
Accept: application/json
*/

// Fetch API
const response = await fetch("https://example.com/api/users/123", {
    method: "GET",
    headers: {
        "Accept": "application/json",
        "Authorization": "Bearer token123"
    }
});

if (response.ok) {
    const data = await response.json();
    console.log(data);
}

// POST with body
const user = { name: "Jane", email: "jane@example.com" };

const postResponse = await fetch("https://example.com/api/users", {
    method: "POST",
    headers: {
        "Content-Type": "application/json"
    },
    body: JSON.stringify(user)
});'
    ),
    'HTTP Request/Response:

REQUEST:
┌─────────────────────────┐
│ GET /api/users HTTP/1.1 │ ← Start line
├─────────────────────────┤
│ Host: example.com       │
│ Accept: application/json│ ← Headers
│ Authorization: Bearer...│
├─────────────────────────┤
│ (optional body)         │ ← Body
└─────────────────────────┘

RESPONSE:
┌─────────────────────────┐
│ HTTP/1.1 200 OK         │ ← Status line
├─────────────────────────┤
│ Content-Type: app/json  │ ← Headers
│ Content-Length: 42      │
├─────────────────────────┤
│ {"id": 1, "name": "X"}  │ ← Body
└─────────────────────────┘

Stateless: each request independent',
    50
  ) ON CONFLICT DO NOTHING;

  -- Headers vs Body vs Query vs Cookies
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Headers vs Body vs Query vs Cookies',
    'Headers = metadata (what type, authorization). Body = actual content (JSON, file). Query params = filters in URL (?page=1). Cookies = client-stored data sent with every request.',
    'Headers: key-value metadata in request/response (Content-Type, Authorization, etc.). Body: payload data (JSON, XML, files) - present in POST/PUT/PATCH, optional in responses. Query parameters: URL-encoded key-value pairs after ? in URL, typically for filtering/pagination. Cookies: small data stored by client, sent via Cookie header, set via Set-Cookie header.',
    'Four ways to pass data in HTTP: (1) Headers - metadata about the request (auth tokens, content type, accepted formats). Use for cross-cutting concerns. (2) Body - main payload (JSON, file upload). Use for large or structured data. POST/PUT/PATCH have bodies, GET does not. (3) Query parameters - key-value in URL after ?key=value. Use for filtering, sorting, pagination, search. Visible in browser bar. (4) Cookies - persistent data stored client-side, automatically sent with every request to domain. Use for session tokens, preferences. Interview: explain when to use each, security considerations (cookies vulnerable to XSS, sensitive data not in query params).',
    to_jsonb(ARRAY[
      'Putting sensitive data in query params (visible in logs/URLs)',
      'Large data in query params (use body)',
      'Not understanding cookies sent automatically',
      'Confusing headers with query params',
      'Not setting HttpOnly on auth cookies (XSS risk)',
      'Using GET with body (non-standard)'
    ]),
    jsonb_build_object(
      'csharp', '// HEADERS
using var client = new HttpClient();
client.DefaultRequestHeaders.Add("Authorization", "Bearer token");
client.DefaultRequestHeaders.Add("Accept", "application/json");

// QUERY PARAMETERS
var url = "https://api.example.com/users?page=1&size=10&sort=name";
var response = await client.GetAsync(url);

// Build query params
var builder = new UriBuilder("https://api.example.com/users");
var query = HttpUtility.ParseQueryString(string.Empty);
query["page"] = "1";
query["size"] = "10";
query["sort"] = "name";
builder.Query = query.ToString();
var response2 = await client.GetAsync(builder.Uri);

// BODY (POST/PUT/PATCH)
var user = new { name = "John", email = "john@example.com" };
var content = new StringContent(
    JsonSerializer.Serialize(user),
    Encoding.UTF8,
    "application/json"
);
await client.PostAsync("https://api.example.com/users", content);

// COOKIES (ASP.NET Core)
// Setting cookie
Response.Cookies.Append("session_id", "abc123", new CookieOptions {
    HttpOnly = true,  // Not accessible via JavaScript
    Secure = true,    // HTTPS only
    SameSite = SameSiteMode.Strict
});

// Reading cookie
if (Request.Cookies.TryGetValue("session_id", out var sessionId)) {
    // Use sessionId
}',
      'typescript', '// HEADERS
const response = await fetch("https://api.example.com/users", {
    headers: {
        "Authorization": "Bearer token",
        "Accept": "application/json"
    }
});

// QUERY PARAMETERS
const params = new URLSearchParams({
    page: "1",
    size: "10",
    sort: "name"
});
const url = `https://api.example.com/users?${params}`;
const response2 = await fetch(url);

// BODY
const user = { name: "John", email: "john@example.com" };
await fetch("https://api.example.com/users", {
    method: "POST",
    headers: {
        "Content-Type": "application/json"
    },
    body: JSON.stringify(user)
});

// COOKIES (browser automatically sends)
// Set cookie (server response):
// Set-Cookie: session_id=abc123; HttpOnly; Secure

// JavaScript can read non-HttpOnly cookies
document.cookie = "pref=dark";
const cookies = document.cookie; // "pref=dark"'
    ),
    'HTTP Data Locations:

REQUEST:
GET /users?page=1&size=10 HTTP/1.1  ← Query params
Host: api.example.com
Authorization: Bearer xyz             ← Header
Accept: application/json              ← Header
Cookie: session_id=abc123             ← Cookie

{"filter": "active"}                  ← Body

┌─────────────────┬──────────────────┐
│ HEADERS         │ Metadata         │
│                 │ Auth, Content-   │
│                 │ Type, etc.       │
├─────────────────┼──────────────────┤
│ QUERY PARAMS    │ Filters, paging  │
│ ?page=1&size=10 │ Visible in URL   │
├─────────────────┼──────────────────┤
│ BODY            │ Main payload     │
│ JSON, file, etc │ POST/PUT/PATCH   │
├─────────────────┼──────────────────┤
│ COOKIES         │ Session, prefs   │
│ Auto-sent       │ Persistent       │
└─────────────────┴──────────────────┘',
    51
  ) ON CONFLICT DO NOTHING;

  -- Content-Type header
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Content-Type',
    'Content-Type header tells the receiver what format the body is. application/json = JSON, multipart/form-data = file upload, text/html = HTML page.',
    'Content-Type: HTTP header specifying the media type of the request or response body. Format: type/subtype (e.g., application/json, text/html). Includes optional charset (Content-Type: text/html; charset=utf-8). Tells recipient how to parse the body.',
    'Content-Type is critical for the receiver to correctly parse the body. Common values: application/json (JSON data), application/xml (XML), text/html (HTML pages), multipart/form-data (file uploads with form data), application/x-www-form-urlencoded (form submissions). Sent by client in POST/PUT/PATCH to tell server what it is sending. Sent by server in response to tell client what it is returning. Charset specifies encoding (utf-8). Interview: explain difference from Accept header (Content-Type = what I am sending, Accept = what I can receive). Mismatch causes 415 Unsupported Media Type.',
    to_jsonb(ARRAY[
      'Confusing Content-Type with Accept header',
      'Wrong Content-Type for file uploads (need multipart/form-data)',
      'Not setting Content-Type (server may reject or misinterpret)',
      'Hardcoding charset when not needed',
      'Not handling Content-Type in API (accepting any type unsafely)',
      'Using wrong type for JSON (text/plain instead of application/json)'
    ]),
    jsonb_build_object(
      'csharp', '// Sending JSON with Content-Type
var user = new { name = "John" };
var content = new StringContent(
    JsonSerializer.Serialize(user),
    Encoding.UTF8,
    "application/json"  // ← Content-Type
);

var response = await httpClient.PostAsync(url, content);

// File upload with multipart/form-data
var multipart = new MultipartFormDataContent();
multipart.Add(new StringContent("John"), "name");

var fileContent = new ByteArrayContent(fileBytes);
fileContent.Headers.ContentType = new MediaTypeHeaderValue("image/png");
multipart.Add(fileContent, "file", "photo.png");

await httpClient.PostAsync(url, multipart);
// Content-Type: multipart/form-data; boundary=----WebKitFormBoundary...

// Reading Content-Type from response
var response = await httpClient.GetAsync(url);
var contentType = response.Content.Headers.ContentType?.MediaType;
if (contentType == "application/json") {
    var json = await response.Content.ReadAsStringAsync();
}',
      'typescript', '// Sending JSON with Content-Type
await fetch(url, {
    method: "POST",
    headers: {
        "Content-Type": "application/json"  // ← Tells server it is JSON
    },
    body: JSON.stringify({ name: "John" })
});

// File upload with multipart/form-data
const formData = new FormData();
formData.append("name", "John");
formData.append("file", fileBlob, "photo.png");

await fetch(url, {
    method: "POST",
    body: formData
    // Content-Type automatically set to multipart/form-data
});

// Reading Content-Type from response
const response = await fetch(url);
const contentType = response.headers.get("Content-Type");
if (contentType?.includes("application/json")) {
    const data = await response.json();
}'
    ),
    'Content-Type:

REQUEST:
POST /api/users HTTP/1.1
Content-Type: application/json  ← What I am SENDING

{"name": "John"}

RESPONSE:
HTTP/1.1 200 OK
Content-Type: application/json  ← What YOU are RECEIVING

{"id": 1, "name": "John"}

Common types:
application/json        → JSON data
application/xml         → XML
text/html              → HTML page
text/plain             → Plain text
multipart/form-data    → File uploads
application/x-www-form-urlencoded → Form data

Content-Type: what I send
Accept: what I can receive',
    52
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Added Batch 2 part 1: HTTP fundamentals (3 terms)';
END $$;

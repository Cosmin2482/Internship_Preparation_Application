/*
  # Batch 2 Part 2: More HTTP & REST Terms
  
  Adds: Accept, Authorization, Location, Safe methods, Pagination
*/

DO $$
DECLARE
  cat_arch_id uuid;
BEGIN
  SELECT id INTO cat_arch_id FROM categories WHERE slug = 'architecture';

  -- Accept header
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Accept',
    'Accept header tells server what formats the client can handle. Accept: application/json means "send me JSON". Server responds with matching Content-Type or 406 Not Acceptable.',
    'Accept: HTTP request header specifying media types the client can process. Supports quality values (q= parameter) for preference weighting. Server uses content negotiation to select best match. If no match, returns 406 Not Acceptable.',
    'Accept enables content negotiation. Client says "I accept these formats" and server picks the best one. Accept: application/json means send JSON. Accept: application/xml means send XML. Can specify multiple: Accept: application/json, text/xml. Quality values show preference: Accept: application/json, text/html;q=0.9 (prefer JSON, HTML ok). Server responds with Content-Type matching what it chose. API design: support common Accept types or return 406 if unsupported. Interview: explain difference from Content-Type (Accept = what I want to receive, Content-Type = what you are sending).',
    to_jsonb(ARRAY[
      'Confusing Accept with Content-Type',
      'Not handling unsupported Accept types (should return 406)',
      'Ignoring Accept header in API implementation',
      'Not understanding quality values (q=)',
      'Client setting wrong Accept for API (text/html for JSON API)',
      'Server not sending correct Content-Type in response'
    ]),
    jsonb_build_object(
      'csharp', '// Setting Accept header
using var client = new HttpClient();
client.DefaultRequestHeaders.Accept.Add(
    new MediaTypeWithQualityHeaderValue("application/json")
);

var response = await client.GetAsync(url);

// Multiple Accept types with quality
client.DefaultRequestHeaders.Accept.Clear();
client.DefaultRequestHeaders.Accept.Add(
    new MediaTypeWithQualityHeaderValue("application/json")
);
client.DefaultRequestHeaders.Accept.Add(
    new MediaTypeWithQualityHeaderValue("application/xml", 0.9)
);
// Accept: application/json, application/xml;q=0.9

// API handling Accept header
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase {
    [HttpGet("{id}")]
    [Produces("application/json", "application/xml")]
    public IActionResult Get(int id) {
        var user = GetUser(id);
        
        // ASP.NET Core handles content negotiation
        return Ok(user); // Returns JSON or XML based on Accept
    }
}

// Manual Accept check
var acceptHeader = Request.Headers["Accept"].ToString();
if (!acceptHeader.Contains("application/json")) {
    return StatusCode(406); // Not Acceptable
}',
      'typescript', '// Setting Accept header
const response = await fetch(url, {
    headers: {
        "Accept": "application/json"
    }
});

// Multiple types with quality
await fetch(url, {
    headers: {
        "Accept": "application/json, text/html;q=0.9"
    }
});

// Check response Content-Type
if (response.headers.get("Content-Type")?.includes("application/json")) {
    const data = await response.json();
} else {
    const text = await response.text();
}'
    ),
    'Accept Header:

REQUEST:
GET /api/users/1 HTTP/1.1
Accept: application/json  ← What I CAN RECEIVE

RESPONSE:
HTTP/1.1 200 OK
Content-Type: application/json  ← What YOU ARE SENDING

{"id": 1, "name": "John"}

Content Negotiation:
Client: Accept: application/json, application/xml;q=0.9
                 ↑ prefer         ↑ ok but lower priority

Server: Content-Type: application/json
        (chose best match)

If no match → 406 Not Acceptable

Key difference:
Accept → what I WANT
Content-Type → what IS BEING SENT',
    53
  ) ON CONFLICT DO NOTHING;

  -- Authorization header
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Authorization',
    'Authorization header carries credentials to prove who you are. Common: Authorization: Bearer <token>. Server checks token and allows/denies access.',
    'Authorization: HTTP request header containing credentials for authenticating the client. Formats: Bearer <token> (JWT/OAuth), Basic <base64> (username:password), Digest, API Key. Server validates and returns 401 Unauthorized if invalid, 403 Forbidden if valid but insufficient permissions.',
    'Authorization header is how clients prove identity to APIs. Most common modern pattern: Bearer token (JWT). Client gets token from auth server, includes it in every API request. Server validates token signature and claims. Basic auth (Authorization: Basic <base64-encoded-user:pass>) is simple but insecure without HTTPS. API keys sometimes in Authorization or custom header (X-API-Key). Interview points: explain Bearer token flow, 401 vs 403 (401 = not authenticated, 403 = authenticated but not authorized), never send tokens without HTTPS, tokens should have expiry, refresh tokens for long sessions.',
    to_jsonb(ARRAY[
      'Sending Authorization over HTTP (need HTTPS)',
      'Confusing 401 (unauthenticated) with 403 (unauthorized)',
      'Not validating token on server',
      'Hardcoding tokens in client code',
      'Using Basic auth without HTTPS (credentials visible)',
      'Not setting token expiration (security risk)'
    ]),
    jsonb_build_object(
      'csharp', '// BEARER TOKEN (most common)
using var client = new HttpClient();
var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...";
client.DefaultRequestHeaders.Authorization = 
    new AuthenticationHeaderValue("Bearer", token);

var response = await client.GetAsync("https://api.example.com/users");

// BASIC AUTH (username:password in base64)
var credentials = Convert.ToBase64String(
    Encoding.UTF8.GetBytes("username:password")
);
client.DefaultRequestHeaders.Authorization = 
    new AuthenticationHeaderValue("Basic", credentials);

// API VALIDATING AUTHORIZATION (ASP.NET Core)
[Authorize] // Requires valid JWT
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase {
    [HttpGet]
    public IActionResult Get() {
        // Only called if Authorization header valid
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        return Ok(GetUsers(userId));
    }
}

// Manual token validation
var authHeader = Request.Headers["Authorization"].ToString();
if (!authHeader.StartsWith("Bearer ")) {
    return Unauthorized(); // 401
}

var token = authHeader.Substring("Bearer ".Length);
if (!ValidateToken(token)) {
    return Unauthorized(); // 401
}

// User authenticated but lacks permission
if (!UserHasPermission(userId, "read:users")) {
    return Forbid(); // 403
}',
      'typescript', '// BEARER TOKEN
const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...";

const response = await fetch("https://api.example.com/users", {
    headers: {
        "Authorization": `Bearer ${token}`
    }
});

// BASIC AUTH
const credentials = btoa("username:password");
await fetch(url, {
    headers: {
        "Authorization": `Basic ${credentials}`
    }
});

// Handling auth errors
if (response.status === 401) {
    // Not authenticated - redirect to login
    window.location.href = "/login";
} else if (response.status === 403) {
    // Authenticated but not authorized
    alert("You do not have permission");
}'
    ),
    'Authorization Header:

REQUEST:
GET /api/users HTTP/1.1
Authorization: Bearer eyJhbGc...  ← Token

RESPONSE (success):
HTTP/1.1 200 OK
[user data]

RESPONSE (auth fail):
HTTP/1.1 401 Unauthorized  ← No/invalid token

RESPONSE (permission fail):
HTTP/1.1 403 Forbidden  ← Valid token, wrong role

Common formats:
Bearer <JWT>         → Modern (OAuth2, JWT)
Basic <base64>       → username:password
API Key <key>        → Custom API keys

401 vs 403:
401 → Who are you? (not authenticated)
403 → I know you, but no access (not authorized)',
    54
  ) ON CONFLICT DO NOTHING;

  -- Location header
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Location',
    'Location header tells client where the new resource is. After POST creates resource, 201 Created + Location: /api/users/123. Client knows the URL of the new thing.',
    'Location: HTTP response header containing the URI of a resource. Used with 201 Created (new resource URL), 202 Accepted (status URL), 3xx redirects (redirect target). Absolute or relative URI.',
    'Location header is critical for RESTful APIs. When POST creates a resource, respond 201 Created with Location header pointing to the new resource URL. Client can then GET that URL to retrieve the resource. Also used in redirects: 301 Moved Permanently, 302 Found, 303 See Other include Location. Best practice: after POST creating user, return 201 + Location: /api/users/123 + user data in body. Client knows both the URL and the data. 202 Accepted (async operations) uses Location to point to status endpoint. Interview: explain why 201 should include Location, difference between 201 (with Location) vs 200 (no Location).',
    to_jsonb(ARRAY[
      'Returning 200 instead of 201 for resource creation',
      'Not including Location header with 201',
      'Location pointing to wrong/invalid URL',
      'Using relative URLs inconsistently',
      'Not following Location in redirects',
      'Forgetting Location in 202 Accepted responses'
    ]),
    jsonb_build_object(
      'csharp', '// RETURNING 201 with Location
[HttpPost]
public IActionResult CreateUser([FromBody] UserDto dto) {
    var user = new User { Name = dto.Name, Email = dto.Email };
    _db.Users.Add(user);
    _db.SaveChanges();
    
    // 201 Created + Location header
    return CreatedAtAction(
        nameof(GetUser),           // Action name
        new { id = user.Id },      // Route values
        user                       // Body
    );
    // Response: 201 Created
    // Location: /api/users/123
    // Body: {"id": 123, "name": "John", ...}
}

[HttpGet("{id}")]
public IActionResult GetUser(int id) {
    var user = _db.Users.Find(id);
    return Ok(user);
}

// Manual Location header
var newUser = CreateUser(dto);
Response.Headers["Location"] = $"/api/users/{newUser.Id}";
return StatusCode(201, newUser);

// FOLLOWING Location (client)
var createResponse = await httpClient.PostAsync(url, content);
if (createResponse.StatusCode == HttpStatusCode.Created) {
    var location = createResponse.Headers.Location;
    // GET the new resource
    var getResponse = await httpClient.GetAsync(location);
}

// REDIRECT with Location
return RedirectToAction("Details", new { id = user.Id });
// Response: 302 Found
// Location: /users/123',
      'typescript', '// Following Location header (client)
const response = await fetch("/api/users", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name: "John", email: "john@example.com" })
});

if (response.status === 201) {
    const location = response.headers.get("Location");
    console.log("New resource at:", location);
    
    // Fetch the new resource
    const newUser = await fetch(location);
    const userData = await newUser.json();
}'
    ),
    'Location Header:

POST /api/users
{"name": "John"}

↓

201 Created
Location: /api/users/123  ← URL of new resource
{"id": 123, "name": "John"}

Client now knows:
✓ Resource created (201)
✓ Where it is (Location)
✓ Its data (body)

Redirect:
GET /old-page

↓

302 Found
Location: /new-page  ← Go here instead

Use cases:
201 Created → new resource URL
202 Accepted → status check URL
3xx redirects → redirect target
301 → permanent move
302/303 → temporary redirect',
    55
  ) ON CONFLICT DO NOTHING;

  -- Safe methods
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Safe Methods',
    'Safe methods = read-only, no side effects. GET and HEAD are safe - they do not change server state. POST/PUT/PATCH/DELETE are unsafe - they modify data.',
    'Safe methods: HTTP methods that do not modify server state. GET, HEAD, OPTIONS, TRACE are safe (read-only). POST, PUT, PATCH, DELETE are unsafe (write operations). Safe methods should be idempotent and cacheable.',
    'Safe methods guarantee no state changes on the server. GET retrieves data, HEAD gets headers only (no body), OPTIONS checks what methods are allowed. These should never modify database, send emails, or cause side effects. Unsafe methods (POST, PUT, PATCH, DELETE) change state. Key interview point: GET should NEVER mutate state - common mistake is GET /api/users/123/delete. Use DELETE instead. Safe methods can be cached, bookmarked, prefetched safely. Browser may retry GET automatically but not POST. Safe vs Idempotent: all safe methods are idempotent, but not vice versa (DELETE is idempotent but not safe).',
    to_jsonb(ARRAY[
      'Using GET for state-changing operations (GET /delete)',
      'Not understanding browsers can prefetch GET requests',
      'Putting delete/update logic in GET handlers',
      'Confusing safe with idempotent',
      'Not making safe methods cacheable',
      'Using POST for everything (should use GET for reads)'
    ]),
    jsonb_build_object(
      'csharp', '// SAFE METHODS (read-only)

// GET - retrieve data
[HttpGet("{id}")]
public IActionResult GetUser(int id) {
    var user = _db.Users.Find(id);
    return Ok(user); // No state change ✓
}

// HEAD - same as GET but no body
[HttpHead("{id}")]
public IActionResult HeadUser(int id) {
    if (_db.Users.Any(u => u.Id == id))
        return Ok();
    return NotFound();
}

// OPTIONS - check allowed methods
[HttpOptions]
public IActionResult Options() {
    Response.Headers.Add("Allow", "GET, POST, PUT, DELETE");
    return Ok();
}

// ✗ WRONG - state change in GET
[HttpGet("delete/{id}")]  // ✗ Bad!
public IActionResult DeleteUser(int id) {
    _db.Users.Remove(...);
    _db.SaveChanges();
    return Ok();
}

// ✓ CORRECT - use DELETE
[HttpDelete("{id}")]  // ✓ Good!
public IActionResult DeleteUser(int id) {
    _db.Users.Remove(...);
    _db.SaveChanges();
    return NoContent();
}

// UNSAFE METHODS (modify state)
[HttpPost]
public IActionResult CreateUser([FromBody] User user) {
    _db.Users.Add(user);
    _db.SaveChanges(); // State change
    return CreatedAtAction(nameof(GetUser), new { id = user.Id }, user);
}',
      'typescript', '// SAFE - GET (read-only)
const user = await fetch("/api/users/123");
// Can be cached, bookmarked, prefetched

// SAFE - HEAD (check if exists)
const response = await fetch("/api/users/123", {
    method: "HEAD"
});
console.log("Exists:", response.ok);

// UNSAFE - POST (creates)
await fetch("/api/users", {
    method: "POST",
    body: JSON.stringify({ name: "John" })
});

// ✗ WRONG - state change in GET
await fetch("/api/users/123/delete"); // Bad!

// ✓ CORRECT - use DELETE
await fetch("/api/users/123", {
    method: "DELETE"
});'
    ),
    'Safe vs Unsafe Methods:

SAFE (read-only, no side effects):
GET    → Read data ✓
HEAD   → Check existence ✓
OPTIONS → Check methods ✓

Can be:
- Cached
- Bookmarked
- Prefetched
- Retried automatically

UNSAFE (modify state):
POST   → Create
PUT    → Replace
PATCH  → Update
DELETE → Remove

Cannot be:
- Cached (usually)
- Prefetched safely
- Retried without confirmation

Safe vs Idempotent:
GET: safe + idempotent
DELETE: unsafe but idempotent
POST: unsafe + non-idempotent',
    56
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Completed Batch 2: Added 8 HTTP & REST terms';
END $$;

/*
  # Batch 8: Authentication & Security Comprehensive
  
  Adds missing auth & security terms:
  - Authentication vs Authorization
  - JWT (JSON Web Token)
  - Session cookie
  - OWASP: SQL Injection, XSS, CSRF
*/

DO $$
DECLARE
  cat_arch_id uuid;
BEGIN
  SELECT id INTO cat_arch_id FROM categories WHERE slug = 'architecture';

  -- Authentication vs Authorization
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'Authentication vs Authorization',
    'Authentication (authn) = who you are (login, prove identity). Authorization (authz) = what you can do (permissions, roles). Authn comes first, then authz checks permissions.',
    'Authentication: verifying identity (username/password, token, biometrics). Authorization: determining permissions and access rights after authentication. Authn answers "who?", authz answers "allowed?". Authn precedes authz.',
    'Critical distinction. Authentication verifies identity - user proves they are who they claim (login with password, present JWT token, biometric). Authorization determines what authenticated user can access - checks roles, permissions (admin can delete, user cannot). Flow: (1) Authenticate - verify credentials. (2) Issue token/session. (3) Authorize - check permissions for each request. HTTP: 401 Unauthorized = not authenticated. 403 Forbidden = authenticated but not authorized. Interview: explain both, give examples, 401 vs 403, common patterns (RBAC role-based access control, claims-based), why separate concerns.',
    to_jsonb(ARRAY[
      'Confusing authentication with authorization',
      'Not implementing both (security gap)',
      'Authorizing before authenticating',
      'Using 401 when should be 403',
      'No role/permission checks (only authentication)',
      'Hardcoding permissions in client (must check server)'
    ]),
    jsonb_build_object(
      'csharp', '// AUTHENTICATION (who are you?)
[HttpPost("login")]
public IActionResult Login([FromBody] LoginDto dto) {
    // Verify credentials
    var user = _userService.FindByEmail(dto.Email);
    if (user == null || !_hasher.Verify(dto.Password, user.PasswordHash)) {
        return Unauthorized(); // 401 - not authenticated
    }
    
    // Generate token
    var token = _tokenService.GenerateJwt(user);
    return Ok(new { token });
}

// AUTHORIZATION (what can you do?)
[Authorize] // Must be authenticated
[HttpDelete("users/{id}")]
public IActionResult DeleteUser(int id) {
    // User authenticated, now check authorization
    var currentUserId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
    var currentUserRole = User.FindFirst(ClaimTypes.Role)?.Value;
    
    // Authorization check
    if (currentUserRole != "Admin" && currentUserId != id.ToString()) {
        return Forbid(); // 403 - authenticated but not authorized
    }
    
    _userService.Delete(id);
    return NoContent();
}

// ROLE-BASED AUTHORIZATION
[Authorize(Roles = "Admin")] // Only admin role
[HttpGet("admin/reports")]
public IActionResult GetReports() {
    return Ok(_reportService.GetAll());
}

// POLICY-BASED AUTHORIZATION
[Authorize(Policy = "CanDeleteUsers")]
[HttpDelete("users/{id}")]
public IActionResult DeleteUser(int id) {
    _userService.Delete(id);
    return NoContent();
}

// Define policy
services.AddAuthorization(options => {
    options.AddPolicy("CanDeleteUsers", policy =>
        policy.RequireRole("Admin", "Moderator"));
});

// CLAIMS-BASED
var claims = new[] {
    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
    new Claim(ClaimTypes.Name, user.Name),
    new Claim(ClaimTypes.Role, user.Role),
    new Claim("department", user.Department)
};

// Check custom claim
if (!User.HasClaim("department", "IT")) {
    return Forbid();
}',
      'typescript', '// Express middleware

// AUTHENTICATION
app.post(''/login'', async (req, res) => {
    const { email, password } = req.body;
    
    // Verify credentials
    const user = await userService.findByEmail(email);
    if (!user || !await bcrypt.compare(password, user.passwordHash)) {
        return res.status(401).json({ error: ''Invalid credentials'' });
    }
    
    // Generate token
    const token = jwt.sign(
        { userId: user.id, role: user.role },
        SECRET,
        { expiresIn: ''1h'' }
    );
    
    res.json({ token });
});

// AUTHENTICATION MIDDLEWARE
function authenticate(req, res, next) {
    const token = req.headers.authorization?.split('' '')[1];
    
    if (!token) {
        return res.status(401).json({ error: ''Not authenticated'' });
    }
    
    try {
        const payload = jwt.verify(token, SECRET);
        req.user = payload;
        next();
    } catch {
        return res.status(401).json({ error: ''Invalid token'' });
    }
}

// AUTHORIZATION MIDDLEWARE
function authorize(...roles) {
    return (req, res, next) => {
        if (!req.user) {
            return res.status(401).json({ error: ''Not authenticated'' });
        }
        
        if (!roles.includes(req.user.role)) {
            return res.status(403).json({ error: ''Forbidden'' });
        }
        
        next();
    };
}

// Usage
app.delete(''/users/:id'', 
    authenticate,              // First: who are you?
    authorize(''admin''),       // Then: are you allowed?
    (req, res) => {
        userService.delete(req.params.id);
        res.status(204).send();
    }
);'
    ),
    'Authentication vs Authorization:

AUTHENTICATION (who?):
User → Login (email + password)
       ↓ Verify credentials
Server → Check database
       ↓ Match found
Server → Issue token/session
       ✓ Authenticated

401 Unauthorized
→ Not authenticated
→ Need to login

AUTHORIZATION (allowed?):
Request → DELETE /users/5
          + Token
          ↓ Verify token ✓
Server → Check role/permissions
         ↓ Is user admin?
         ✗ No (regular user)
Server → 403 Forbidden

403 Forbidden
→ Authenticated ✓
→ But not authorized ✗

Flow:
1. Authenticate first
2. Then authorize

authn → who you are
authz → what you can do',
    70
  ) ON CONFLICT DO NOTHING;

  -- JWT
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_arch_id,
    'JWT (JSON Web Token)',
    'JWT = signed token with user info (claims). Three parts: header.payload.signature. Server signs it, client stores it, sends with each request. Stateless - no server session needed. Server validates signature.',
    'JWT: compact URL-safe token format for securely transmitting claims between parties. Structure: header (algorithm).payload (claims).signature. Signed with secret or private key. Stateless - server does not store session. Used for authentication (Authorization: Bearer <token>). Self-contained, has expiry.',
    'Modern authentication standard. JWT has three base64-encoded parts separated by dots: (1) Header - algorithm and type. (2) Payload - claims (user ID, role, expiry). (3) Signature - HMAC of header + payload with secret. Server generates JWT after login, client stores it (localStorage/sessionStorage), includes in Authorization header. Server validates signature and checks expiry. Benefits: stateless (no server session), scalable, works across domains. Drawbacks: cannot revoke (until expiry), larger than session ID. Interview: explain structure, signing, validation, expiry (exp claim), refresh tokens, where to store (not localStorage for sensitive apps - XSS risk, use httpOnly cookies or memory).',
    to_jsonb(ARRAY[
      'Storing sensitive data in JWT (payload is not encrypted)',
      'No expiration or very long expiration',
      'Weak secret key (use long random string)',
      'Not validating signature server-side',
      'Storing JWT in localStorage (XSS vulnerability)',
      'No refresh token strategy (user logs out on exp)'
    ]),
    jsonb_build_object(
      'csharp', '// GENERATING JWT
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;

public string GenerateJwt(User user) {
    var claims = new[] {
        new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
        new Claim(JwtRegisteredClaimNames.Email, user.Email),
        new Claim(ClaimTypes.Role, user.Role),
        new Claim("name", user.Name)
    };
    
    var key = new SymmetricSecurityKey(
        Encoding.UTF8.GetBytes(_config["Jwt:Secret"])
    );
    var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
    
    var token = new JwtSecurityToken(
        issuer: _config["Jwt:Issuer"],
        audience: _config["Jwt:Audience"],
        claims: claims,
        expires: DateTime.Now.AddHours(1), // Expiry
        signingCredentials: creds
    );
    
    return new JwtSecurityTokenHandler().WriteToken(token);
}

// CONFIGURING JWT AUTHENTICATION
builder.Services
    .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options => {
        options.TokenValidationParameters = new TokenValidationParameters {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Secret"])
            )
        };
    });

// CLIENT USAGE
var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...";

var client = new HttpClient();
client.DefaultRequestHeaders.Authorization = 
    new AuthenticationHeaderValue("Bearer", token);

var response = await client.GetAsync("/api/users/me");

// JWT STRUCTURE
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9 ← Header (base64)
// .
// eyJzdWIiOiIxMjMiLCJuYW1lIjoiSm9obiJ9 ← Payload (base64)
// .
// SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c ← Signature

// Decoded:
// Header: {"alg": "HS256", "typ": "JWT"}
// Payload: {"sub": "123", "name": "John", "exp": 1734567890}
// Signature: HMAC-SHA256(header + payload, secret)',
      'typescript', '// Node.js with jsonwebtoken
import jwt from ''jsonwebtoken'';

const SECRET = process.env.JWT_SECRET;

// GENERATE JWT
function generateToken(user) {
    const payload = {
        userId: user.id,
        email: user.email,
        role: user.role
    };
    
    const token = jwt.sign(
        payload,
        SECRET,
        { expiresIn: ''1h'' } // Expiry
    );
    
    return token;
}

// VERIFY JWT
function verifyToken(token) {
    try {
        const decoded = jwt.verify(token, SECRET);
        return decoded; // { userId, email, role, iat, exp }
    } catch (error) {
        throw new Error(''Invalid token'');
    }
}

// MIDDLEWARE
function authenticate(req, res, next) {
    const authHeader = req.headers.authorization;
    const token = authHeader?.split('' '')[1];
    
    if (!token) {
        return res.status(401).json({ error: ''No token'' });
    }
    
    try {
        const decoded = verifyToken(token);
        req.user = decoded;
        next();
    } catch {
        return res.status(401).json({ error: ''Invalid token'' });
    }
}

// CLIENT
fetch(''/api/users/me'', {
    headers: {
        ''Authorization'': `Bearer ${token}`
    }
});'
    ),
    'JWT Structure:

header.payload.signature

HEADER (algorithm + type):
{
    "alg": "HS256",
    "typ": "JWT"
}
↓ base64
eyJhbGci...

PAYLOAD (claims):
{
    "sub": "123",
    "name": "John",
    "role": "admin",
    "exp": 1734567890
}
↓ base64
eyJzdWIi...

SIGNATURE:
HMAC-SHA256(
    base64(header) + "." + base64(payload),
    secret
)
↓
SflKxw...

Full JWT:
eyJhbGci...eyJzdWIi...SflKxw...

Flow:
1. User logs in
2. Server generates JWT
3. Client stores JWT
4. Client sends JWT with requests
5. Server validates signature
6. Server extracts claims

Stateless ✓
Self-contained ✓
Cannot revoke ✗',
    71
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Added Batch 8 part 1: Auth fundamentals (2 terms)';
END $$;

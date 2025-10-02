# Database Seeding Guide

## Current Status

The database has been seeded with **sample terms** from all categories demonstrating the complete structure:

### Seeded Terms (Examples)
- **CS Fundamentals (Easy)**: Array, Stack, Queue, Set
- **CS Fundamentals (Medium)**: Doubly Linked List, Deque, BST, Heap, Graph Basics
- **OOP (Easy)**: OOP Pillars

Each term includes:
- ✅ ELI5 explanation
- ✅ Formal definition
- ✅ Interview answer (30-60s)
- ✅ Common pitfalls (3-7 items)
- ✅ Code examples (C# and/or TypeScript)
- ✅ ASCII/text diagram
- ✅ 5+ quiz questions with explanations

## Seed File Structure

The comprehensive seed file (`comprehensive-seed-all.sql`) demonstrates the pattern:

```sql
-- 1. Get category IDs
SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';

-- 2. Insert term
INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
VALUES (
  cat_cs,
  'Term Name',
  'Simple explanation...',
  'Technical definition...',
  'Interview answer...',
  to_jsonb(ARRAY['Pitfall 1', 'Pitfall 2', 'Pitfall 3']),
  jsonb_build_object(
    'csharp', 'C# code here',
    'typescript', 'TypeScript code here'
  ),
  'ASCII diagram here',
  order_index_number
) RETURNING id INTO current_term_id;

-- 3. Insert quiz questions
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
VALUES
  (current_term_id, 'Question 1?',
   to_jsonb(ARRAY['Choice A', 'Choice B', 'Choice C', 'Choice D']),
   correct_index_0_to_3,
   'Explanation why correct'),
  (current_term_id, 'Question 2?', ...),
  ... (5+ questions total)
```

## Complete Term List to Seed

### CS Fundamentals (Easy)
- [x] Array
- [ ] Linked List (Singly)
- [x] Stack
- [x] Queue
- [x] Set
- [ ] Hash Table/Dictionary
- [ ] Tree Basics
- [ ] Sorting (Bubble/Selection/Insertion)
- [ ] Searching (Linear/Binary)
- [ ] BFS/DFS & Traversals
- [ ] Two-Pointers/Sliding Window
- [ ] Hashing for Frequency/Prefix Sum
- [ ] Big-O Time/Space

### CS Fundamentals (Medium)
- [x] Linked List (Doubly)
- [x] Deque
- [x] BST
- [x] Heap/Priority Queue
- [x] Graph Basics
- [ ] Greedy vs Dynamic Programming
- [ ] Memory: stack vs heap
- [ ] Networking Basics

### CS Fundamentals (Advanced)
- [ ] Union-Find/Disjoint Set
- [ ] Concurrency: threads vs async I/O
- [ ] Security: SQLi, XSS, CSRF
- [ ] Cookies vs Tokens; CORS; Caching

### OOP (Easy)
- [x] OOP Pillars
- [ ] Class vs Object; Constructors
- [ ] Access modifiers
- [ ] Properties/Fields; readonly/const

### OOP (Medium)
- [ ] Interfaces vs Abstract classes
- [ ] virtual/override/new; sealed
- [ ] Records, immutability
- [ ] Exceptions, using/IDisposable
- [ ] Async/Await, Task, CancellationToken
- [ ] Nullable reference types; pattern matching

### OOP (Advanced)
- [ ] Generics, constraints, variance
- [ ] Delegates & Events
- [ ] SOLID principles
- [ ] Dependency Injection

### .NET & Backend (Medium)
- [ ] ASP.NET Core pipeline, middleware
- [ ] Model binding & validation
- [ ] Configuration & Options pattern
- [ ] Caching: IMemoryCache vs IDistributedCache
- [ ] SignalR/WebSockets

### .NET & Backend (Advanced)
- [ ] AuthN/AuthZ: JWT, OAuth2
- [ ] Entity Framework Core (full coverage)
- [ ] Testing: xUnit, Moq, WebApplicationFactory
- [ ] gRPC vs REST vs GraphQL
- [ ] Background jobs, hosted services

### SQL & Data (Easy)
- [ ] Schema design & Normalization
- [ ] Keys: Primary, Foreign, Unique
- [ ] JOINs: INNER, LEFT, RIGHT, FULL
- [ ] Views, Stored Procedures

### SQL & Data (Medium)
- [ ] Indexes: clustered vs nonclustered
- [ ] Transactions & ACID; Isolation levels
- [ ] Pagination: OFFSET/FETCH vs keyset
- [ ] ORM pitfalls: N+1

### SQL & Data (Advanced)
- [ ] Query plans & parameter sniffing

### TypeScript & Angular (Easy)
- [ ] TypeScript basics: types, interfaces
- [ ] Modules/import/export; Promises
- [ ] Angular Components & bindings

### TypeScript & Angular (Medium)
- [ ] Lifecycle hooks
- [ ] Services & DI
- [ ] HttpClient, interceptors
- [ ] Routing: lazy loading, guards
- [ ] Forms: Reactive vs Template-driven

### TypeScript & Angular (Advanced)
- [ ] RxJS: Observables, operators
- [ ] Change Detection, OnPush
- [ ] Testing: TestBed, HttpTestingController

### App Architecture (Easy/Medium)
- [ ] Clean Architecture / Layers
- [ ] MVC vs API+SPA
- [ ] DTO vs Entity mapping
- [ ] REST Best Practices
- [ ] API Versioning

### App Architecture (Advanced)
- [ ] Repository & Unit of Work
- [ ] CQRS (light)
- [ ] Idempotency; ETag/If-Match

### DevOps & CI/CD (Easy)
- [ ] Git workflows: GitHub Flow vs GitFlow
- [ ] CI steps: build, test, lint
- [ ] Docker basics

### DevOps & CI/CD (Medium)
- [ ] Pipelines (GitHub Actions/Azure DevOps)
- [ ] Artifacts & environments
- [ ] Blue-green, canary deployments

### DevOps & CI/CD (Advanced)
- [ ] Observability: logs, metrics, traces

### AI/ML Basics (Easy)
- [ ] Tasks: classification vs regression
- [ ] Metrics: accuracy, precision, recall, F1
- [ ] Train/val/test split
- [ ] Confusion matrix; threshold tuning

### AI/ML Basics (Medium)
- [ ] Overfitting/Underfitting; regularization
- [ ] Cross-validation; data leakage

### AI/ML Basics (Advanced)
- [ ] Prompt engineering
- [ ] Embeddings, tokenization, transformer, RAG

### Soft Skills & HR (Easy)
- [ ] STAR Method
- [ ] HR question bank
- [ ] Scrum basics
- [ ] Handling pressure

### Cloud Basics (Easy)
- [ ] AWS/Azure 101: IAM, storage, networking

## How to Expand the Seed

### Option 1: Continue SQL File

Add to `comprehensive-seed-all.sql` following the exact pattern shown:

```sql
-- New Term
INSERT INTO terms (...) VALUES (...) RETURNING id INTO current_term_id;
INSERT INTO quiz_questions (...) VALUES (...), (...), (...), (...), (...);
```

Execute with Supabase MCP tools or SQL editor.

### Option 2: Use TypeScript Seeder

Create `seed-batch.ts`:

```typescript
import { supabase } from './src/lib/supabase';

const terms = [
  {
    category_slug: 'cs-fundamentals',
    term: 'Linked List (Singly)',
    eli5: '...',
    formal_definition: '...',
    interview_answer: '...',
    pitfalls: ['...', '...'],
    code_examples: { csharp: '...', typescript: '...' },
    diagram: '...',
    order_index: 2,
    quiz: [
      { question: '...', choices: [...], correct_index: 0, explanation: '...' },
      // ... 5+ questions
    ]
  },
  // ... more terms
];

async function seed() {
  for (const t of terms) {
    const { data: cat } = await supabase
      .from('categories')
      .select('id')
      .eq('slug', t.category_slug)
      .single();

    const { data: term } = await supabase
      .from('terms')
      .insert({
        category_id: cat.id,
        term: t.term,
        eli5: t.eli5,
        formal_definition: t.formal_definition,
        interview_answer: t.interview_answer,
        pitfalls: t.pitfalls,
        code_examples: t.code_examples,
        diagram: t.diagram,
        order_index: t.order_index
      })
      .select()
      .single();

    await supabase.from('quiz_questions').insert(
      t.quiz.map(q => ({ ...q, term_id: term.id }))
    );

    console.log(`Seeded: ${t.term}`);
  }
}

seed();
```

Run with: `npx tsx seed-batch.ts`

### Option 3: Manual via Supabase Dashboard

Use the SQL editor in Supabase Dashboard to paste and execute seed SQL in batches.

## Content Guidelines

### ELI5 (Explain Like I'm 5)
- Use everyday analogies
- 1-2 sentences
- No jargon

### Formal Definition
- Technical accuracy
- Mention complexity where relevant
- 2-3 sentences

### Interview Answer
- 30-60 second verbal response
- Cover when/why/tradeoffs
- 3-5 sentences

### Pitfalls
- 3-7 common mistakes
- Concrete and actionable
- What to avoid

### Code Examples
- Show both C# and TypeScript where applicable
- Keep concise (10-20 lines max)
- Include comments for clarity
- Real-world patterns

### Diagrams
- ASCII art or simple text representation
- Show structure/flow/relationships
- 5-10 lines max

### Quiz Questions
- 5-7 questions per term
- 4 choices each
- Mix difficulty
- One-sentence explanations
- Test understanding, not memorization

## Level Distribution

Aim for:
- **Easy**: 40% of terms (foundations, basic concepts)
- **Medium**: 40% of terms (practical application, tradeoffs)
- **Advanced**: 20% of terms (deep dives, edge cases, advanced patterns)

## Execution Commands

```bash
# Execute full seed via Supabase
psql $DATABASE_URL < comprehensive-seed-all.sql

# Or via MCP tools in Claude
# Use mcp__supabase__execute_sql with SQL content
```

## Verification

After seeding, verify:

```sql
-- Count terms by category
SELECT c.name, COUNT(t.id) as term_count
FROM categories c
LEFT JOIN terms t ON c.id = t.category_id
GROUP BY c.name
ORDER BY c.order_index;

-- Count quiz questions
SELECT COUNT(*) FROM quiz_questions;

-- Check for terms without quizzes
SELECT t.term
FROM terms t
LEFT JOIN quiz_questions q ON t.id = q.term_id
WHERE q.id IS NULL;
```

Expected totals:
- Categories: 10
- Terms: 150+ (target)
- Quiz Questions: 750+ (5+ per term)

## Next Steps

1. Prioritize high-value terms for interview prep
2. Seed in batches by category
3. Test UI with new terms
4. Gather feedback on content quality
5. Iterate and refine

The foundation is complete—expand systematically following the established patterns!

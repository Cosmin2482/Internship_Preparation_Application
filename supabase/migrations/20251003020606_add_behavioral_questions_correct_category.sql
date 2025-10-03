/*
  # Add Behavioral Interview Questions and Tips
  
  Add soft skills, behavioral questions, interview tips
*/

DO $$
DECLARE
  cat_hr uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_hr FROM categories WHERE slug = 'hr';

  -- Behavioral Interview Questions
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_hr, 'Behavioral Interview Questions',
    'Questions about past experiences: how you handled bugs, conflicts, deadlines. Use STAR method: Situation, Task, Action, Result.',
    'Behavioral questions assess soft skills, problem-solving, teamwork, learning ability through concrete past experiences. STAR framework structures answers.',
    'Common questions: bug you solved, time you asked for help, handling feedback, prioritizing tasks, dealing with tight deadlines. Answer with STAR: Situation (context), Task (challenge), Action (what YOU did), Result (outcome + learning). Be specific, honest, show growth mindset.',
    to_jsonb(ARRAY['Generic answers without specifics', 'Not showing what YOU did', 'Blaming others', 'No learnings mentioned', 'Too long stories', 'Not preparing examples']),
    jsonb_build_object(
      'csharp', 'Bug Fixed Example (STAR):

Situation: Users could not login after we added password hashing. QA reported 100% login failures.

Task: Find why hashed passwords were not matching and fix before demo next day.

Action:
1. Reproduced bug locally with debugger
2. Found we were hashing password TWICE on login
3. Fixed to hash once, matching registration
4. Added unit tests for both flows
5. Verified fix in staging

Result: Login worked. Learned to add tests for critical paths upfront.

BUGGY: return user.Hash == Hash(Hash(password));
FIXED: return user.Hash == Hash(password);',
      'typescript', 'Learning New Tech Example (STAR):

Situation: Needed to implement infinite scroll but had never done it.

Task: Learn intersection observer API and implement within sprint.

Action:
1. Read MDN docs
2. Built small prototype
3. Asked senior for code review on prototype
4. Incorporated feedback
5. Implemented in main app
6. Documented for team wiki

Result: Feature shipped on time. Team reused component. Learned asking early prevents rewrites.'
    ),
    'STAR Method:

[S]ituation - Context
[T]ask - Your challenge
[A]ction - What YOU did (steps)
[R]esult - Outcome + Learning

Questions:
• Bug you fixed?
• Asked for help?
• Handled feedback?
• Tight deadline?
• Learned new tech?
• Team conflict?',
    10
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'STAR stands for?', to_jsonb(ARRAY['Start-Try-Achieve-Repeat', 'Situation-Task-Action-Result', 'Study-Test-Apply-Review', 'Simple-Technical-Advanced-Review']), 1, 'Framework for behavioral answers.'),
    (current_term_id, 'In STAR Action focus on?', to_jsonb(ARRAY['What team did', 'What YOU specifically did', 'What company did', 'General approach']), 1, 'Interviewer wants YOUR contribution.'),
    (current_term_id, 'Good behavioral answer includes?', to_jsonb(ARRAY['Only success', 'Situation + actions + learning', 'Generic statement', 'Blame others']), 1, 'Specific + growth mindset.'),
    (current_term_id, 'When asked about bug?', to_jsonb(ARRAY['Say had none', 'Describe investigation fix learning', 'Blame QA', 'Say it was easy']), 1, 'Show debugging process.'),
    (current_term_id, 'If you made mistake?', to_jsonb(ARRAY['Hide it', 'Own it explain fix and learning', 'Blame others', 'Minimize it']), 1, 'Accountability + growth.');

  -- Interview Tips
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_hr, 'Interview Tips and Golden Phrases',
    'Key phrases showing deep understanding. How to answer tricky questions. What interviewers want to hear.',
    'Strategic phrases demonstrating technical depth, critical thinking, professional maturity. Preparation for common trap questions.',
    'Golden phrases: Override for polymorphism new just hides, PUT idempotent PATCH partial, 422 validation 409 conflicts, AsNoTracking read-only. Prepare: Why Trimble, strength weakness, 3-year goal, questions for interviewer.',
    to_jsonb(ARRAY['Memorizing without understanding', 'Generic hardworking', 'No questions for interviewer', 'Badmouthing previous team', 'Not knowing company basics']),
    jsonb_build_object(
      'csharp', 'GOLDEN PHRASES:

1. Override vs New:
I use override for true polymorphism - method called depends on actual object type at runtime. New just hides parent method and binds at compile-time, which is not polymorphism.

2. Abstract vs Interface:
I choose interface when I only need contract - multiple implementations with no shared code. Abstract class when I have common implementation to share, or need fields constructors.

3. EF Core Performance:
I use AsNoTracking for read-only queries - skips change tracking overhead. I watch for N+1 with Include for eager loading or Select for projection.

4. Why Trimble:
Trimble works on real-world problems - construction, geospatial, cloud at scale. As intern, I want to learn from experienced engineers on production systems, contribute to meaningful projects, grow from code reviews and pair programming.',
      'typescript', 'GOLDEN PHRASES:

1. Promises vs Async Await:
Async await is syntactic sugar over Promises - cleaner than then chains. Key: always wrap in try-catch to handle rejections.

2. React useEffect:
UseEffect for side effects after render. Dependency array crucial - empty means run once on mount. Always clean up subscriptions timers in return function.

3. TypeScript Benefits:
TypeScript catches errors at compile time not runtime. Strong typing documents code better than comments, IDE autocomplete speeds development.'
    ),
    'Interview Prep:

Research company:
- Products services
- Tech stack
- Recent news
  
Prepare stories:
- Bug fixed
- Help requested
- Feedback received
  
Know deeply:
- OOP 4 pillars
- HTTP methods + codes
- SQL JOINs + indexes
  
Questions to ask:
- Mentorship structure?
- Typical intern project?
- Code review process?
- Success metrics?',
    11
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Why Trimble answer should?', to_jsonb(ARRAY['Be generic', 'Show research + interest + learning goals', 'Focus only salary', 'Be very short']), 1, 'Specific authentic growth-focused.'),
    (current_term_id, 'Weakness answer should?', to_jsonb(ARRAY['Say none', 'Real weakness + how improving', 'Fake strength as weakness', 'Blame others']), 1, 'Self-aware + proactive.'),
    (current_term_id, 'Questions for interviewer?', to_jsonb(ARRAY['None', 'About mentorship projects team metrics', 'Only salary', 'Generic questions']), 1, 'Shows interest preparation.'),
    (current_term_id, 'When you do not know answer?', to_jsonb(ARRAY['Make up something', 'Say honestly + show thinking', 'Stay silent', 'Change topic']), 1, 'Honesty + problem-solving.'),
    (current_term_id, 'Override vs new phrase?', to_jsonb(ARRAY['Same thing', 'Override for polymorphism new just hides', 'No difference', 'Random']), 1, 'Shows deep understanding.');

  RAISE NOTICE 'Added behavioral questions and interview tips';
END $$;

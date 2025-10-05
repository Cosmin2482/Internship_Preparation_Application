/*
  # Add HR and Behavioral Interview Questions
  
  Critical soft skills and behavioral questions for interviews
*/

DO $$
DECLARE
  general_term_id uuid;
BEGIN
  SELECT id INTO general_term_id FROM terms WHERE term = 'Abstraction' LIMIT 1;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation) VALUES
  
  -- Bug Resolution Story
  (general_term_id, 'How should you structure a story about resolving a bug in an interview?',
   '["Just describe the fix", "Context (where was bug) → Investigation (logs/debugging) → Fix (solution) → Lesson learned", "Only talk about the code", "Keep it vague"]'::jsonb, 1,
   'Use STAR format adapted: Context (project and bug), Investigation (what debugging tools/logs you used), Fix (the actual solution), Lesson Learned (e.g., "I learned to always check edge cases and NULL values"). This shows problem-solving process, not just the result.'),
  
  -- Asking for Help
  (general_term_id, 'What is the best approach when stuck on a problem?',
   '["Never ask for help", "Try for reasonable time, document what you tried, then ask with context - team speed matters more than pride", "Google forever", "Give up immediately"]'::jsonb, 1,
   'Try to solve independently first (documentation, Stack Overflow, POC), but do not waste hours. When asking: provide context, what you tried, what you observed. Example: "I am blocked X hours on authentication. I have tried A and B, getting error C. Could you help?" Team velocity > personal pride.'),
  
  -- Learning New Technology
  (general_term_id, 'How do you approach learning an unfamiliar technology?',
   '["Panic and give up", "Honest admission → Official docs → Working example → Isolated POC → Ask mentor after exhausting resources", "Pretend to know it", "Only use tutorials"]'::jsonb, 1,
   'Be honest: "I am not familiar with X yet, but..." Then: 1) Read official documentation, 2) Find a working example (Stack Overflow), 3) Build a small POC (Proof of Concept), 4) Ask mentor/colleague after trying. This shows learning ability and resourcefulness.'),
  
  -- Handling Negative Feedback
  (general_term_id, 'How should you react to negative code review feedback?',
   '["Defend your code", "See feedback as learning opportunity, ask clarifications, separate emotions from code quality, apply suggestions", "Ignore it", "Argue with reviewer"]'::jsonb, 1,
   'View feedback as a chance to improve. Ask clarifying questions if needed ("Would you prefer a Factory pattern here?"), acknowledge the suggestion, and apply it. Show you can separate personal feelings from code quality. Thank the reviewer.'),
  
  -- Sprint and Agile
  (general_term_id, 'What is a Sprint in Scrum?',
   '["A fast run", "A time-boxed period (1-4 weeks, typically 2) where team delivers a working product increment", "The entire project", "Only for large companies"]'::jsonb, 1,
   'A Sprint is a fixed time period (usually 2 weeks) where the team commits to delivering a potentially shippable product increment. It includes planning, daily scrums, development, review (demo), and retrospective (process improvement).'),
  
  -- Daily Standup
  (general_term_id, 'What is the purpose of Daily Scrum (standup)?',
   '["To micromanage", "15-minute sync where each member shares: yesterday progress, today plans, blockers - NOT problem-solving", "To assign tasks", "To review all code"]'::jsonb, 1,
   'Daily Scrum is a short synchronization meeting (15 min max). Each person answers: What did I do yesterday? What will I do today? Any blockers? It is for coordination, not detailed problem-solving (take those offline).'),
  
  -- Breaking Down Tasks
  (general_term_id, 'How do you break a large task into smaller ones?',
   '["Just start coding", "Use Vertical Slicing (UI to DB) or INVEST principles - make tasks independent, small, testable, valuable", "Keep it as one huge task", "Wait for manager to do it"]'::jsonb, 1,
   'Use Vertical Slicing (complete feature from UI to DB) or INVEST (Independent, Negotiable, Valuable, Estimable, Small, Testable). Example: Instead of "Implement User CRUD" (huge), create "POST /users endpoint", "Validate DTO", "Add to DB", "Write tests".'),
  
  -- Asking for Help Effectively
  (general_term_id, 'What is the RIGHT way to ask for help from teammates?',
   '["Just say it does not work", "Provide context, what you tried, what error/behavior you observed - save colleagues time", "Send just error message", "Ask vague questions"]'::jsonb, 1,
   'Do NOT just say "It does not work". Provide: 1) Context (what you are trying to do), 2) What you tried (attempted solutions), 3) What you observed (error messages, unexpected behavior). Example: "I am trying to connect to DB. I tried connection string A and B, getting timeout error. Logs show X."'),
  
  -- Git Best Practices
  (general_term_id, 'What makes a good Git commit message?',
   '["fix", "Descriptive, explains WHY (not just what), uses imperative mood (Add, Fix, Update)", "Any text works", "Just emoji"]'::jsonb, 1,
   'Good commit messages are: 1) Descriptive ("Add" vs "fix"), 2) Explain WHY (reasoning behind change), 3) Use imperative mood ("Add validation" not "Added validation"). Example: "feat: Add age validation to prevent negative values in user registration"'),
  
  -- Pull Request Quality
  (general_term_id, 'What makes a good Pull Request?',
   '["As large as possible", "Small, atomic (one issue), with description of problem/solution and checklist", "No description needed", "Combine many unrelated changes"]'::jsonb, 1,
   'Good PR is: 1) Atomic (solves one problem), 2) Has clear description (what problem, how solved), 3) Includes checklist (tested locally, docs updated), 4) Reasonable size (not 5000 lines). Easier to review = faster merge.');

END $$;

/*
  # Remove Romanian Language Support
  
  1. Delete all Romanian terms, categories, and quiz questions
  2. Remove language column
  3. Restore unique constraints
*/

DO $$
BEGIN
  -- Delete all Romanian data
  DELETE FROM quiz_questions WHERE language = 'ro';
  DELETE FROM terms WHERE language = 'ro';
  DELETE FROM categories WHERE language = 'ro';
  
  -- Drop language column from all tables
  ALTER TABLE categories DROP COLUMN IF EXISTS language;
  ALTER TABLE terms DROP COLUMN IF EXISTS language;
  ALTER TABLE quiz_questions DROP COLUMN IF EXISTS language;
  
  -- Drop composite unique constraint
  ALTER TABLE categories DROP CONSTRAINT IF EXISTS categories_slug_language_key;
  
  -- Restore original unique constraints
  ALTER TABLE categories ADD CONSTRAINT categories_slug_key UNIQUE (slug);
  ALTER TABLE categories ADD CONSTRAINT categories_name_key UNIQUE (name);
  
  RAISE NOTICE 'Removed Romanian language support completely';
END $$;

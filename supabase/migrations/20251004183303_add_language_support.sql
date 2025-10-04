/*
  # Add Language Support
  
  1. Add language column to categories, terms, quiz_questions
  2. Set default language to 'en' for existing data
  3. Add language filter indexes
*/

-- Add language column to categories
ALTER TABLE categories ADD COLUMN IF NOT EXISTS language TEXT NOT NULL DEFAULT 'en';

-- Add language column to terms
ALTER TABLE terms ADD COLUMN IF NOT EXISTS language TEXT NOT NULL DEFAULT 'en';

-- Add language column to quiz_questions
ALTER TABLE quiz_questions ADD COLUMN IF NOT EXISTS language TEXT NOT NULL DEFAULT 'en';

-- Create indexes for language filtering
CREATE INDEX IF NOT EXISTS idx_categories_language ON categories(language);
CREATE INDEX IF NOT EXISTS idx_terms_language ON terms(language);
CREATE INDEX IF NOT EXISTS idx_quiz_questions_language ON quiz_questions(language);

-- Add composite index for common queries
CREATE INDEX IF NOT EXISTS idx_terms_category_language ON terms(category_id, language);

-- Update existing data to be in English
UPDATE categories SET language = 'en' WHERE language IS NULL;
UPDATE terms SET language = 'en' WHERE language IS NULL;
UPDATE quiz_questions SET language = 'en' WHERE language IS NULL;

COMMENT ON COLUMN categories.language IS 'Language code: en (English) or ro (Romanian)';
COMMENT ON COLUMN terms.language IS 'Language code: en (English) or ro (Romanian)';
COMMENT ON COLUMN quiz_questions.language IS 'Language code: en (English) or ro (Romanian)';

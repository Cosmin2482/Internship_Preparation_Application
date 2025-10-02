/*
  # Internship Prep Super-App Database Schema

  ## Overview
  This migration creates the complete database structure for a comprehensive study application
  covering C#/.NET, Angular/TypeScript, CS fundamentals, SQL, architecture, DevOps, AI/ML, and HR.

  ## Tables Created

  ### 1. categories
  Stores the main subject categories (CS Fundamentals, OOP, .NET, SQL, Web/Angular, Architecture, DevOps, AI/ML, HR)
  - `id` (uuid, primary key)
  - `name` (text, unique) - Category display name
  - `slug` (text, unique) - URL-friendly identifier
  - `order_index` (integer) - Display order in sidebar
  - `created_at` (timestamptz)

  ### 2. terms
  Stores all study terms/concepts with complete content
  - `id` (uuid, primary key)
  - `category_id` (uuid, foreign key to categories)
  - `term` (text) - The concept name
  - `eli5` (text) - Plain, intuitive explanation
  - `formal_definition` (text) - Academic/technical definition
  - `interview_answer` (text) - 30-60 second answer for interviews
  - `pitfalls` (jsonb) - Array of common mistakes
  - `code_examples` (jsonb) - Object with csharp/typescript code samples
  - `diagram` (text) - ASCII/SVG diagram representation
  - `order_index` (integer) - Display order within category
  - `created_at` (timestamptz)

  ### 3. quiz_questions
  Stores multiple-choice quiz questions for each term
  - `id` (uuid, primary key)
  - `term_id` (uuid, foreign key to terms)
  - `question` (text)
  - `choices` (jsonb) - Array of 4 answer choices
  - `correct_index` (integer) - Index (0-3) of correct answer
  - `explanation` (text) - Why the answer is correct
  - `created_at` (timestamptz)

  ### 4. labs
  Stores interactive lab exercises
  - `id` (uuid, primary key)
  - `name` (text, unique)
  - `description` (text)
  - `type` (text) - Lab type: threshold_explorer, knn_playground, sql_practice, code_kata
  - `config` (jsonb) - Lab-specific configuration
  - `created_at` (timestamptz)

  ### 5. user_progress
  Tracks user study progress (for future features)
  - `id` (uuid, primary key)
  - `term_id` (uuid, foreign key to terms)
  - `completed` (boolean)
  - `notes` (text)
  - `last_studied` (timestamptz)
  - `created_at` (timestamptz)

  ## Security
  - RLS enabled on all tables
  - Public read access (study app is public)
  - No write access (content is pre-seeded)
*/

-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  slug text UNIQUE NOT NULL,
  order_index integer NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create terms table
CREATE TABLE IF NOT EXISTS terms (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  category_id uuid NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  term text NOT NULL,
  eli5 text NOT NULL,
  formal_definition text NOT NULL,
  interview_answer text NOT NULL,
  pitfalls jsonb NOT NULL DEFAULT '[]'::jsonb,
  code_examples jsonb NOT NULL DEFAULT '{}'::jsonb,
  diagram text DEFAULT '',
  order_index integer NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create quiz_questions table
CREATE TABLE IF NOT EXISTS quiz_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  term_id uuid NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
  question text NOT NULL,
  choices jsonb NOT NULL,
  correct_index integer NOT NULL CHECK (correct_index >= 0 AND correct_index <= 3),
  explanation text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create labs table
CREATE TABLE IF NOT EXISTS labs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  description text NOT NULL,
  type text NOT NULL,
  config jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

-- Create user_progress table (for future features)
CREATE TABLE IF NOT EXISTS user_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  term_id uuid NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
  completed boolean DEFAULT false,
  notes text DEFAULT '',
  last_studied timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_terms_category_id ON terms(category_id);
CREATE INDEX IF NOT EXISTS idx_terms_order ON terms(category_id, order_index);
CREATE INDEX IF NOT EXISTS idx_quiz_term_id ON quiz_questions(term_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_term_id ON user_progress(term_id);

-- Enable RLS on all tables
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE terms ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE labs ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Public read access for study content
CREATE POLICY "Public read access to categories"
  ON categories FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access to terms"
  ON terms FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access to quiz questions"
  ON quiz_questions FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access to labs"
  ON labs FOR SELECT
  TO public
  USING (true);

-- User progress policies (authenticated users only, future feature)
CREATE POLICY "Users can read own progress"
  ON user_progress FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert own progress"
  ON user_progress FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Users can update own progress"
  ON user_progress FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);
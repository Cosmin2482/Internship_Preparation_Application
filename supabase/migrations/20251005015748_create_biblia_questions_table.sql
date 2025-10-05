/*
  # Create BIBLIA Questions Table

  1. New Tables
    - `biblia_questions`
      - `id` (uuid, primary key)
      - `question` (text) - Întrebarea în română
      - `correct_answer` (text) - Răspunsul corect complet
      - `category` (text) - Categoria (Computer Science, OOP, Design Patterns, etc.)
      - `difficulty` (text) - easy, medium, hard
      - `order_index` (integer) - Pentru ordonarea întrebărilor
      - `created_at` (timestamptz)

  2. Security
    - Enable RLS on `biblia_questions` table
    - Add policy for public read access (no auth required for study app)
*/

CREATE TABLE IF NOT EXISTS biblia_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  question text NOT NULL,
  correct_answer text NOT NULL,
  category text NOT NULL,
  difficulty text DEFAULT 'medium',
  order_index integer NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE biblia_questions ENABLE ROW LEVEL SECURITY;

-- Public read access for study purposes
CREATE POLICY "Anyone can read biblia questions"
  ON biblia_questions
  FOR SELECT
  TO anon, authenticated
  USING (true);

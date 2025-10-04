/*
  # Create Romanian Categories
  
  Drop unique constraints and add Romanian categories
*/

-- Drop unique constraints to allow same slug for different languages
ALTER TABLE categories DROP CONSTRAINT IF EXISTS categories_slug_key;
ALTER TABLE categories DROP CONSTRAINT IF EXISTS categories_name_key;

-- Add composite unique constraint on slug + language
ALTER TABLE categories ADD CONSTRAINT categories_slug_language_key UNIQUE (slug, language);

-- Insert Romanian categories
INSERT INTO categories (name, slug, order_index, language)
VALUES 
  ('Fundamentale CS', 'cs-fundamentals', 0, 'ro'),
  ('OOP și Design Patterns', 'oop', 1, 'ro'),
  ('.NET și Backend', 'dotnet', 2, 'ro'),
  ('SQL și Date', 'sql', 3, 'ro'),
  ('TypeScript și Angular', 'angular', 4, 'ro'),
  ('Arhitectură Aplicații', 'architecture', 5, 'ro'),
  ('DevOps și CI/CD', 'devops', 6, 'ro'),
  ('AI/ML Baze', 'ai-ml', 7, 'ro'),
  ('Soft Skills și HR', 'hr', 8, 'ro'),
  ('Termeni Români 🇷🇴', 'romanian', 9, 'ro');

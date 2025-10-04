/*
  # Add Priority Level to Categories
  
  Add priority field to indicate how likely topics are to appear in interview
*/

DO $$
BEGIN
  -- Add priority column
  ALTER TABLE categories ADD COLUMN IF NOT EXISTS priority text DEFAULT 'medium';
  
  -- Update existing categories with priorities based on interview likelihood
  UPDATE categories SET priority = '99%' WHERE slug IN ('oop', 'sql', 'dotnet', 'architecture');
  UPDATE categories SET priority = 'likely' WHERE slug IN ('typescript', 'cs-fundamentals');
  UPDATE categories SET priority = 'medium' WHERE slug IN ('devops', 'ai-ml');
  UPDATE categories SET priority = 'low' WHERE slug IN ('soft-skills');
  
  RAISE NOTICE 'Added priority levels to categories';
END $$;

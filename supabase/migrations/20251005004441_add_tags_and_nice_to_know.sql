/*
  # Add Tags and Nice to Know Section
  
  1. Changes
    - Add tags column to terms table (array of text for flexible categorization)
    - Add nice_to_know text column for interview advice and tips
    - Create indexes for efficient tag searching
  
  2. Purpose
    - Tags allow flexible categorization beyond categories (e.g., "critical", "frequently-asked", "advanced")
    - Nice to know provides additional context and interview tips specific to each term
*/

-- Add tags column to terms table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'terms' AND column_name = 'tags'
  ) THEN
    ALTER TABLE terms ADD COLUMN tags TEXT[] DEFAULT '{}';
  END IF;
END $$;

-- Add nice_to_know column for interview advice
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'terms' AND column_name = 'nice_to_know'
  ) THEN
    ALTER TABLE terms ADD COLUMN nice_to_know TEXT DEFAULT '';
  END IF;
END $$;

-- Create index for tag searching
CREATE INDEX IF NOT EXISTS idx_terms_tags ON terms USING GIN (tags);

-- Add comment for documentation
COMMENT ON COLUMN terms.tags IS 'Array of tags for flexible categorization (e.g., critical, frequently-asked, behavioral)';
COMMENT ON COLUMN terms.nice_to_know IS 'Additional interview tips and advice specific to this term';
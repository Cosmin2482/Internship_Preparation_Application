/*
  # Remove Duplicate Terms
  
  Clean up duplicate terms in the database
*/

DO $$
BEGIN
  -- Delete duplicate 'Class vs Object' (keep first)
  DELETE FROM terms WHERE id = '98445941-5017-4c8b-884e-41c5f12ea365';
  
  -- Delete duplicates for other terms (keeping first occurrence)
  DELETE FROM terms t1
  WHERE EXISTS (
    SELECT 1 FROM terms t2
    WHERE t1.term = t2.term
    AND t1.id > t2.id
    AND t1.term IN (
      'CORS (Cross-Origin Resource Sharing)',
      'Generics',
      'HTTP Methods',
      'HTTP Status Codes',
      'Merge Sort',
      'Middleware',
      'Quick Sort',
      'Repository Pattern',
      'Stack vs Heap Memory',
      'Value Types vs Reference Types',
      'Value vs Reference Types'
    )
  );
  
  RAISE NOTICE 'Removed duplicate terms';
END $$;

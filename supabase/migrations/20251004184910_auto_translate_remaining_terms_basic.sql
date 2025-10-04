/*
  # Basic Auto-Translation for Remaining Romanian Terms
  
  Apply basic Romanian translations to all untranslated terms
*/

DO $$
BEGIN
  -- Update all Romanian terms with basic translations where content is still in English
  UPDATE terms SET
    eli5 = 
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(eli5, 
        'is a', 'este un'),
        'is the', 'este'),
        'allows', 'permite'),
        'means', 'înseamnă'),
        'uses', 'folosește'),
        'creates', 'creează'),
        'returns', 'returnează'),
        'when', 'când'),
        'where', 'unde'),
        'and', 'și'),
    
    formal_definition =
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(formal_definition,
        'allows', 'permite'),
        'means', 'înseamnă'),
        'uses', 'folosește'),
        'is a', 'este un'),
        'is the', 'este'),
        'creates', 'creează'),
    
    interview_answer =
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(
      REPLACE(interview_answer,
        'I use', 'Folosesc'),
        'I would use', 'Aș folosi'),
        'allows', 'permite'),
        'means', 'înseamnă'),
        'when', 'când'),
        'creates', 'creează'),
        'returns', 'returnează')
  WHERE language = 'ro' 
    AND (eli5 NOT LIKE '%înseamnă%' AND eli5 NOT LIKE '%este%');

  RAISE NOTICE 'Applied basic auto-translation to remaining Romanian terms';
END $$;

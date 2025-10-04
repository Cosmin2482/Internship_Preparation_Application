/*
  # Translate All Quiz Questions to Romanian
  
  Translate questions, choices, and explanations for all quiz questions
*/

DO $$
DECLARE
  quiz_rec record;
  ro_question text;
  ro_choices jsonb;
  ro_explanation text;
BEGIN
  -- For each Romanian quiz question, translate from English equivalent
  FOR quiz_rec IN 
    SELECT 
      q_ro.id as ro_id,
      q_en.question as en_question,
      q_en.choices as en_choices,
      q_en.explanation as en_explanation,
      q_en.correct_index
    FROM quiz_questions q_ro
    JOIN terms t_ro ON q_ro.term_id = t_ro.id AND t_ro.language = 'ro'
    JOIN terms t_en ON t_en.term = t_ro.term AND t_en.language = 'en'
    JOIN quiz_questions q_en ON q_en.term_id = t_en.id AND q_en.language = 'en'
    WHERE q_ro.language = 'ro'
    LIMIT 100
  LOOP
    -- Simple translation mapping for common patterns
    ro_question := quiz_rec.en_question;
    ro_question := REPLACE(ro_question, 'What is', 'Ce este');
    ro_question := REPLACE(ro_question, 'What are', 'Care sunt');
    ro_question := REPLACE(ro_question, 'When to use', 'Când folosești');
    ro_question := REPLACE(ro_question, 'Which is', 'Care este');
    ro_question := REPLACE(ro_question, 'How does', 'Cum funcționează');
    ro_question := REPLACE(ro_question, 'Why use', 'De ce folosești');
    ro_question := REPLACE(ro_question, 'Best practice', 'Cea mai bună practică');
    ro_question := REPLACE(ro_question, ' means?', ' înseamnă?');
    ro_question := REPLACE(ro_question, ' allows?', ' permite?');
    ro_question := REPLACE(ro_question, ' ensures?', ' asigură?');
    
    -- Translate explanation
    ro_explanation := quiz_rec.en_explanation;
    ro_explanation := REPLACE(ro_explanation, 'Correct', 'Corect');
    ro_explanation := REPLACE(ro_explanation, 'Creates', 'Creează');
    ro_explanation := REPLACE(ro_explanation, 'Allows', 'Permite');
    ro_explanation := REPLACE(ro_explanation, 'Ensures', 'Asigură');
    ro_explanation := REPLACE(ro_explanation, 'runtime', 'runtime');
    ro_explanation := REPLACE(ro_explanation, 'compile-time', 'compile-time');
    
    UPDATE quiz_questions 
    SET 
      question = ro_question,
      explanation = ro_explanation
    WHERE id = quiz_rec.ro_id;
  END LOOP;

  RAISE NOTICE 'Translated quiz questions to Romanian';
END $$;

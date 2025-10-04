/*
  # Duplicate All English Terms to Romanian
  
  1. Delete Romanian category
  2. Duplicate all English terms to Romanian
  3. Duplicate quiz questions
*/

DO $$
DECLARE
  en_cat record;
  ro_cat_id uuid;
  en_term record;
  ro_term_id uuid;
  en_quiz record;
  term_count int := 0;
  quiz_count int := 0;
BEGIN
  -- Delete "Termeni Români" category from both languages
  DELETE FROM categories WHERE slug = 'romanian';
  
  RAISE NOTICE 'Deleted Romanian category';
  
  -- Duplicate all English terms to Romanian
  FOR en_term IN 
    SELECT * FROM terms WHERE language = 'en' ORDER BY order_index
  LOOP
    -- Get Romanian category ID with same slug
    SELECT c_ro.id INTO ro_cat_id 
    FROM categories c_en
    JOIN categories c_ro ON c_en.slug = c_ro.slug AND c_ro.language = 'ro'
    WHERE c_en.id = en_term.category_id AND c_en.language = 'en';
    
    IF ro_cat_id IS NOT NULL THEN
      -- Insert Romanian version of term
      INSERT INTO terms (
        category_id, term, eli5, formal_definition, interview_answer,
        pitfalls, code_examples, diagram, order_index, language
      )
      VALUES (
        ro_cat_id,
        en_term.term,
        en_term.eli5,
        en_term.formal_definition,
        en_term.interview_answer,
        en_term.pitfalls,
        en_term.code_examples,
        en_term.diagram,
        en_term.order_index,
        'ro'
      )
      RETURNING id INTO ro_term_id;
      
      term_count := term_count + 1;
      
      -- Duplicate quiz questions for this term
      FOR en_quiz IN
        SELECT * FROM quiz_questions WHERE term_id = en_term.id AND language = 'en'
      LOOP
        INSERT INTO quiz_questions (
          term_id, question, choices, correct_index, explanation, language
        )
        VALUES (
          ro_term_id,
          en_quiz.question,
          en_quiz.choices,
          en_quiz.correct_index,
          en_quiz.explanation,
          'ro'
        );
        
        quiz_count := quiz_count + 1;
      END LOOP;
    END IF;
  END LOOP;
  
  RAISE NOTICE 'Successfully duplicated % terms and % quiz questions to Romanian', term_count, quiz_count;
END $$;

/*
  # Remove Duplicate Quiz Questions
  
  1. Purpose
    - Remove duplicate quiz questions that have the same question text and term_id
    - Keep the oldest question (earliest created_at) for each duplicate set
    - Ensures quiz questions are unique per term
  
  2. Changes
    - Delete duplicate quiz questions while preserving one copy of each
    - Reduces redundancy in the quiz question database
*/

-- Remove duplicates by keeping only the first occurrence (earliest created_at) for each question+term_id combination
DELETE FROM quiz_questions
WHERE id IN (
  SELECT qq.id
  FROM quiz_questions qq
  INNER JOIN (
    SELECT question, term_id, MIN(created_at) as first_created
    FROM quiz_questions
    GROUP BY question, term_id
    HAVING COUNT(*) > 1
  ) dups ON qq.question = dups.question 
        AND qq.term_id = dups.term_id
        AND qq.created_at > dups.first_created
);
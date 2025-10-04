export interface Category {
  id: string;
  name: string;
  slug: string;
  order_index: number;
  priority?: string;
}

export interface Term {
  id: string;
  category_id: string;
  term: string;
  eli5: string;
  formal_definition: string;
  interview_answer: string;
  pitfalls: string[];
  code_examples: {
    csharp?: string;
    typescript?: string;
  };
  diagram: string;
  order_index: number;
}

export interface QuizQuestion {
  id: string;
  term_id: string;
  question: string;
  choices: string[];
  correct_index: number;
  explanation: string;
}

export interface Lab {
  id: string;
  name: string;
  description: string;
  type: 'threshold_explorer' | 'knn_playground' | 'sql_practice' | 'code_kata';
  config: Record<string, unknown>;
}

export interface STARStory {
  situation: string;
  task: string;
  action: string;
  result: string;
}

export interface Database {
  public: {
    Tables: {
      categories: {
        Row: {
          id: string;
          name: string;
          slug: string;
          order_index: number;
          created_at: string;
        };
        Insert: Omit<Database['public']['Tables']['categories']['Row'], 'id' | 'created_at'>;
        Update: Partial<Database['public']['Tables']['categories']['Insert']>;
      };
      terms: {
        Row: {
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
          created_at: string;
        };
        Insert: Omit<Database['public']['Tables']['terms']['Row'], 'id' | 'created_at'>;
        Update: Partial<Database['public']['Tables']['terms']['Insert']>;
      };
      quiz_questions: {
        Row: {
          id: string;
          term_id: string;
          question: string;
          choices: string[];
          correct_index: number;
          explanation: string;
          created_at: string;
        };
        Insert: Omit<Database['public']['Tables']['quiz_questions']['Row'], 'id' | 'created_at'>;
        Update: Partial<Database['public']['Tables']['quiz_questions']['Insert']>;
      };
      labs: {
        Row: {
          id: string;
          name: string;
          description: string;
          type: string;
          config: Record<string, unknown>;
          created_at: string;
        };
        Insert: Omit<Database['public']['Tables']['labs']['Row'], 'id' | 'created_at'>;
        Update: Partial<Database['public']['Tables']['labs']['Insert']>;
      };
    };
  };
}

export type Category = Database['public']['Tables']['categories']['Row'];
export type Term = Database['public']['Tables']['terms']['Row'];
export type QuizQuestion = Database['public']['Tables']['quiz_questions']['Row'];
export type Lab = Database['public']['Tables']['labs']['Row'];

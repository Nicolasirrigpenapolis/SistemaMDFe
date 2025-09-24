// Interfaces TypeScript que correspondem às classes C# do backend

export interface ApiResponse<T> {
  success: boolean;
  message: string;
  data?: T;
  pagination?: PaginationInfo;
  errors?: ErrorInfo[];
  meta?: Record<string, any>;
  timestamp: string;
}

export interface PaginationInfo {
  currentPage: number;
  pageSize: number;
  totalItems: number;
  totalPages: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
}

export interface ErrorInfo {
  code: string;
  message: string;
  field?: string;
  details?: any;
}

// Tipo helper para respostas paginadas
export type PaginatedApiResponse<T> = ApiResponse<T[]> & {
  pagination: PaginationInfo;
};

// Tipo para resposta de erro
export type ErrorApiResponse = ApiResponse<null> & {
  errors: ErrorInfo[];
};
using MDFeApi.DTOs;

namespace MDFeApi.Helpers
{
    public static class ApiResponseHelper
    {
        // Resposta de sucesso simples
        public static ApiResponse<T> Success<T>(T data, string message = "Operação realizada com sucesso")
        {
            return new ApiResponse<T>
            {
                Success = true,
                Message = message,
                Data = data
            };
        }

        // Resposta de sucesso com paginação
        public static ApiResponse<T> Success<T>(T data, int currentPage, int pageSize, int totalItems, string message = "Operação realizada com sucesso")
        {
            var totalPages = (int)Math.Ceiling(totalItems / (double)pageSize);

            return new ApiResponse<T>
            {
                Success = true,
                Message = message,
                Data = data,
                Pagination = new PaginationInfo
                {
                    CurrentPage = currentPage,
                    PageSize = pageSize,
                    TotalItems = totalItems,
                    TotalPages = totalPages,
                    HasNextPage = currentPage < totalPages,
                    HasPreviousPage = currentPage > 1
                }
            };
        }

        // Resposta de erro simples
        public static ApiResponse<object> Error(string message, string? code = null)
        {
            return new ApiResponse<object>
            {
                Success = false,
                Message = message,
                Errors = code != null ? new[]
                {
                    new ErrorInfo { Code = code, Message = message }
                } : null
            };
        }

        // Resposta de erro com detalhes
        public static ApiResponse<object> Error(string message, ErrorInfo[] errors)
        {
            return new ApiResponse<object>
            {
                Success = false,
                Message = message,
                Errors = errors
            };
        }

        // Resposta de erro de validação
        public static ApiResponse<object> ValidationError(Dictionary<string, string[]> validationErrors)
        {
            var errors = validationErrors.SelectMany(kvp =>
                kvp.Value.Select(error => new ErrorInfo
                {
                    Code = "VALIDATION_ERROR",
                    Message = error,
                    Field = kvp.Key
                })
            ).ToArray();

            return new ApiResponse<object>
            {
                Success = false,
                Message = "Erro de validação",
                Errors = errors
            };
        }

        // Resposta "não encontrado"
        public static ApiResponse<object> NotFound(string message = "Recurso não encontrado")
        {
            return new ApiResponse<object>
            {
                Success = false,
                Message = message,
                Errors = new[]
                {
                    new ErrorInfo { Code = "NOT_FOUND", Message = message }
                }
            };
        }

        // Converter ResultadoPaginado para ApiResponse
        public static ApiResponse<List<T>> FromResultadoPaginado<T>(ResultadoPaginado<T> resultado, string message = "Operação realizada com sucesso")
        {
            return Success(resultado.Itens, resultado.Pagina, resultado.TamanhoPagina, resultado.TotalItens, message);
        }
    }
}
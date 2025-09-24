using System.Collections.Generic;
using System;

namespace MDFeApi.DTOs
{
    public class ResultadoPaginado<T>
    {
        public List<T> Itens { get; set; } = new List<T>();
        public int TotalItens { get; set; }
        public int Pagina { get; set; }
        public int TamanhoPagina { get; set; }
        public int TotalPaginas => (int)Math.Ceiling(TotalItens / (double)TamanhoPagina);
        public bool TemProximaPagina => Pagina < TotalPaginas;
        public bool TemPaginaAnterior => Pagina > 1;
    }

    // Classe mantida para compatibilidade temporária - remover após migração completa
    public class PagedResult<T>
    {
        public List<T> Items { get; set; } = new List<T>();
        public int TotalCount { get; set; }
        public int Page { get; set; }
        public int PageSize { get; set; }
        public int TotalPages => (int)Math.Ceiling(TotalCount / (double)PageSize);
        public bool HasNextPage => Page < TotalPages;
        public bool HasPreviousPage => Page > 1;
    }

    // Classe básica mantida para compatibilidade
    public class RespostaApi<T>
    {
        public bool Sucesso { get; set; }
        public string Mensagem { get; set; } = string.Empty;
        public T? Dados { get; set; }
        public string? CodigoErro { get; set; }
    }

    // Nova classe padrão de resposta API seguindo boas práticas 2024
    public class ApiResponse<T>
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public T? Data { get; set; }
        public PaginationInfo? Pagination { get; set; }
        public ErrorInfo[]? Errors { get; set; }
        public Dictionary<string, object>? Meta { get; set; }
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;
    }

    public class PaginationInfo
    {
        public int CurrentPage { get; set; }
        public int PageSize { get; set; }
        public int TotalItems { get; set; }
        public int TotalPages { get; set; }
        public bool HasNextPage { get; set; }
        public bool HasPreviousPage { get; set; }
    }

    public class ErrorInfo
    {
        public string Code { get; set; } = string.Empty;
        public string Message { get; set; } = string.Empty;
        public string? Field { get; set; }
        public object? Details { get; set; }
    }
}

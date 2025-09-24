using System.ComponentModel.DataAnnotations;

namespace MDFeApi.Models
{
    public class PaginationResult<T>
    {
        public List<T> Items { get; set; } = new List<T>();
        public int TotalItems { get; set; }
        public int TotalPages { get; set; }
        public int CurrentPage { get; set; }
        public int PageSize { get; set; }
        public bool HasPreviousPage => CurrentPage > 1;
        public bool HasNextPage => CurrentPage < TotalPages;
        public int StartItem => TotalItems > 0 ? ((CurrentPage - 1) * PageSize) + 1 : 0;
        public int EndItem => Math.Min(CurrentPage * PageSize, TotalItems);
    }

    public class PaginationRequest
    {
        [Range(1, int.MaxValue, ErrorMessage = "A página deve ser maior que 0")]
        public int Page { get; set; } = 1;

        [Range(1, 100, ErrorMessage = "O tamanho da página deve estar entre 1 e 100")]
        public int PageSize { get; set; } = 10;

        public string? Search { get; set; }
        public string? SortBy { get; set; }
        public string? SortDirection { get; set; } = "asc";
    }
}
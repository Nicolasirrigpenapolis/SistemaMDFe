using MDFeApi.Models;
using Microsoft.EntityFrameworkCore;

namespace MDFeApi.Extensions
{
    public static class QueryableExtensions
    {
        public static async Task<PaginationResult<T>> ToPaginatedListAsync<T>(
            this IQueryable<T> query,
            int page,
            int pageSize)
        {
            var totalItems = await query.CountAsync();
            var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

            var items = await query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return new PaginationResult<T>
            {
                Items = items,
                TotalItems = totalItems,
                TotalPages = totalPages,
                CurrentPage = page,
                PageSize = pageSize
            };
        }

        public static async Task<PaginationResult<T>> ToPaginatedListAsync<T>(
            this IQueryable<T> query,
            PaginationRequest request)
        {
            return await query.ToPaginatedListAsync(request.Page, request.PageSize);
        }
    }
}
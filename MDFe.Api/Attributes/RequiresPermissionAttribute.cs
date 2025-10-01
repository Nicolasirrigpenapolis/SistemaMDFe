using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using MDFeApi.Services;
using System.Security.Claims;

namespace MDFeApi.Attributes
{
    public class RequiresPermissionAttribute : Attribute, IAsyncActionFilter
    {
        private readonly string _permissionCode;

        public RequiresPermissionAttribute(string permissionCode)
        {
            _permissionCode = permissionCode;
        }

        public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
        {
            var permissaoService = context.HttpContext.RequestServices.GetService<IPermissaoService>();

            if (permissaoService == null)
            {
                context.Result = new StatusCodeResult(500);
                return;
            }

            // Extrair cargoId do JWT
            var cargoIdClaim = context.HttpContext.User?.FindFirst("CargoId")?.Value;

            if (!int.TryParse(cargoIdClaim, out int cargoId))
            {
                context.Result = new ForbidResult();
                return;
            }

            // Verificar se o cargo tem a permissão
            var hasPermission = await permissaoService.UserHasPermissionAsync(cargoId, _permissionCode);

            if (!hasPermission)
            {
                context.Result = new ForbidResult();
                return;
            }

            await next();
        }
    }
}
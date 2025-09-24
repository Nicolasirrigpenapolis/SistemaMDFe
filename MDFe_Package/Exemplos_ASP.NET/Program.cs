using SeuProjeto.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

// Registrar o serviço MDFe
builder.Services.AddScoped<IMDFeService, MDFeService>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() {
        Title = "MDFe API - Modal Rodoviário",
        Version = "v1",
        Description = "API para emissão de Manifesto Eletrônico de Documentos Fiscais (MDFe) - Transporte Rodoviário"
    });
});

// Configurar logging
builder.Logging.AddConsole();
builder.Logging.AddDebug();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "MDFe API v1");
        c.RoutePrefix = string.Empty; // Swagger na raiz
    });
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

// Health check básico
app.MapGet("/health", () => new {
    Status = "OK",
    Timestamp = DateTime.Now,
    Service = "MDFe API - Modal Rodoviário",
    Version = "1.2.2.337"
});

app.Run();
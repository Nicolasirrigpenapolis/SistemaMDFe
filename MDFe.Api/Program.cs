// Teste de modificação - Program.cs
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.Services;
using MDFeApi.Repositories;
using MDFeApi.Interfaces;
using MDFeApi.HealthChecks;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddMemoryCache();

builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.IgnoreCycles;
        options.JsonSerializerOptions.WriteIndented = true;
        options.JsonSerializerOptions.PropertyNamingPolicy = System.Text.Json.JsonNamingPolicy.CamelCase;
    });

// Configure Entity Framework
builder.Services.AddDbContext<MDFeContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Configuração de senha para hash manual
builder.Services.AddScoped<IPasswordHasher, PasswordHasher>();

// Configure JWT
var jwtSettings = builder.Configuration.GetSection("JwtSettings");
var secretKey = Environment.GetEnvironmentVariable("JWT_SECRET_KEY")
    ?? builder.Configuration["JwtSettings:SecretKey"]
    ?? throw new InvalidOperationException("JWT SecretKey not found. Set JWT_SECRET_KEY environment variable.");

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtSettings["Issuer"],
        ValidAudience = jwtSettings["Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey)),
        ClockSkew = TimeSpan.Zero
    };
});

// Register cache service
builder.Services.AddSingleton<ICacheService, CacheService>();

// Register application services
builder.Services.AddScoped<IMDFeService, MDFeService>();
builder.Services.AddScoped<IMDFeBusinessService, MDFeBusinessService>();
builder.Services.AddScoped<ICertificadoService, CertificadoService>();
builder.Services.AddScoped<IIBGEService, IBGEService>();

// Register repositories
builder.Services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
builder.Services.AddScoped<IPermissaoRepository, PermissaoRepository>();

// Register permission services
builder.Services.AddScoped<IPermissaoService, PermissaoService>();

// Register HttpClient for IBGE service
builder.Services.AddHttpClient<IIBGEService, IBGEService>();

// Register HttpClient for validation services (CNPJ lookup)
builder.Services.AddHttpClient();

// Configure Health Checks
builder.Services.AddHealthChecks()
    .AddCheck<DatabaseHealthCheck>("database", tags: new[] { "db", "ready" })
    .AddCheck<IBGEServiceHealthCheck>("ibge_service", tags: new[] { "external", "ready" })
    .AddCheck<ACBrMonitorHealthCheck>("acbr_monitor", tags: new[] { "acbr", "ready" });

// Register health check dependencies
builder.Services.AddHttpClient<IBGEServiceHealthCheck>();

// Registrar serviços ACBr Monitor
builder.Services.AddSingleton<IACBrMonitorClient>(provider =>
{
    var logger = provider.GetRequiredService<ILogger<ACBrMonitorClient>>();
    var host = builder.Configuration["ACBrMonitor:Host"] ?? "127.0.0.1";
    var port = builder.Configuration.GetValue<int>("ACBrMonitor:Port", 3434);
    var timeout = builder.Configuration.GetValue<int>("ACBrMonitor:Timeout", 30000);

    return new ACBrMonitorClient(host, port, timeout, logger);
});

builder.Services.AddScoped<IACBrResponseParser, ACBrResponseParser>();
builder.Services.AddScoped<IMDFeIniGenerator, MDFeIniGenerator>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() { Title = "MDFe API", Version = "v1" });
    
    // Configure JWT authentication in Swagger
    c.AddSecurityDefinition("Bearer", new()
    {
        Name = "Authorization",
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.ApiKey,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = Microsoft.OpenApi.Models.ParameterLocation.Header,
        Description = "JWT Authorization header using the Bearer scheme."
    });
    
    c.AddSecurityRequirement(new()
    {
        {
            new()
            {
                Reference = new()
                {
                    Type = Microsoft.OpenApi.Models.ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] {}
        }
    });
});

// Configure CORS for frontend
builder.Services.AddCors(options =>
{
    options.AddPolicy("Production", policy =>
    {
        // Em produção, especificar domínios exatos
        policy
            .WithOrigins("https://seu-dominio-frontend.com") // Substituir pelo domínio real
            .WithMethods("GET", "POST", "PUT", "DELETE", "PATCH")
            .WithHeaders("Content-Type", "Authorization")
            .AllowCredentials();
    });

    options.AddPolicy("Development", policy =>
    {
        policy
            .WithOrigins("http://localhost:3000", "https://localhost:5001", "http://localhost:5173", "http://localhost:8080")
            .AllowAnyMethod()
            .AllowAnyHeader()
            .AllowCredentials();
    });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();

    // Serve static files from frontend/build in development
    var frontendPath = Path.Combine(Directory.GetCurrentDirectory(), "..", "frontend", "build");
    if (Directory.Exists(frontendPath))
    {
        app.UseDefaultFiles();
        app.UseStaticFiles(new StaticFileOptions
        {
            FileProvider = new Microsoft.Extensions.FileProviders.PhysicalFileProvider(frontendPath),
            RequestPath = ""
        });
    }
}

app.UseHttpsRedirection();

// Add security middlewares (comentado temporariamente - middlewares não encontrados)
// app.UseMiddleware<MDFeApi.Middleware.RateLimitingMiddleware>();
// app.UseMiddleware<MDFeApi.Middleware.InputValidationMiddleware>();

// Add custom validation middleware
app.UseMiddleware<MDFeApi.Middleware.ValidationExceptionMiddleware>();

// Usar política CORS apropriada baseada no ambiente
if (app.Environment.IsDevelopment())
{
    app.UseCors("Development");
}
else
{
    app.UseCors("Production");
}

app.UseAuthentication();
app.UseAuthorization();

// Configure Health Check endpoints
app.MapHealthChecks("/health", new Microsoft.AspNetCore.Diagnostics.HealthChecks.HealthCheckOptions
{
    ResponseWriter = async (context, report) =>
    {
        context.Response.ContentType = "application/json";
        var result = System.Text.Json.JsonSerializer.Serialize(new
        {
            status = report.Status.ToString(),
            timestamp = DateTime.UtcNow,
            duration = report.TotalDuration.TotalMilliseconds,
            checks = report.Entries.Select(x => new
            {
                name = x.Key,
                status = x.Value.Status.ToString(),
                duration = x.Value.Duration.TotalMilliseconds,
                description = x.Value.Description,
                data = x.Value.Data,
                exception = x.Value.Exception?.Message
            })
        }, new System.Text.Json.JsonSerializerOptions
        {
            WriteIndented = true,
            PropertyNamingPolicy = System.Text.Json.JsonNamingPolicy.CamelCase
        });
        await context.Response.WriteAsync(result);
    }
});

// Health check endpoints específicos
app.MapHealthChecks("/health/ready", new Microsoft.AspNetCore.Diagnostics.HealthChecks.HealthCheckOptions
{
    Predicate = check => check.Tags.Contains("ready")
});

app.MapHealthChecks("/health/live", new Microsoft.AspNetCore.Diagnostics.HealthChecks.HealthCheckOptions
{
    Predicate = check => check.Tags.Contains("live")
});

app.MapControllers();

// SPA fallback for React Router
if (app.Environment.IsDevelopment())
{
    app.MapFallbackToFile("index.html");
}

// Ensure database is created
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<MDFeContext>();
    var passwordHasher = scope.ServiceProvider.GetRequiredService<IPasswordHasher>();
    var logger = scope.ServiceProvider.GetRequiredService<ILogger<Program>>();

    try
    {
        // Apply pending migrations
        context.Database.Migrate();
        logger.LogInformation("Database migrations applied successfully");

        // Create master user automatically
        await CreateMasterUser(context, passwordHasher, logger);
    }
    catch (Exception ex) when (ex.Message.Contains("multiple cascade paths") || ex.Message.Contains("cascade"))
    {
        // Ignore foreign key constraint errors - database creation may have partially succeeded
        logger.LogWarning(ex, "Foreign key constraint error during database creation - continuing anyway");
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "An error occurred while applying database migrations");
    }
}

async Task CreateMasterUser(MDFeContext context, IPasswordHasher passwordHasher, ILogger logger)
{
    try
    {
        // Check if master user already exists
        var existingUser = await context.Usuarios.Include(u => u.Cargo).FirstOrDefaultAsync(u => u.UserName == "programador");
        if (existingUser != null)
        {
            // Se o usuário existe mas não tem cargo, vamos atualizar
            if (existingUser.CargoId == null)
            {
                logger.LogInformation("Master user exists but missing cargo - updating...");

                // Criar cargo Programador se não existir
                var cargo = await context.Cargos.FirstOrDefaultAsync(c => c.Nome == "Programador");
                if (cargo == null)
                {
                    cargo = new Cargo
                    {
                        Nome = "Programador",
                        Descricao = "Desenvolvedor do sistema com acesso total",
                        Ativo = true,
                        DataCriacao = DateTime.UtcNow
                    };
                    context.Cargos.Add(cargo);
                    await context.SaveChangesAsync();
                    logger.LogInformation("Cargo 'Programador' created successfully");
                }

                // Atualizar usuário com cargo
                existingUser.CargoId = cargo.Id;
                await context.SaveChangesAsync();
                logger.LogInformation("Master user updated with cargo 'Programador'");
            }
            else
            {
                logger.LogInformation("Master user already exists with cargo");
            }
            return;
        }

        // Criar cargo Programador se não existir
        var programadorCargo = await context.Cargos.FirstOrDefaultAsync(c => c.Nome == "Programador");
        if (programadorCargo == null)
        {
            programadorCargo = new Cargo
            {
                Nome = "Programador",
                Descricao = "Desenvolvedor do sistema com acesso total",
                Ativo = true,
                DataCriacao = DateTime.UtcNow
            };
            context.Cargos.Add(programadorCargo);
            await context.SaveChangesAsync();
            logger.LogInformation("Cargo 'Programador' created successfully");
        }

        // Create master user with cargo
        var masterUser = new Usuario
        {
            UserName = "programador",
            Nome = "Programador",
            CargoId = programadorCargo.Id,
            Ativo = true,
            DataCriacao = DateTime.UtcNow
        };

        // Hash the password
        masterUser.PasswordHash = passwordHasher.HashPassword("conectairrig@");

        // Add user to database
        context.Usuarios.Add(masterUser);
        await context.SaveChangesAsync();

        logger.LogInformation("Master user 'programador' created successfully with cargo 'Programador'");
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error creating master user");
    }
}

app.Run();
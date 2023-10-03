using backend;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<PosterDBContext>(opt =>
    opt.UseInMemoryDatabase("Poster"));
// builder.Services.AddCors(options =>
// {
//     options.AddPolicy("AllowReactApp",
//         builder => builder
//             .WithOrigins("http://localhost:3000") // Replace with your React app's URL
//             .AllowAnyMethod()
//             .AllowAnyHeader());
// });
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// app.UseCors("AllowReactApp");
app.UseRouting();
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
});

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

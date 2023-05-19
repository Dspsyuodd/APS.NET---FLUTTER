using backend2.Data;
using Microsoft.EntityFrameworkCore;

var myAllowSpecificOrigins = "_myAllowSpecificOrigins";
var connectionString = "server=localhost;user=root;database=topics;password=dspsyuod;port=3306";
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddPolicy(name: myAllowSpecificOrigins,
                      builder =>
                      {
                          builder.AllowAnyMethod();
                          builder.AllowAnyHeader();
                          builder.AllowAnyOrigin();
                      });

});
builder.Services.AddSwaggerGen();
builder.Services.AddEndpointsApiExplorer();
// services.AddResponseCaching();

builder.Services.AddControllers();
builder.Services.AddDbContext<AppDbContext>(opt =>
    opt.UseMySQL(connectionString));

var app = builder.Build();
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.UseCors(myAllowSpecificOrigins);

app.UseAuthorization();

app.MapControllers();

app.Run();


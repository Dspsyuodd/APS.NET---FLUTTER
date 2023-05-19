using backend2.Models;
using Microsoft.EntityFrameworkCore;

namespace backend2.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions options) : base(options) { }
        public DbSet<Message> Messages { get; set; } = null!;
        public DbSet<Moderator> Moderators { get; set; } = null!;
        
        public DbSet<Topic> Topics { get; set; } = null!;
        public DbSet<ApiKey> ApiKeys { get; set; } = null!;
    }
}

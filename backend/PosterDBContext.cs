using Microsoft.EntityFrameworkCore;
namespace backend;

public class PosterDBContext : DbContext
{
    public PosterDBContext(DbContextOptions<PosterDBContext> options)
        : base(options)
    {
    }

    public DbSet<Poster> Posters { get; set; }
}
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
namespace backend;

[Route("api/posters")]
[ApiController]
public class PosterController : ControllerBase
{
    // GET: api/posters

    private readonly PosterDBContext _context;

    public PosterController(PosterDBContext context)
    {
        _context = context;
    }

    public Poster[] posters = {new Poster{Message = "This is the first", Date=DateTime.Now} };
    [HttpGet]
    public ActionResult<IEnumerable<Poster>> Get()
    {
        // Your logic to retrieve posters from a database or elsewhere
        Console.WriteLine("imhere get");

        return _context.Posters;
    
    }
    [HttpPost]
    public ActionResult<IEnumerable<Poster>> Post([FromBody] string message)
    {
        // Your logic to retrieve posters from a database or elsewhere
        Console.WriteLine("imhere");
        
        var id = _context.Posters.Count() + 1;
        var poster = new Poster{Id = id, Message = message, Date=DateTime.Now};

                // Add the poster to the in-memory database
        _context.Posters.Add(poster);
        _context.SaveChanges();
        return CreatedAtAction(nameof(Post), new {Id = poster.Id}, poster);
    }
}

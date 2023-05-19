using backend2.Models;
using backend2.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend2.MyControllers;

[Route("api/[controller]")]
[ApiController]
public class ModeratorsController : ControllerBase
{
    private readonly AppDbContext _context;

    public ModeratorsController(AppDbContext context)
    {
        _context = context;
    }


    // GET: api/Moderators/5
    [HttpGet("login")]
    public async Task<ActionResult<string>> GetModerator(string login, string password)
    {
        if (_context.Moderators == null)
        {
            return NotFound();
        }
        var moderator = await _context.Moderators.FirstAsync(x => x.Login == login).ConfigureAwait(false);
        try
        {
            if (moderator.HashedPassword == null || !SecretHasher.Verify(password, moderator.HashedPassword)) return "404";
        }
        catch (Exception e)
        {
            return "404";
        }
        
        
        var apiKey = ApiKeyGenerate.GenerateKey();
        _context.ApiKeys.Add(new ApiKey {Key = apiKey});
        await _context.SaveChangesAsync();
        return apiKey;
    }

    // PUT: api/Moderators/5
    [HttpPost("registration")]
    public async Task<ActionResult<string>> Registration(string login, string password, string apiKey)
    {
        if (!_context.ApiKeys.Any(x => x.Key == apiKey)) return "403";
        var hashedPassword = SecretHasher.Hash(password);
        var moderator = new Moderator { Login = login, HashedPassword = hashedPassword };
        _context.Moderators.Add(moderator);
        await _context.SaveChangesAsync();
        return "bip bop registration";
    }
    

    private bool ModeratorExists(long id)
    {
        return (_context.Moderators?.Any(e => e.Id == id)).GetValueOrDefault();
    }
}
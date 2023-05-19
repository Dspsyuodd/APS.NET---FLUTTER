using backend2.Data;
using backend2.Models;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend2.MyControllers;

[Route("api/[controller]")]
[ApiController]
public class TopicsController : ControllerBase
{
    private readonly AppDbContext _context;

    public TopicsController(AppDbContext context)
    {
        _context = context;
    }

    // GET: api/Topics
    [HttpGet("get_all")]
    public async Task<ActionResult<IEnumerable<Topic>>> GetTopicItems()
    {
        if (_context.Topics == null)
        {
            return NotFound();
        }
        return await _context.Topics.ToListAsync();
    }

    // GET: api/Topics/5
    [HttpGet("get_info")]
    public async Task<ActionResult<Topic>> GetTopic(long id)
    {
        if (_context.Topics == null)
        {
            return NotFound();
        }
        var topic = await _context.Topics.FindAsync(id);

        if (topic == null)
        {
            return NotFound();
        }

        return topic;
    }
    
    // POST: api/Topics
    [HttpPost($"create")]
    public async Task<ActionResult<Topic>> AddTopic(string topicName, string userName)
    {
        if (_context.Topics == null)
        {
            return Problem("Entity set 'TopicContext.TopicItems'  is null.");
        }
        var newTopic = new Topic() { Name = topicName, UserName = userName};
        _context.Topics.Add(newTopic);
        await _context.SaveChangesAsync();

        return CreatedAtAction("AddTopic", new { id = newTopic.Id }, newTopic);
    }
    
    private bool TopicExists(long id)
    {
        return (_context.Topics?.Any(e => e.Id == id)).GetValueOrDefault();
    } 
    // PUT: api/Topics/5
    // [HttpPut("{id}")]
    // public async Task<IActionResult> PutTopic(long id, Topic topic)
    // {
    //     if (id != topic.Id)
    //     {
    //         return BadRequest();
    //     }
    //
    //     _context.Entry(topic).State = EntityState.Modified;
    //
    //     try
    //     {
    //         await _context.SaveChangesAsync();
    //     }
    //     catch (DbUpdateConcurrencyException)
    //     {
    //         if (!TopicExists(id))
    //         {
    //             return NotFound();
    //         }
    //         else
    //         {
    //             throw;
    //         }
    //     }
    //
    //     return NoContent();
    // }

    
    //
    // // DELETE: api/Topics/5
    // [HttpDelete("{id}")]
    // public async Task<IActionResult> DeleteTopic(long id)
    // {
    //     if (_context.Topics == null)
    //     {
    //         return NotFound();
    //     }
    //     var topic = await _context.Topics.FindAsync(id);
    //     if (topic == null)
    //     {
    //         return NotFound();
    //     }
    //
    //     _context.Topics.Remove(topic);
    //     await _context.SaveChangesAsync();
    //
    //     return NoContent();
    // }

      
}
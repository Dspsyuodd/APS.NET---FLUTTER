using backend2.Data;
using backend2.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend2.MyControllers;

[Route("api/[controller]")]
[ApiController]
public class MessagesController : ControllerBase
{
    private readonly AppDbContext _context;

    public MessagesController(AppDbContext context)
    {
        _context = context;
    }

    // GET: api/Messages
    [HttpGet("get_messages")]
    public async Task<ActionResult<IEnumerable<Message>>> GetMessagesByTopic(long topicId)
    {
        if (_context.Messages == null)
        {
            return NotFound();
        }
        return await _context.Messages.Where(x => x.TopicId == topicId).ToListAsync();
    }

    // GET: api/Messages/5
    [HttpGet("get_message")]
    public async Task<ActionResult<Message>> GetMessage(long id)
    {
        if (_context.Messages == null)
        {
            return NotFound();
        }
        var message = await _context.Messages.FindAsync(id);

        if (message == null)
        {
            return NotFound();
        }

        return message;
    }

    // POST: api/Messages
    // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [HttpPost("create")]
    public async Task<ActionResult<Message>> CreateMessage(string text,  long topicId, string userName, long parentId = -1)
    {
        if (_context.Messages == null)
        {
            return Problem("Entity set 'MessageContext.Messages'  is null.");
        }

        var newMessage = new Message() { ParentId = parentId, TopicId = topicId, Text = text, UserName = userName};
        _context.Messages.Add(newMessage);
        await _context.SaveChangesAsync();

        return CreatedAtAction("GetMessage", new { id = newMessage.Id }, newMessage);
    }
    
    [HttpPost("delete")]
    public async Task<ActionResult<Message>> DeleteMessage(string apiKey, long messageId)
    {
        if (!_context.ApiKeys.Any(x => x.Id == messageId)) throw new HttpRequestException();
        var messageToRemove = await _context.Messages.FirstAsync(x => x.Id == messageId);
        _context.Messages.Remove(messageToRemove);
        await _context.SaveChangesAsync();

        return CreatedAtAction("GetMessage", new { id = messageToRemove.Id }, messageToRemove);
    }

    private bool MessageExists(long id)
    {
        return (_context.Messages?.Any(e => e.Id == id)).GetValueOrDefault();
    }
}
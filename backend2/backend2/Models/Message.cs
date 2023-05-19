namespace backend2.Models;

public class Message
{
    public long Id { get; set; }
    public long TopicId { get; set; }
    public long ParentId { get; set; }
    public string UserName { get; set; }
    public string? Text { get; set; }
    public DateTime CreateAt { get; set; }
    
    public Message()
    {
        CreateAt = DateTime.Now;
    }

}
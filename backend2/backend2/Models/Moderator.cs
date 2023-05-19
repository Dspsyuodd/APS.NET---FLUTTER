namespace backend2.Models;

public class Moderator
{
    public long Id { get; set; }
    public string? Login { get; set; }
    public string? HashedPassword { get; set; }
}


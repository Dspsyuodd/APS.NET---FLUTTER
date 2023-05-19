using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace backend2.Models;

public class Topic
{
    public long Id { get; set; }
    public string? Name { get; set; }
    public string UserName { get; set; }
    
    public DateTime CreateAt { get; set; }

    public Topic()
    {
        CreateAt = DateTime.Now;
    }
    

}
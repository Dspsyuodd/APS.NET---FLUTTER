using System.Text;

namespace backend2.MyControllers;

public class ApiKeyGenerate
{
    public static string GenerateKey()
    {
        var random = new Random();

        var sb = new StringBuilder();

        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".ToCharArray();

        for (var i = 0; i < 16; i++)
        {
            var index = random.Next(chars.Length);

            sb.Append(chars[index]);
        }
        var result = sb.ToString();
        return result;
    }
    
}
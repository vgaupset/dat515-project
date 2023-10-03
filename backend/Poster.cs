namespace backend;

public class Poster
{
    public int Id { get; set; }
    public DateTime Date { get; set; }
    public string Message { get; set; } = "";

    public Poster[] Comments { get; set; } = {};

}

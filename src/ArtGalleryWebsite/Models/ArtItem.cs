// ============================
// 3. Models/ArtItem.cs
// ============================
namespace ArtGalleryWebsite.Models
{
    public class ArtItem
    {
        public int Id { get; set; }
        public required string Title { get; set; }
        public required string ImageUrl { get; set; }
        public required string Category { get; set; }
    }
}

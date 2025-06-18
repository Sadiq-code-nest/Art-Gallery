// // ============================
// // 4. Controllers/HomeController.cs
// // ============================

using Microsoft.AspNetCore.Mvc;
using ArtGalleryWebsite.Models;
using System.Collections.Generic;
using System.Linq;

namespace ArtGalleryWebsite.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index(string category)
        {
            var arts = new List<ArtItem>
            {
                new ArtItem { Id = 1, Title = "Sunset", Category = "Natural Scenario", ImageUrl = "/images/sunset.jpg" },
                new ArtItem { Id = 2, Title = "Beautiful Bangladesh Sunset", Category = "Natural Scenario", ImageUrl = "/images/sunset2.jpg" },
                new ArtItem { Id = 3, Title = "Gaming Character", Category = "Gaming", ImageUrl = "/images/game.jpg" },
                new ArtItem { Id = 4, Title = "Fantastic Character", Category = "Gaming", ImageUrl = "/images/game2.jpg" },
                new ArtItem { Id = 5, Title = "Boys Dance", Category = "Culture", ImageUrl = "/images/dance.jpg" },
                new ArtItem { Id = 6, Title = "Girls Dance", Category = "Culture", ImageUrl = "/images/dance2.jpg" },
                new ArtItem { Id = 7, Title = "Funny Cat", Category = "Funny", ImageUrl = "/images/cat2.jpg" },
                new ArtItem { Id = 8, Title = "Laughing Baby", Category = "Funny", ImageUrl = "/images/baby.jpg" },
                new ArtItem { Id = 9, Title = "Night Sky", Category = "Night", ImageUrl = "/images/night.jpg" },
                new ArtItem { Id = 10, Title = "Moon Night", Category = "Night", ImageUrl = "/images/night2.jpg" },
                new ArtItem { Id = 11, Title = "Delicious Pizza", Category = "Food", ImageUrl = "/images/pizza.jpg" },
                new ArtItem { Id = 12, Title = "Delicious Ramen", Category = "Food", ImageUrl = "/images/ramen.jpg" },
                new ArtItem { Id = 13, Title = "Joker", Category = "Movie", ImageUrl = "/images/movie.jpg" },
                new ArtItem { Id = 14, Title = "Empires Strike Back", Category = "Movie", ImageUrl = "/images/movie2.jpg" },
                new ArtItem { Id = 15, Title = "Inside Out!", Category = "Movie", ImageUrl = "/images/inside-out.jpg" },
                new ArtItem { Id = 16, Title = "Moana 2", Category = "Movie", ImageUrl = "/images/moana.jpg" },
                new ArtItem { Id = 17, Title = "Wall-E", Category = "Movie", ImageUrl = "/images/wall-e.jpg" },
                new ArtItem { Id = 18, Title = "Waterfall", Category = "Water", ImageUrl = "/images/waterfall.jpg" },
                new ArtItem { Id = 19, Title = "Mountain View", Category = "Hill", ImageUrl = "/images/hill.jpg" },
                new ArtItem { Id = 20, Title = "Beach Sunset", Category = "Sea Beach", ImageUrl = "/images/beach.jpg" },
                new ArtItem { Id = 21, Title = "Abstract Art", Category = "Creative", ImageUrl = "/images/abstract.jpg" },
                new ArtItem { Id = 22, Title = "Tiger in Forest", Category = "Animal", ImageUrl = "/images/tiger.jpg" },
                new ArtItem { Id = 23, Title = "Toy Robot", Category = "Toy", ImageUrl = "/images/toy.jpg" },
                new ArtItem { Id = 24, Title = "Flying Birds", Category = "Birds", ImageUrl = "/images/birds.jpg" },
                new ArtItem { Id = 25, Title = "Green Plant", Category = "Plant", ImageUrl = "/images/plant.jpg" },
                new ArtItem { Id = 26, Title = "Tree in Autumn", Category = "Tree", ImageUrl = "/images/tree.jpg" }
            };

            if (!string.IsNullOrEmpty(category))
            {
                arts = arts
                    .Where(a => a.Category.ToLower() == category.ToLower())
                    .ToList();
            }

            return View(arts);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GameX8_0._4.Models
{
    public class Game
    {
       public int gameID { get; set; }
       public string gameName { get; set; }
       public string gameDescription { get; set; }
       public string releaseDate { get; set; }
       public string genre { get; set; }
       public string Developer { get; set; }
       public List<string> mediaLinks { get; set; }
       public List<Review> reviews { get; set; }

       public  Game()
        {
            
            mediaLinks = new List<string>();
            
        }
    }
    
    
}
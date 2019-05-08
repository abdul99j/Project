using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameX8_0._4.Models;

namespace GameX8_0._4.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index(string userName)
        {
            return View();
        }

        public ActionResult LoginProc(string userName,string password)
        {
            int result = CRUD.Login(userName, password);
            if(result==0)
            {
                Session["userName"] = userName;
                return RedirectToAction("Index", new { userName });
            }
            return View();
        }

        public ActionResult Signup()
        {
            return View();
        }

        public ActionResult SignupProc(string userName,string email,string password,string firstName,
            string lastName,string dateOfBirth,string gender)
        {
            int result = CRUD.Signup(userName, firstName, lastName, email,gender,password, dateOfBirth);
            if (result == 0)
            {
                string success = "REGISTRATION SUCCESS";
                return RedirectToAction("Login",(object)success);
            }

            else if (result == 1)
            {
                string errorMessage = "INVALID VALUES";
                return RedirectToAction("Signup",(object)errorMessage);
            }
            else if (result == 2)
            {
                string errorMessage = "userName already exitsts";
                return RedirectToAction("Signup",(object)errorMessage);
            }
            else
            {
                string errorMessage = "Some error occured at server ERROR NO 4315";
                return View("Signup", (object)errorMessage);
            }
        }
        public ActionResult Game(string gameName)
        {
            if (gameName != null)
            {
                Session["gameName"]= gameName;
                int gameId=CRUD.GetGameID(gameName);
                Game game = new Game();
                game = CRUD.GetGame(gameId);
                game.mediaLinks = CRUD.getGameMedia(gameId);
                game.reviews = CRUD.getGameReviews(gameId);
                return View("game",game);
            }
            else
            {
                return RedirectToAction("Games", "Admin");
            }
        }

        public ActionResult AddGame(string gameName)
        {
            if(Session["userName"]!=null)
            {
                int result = CRUD.AddToUserGames(Session["userName"].ToString(), gameName);
                if(result==-1||result==1)
                {
                    string errorMsg = "ALREADY ADDED";
                    ViewData["errorMsg"] = errorMsg;
                    return View("Index");
                }
                ViewData["Success"] = "ADDED SUCESSFULLY";
                return View("Index",(object)ViewData["Success"].ToString());
            }
            else
            {
                return  RedirectToAction("Login", "Authenticate");
            }
        }

        public ActionResult AddReview(int rating,string description)
        {
            if (Session["gameName"] != null&&Session["userName"]!=null) { 
            int gameID = CRUD.GetGameID(ViewData["gameName"].ToString());
                int result=CRUD.AddRating(rating, description, gameID,Session["userName"].ToString());
                if(result==0)
                {
                    return RedirectToAction("Game", new { gameName = ViewData["gameName"].ToString() });
                }
                else
                {
                    return RedirectToAction("Games", "Home");
                }
            }
            else
            {
                return RedirectToAction("Games", "Home");
            }

        }

        public ActionResult Games()
        {
            List<Game> games = new List<Game>();
            games = CRUD.GetAllGames();
            return View("Games", games);
        }

        
       
    }
}

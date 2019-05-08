using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameX8_0._4.Models;

namespace GameX8_0._4.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
        public ActionResult Dashboard(string userName)
        {
            if(Session["userName"]!=null&&Session["admin"]!=null)
            { 
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }
        public ActionResult ViewUser()
        {
            if (Session["userName"] != null&&Session["admin"]!=null) { 
                List<Users> users = CRUD.GetAllUsers();
                return View(users);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }
        public ActionResult SearchUser(string userName)
        {
            if (Session["userName"] != null && Session["admin"] != null)
            { 
                List<Users> SearchResult=new List<Users>();
                SearchResult.Add(CRUD.SeachUser(userName));
                return View("ViewUser",SearchResult);
            }
            else
            {
                return RedirectToAction("Index", "HomeController");
            }
        }
        public ActionResult MyAccount(string userName)
        {
            if (Session["userName"]!=null)
            {
                userName = Session["userName"].ToString();
                ViewBag.currentUser = new Users();
                ViewBag.currentUser = CRUD.SeachUser(userName);
                ViewBag.userGames = new List<Game>();
                ViewBag.userGames = CRUD.GetUserGames(userName);
                return View();
            }
            else
            {
                return RedirectToAction("Index","Home");
            }
         }
        public ActionResult DeleteGame(string gameName)
        {
            if (Session["userName"] != null && Session["admin"] != null)
            {
                CRUD.deleteGameByName(gameName);
                return View("ViewUsers");
            }
            else
            {
                return RedirectToAction("Index", "HomeController");
            }
        }
        public ActionResult SearchGame(string gameName)
        {
            Game SearchResult = new Game();
            int gameId = CRUD.GetGameID(gameName);
            SearchResult = CRUD.GetGame(gameId);
            List<Game> game = new List<Game>();
            game.Add(SearchResult);
            return View("ViewGames", game);
        }
        

        public ActionResult ViewGames()
        {
            if (Session["userName"] != null && Session["admin"] != null)
            {
                List<Game> games = new List<Game>();
                games = CRUD.GetAllGames();
                return View("ViewGames", games);
            }
            else if(Session["userName"]!=null)
            {
                return RedirectToAction("Index", "Home",new {userName=Session["userName"].ToString() });
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }
        
        public ActionResult AddUser()
        {
            if(Session["userName"]!=null&&Session["admin"]!=null)
            {
                return View();
            }
            else if(Session["userName"]!=null)
            {
                return RedirectToAction("Index", Session["userName"].ToString());
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }
        public ActionResult AddGame()
        {
            return View();
        }
        public ActionResult AddGameProc(string gameName, string gameDesc, string releaseDate, string developer,
           string genre)
        {
            CRUD.InsertNewGame(gameName, gameDesc, releaseDate, developer, genre);
            return View("ViewGames");
        }
        public ActionResult AddMedia()
        {
            return View();
        }
       public ActionResult DeleteUser(string userName)
        {
            if (Session["userName"] != null && Session["admin"] != null)
            {
                CRUD.removeUser(userName);
            }
            return RedirectToAction("ViewUser", "Admin");
        }
        public ActionResult DeleteAllUsers()
        {
            if (Session["userName"] != null && Session["admin"] != null)
            {
                string user = Session["userName"].ToString();
                CRUD.DeleteAllUsers(user);
            }
            return RedirectToAction("ViewUser", "Admin");
        }

        public ActionResult UserInfo(string userName)
        {
            if(Session["userName"]!=null&&Session["admin"]!=null)
            {
                Users user = new Users();
                user = CRUD.SeachUser(userName);
                ViewBag.currentUser = user;
                ViewBag.UserGames = new List<Game>();
                ViewBag.UserGames = CRUD.GetUserGames(userName);
                return View("UserInfo");
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }

        }
        public ActionResult DeleteAllGames()
        {
            if (Session["userName"] != null && Session["admin"] != null)
            {
                CRUD.DeleteAllGames();
            }
            return RedirectToAction("ViewGames", "Admin");
        }
    }
}
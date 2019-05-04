using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Game_X80._2.Models;
namespace Game_X80._2.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Login()
        {
            return View();
        }
        public ActionResult Signup()
        {
            return View();
        }
        public ActionResult authenticate(String userName, String password)
        {
            int result = CRUD.Login(userName, password);

            if (result == -1)
            {
                return View("index");
            }
            else if (result == 1)
            {

                return View("Signup");
            }

            return RedirectToAction("Login");

        }
        public ActionResult Authenticate11(string Fname, string lname, string userName, string userEmail, string userPassword, string gender, string dateOfBirth)
        {
            int result = CRUD.SignUp(Fname, lname, userName, userEmail, userPassword, gender, dateOfBirth);

            if (result == 1)
            {
                Session["userName"] = userName;
                Response.Write(Session["userName"]);
                return RedirectToAction("getAllUsers");
                
            }
                
            else if (result == 2)
            {

                return RedirectToAction("Index");
            }
            else if (result == -1)
            {
                return RedirectToAction("Index");
            }
            return RedirectToAction("Signup");
        }
        public ActionResult getAllUsers()
        {
            List <User> l1= CRUD.getAllUsers();
            return View(l1);
        }
        public ActionResult Admin()
        {
            return View();
        }
    }
    
}

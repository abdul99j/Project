using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameX8_0._4.Models;

namespace GameX8_0._4.Controllers
{
    public class AuthenticateController : Controller
    {
        public ActionResult Login()
        {
            return View();
        }
        public ActionResult LoginProc(string userName, string password)
        {
            int result = CRUD.Login(userName, password);
            Users user = new Users();
            user = CRUD.SeachUser(userName);
            if (result == 0&&user.userStatus=="admin")
            {

                Session["userName"] = userName;
                Session["admin"] = userName;
                return RedirectToAction("Dashboard","Admin", new { userName });
            }
            if(result==0&&user.userStatus=="user")
            {
                Session["userName"] = userName;
                return RedirectToAction("Index", "Home", new { userName });
            }
            return View();
        }

        public ActionResult Signup()
        {
            return View();
        }

        public ActionResult SignupProc(string userName, string email, string password, string firstName,
            string lastName, string dateOfBirth, string gender)
        {
            int result = CRUD.Signup(userName, firstName, lastName, email, gender, password, dateOfBirth);
            if (result == 0)
            {
                string success = "REGISTRATION SUCCESS";
                return RedirectToAction("Login", (object)success);
            }

            else if (result == 1)
            {
                string errorMessage = "INVALID VALUES";
                return RedirectToAction("Signup", (object)errorMessage);
            }
            else if (result == 2)
            {
                string errorMessage = "userName already exitsts";
                return RedirectToAction("Signup", (object)errorMessage);
            }
            else
            {
                string errorMessage = "Some error occured at server ERROR NO 4315";
                return View("Signup", (object)errorMessage);
            }
        }
    }
}
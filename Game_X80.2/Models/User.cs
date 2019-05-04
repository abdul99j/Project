using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;

namespace Game_X80._2.Models
{
    public class User
    {
        public string userName { get; set; }
        public string Fname { get; set; }
        public string Lname { get; set; }
        public string userPassword { get; set; }
        public string userStatus { get; set; }
        public string userEmail { get; set; }
        public string dateOfBirth { get; set; }
        public string gender { get; set; }
    }
   
}
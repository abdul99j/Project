using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;

namespace Game_X80._2.Models
{
        public class CRUD
        {
            public static string connectionString = "Server= localhost\\sqlexpress; Database= GameX8;Integrated Security=SSPI;";
            
            public static List<User> getAllUsers()
            {
                SqlConnection con = new SqlConnection(connectionString);
          
                con.Open();
                SqlCommand cmd;

                try
                {
                    cmd = new SqlCommand("select * from users", con);
                    cmd.CommandType = System.Data.CommandType.Text;

                    SqlDataReader rdr = cmd.ExecuteReader();

                    List<User> list = new List<User>();
                    while (rdr.Read())
                    {
                        User user = new User();

                        user.userName = rdr["userName"].ToString();
                        user.Fname = rdr["Fname"].ToString();
                        user.Lname = rdr["Lname"].ToString();
                        user.userPassword = rdr["userPassword"].ToString();
                        user.userStatus = rdr["userStatus"].ToString();
                        user.userEmail = rdr["userEmail"].ToString();
                        user.dateOfBirth = rdr["dateOfBirth"].ToString();
                        list.Add(user);
                    }
                    rdr.Close();
                    con.Close();

                    return list;


                }

                catch (SqlException ex)
                {
                    Console.WriteLine("SQL Error" + ex.Message.ToString());
                    return null;

                }

            }


            



            public static int Login(string userName, string password)
            {
                
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                SqlCommand cmd;
                int result = 0;
                /* string connetionString = null;
                 SqlConnection cnn ;
                 connetionString = "Server= localhost; Database= GameX8;Integrated Security=SSPI;";
                cnn = new SqlConnection(connetionString);*/

                try
                {
           
                    cmd = new SqlCommand("LOG_IN", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@UserName", SqlDbType.NVarChar, 50).Value = userName;
                    cmd.Parameters.Add("@UserPassword", SqlDbType.NVarChar, 50).Value = password;

                    cmd.Parameters.Add("@out_flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.ExecuteNonQuery();
                    result = 1;
                    result = Convert.ToInt32(cmd.Parameters["@out_flag"].Value);


                }

                catch (SqlException ex)
                {
                    Console.WriteLine("SQL Error" + ex.Message.ToString());
                     //-1 will be interpreted as "error while connecting with the database."
                }
                finally
                {
                    con.Close();
                }
                return result;

            }

        public static int SignUp(string Fname, string lname, string userName, string userEmail,
            string userPassword, string gender, string dateOfBirth)
            {

                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                SqlCommand cmd;
                int result = 0;

                try
                {
                    cmd = new SqlCommand("SIGN_UP", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@UserName", SqlDbType.NVarChar, 50).Value = userName;
                    cmd.Parameters.Add("@fname", SqlDbType.NVarChar, 50).Value = Fname;
                    cmd.Parameters.Add("@lname", SqlDbType.NVarChar, 50).Value = lname;
                    cmd.Parameters.Add("@UserEmail", SqlDbType.NVarChar, 50).Value = userEmail;
                    cmd.Parameters.Add("@UserPassword", SqlDbType.NVarChar, 50).Value = userPassword;
                    cmd.Parameters.Add("@UserStatus", SqlDbType.NVarChar, 50).Value = "user";
                    cmd.Parameters.Add("@DateOfBirth", SqlDbType.NVarChar, 50).Value = dateOfBirth;
                    cmd.Parameters.Add("@Gender", SqlDbType.NVarChar, 50).Value = gender;


                    cmd.Parameters.Add("@out_flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                    cmd.ExecuteNonQuery();
                    result = Convert.ToInt32(cmd.Parameters["@out_flag"].Value);

                }

                catch (SqlException ex)
                {
                    Console.WriteLine("SQL Error" + ex.Message.ToString());
                    result = -1; //-1 will be interpreted as "error while connecting with the database."
                }
                finally
                {
                    con.Close();
                }
                return result;

            }
        }
}
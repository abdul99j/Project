using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;

namespace GameX8_0._4.Models
{
    public class CRUD
    {
        public static string connectionString = "data source=desktop-12i97al\\sqlexpress; Initial Catalog=GameX8;Integrated Security=true";

        public static List<Users> GetAllUsers()
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("SELECT * FROM users", con);
                cmd.CommandType = System.Data.CommandType.Text;

                SqlDataReader rdr = cmd.ExecuteReader();

                List<Users> list = new List<Users>();
                while (rdr.Read())
                {
                    Users user = new Users();

                    user.userName = rdr["userName"].ToString();
                    user.password = rdr["userPassword"].ToString();
                    user.gender = rdr["gender"].ToString();
                    user.dateOfBirth = rdr["dateOfBirth"].ToString();
                    user.userEmail = rdr["userEmail"].ToString();
                    user.Fname = rdr["Fname"].ToString();
                    user.Lname = rdr["Lname"].ToString();
                    user.userStatus = rdr["userStatus"].ToString();
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
        public static List<int> GetAllGameId()
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("SELECT gameId FROM Games", con);
                cmd.CommandType = System.Data.CommandType.Text;

                List<int> game_Ids = new List<int>();

                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    int gameID = Convert.ToInt32(rdr["gameId"]);
                    game_Ids.Add(gameID);
                }
                rdr.Close();
                con.Close();

                return game_Ids;
            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                return null;

            }
        }
        public static List<Game> GetAllGames()
        {

            List<Game> games=new List<Game>();
            List<int> game_IDs = new List<int>();
            Game game = new Game();
            game_IDs = GetAllGameId();

            foreach(int gameID in game_IDs)
            {
                game.gameID = gameID;
                game=GetGame(gameID);
                game.reviews = getGameReviews(gameID);
                game.mediaLinks = getGameMedia(gameID);
                games.Add(game);
            }
            return games;
        }
    
        public static int Login(string userId, string password)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;

            try
            {
                cmd = new SqlCommand("LOG_IN", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@UserName", SqlDbType.NVarChar, 50).Value = userId;
                cmd.Parameters.Add("@UserPassword", SqlDbType.NVarChar, 50).Value = password;


                cmd.Parameters.Add("@Out_Flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@Out_Flag"].Value);
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
        public static int Signup(string userName, string fName, string lName, string email, string gender,
           string password, string dob, string status = "user")
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;

            try
            {
                cmd = new SqlCommand("SIGN_UP", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@UserName", SqlDbType.NVarChar, 30).Value = userName;
                cmd.Parameters.Add("@fname", SqlDbType.NVarChar, 30).Value = fName;
                cmd.Parameters.Add("@lname", SqlDbType.NVarChar, 30).Value = lName;
                cmd.Parameters.Add("@UserPassword", SqlDbType.NVarChar, 100).Value = password;
                cmd.Parameters.Add("@UserStatus", SqlDbType.NVarChar, 10).Value = status;
                cmd.Parameters.Add("@UserEmail", SqlDbType.NVarChar, 100).Value = email;
                cmd.Parameters.Add("@DateOfBirth", SqlDbType.Date, 30).Value = dob;
                cmd.Parameters.Add("@gender", SqlDbType.Char, 1).Value = gender;

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

        public static int ViewUsers(string userName, string fName, string lName, string email,
           string password, string dob, string status)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;

            try
            {
                cmd = new SqlCommand("SELECT * FROM users WHERE userName=userName", con);
                cmd.CommandType = System.Data.CommandType.Text;





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

        
    

        public static int GetGameID(string gameName)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = -1;

            try
            {
                cmd = new SqlCommand("SELECT * FROM games WHERE gameName=@gameName", con);
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Parameters.AddWithValue("@gameName", gameName);

                SqlDataReader rdr_game = cmd.ExecuteReader();

                if (rdr_game.Read())
                {
                    result = Convert.ToInt32(rdr_game["gameId"]);
                }
                return result;
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1;
                return result;
            }
            finally
            {
                con.Close();
            }
        }

        public static Users SeachUser(string userName)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("SELECT * FROM users WHERE userName=@userName", con);
                cmd.Parameters.AddWithValue("@userName", userName);
                cmd.CommandType = System.Data.CommandType.Text;
                SqlDataReader rdr = cmd.ExecuteReader();
                Users user = new Users();
                if (rdr.Read())
                {
                    user.userName = rdr["userName"].ToString();
                    user.password = rdr["userPassword"].ToString();
                    user.gender = rdr["gender"].ToString();
                    user.dateOfBirth = rdr["dateOfBirth"].ToString();
                    user.userEmail = rdr["userEmail"].ToString();
                    user.Fname = rdr["Fname"].ToString();
                    user.Lname = rdr["Lname"].ToString();
                    user.userStatus = rdr["userStatus"].ToString();
                    return user;
                }
                return null;
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                return null;
            }
            finally
            {
                con.Close();
            }
        }
        public static Game GetGame(int gameID)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("SELECT * FROM games WHERE gameId=@gameID", con);
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Parameters.AddWithValue("@gameID", gameID);


                SqlDataReader rdr_game;
                rdr_game = cmd.ExecuteReader();

                Game game = new Game();
                
                if (rdr_game.Read())
                {
                    game.gameID = Convert.ToInt32(rdr_game["gameId"]);
                    game.gameName = rdr_game["gameName"].ToString();
                    game.gameDescription = rdr_game["gameDescription"].ToString();
                    game.releaseDate = rdr_game["releaseDate"].ToString();
                    game.Developer = rdr_game["developer"].ToString();
                    game.genre = rdr_game["genre"].ToString();
                    game.Developer = rdr_game["developer"].ToString();
                }
                
                return game;
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                return null;
            }
            finally
            {
                con.Close();
            }
        }
        public static List<Review> getGameReviews(int gameID)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("SELECT rating,reviewDescription,dateGive FROM review WHERE gameId=@gameID", con);
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Parameters.AddWithValue("@gameID", gameID);

                List <Review> reviews= new List<Review>();
                Review review = new Review();

                SqlDataReader rdr_review;
                rdr_review = cmd.ExecuteReader();
                while(rdr_review.Read())
                {
                    review.rating = Convert.ToInt32(rdr_review["rating"]);
                    review.reviewDesc = rdr_review["reviewDescription"].ToString();
                    review.dateGiven = rdr_review["dateGive"].ToString();

                    reviews.Add(review);

                }
                return reviews;
                
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                return null;
            }
            finally
            {
                con.Close();
            }
        } 
        public static List<string> getGameMedia(int gameID)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("SELECT mediaLink FROM Media WHERE gameID=@gameID", con);
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Parameters.AddWithValue("@gameID", gameID);

                List<string> mediaLinks= new List<string>();
                

                SqlDataReader rdr_media;
                rdr_media = cmd.ExecuteReader();
                while (rdr_media.Read())
                {
                    mediaLinks.Add(rdr_media["mediaLink"].ToString());
                }
                return mediaLinks;
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                return null;
            }
            finally
            {
                con.Close();
            }
        }

        

        public static List<Game> getUserGames(string userName)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;


            try
            {
                cmd = new SqlCommand("SELECT gameId FROM USER_GAMES WHERE userName=@userName", con);
                cmd.Parameters.AddWithValue("@userName", userName);
                cmd.CommandType = System.Data.CommandType.Text;
                SqlDataReader rdr = cmd.ExecuteReader();

                List<Game> games = new List<Game>();
                SqlDataReader rdr_games = cmd.ExecuteReader();

                while (rdr_games.Read())
                {
                    int gameId = Convert.ToInt32(rdr_games["gameId"]);
                    Game game = new Game();
                    game = GetGame(gameId);
                    games.Add(game);
                }
                return games;
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                return null;
            }
            finally
            {
                con.Close();
            }
        }
        public static int insertNewGame(string gameName, string gameDesc, string releaseDate, string developer,
            string genre)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;

            try
            {
                cmd = new SqlCommand("ADD_NEW_USER", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@gameName", SqlDbType.NVarChar, 50).Value = gameName;
                cmd.Parameters.Add("@gameDescription", SqlDbType.NVarChar, 1000).Value = gameDesc;
                cmd.Parameters.Add("@releaseDate", SqlDbType.NVarChar, 1000).Value = releaseDate;
                cmd.Parameters.Add("@developer", SqlDbType.NVarChar, 1000).Value = developer;
                cmd.Parameters.Add("@genre", SqlDbType.NVarChar, 1000).Value = genre;

                cmd.Parameters.Add("@returnValue", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@returnValue"].Value);
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

        public static void deleteGameById(int gameID)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;


            try
            {
                cmd = new SqlCommand("DELETE FROM Games WHERE gameId=@gameId", con);
                cmd.Parameters.AddWithValue("@gameId", gameID);
                cmd.CommandType = System.Data.CommandType.Text;
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
        }
        public static void deleteGameByName(string gameName)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;


            try
            {
                cmd = new SqlCommand("DELETE FROM Games WHERE gameId=@gameName", con);
                cmd.Parameters.AddWithValue("@gameName", gameName);
                cmd.CommandType = System.Data.CommandType.Text;
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
        }

        public static int removeUser(string userName)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result;

            try
            {
                cmd = new SqlCommand("REMOVE_USER", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@userName", SqlDbType.NVarChar, 50).Value = userName;

                cmd.Parameters.Add("@returnValue", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@returnValue"].Value);
                return result;
            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1;
                return result;
            }
            finally
            {
                con.Close();
            }
        }
        public static int deleteMediaById(int mediaId)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result;

            try
            {
                cmd = new SqlCommand("DELETE_MEDIA", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@mediaId", SqlDbType.NVarChar, 50).Value = mediaId;
                cmd.Parameters.Add("@returnValue", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@returnValue"].Value);
                return result;
            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1;
                return result;
            }
            finally
            {
                con.Close();
            }
        }

        public static int getReviewId(string userName, string gameName)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result;

            try
            {
                cmd = new SqlCommand("SELECT reviewID FROM review", con);
                cmd.CommandType = System.Data.CommandType.Text;
                SqlDataReader rdr;

                rdr = cmd.ExecuteReader();
                if(rdr.Read())
                {
                    result = Convert.ToInt32(rdr["reviewID"]);
                }
                else
                {
                    result = -1;
                }
                return result;
            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1;
                return result;
            }
            finally
            {
                con.Close();
            }
        }
        public static int deleteReviewById(int reviewId)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            SqlCommand cmd_reviewFor;
            int result;

            try
            {
                cmd = new SqlCommand("DELETE FROM review WHERE reviewID=@reviewID", con);
                cmd_reviewFor = new SqlCommand("DELETE FROM review WHERE reviewID=@reviewID", con);
                cmd.Parameters.AddWithValue("@reviewID", reviewId);
                cmd_reviewFor.Parameters.AddWithValue("@reviewID", reviewId);
                
                SqlDataReader rdr;

                rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    result = Convert.ToInt32(rdr["reviewID"]);
                }
                else
                {
                    result = -1;
                }
                return result;
            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1;
                return result;
            }
            finally
            {
                con.Close();
            }

        }

    }

}
   
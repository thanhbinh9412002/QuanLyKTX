using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace QuanLyKTX.DataProvider
{

    public class DBConnection
    {
        //SqlConnection cnnStr = new SqlConnection(@"Data Source=THANHBINH\SQLEXPRESS;Initial Catalog=QuanLyKTX;Integrated Security=True");
        private SqlDataAdapter adapter;
        private SqlConnection connection;
        public DBConnection()
        {
            adapter = new SqlDataAdapter();
            connection = new SqlConnection(Properties.Settings.Default.cnnStr);
        }
        private SqlConnection openConnection()
        {
            if (connection.State == ConnectionState.Closed || connection.State == ConnectionState.Broken)
            {
                connection.Open();
            }
            return connection;
        }

        public void executeInsertQuery(String query, SqlParameter[] sqlParameter)
        {
            using (SqlCommand sqlCommand = new SqlCommand(query, openConnection()))
            {
                sqlCommand.CommandType = CommandType.Text;
                sqlCommand.Parameters.AddRange(sqlParameter);
                try
                {
                    sqlCommand.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                finally
                {
                    connection.Close();
                }
            }
        }

        public object executeScalar(String query, CommandType storedProcedure, SqlParameter[] sqlParameter)
        {
            using (SqlCommand sqlCommand = new SqlCommand(query, openConnection()))
            {
                sqlCommand.CommandType = CommandType.Text;
                sqlCommand.Parameters.AddRange(sqlParameter);
                object result = new object();
                try
                {
                    result = sqlCommand.ExecuteScalar();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                finally
                {
                    connection.Close();
                }
                return result;
            }
        }
        public DataTable executeReader(String query, SqlParameter[] sqlParameter)
        {
            using (SqlCommand sqlCommand = new SqlCommand(query, openConnection()))
            {
                sqlCommand.CommandType = CommandType.Text;
                sqlCommand.Parameters.AddRange(sqlParameter);
                DataTable dt = new DataTable();
                try
                {
                    SqlDataReader dataReader = sqlCommand.ExecuteReader(CommandBehavior.CloseConnection);
                    dt.Load(dataReader);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                finally
                {
                    connection.Close();
                }
                return dt;
            }
        }
        public int executeCount(string query)           // trả về số lượng 
        {
            int cout = 0;
            using (SqlCommand sqlCommand = new SqlCommand(query, openConnection()))
            {
                try
                {
                    cout = (Int32)sqlCommand.ExecuteScalar();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                finally
                {
                    connection.Close();
                }
                return cout;
            }
        }

        public DataTable executeLoadData(string query)      // trả về bảng dữ liệu
        {
            using (SqlCommand command = new SqlCommand(query, openConnection()))
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    DataTable dt = new DataTable();
                    try
                    {
                        dt.Load(reader);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    finally
                    {
                        connection.Close();
                        reader.Close();
                    }
                    return dt;
                }
            }
        }

        public int ExecuteStoredProcedure(string spName, string[] pNames, object[] pValues) //trả về 1 giá trị khi gọi procedure bên sql

        {
            int kq = 0;
            openConnection();
            // Khai báo và khởi tạo đối tượng Command với tham số tên thủ tục spName
            SqlCommand cmd = new SqlCommand(spName, connection);
            // Khai báo kiểu thủ tục
            cmd.CommandType = CommandType.StoredProcedure;
            // Khai báo tham số SqlParameter
            SqlParameter p;
            // Khởi tạo danh sách các tham số với giá trị tương ứng
            for (int i = 0; i < pNames.Length; i++)
            {
                p = new SqlParameter(pNames[i], pValues[i]);
                cmd.Parameters.Add(p);
            }
            SqlParameter n = new SqlParameter("@kq", SqlDbType.Int);
            n.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(n);
            cmd.ExecuteScalar();
            kq = (Int32)n.Value;
            connection.Close();
            return kq;
        }

        public int ExecuteStoredProcedure_Update(string spName, string[] pNames, object[] pValues) //thêm, xóa, sửa khi gọi procedure bên sql

        {
            openConnection();
            // Khai báo và khởi tạo đối tượng Command với tham số tên thủ tục spName
            SqlCommand cmd = new SqlCommand(spName, connection);
            // Khai báo kiểu thủ tục
            cmd.CommandType = CommandType.StoredProcedure;
            // Khai báo tham số SqlParameter
            SqlParameter p;
            // Khởi tạo danh sách các tham số với giá trị tương ứng
            for (int i = 0; i < pNames.Length; i++)
            {
                p = new SqlParameter(pNames[i], pValues[i]);
                cmd.Parameters.Add(p);
            }
            connection.Close();
            return cmd.ExecuteNonQuery(); 
        }
    }     
}

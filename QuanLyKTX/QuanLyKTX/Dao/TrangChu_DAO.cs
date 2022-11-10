using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyKTX.Class
{
    internal class TrangChu_DAO
    {
        private string user;
        private string password;
        private string role;

        TrangChu_DAO(string user, string password, string role)
        {
            this.user = user;
            this.password = password;
            this.role = role;
        }
    }
}
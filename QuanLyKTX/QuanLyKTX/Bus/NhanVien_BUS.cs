using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using QuanLyKTX.DAO;
using QuanLyKTX.Class;

namespace QuanLyKTX
{
    internal class NhanVien_BUS
    {
        private NhanVien_DAO nvDAO;
        public NhanVien_BUS()
        {
            nvDAO = new NhanVien_DAO();
        }
        public DataTable DanhSachNhanVien()
        {
            return nvDAO.DanhSachNhanVien();
        }
        public DataTable TimNhanVien(string MaNV)
        {
            return nvDAO.TimNhanVien(MaNV);
        }
        public bool SuaNhanVien(NhanVien nv)
        {
            return nvDAO.SuaNhanVien(nv);
        }
        public bool ThemNhanVien(NhanVien nv)
        {
            return nvDAO.ThemNhanVien(nv);
        }
        public bool XoaNhanVien(string MaNhanVien1)
        {
            return nvDAO.XoaNhanVien(MaNhanVien1);
        }
    }
}

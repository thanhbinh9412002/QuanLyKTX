using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using QuanLyKTX.Class;
using QuanLyKTX.DataProvider;

namespace QuanLyKTX.DAO
{
    internal class NhanVien_DAO
    {
        private DBConnection conn;
        public NhanVien_DAO()
        {
            conn = new DBConnection();
        }

        public DataTable DanhSachNhanVien()
        {
            const string sql = "select * from NhanVien";
            SqlParameter[] sqlParameters = new SqlParameter[0];
            DataTable dt = new DataTable();
            dt = conn.executeReader(sql, sqlParameters);
            return dt;
        }
        public DataTable TimNhanVien(string MaNV)
        {
            const string sql = "select * from NhanVien where MaNhanVien = @MaNV";
            SqlParameter[] sqlParameters = new SqlParameter[0];
            DataTable dt = new DataTable();
            dt = conn.executeReader(sql, sqlParameters);
            return dt;
        }
        public bool SuaNhanVien(NhanVien nv)
        {
            string spName = "[dbo].[proc_SuaNhanVien]";
            string[] pNames = { "@manv", "@tennv", "@sdtnv", "@gioitinhnv", "@tongiaonv", "@quoctichnv", "@cmnd_cccd_nv", "@cv", "@manql" };
            object[] pValues = {nv.MaNV, nv.TenNV, nv.SoDT, nv.Gioitinh, nv.Tongiao, nv.Quoctich, nv.CMND, nv.CV, nv.Manql};
            int count = conn.ExecuteStoredProcedure(spName, pNames, pValues);
            return count > 0;
        }
        public bool ThemNhanVien(NhanVien nv)
        {
            string spName = "[dbo].[proc_XoaNhanVien]";
            string[] pNames = { "@manv", "@tennv", "@sdtnv", "@gioitinhnv", "@tongiaonv", "@quoctichnv", "@cmnd_cccd_nv", "@cv", "@manql" };
            object[] pValues = { nv.MaNV, nv.TenNV, nv.SoDT, nv.Gioitinh, nv.Tongiao, nv.Quoctich, nv.CMND, nv.CV, nv.Manql };
            int count = conn.ExecuteStoredProcedure(spName, pNames, pValues);
            return count > 0;
        }
        public bool XoaNhanVien(string MaNhanVien1)
        {
            string spName = "[dbo].[proc_XoaNhanVien]";
            string[] pNames = {"@manv"};
            object[] pValues = {MaNhanVien1};
            int count = conn.ExecuteStoredProcedure(spName, pNames, pValues);
            return count > 0;
        }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyKTX.Class;

namespace QuanLyKTX
{
    public partial class frm_TrangChu : Form
    {
        public frm_DangNhap fmDangNhap;
        public string chucvu = null;
        public string CCMD = null;
        public frm_TrangChu()
        {
            InitializeComponent();
        }

        private void frm_TrangChu_Load(object sender, EventArgs e)
        {
            //MainNoEnabled();
            fmDangNhap = new frm_DangNhap();
            fmDangNhap.fmTrangChu = this;
            fmDangNhap.ShowDialog();
            if (chucvu == "Admin")
            {
                MainEnabled();
            }
            else
            {
                MainNoEnabled();
            }

            //lblUser.Text = "Hi " + mfullname + " !";

            //loadthongtin();
        }
        private void MainEnabled()  // quyền admin
        {
            btn_TrangChu.Enabled = true;
            btn_HoaDon.Enabled = true;
            btn_SinhVien.Enabled = true;
            btn_Toa.Enabled = true;
            btn_NhanVien.Enabled = true;
            btn_CaiDat.Enabled = true;
            btn_ThietBi.Enabled = true;
            btn_ThongKe.Enabled = true;
            lsb_ThongTinCaNhan.Visible = false;
        }
        private void MainNoEnabled()  // quyền quản lý
        {
            btn_TrangChu.Enabled = true;
            btn_HoaDon.Enabled = true;
            btn_SinhVien.Enabled = true;
            btn_Toa.Enabled = true;
            btn_NhanVien.Enabled = false;
            btn_CaiDat.Enabled = true;
            btn_ThietBi.Enabled = true;
            btn_ThongKe.Enabled = false;
        }

        private void btn_TrangChu_Click(object sender, EventArgs e)
        {
            btn_TrangChu.BackColor = Color.White;
           // MessageBox.Show("Hello");
        }

        private void btn_HoaDon_Click(object sender, EventArgs e)
        {

        }

        private void btn_Toa_Click(object sender, EventArgs e)
        {

        }

        private void btn_SinhVien_Click(object sender, EventArgs e)
        {

        }

        private void btn_NhanVien_Click(object sender, EventArgs e)
        {

        }

        private void btn_ThietBi_Click(object sender, EventArgs e)
        {

        }

        private void btn_CaiDat_Click(object sender, EventArgs e)
        {

        }

        private void btn_ThongKe_Click(object sender, EventArgs e)
        {

        }

        private void btn_TrangChu_MouseHover(object sender, EventArgs e)
        {
            lsb_ThongTinCaNhan.Visible = true;
        }
    }
}

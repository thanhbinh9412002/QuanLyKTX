using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyKTX.BUS;
using QuanLyKTX.Class;

namespace QuanLyKTX
{
    public partial class frm_DangNhap : Form
    {
        public frm_TrangChu fmTrangChu;
        public frm_DangNhap()
        {
            InitializeComponent();
        }

        private void btn_dangnhap_Click(object sender, EventArgs e)
        {
            //string password = dnBUS.Check_Tai_Khoan(txt_user.Text);
            string user = txt_user.Text;
            string password = txt_password.Text;
            string role;
            if( rdbtn_admin.Checked == true )
            {
                role = "Admin";
            }
            else
            {
                role = "Quản lý";
            }
            Tai_khoan tk = new Tai_khoan(user, password, role);
            DangNhap_BUS dnBUS = new DangNhap_BUS();
            int kq  = dnBUS.Check_Tai_Khoan(tk);
            if (kq == 1)
            {
                fmTrangChu.chucvu = role;
                this.Close();
            }
            else
            {
                lb_trangthai.Text = "Đăng nhập không thành công! Vui lòng kiểm tra lại";
                txt_password.ResetText();
                txt_password.Focus();
            }
        }

        private void btn_thoat_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void frm_DangNhap_Load(object sender, EventArgs e)
        {
            txt_user.Focus();
        }

        private void txt_user_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txt_password.Focus();
            }
        }

        private void txt_password_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                rdbtn_admin.Focus();
            }
        }

        private void rdbtn_admin_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                btn_dangnhap.Focus();
            }
        }

        private void rdbtn_quanly_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                btn_dangnhap.Focus();
            }
        }
    }
}

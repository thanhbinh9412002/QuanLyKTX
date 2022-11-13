using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyKTX.DAO;
using QuanLyKTX.Class;

namespace QuanLyKTX
{
    public partial class frm_CapNhatNhanVien : Form
    {
        public frm_NhanVien fmNhanVien;
        public string MaNhanVien = null;
        public string TenNhanVien = null;
        public string SoDienThoai = null;
        public string GioiTinh = null;
        public string TonGiao = null;
        public string QuocTich = null;
        public string CMND_CCCD = null;
        public string ChucVu = null;
        public string MaNQL = null;
        public int tmp;
        public frm_CapNhatNhanVien()
        {
            InitializeComponent();
        }
        private void frm_CapNhatNhanVien_Load(object sender, EventArgs e)
        {
            txt_MaNhanVien.Text = MaNhanVien;
            txt_TenNhanVien.Text = TenNhanVien;
            txt_SoDienThoai.Text = SoDienThoai;
            cbb_GioiTinh.Text = GioiTinh;
            txt_TonGiao.Text = TonGiao;
            txt_QuocTich.Text = QuocTich;
            txt_CMND.Text = CMND_CCCD;
            txt_ChucVu.Text = ChucVu;
            cbb_MaNQL.Text = MaNQL;
            txt_MaNhanVien.Focus();
        }

        private void btn_luu_Click(object sender, EventArgs e)
        {
            if(tmp == 0)
            {
                NhanVien nv = new NhanVien(txt_MaNhanVien.Text, txt_TenNhanVien.Text, txt_SoDienThoai.Text, cbb_GioiTinh.Text,
                    txt_TonGiao.Text, txt_QuocTich.Text, txt_CMND.Text, txt_ChucVu.Text, cbb_MaNQL.Text);
                NhanVien_BUS nvBUS = new NhanVien_BUS();
                if (nvBUS.ThemNhanVien(nv))
                {
                    MessageBox.Show("Thêm mới nhân viên thành công!");
                    this.Close();
                }
                else MessageBox.Show("Có lỗi xảy ra!");
            }    
            else
            {
                NhanVien nv = new NhanVien(txt_MaNhanVien.Text, txt_TenNhanVien.Text, txt_SoDienThoai.Text, cbb_GioiTinh.Text,
                    txt_TonGiao.Text, txt_QuocTich.Text, txt_CMND.Text, txt_ChucVu.Text, cbb_MaNQL.Text);
                NhanVien_BUS nvBUS = new NhanVien_BUS();
                if (nvBUS.SuaNhanVien(nv))
                {
                    MessageBox.Show("Sửa đổi thông tin nhân viên thành công!");
                    this.Close();
                }
                else MessageBox.Show("Có lỗi xảy ra!");
            }
            
        }

        private void btn_huy_Click(object sender, EventArgs e)
        {
            fmNhanVien = new frm_NhanVien();
            fmNhanVien.ShowDialog();
            this.Close();
        }
    }
}

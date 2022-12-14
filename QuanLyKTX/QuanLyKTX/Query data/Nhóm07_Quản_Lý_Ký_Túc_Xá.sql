create database QuanLyKTX
GO
use QuanLyKTX
GO
--Done
create table TaiKhoan (
	TenTaiKhoan char(15) ,
	MatKhau char(20) NOT NULL,
	VaiTro nvarchar(10) NOT NULL,
	Constraint PK_TaiKhoan Primary Key (TenTaiKhoan)
)
GO
--Done
create table NhanVien
(
    MaNhanVien char(10) NOT NULL,
    TenNhanVien nvarchar(50) NOT NULL,
    SoDienThoai char(15) NOT NULL,
    GioiTinh nvarchar(10) NOT NULL,
    TonGiao nvarchar(10) NOT NULL,
    QuocTich nvarchar(10) NOT NULL,
    CMND_CCCD char(20) NOT NULL,
    ChucVu nvarchar(20) NOT NULL,
	MaNQL char(10) NOT NULL,
    CONSTRAINT Pk_NhanVien PRIMARY KEY (MaNhanVien)
)
GO 

-- Done
create table Toa
(
    TenToa nvarchar(5)  NOT NULL,
    SoPhong int NOT NULL,
    MaNguoiQuanLy char(10) NOT NULL
    CONSTRAINT Pk_Toa PRIMARY KEY (TenToa)
)
GO

-- Done
CREATE TABLE Phong(
	MaPhong char(10) NOT NULL,
	Toa nvarchar(5) NOT NULL,
	SoLuongSinhVienHienTai int NOT NULL,
	SoLuongSinhVienToiDa int NOT NULL,
	Constraint PK_Phong Primary Key (MaPhong)
)
GO
--Done
CREATE TABLE SinhVien(
    MaSinhVien char(10) NOT NULL,
    HoTen nvarchar(50) NOT NULL,
    SoDienThoai nchar(50) NOT NULL,
    GioiTinh nvarchar(10) NOT NULL,
    NamHoc int NOT NULL,
    TonGiao nvarchar(10) NOT NULL,
    QuocTich nvarchar(10) NOT NULL,
    CMND_CCCD char(15) NOT NULL,
    MaPhong char(10) NOT NULL,
    Constraint PK_SinhVien Primary Key (MaSinhVien)
)
GO
-- Done
create table HoaDonDienNuoc (
	MaHoaDon char(10),
	MaPhong char(10) NOT NULL,
	TrangThai nvarchar(20), 
	TienDien float NOT NULL,
	TienNuoc float NOT NULL,
	NgayTao Date ,
	Constraint PK_HoaDonDienNuoc Primary Key (MaHoaDon)
)
GO

-- Done
create table TrangThietBi (
	MaThietBi char(10),
	TenThietBi nvarchar(20) NOT NULL,
	TongSoLuong int NOT NULL,
	Constraint PK_TrangThietBi Primary Key (MaThietBi)
)
GO

-- Done 
create table ThietBiTrongPhong (
	MaThietBiTrongPhong char(10),
	MaPhong char(10),
	SoLuongHong int NOT NULL,
	SoLuongTot int NOT NULL,
	SoLuongToiDa int NOT NULL
	Constraint PK_PhongThietBi Primary Key (MaThietBiTrongPhong,MaPhong)
)
GO


--														Ràng buộc khóa ngoại
--Done
ALTER TABLE Toa  ADD CONSTRAINT 
FK_Toa_QuanLy
FOREIGN KEY (MaNguoiQuanLy) REFERENCES NhanVien(MaNhanVien)
ON UPDATE CASCADE
GO
ALTER TABLE Toa CHECK CONSTRAINT FK_Toa_QuanLy
GO

--Done
ALTER TABLE Phong WITH CHECK ADD CONSTRAINT 
FK_Phong_Toa
FOREIGN KEY (Toa) REFERENCES Toa(TenToa)
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE Phong CHECK CONSTRAINT FK_Phong_Toa
GO
--Done
ALTER TABLE SinhVien WITH CHECK ADD CONSTRAINT 
FK_SinhVien_Phong 
FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE SinhVien CHECK CONSTRAINT FK_SinhVien_Phong
GO
--Done
ALTER TABLE HoaDonDienNuoc WITH CHECK ADD CONSTRAINT 
FK_HoaDonDienNuoc_Phong 
FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
ON DELETE CASCADE;
GO
ALTER TABLE HoaDonDienNuoc CHECK CONSTRAINT FK_HoaDonDienNuoc_Phong
GO
--Done
ALTER TABLE ThietBiTrongPhong
WITH CHECK ADD CONSTRAINT FK_TrangThietBi_ThietBi
FOREIGN KEY (MaThietBiTrongPhong) REFERENCES TrangThietBi(MaThietBi)
ON DELETE CASCADE;
GO
ALTER TABLE ThietBiTrongPhong CHECK CONSTRAINT FK_TrangThietBi_ThietBi
GO
--Done
ALTER TABLE ThietBiTrongPhong
ADD CONSTRAINT FK_ThietBiTrongPhong_Phong
FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
ON DELETE CASCADE;
GO
ALTER TABLE ThietBiTrongPhong CHECK CONSTRAINT FK_ThietBiTrongPhong_Phong
GO


--													 Ràng buộc điều kiện 
--Done
ALTER TABLE SinhVien WITH CHECK ADD CONSTRAINT 
CHECK_CMND_CCCD_SV CHECK ((len(CMND_CCCD)=(9)) or (len(CMND_CCCD)=(12)))
GO
--Done
ALTER TABLE SinhVien WITH CHECK ADD CONSTRAINT 
CHECK_SDT_SV CHECK ((len(SoDienThoai)=(10)))
GO
--Done
ALTER TABLE NhanVien WITH CHECK ADD CONSTRAINT 
CHECK_CMND_CCCD_NV CHECK ((len(CMND_CCCD)=(9)) or (len(CMND_CCCD)=(12)))
GO
--Done
ALTER TABLE NhanVien WITH CHECK ADD CONSTRAINT 
CHECK_SDT_NV CHECK ((len(SoDienThoai)=(10)))
GO
--Done
ALTER TABLE SinhVien WITH CHECK ADD CONSTRAINT 
CHECK_NamHocSV CHECK ((NamHoc<(5)))
GO
--Done
ALTER TABLE TrangThietBi WITH CHECK ADD CONSTRAINT 
CHECK_SoLuongThietBi_TrangThietBi CHECK (TongSoLuong >0)
GO
--Done
ALTER TABLE HoaDonDienNuoc WITH CHECK ADD CONSTRAINT 
CHECK_SoTien_HoaDonDienNuoc CHECK (TienDien > 0 and TienNuoc > 0)
GO

--Alter table HoaDonDienNuoc drop constraint CHECK_SoTien_HoaDonDienNuoc
--Done
ALTER TABLE TaiKhoan WITH CHECK ADD CONSTRAINT 
CHECK_MatKhau_TaiKhoan CHECK ((len(MatKhau)>=(8)))
GO
--Done
ALTER TABLE Phong WITH CHECK ADD CONSTRAINT
CHECK_SoluongSV CHECK ((SoLuongSinhVienHienTai>=(0) AND
SoLuongSinhVienToiDa<(9)))
GO
--Done
ALTER TABLE Toa WITH CHECK ADD CONSTRAINT
CHECK_SoPhong CHECK (SoPhong > 20)
GO
--Done
ALTER TABLE ThietBiTrongPhong WITH CHECK ADD CONSTRAINT 
CHECK_SoThietBiTrongPhong CHECK (SoLuongHong >= (0) and SoLuongTot >= (0) and SoLuongHong + SoLuongTot = SoLuongToiDa)
GO


--															 Trigger 
-- Done
CREATE TRIGGER Tg_ThemTaiKhoan
ON NhanVien
FOR INSERT
AS
BEGIN
	SET NOCOUNT ON;
	declare @VaiTro nvarchar(10)
	select @VaiTro = NhanVien.ChucVu
	from NhanVien
	if(@VaiTro = N'Quản lý')
	begin
		INSERT INTO TaiKhoan(
			TenTaiKhoan,
			MatKhau,
			VaiTro
		)
		SELECT
			i.CMND_CCCD,
			i.CMND_CCCD,
			i.ChucVu
			FROM inserted i
	end
END
GO
-- Done
CREATE TRIGGER tg_XoaThongTinDangNhapNhanVien
ON NhanVien
FOR DELETE
AS
	BEGIN
		SET NOCOUNT ON;
		DELETE FROM TaiKhoan
		FROM deleted i
		WHERE TenTaiKhoan = i.CMND_CCCD
	END
GO
-- Done
-- Trigger : Khi chỉnh sửa hoặc chèn thêm phòng mới , Mã phòng phải được đặt đúng cú pháp đưa ra 
CREATE TRIGGER tg_Phong 
on Phong
after insert, update
as
begin
	if (select count(*) as Count 
			from (select MaPhong from inserted where MaPhong is not null and MaPhong like'%[a-zA-Z][0-9]%') as q) = 0
				ROLLBACK TRANSACTION
end
GO
-- Done
-- Mỗi người quản lý chỉ được quản lý 1 tòa duy nhất 
-- Trigger: Khi thêm 1 tòa mới hoặc cập nhật Mã ng quản lý của tòa , phải thỏa điều kiện là người quản lý đó 
-- chưa quản lý tòa nào trong KTX 
CREATE TRIGGER tg_ThemToa
on Toa
after insert , update
as 
	declare @new char(15)
	select @new = inserted.MaNguoiQuanLy
	from inserted
begin
	if (SELECT count(MaNguoiQuanLy) as Count
		from (select MaNguoiQuanLy from Toa where Toa.MaNguoiQuanLy = @new) as q) >= 2
			ROLLBACK TRANSACTION 
end
GO
-- Done
--số lượng sinh viên trong phòng khi thêm sinh viên
CREATE TRIGGER tg_SoLuongSinhVienTrongPhongKhiThem
ON SinhVien
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SoLuongSinhVien int, @SoLuongSinhVienToiDa int
	SELECT @SoLuongSinhVien = Phong.SoLuongSinhVienHienTai,@SoLuongSinhVienToiDa = Phong.SoLuongSinhVienToiDa
	FROM inserted, Phong
	WHERE inserted.MaPhong= Phong.MaPhong
	IF(@SoLuongSinhVien >= @SoLuongSinhVienToiDa)
		BEGIN
			RAISERROR(N'Phòng đã đủ sinh viên', 16,1)
			ROLLBACK
		END
	ELSE
		BEGIN 
			UPDATE Phong SET SoLuongSinhVienHienTai = SoLuongSinhVienHienTai + 1
			FROM inserted, Phong
			WHERE Phong.MaPhong = inserted.MaPhong
		END
END
GO
-- Done
CREATE TRIGGER tg_SoLuongSinhVienTrongPhongKhiSua
ON SinhVien
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SoLuongSinhVien int, @SoLuongSinhVienToiDa int, @SoPhongCu nchar(10), @SoPhongMoi nchar(10)
	SELECT @SoLuongSinhVien = Phong.SoLuongSinhVienHienTai, @SoLuongSinhVienToiDa = Phong.SoLuongSinhVienToiDa,@SoPhongMoi = updated.MaPhong,@SoPhongCu = deleted.MaPhong
	FROM inserted updated,deleted, Phong
	WHERE updated.MaPhong = Phong.MaPhong
	IF(@SoPhongCu != @SoPhongMoi)
	BEGIN
		IF(@SoLuongSinhVien >= @SoLuongSinhVienToiDa)
		BEGIN
			RAISERROR(N'Phòng đã đủ sinh viên', 16,1)
			ROLLBACK TRANSACTION
		END
		ELSE
		BEGIN 
			UPDATE Phong SET SoLuongSinhVienHienTai = SoLuongSinhVienHienTai - 1
			FROM deleted, Phong
			WHERE Phong.MaPhong = deleted.MaPhong
			UPDATE Phong SET SoLuongSinhVienHienTai = SoLuongSinhVienHienTai + 1
			FROM inserted updated, Phong
			WHERE Phong.MaPhong = updated.MaPhong
		END
	END
END
GO
-- Done
CREATE TRIGGER tg_GiamSoLuongSinhVien
ON SinhVien
FOR DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SoLuongSinhVien int
	SELECT @SoLuongSinhVien = Phong.SoLuongSinhVienHienTai
	FROM deleted , Phong
	WHERE deleted.MaPhong = Phong.MaPhong

	UPDATE Phong SET SoLuongSinhVienHienTai = SoLuongSinhVienHienTai - 1
	FROM deleted, Phong
	WHERE Phong.MaPhong = deleted.MaPhong
END
GO
-- Done
CREATE TRIGGER tg_ThemHoaDon
ON HoaDonDienNuoc
AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	DECLARE @SoSinhVien int
	SELECT @SoSinhVien = Phong.SoLuongSinhVienHienTai
	FROM inserted, Phong 
	WHERE inserted.MaPhong = Phong.MaPhong
	IF (@SoSinhVien = 0)
	BEGIN
		RAISERROR(N'Phòng trống', 16,1)
		ROLLBACK TRANSACTION
	END
END
GO
-- Done
--Kiểm tra chức vụ nhân viên khi thêm người quản lý phòng

GO
-- Done
--admin xóa nhân viên ra khỏi cơ sở dữ liệu.
CREATE TRIGGER dbo.XoaNhanVien 
ON NhanVien
FOR DELETE
AS 
BEGIN
	SET NOCOUNT ON;
	update Toa
	set MaNguoiQuanLy = N'Trống'
	where MaNguoiQuanLy is null
END
GO
--														Thêm dữ liệu

insert into NhanVien Values('NV01',N'Nguyễn Thị Thương','0367064835', N'Nữ',N'Không',N'Việt Nam','221502791',N'Quản lý','NV01')
insert into NhanVien Values('NV02',N'Lương Hoàng','0312452124', N'Nam',N'Không',N'Việt Nam','221531242',N'Bảo vệ','NV01')
insert into NhanVien Values('NV03',N'Trần Tú','0364412342', N'Nam',N'Không',N'Việt Nam','221512463',N'Lao công','NV01')
insert into NhanVien Values('NV04',N'Cao Thị Cẩm Tú','0367125213', N'Nữ',N'Không',N'Việt Nam','221512664',N'Lao công','NV01')
insert into NhanVien Values('NV05',N'Bùi Tú Quyên','0367784322', N'Nam',N'Không',N'Việt Nam','221586225',N'Bảo vệ','NV01')
insert into NhanVien Values('NV06',N'Nguyễn Thị Hậu','0367095413', N'Nữ',N'Không',N'Việt Nam','221587666',N'Lao công','NV01')
insert into NhanVien Values('NV07',N'Huỳnh Hậu','0367987432', N'Nam',N'Không',N'Việt Nam','221574777',N'Quản lý','NV07')
insert into NhanVien Values('NV08',N'Nguyễn Thị Hoài','0367053413', N'Nữ',N'Không',N'Việt Nam','221534872',N'Lao công','NV07')
insert into NhanVien Values('NV09',N'Nguyễn Tuyến','0322275423', N'Nam',N'Không',N'Việt Nam','221591249',N'Bảo vệ','NV07')
insert into NhanVien Values('NV10',N'Nguyễn Thị Duyên','0367842103', N'Nữ',N'Không',N'Việt Nam','221531558',N'Giữ xe','NV07')
insert into NhanVien Values('NV11',N'Nguyễn Thị Tuyến','0322864192', N'Nữ',N'Không',N'Việt Nam','221537249',N'Giữ xe','NV07')
GO


insert into Toa Values('A', 21, 'NV03')
insert into Toa Values('B', 22 ,'NV11')
insert into Toa Values('C', 23 ,'NV10')
insert into Toa Values('D', 24 ,'NV08')
insert into Toa Values('E', 25, 'NV09')
GO

insert into Phong Values('P101','A', 0 , 8)
insert into Phong Values('P402','E', 0 , 6)
insert into Phong Values('P711','B', 0 , 8)
insert into Phong Values('P310','A', 0 , 4)
insert into Phong Values('P405','C', 0 , 6)
insert into Phong Values('P103','B', 0 , 8)
insert into Phong Values('P204','A', 0 , 4)
insert into Phong Values('P602','D', 0 , 8)
insert into Phong Values('P802','C', 0 , 6)
insert into Phong Values('P508','E', 0 , 8)
GO

-- Tòa B, C là nữ, còn A, D, E là nam

insert into SinhVien Values('20133104',N'Nguyễn Văn Thanh','0367064834', N'Nam',3,N'Không',N'Việt Nam','221502781','P101')
insert into SinhVien Values('22133102',N'Lương Sĩ Hoàng','0312452123', N'Nam',1,N'Không',N'Việt Nam','221531232','P101')
insert into SinhVien Values('21133101',N'Trần Thái Tú','0364412341', N'Nam',2,N'Không',N'Việt Nam','221512453','P101')
insert into SinhVien Values('22133133',N'Cao Tuấn Tú','0367125212', N'Nam',3,N'Không',N'Việt Nam','221512654','P101')

insert into SinhVien Values('21133122',N'Nguyễn Phước Ninh','0367784321', N'Nam',2,N'Không',N'Việt Nam','221586215','P402')
insert into SinhVien Values('22412122',N'Nguyễn Thanh Tuấn ','0367095412', N'Nam',1,N'Không',N'Việt Nam','221587656','P402')
insert into SinhVien Values('21133166',N'Huỳnh Công Hậu','0367987431', N'Nam',2,N'Không',N'Việt Nam','221574767','P402')
insert into SinhVien Values('20133123',N'Nguyễn Sĩ','0367053412', N'Nam',3,N'Không',N'Việt Nam','221534548','P402')
insert into SinhVien Values('20133111',N'Nguyễn Tuyên','0322234123', N'Nam',3,N'Không',N'Việt Nam','221521239','P402')
insert into SinhVien Values('21147523',N'Nguyễn Phước Minh','0367784375', N'Nam',2,N'Không',N'Việt Nam','221586215','P402')

insert into SinhVien Values('22133752',N'Nguyễn Thị Thanh ','0372403491', N'Nữ',1,N'Không',N'Việt Nam','221543157','P711')
insert into SinhVien Values('21241242',N'Huỳnh Lê Vân','0367784295', N'Nữ',2,N'Không',N'Việt Nam','221521232','P711')
insert into SinhVien Values('20196542',N'Nguyễn Thị Thùy','0367823472', N'Nữ',3,N'Không',N'Việt Nam','221551921','P711')

insert into SinhVien Values('20423224',N'Nguyễn Tuấn Tú','0367054212', N'Nam',3,N'Không',N'Việt Nam','221508753','P310')
insert into SinhVien Values('22214252',N'Lương Huy Hoàng','0312476542', N'Nam',1,N'Không',N'Việt Nam','221587632','P310')
insert into SinhVien Values('21242152',N'Trần Công Tú','0364412342', N'Nam',2,N'Không',N'Việt Nam','221509533','P310')
insert into SinhVien Values('20133133',N'Cao Văn Tú','0367187421', N'Nam',3,N'Không',N'Việt Nam','221574263','P310')

insert into SinhVien Values('20122123',N'Cao Ngọc Trinh','0322265322', N'Nữ',3,N'Không',N'Việt Nam','221528532','P103')
insert into SinhVien Values('21452323',N'Nguyễn Hoàng Linh','0322974256', N'Nữ',2,N'Không',N'Việt Nam','221528533','P103')
insert into SinhVien Values('22141414',N'Bùi Thị Xuân','0322298532', N'Nữ',1,N'Không',N'Việt Nam','221597422','P103')

insert into SinhVien Values('21241415',N'Lê Thị Vân','0367784872', N'Nữ',2,N'Không',N'Việt Nam','221527423','P405')
insert into SinhVien Values('20197413',N'Nguyễn Thy','0367842138', N'Nữ',3,N'Không',N'Việt Nam','221554219','P405')

insert into SinhVien Values('20112563',N'Hứa Tấn Đạt','0362853234', N'Nam',3,N'Không',N'Việt Nam','221590876','P204')

insert into SinhVien Values('22112311',N'Nguyễn Hải Đăng','0917243432', N'Nam',1,N'Không',N'Việt Nam','221541995','P602')
insert into SinhVien Values('21124133',N'Trần Tiến Dũng','0397294885', N'Nam',2,N'Không',N'Việt Nam','221517453','P602')
insert into SinhVien Values('20087612',N'Phan Anh Dũng','0309764789', N'Nam',3,N'Không',N'Việt Nam','221568477','P602')
insert into SinhVien Values('20567821',N'Nguyễn Bảo Đức','0336579432', N'Nam',3,N'Không',N'Việt Nam','221588133','P602')
insert into SinhVien Values('21241412',N'Trần Huy Hoàng','0374088270', N'Nam',2,N'Không',N'Việt Nam','221536646','P602')
insert into SinhVien Values('22214412',N'Phan Gia Hưng','0373133725', N'Nam',1,N'Không',N'Việt Nam','221549877','P602')
insert into SinhVien Values('21241223',N'Nguyễn Phúc Hưng','0333467946', N'Nam',2,N'Không',N'Việt Nam','221534038','P602')
insert into SinhVien Values('20234123',N'Phan Tuấn Hưng','0343739289', N'Nam',3,N'Không',N'Việt Nam','221536132','P602')

insert into SinhVien Values('20412351',N'Phạm Huyền Anh','0386605348', N'Nữ',3,N'Không',N'Việt Nam','221516004','P802')
insert into SinhVien Values('21526322',N'Nguyễn Trúc Khuê','0390327281', N'Nữ',2,N'Không',N'Việt Nam','221566002','P802')
insert into SinhVien Values('22542151',N'Trần Cẩm Liên','0394335770', N'Nữ',1,N'Không',N'Việt Nam','221544574','P802')
insert into SinhVien Values('21232142',N'Nguyễn Bảo Ngọc','0316329877', N'Nữ',2,N'Không',N'Việt Nam','221526296','P802')
insert into SinhVien Values('20141123',N'Phạm Diễm Ngọc','0377941169', N'Nữ',3,N'Không',N'Việt Nam','221537257','P802')

insert into SinhVien Values('19573222',N'Nguyễn Phúc Lâm','0366873638', N'Nam',4,N'Không',N'Việt Nam','221513571','P508')
insert into SinhVien Values('20124631',N'Lê Quang Lộc','0312545295', N'Nam',3,N'Không',N'Việt Nam','221516358','P508')
insert into SinhVien Values('21242412',N'Nguyễn Duy Luận','0367725757', N'Nam',2,N'Không',N'Việt Nam','221585483','P508')
insert into SinhVien Values('22151512',N'Trần Gia Long','0385174102', N'Nam',1,N'Không',N'Việt Nam','221562595','P508')
insert into SinhVien Values('21168595',N'Lê Hoàng Nam','0326767932', N'Nam',2,N'Không',N'Việt Nam','221537782','P508')
GO

insert into HoaDonDienNuoc Values('HD1','P101', N'Đã đóng',150 , 300, '2020-07-31')
insert into HoaDonDienNuoc Values('HD2','P402', N'Chưa đóng', 500, 200,  '2021-08-31')
insert into HoaDonDienNuoc Values('HD3','P711', N'Đã đóng', 200, 350,  '2019-01-31')
insert into HoaDonDienNuoc Values('HD4','P310', N'Chưa đóng',200, 300,  '2022-01-31')
insert into HoaDonDienNuoc Values('HD5','P405', N'Đã đóng', 150, 140,  '2020-05-31')
insert into HoaDonDienNuoc Values('HD6','P103', N'Chưa đóng',300, 450,  '2021-01-31')
insert into HoaDonDienNuoc Values('HD7','P204', N'Đã đóng',120, 140,  '2021-05-31')
insert into HoaDonDienNuoc Values('HD8','P602', N'Đã đóng', 70, 90, '2021-07-31')
insert into HoaDonDienNuoc Values('HD9','P802', N'Chưa đóng',200, 390,  '2022-08-31')
insert into HoaDonDienNuoc Values('HD10','P508', N'Đã đóng',150, 300 ,  '2021-10-31')
GO

insert into TrangThietBi Values('TB1', N'Bóng đèn',800)
insert into TrangThietBi Values('TB2', N'Giường' ,200)
insert into TrangThietBi Values('TB3', N'Tủ' ,100)
insert into TrangThietBi Values('TB4', N'Quạt' ,300)
insert into TrangThietBi Values('TB5', N'Sào phơi đồ',100)
GO


insert into ThietBiTrongPhong Values('TB1','P101', 2 , 2, 4)
insert into ThietBiTrongPhong Values('TB2','P402', 0 , 2, 2)
insert into ThietBiTrongPhong Values('TB3','P711', 0 , 1, 1)
insert into ThietBiTrongPhong Values('TB4','P310', 1 , 1, 2)
insert into ThietBiTrongPhong Values('TB1','P405', 1 , 3, 4)
insert into ThietBiTrongPhong Values('TB2','P103', 2 , 0, 2)
insert into ThietBiTrongPhong Values('TB3','P204', 0 , 1, 1)
insert into ThietBiTrongPhong Values('TB4','P602', 2 , 0, 2)
insert into ThietBiTrongPhong Values('TB5','P802', 0 , 1, 1)
insert into ThietBiTrongPhong Values('TB2','P508', 1 , 1, 2)
GO



--															 View 
-- Done
-- sử dụng view lọc ra những phòng cần sửa chữa vật dụng cho admin hoặc quản lý xem
CREATE VIEW view_DanhSachVatDungCanSuaChua
as
	select a.Toa as N'Tên tòa', a.MaPhong as N'Số phòng', c.TenThietBi as N'Tên thiết bị', b.SoLuongHong as N'Số lượng hỏng', b.SoLuongTot as N'Số lượng còn sử dụng'
	from Phong as a, ThietBiTrongPhong as b, TrangThietBi as c
	where a.MaPhong = b.MaPhong and b.MaThietBiTrongPhong = c.MaThietBi and b.SoLuongHong > 0
go

-- Done
--Sử dụng View lọc ra thông tin nhân viên kèm thông tin đăng nhập (chỉ cho admin xem)
CREATE VIEW view_ThongTinDangNhap
as
	select a.MaNhanVien as N'Mã nhân viên', a.TenNhanVien as N'Tên nhân viên', a.SoDienThoai as N'Số điện thoại', a.GioiTinh as N'Giới tính',
			a.TonGiao as N'Tôn giáo', a.QuocTich as N'Quốc tịch', a.CMND_CCCD as N'Số CMND/ CCCD', a.ChucVu as N'Chức vụ', b.TenTaiKhoan as N'Tên đăng nhập', 
			b.MatKhau as N'Mật khẩu', b.VaiTro as 'Quyền'
	from NhanVien as a, TaiKhoan as b
	where a.CMND_CCCD = b.TenTaiKhoan and b.VaiTro = N'Quản Lý'
go

CREATE VIEW view_NhanVienLaoCong
as
	select MaNhanVien as N'Mã nhân viên', TenNhanVien as N'Tên nhân viên', SoDienThoai as N'Số điện thoại', GioiTinh as N'Giới tính',
			TonGiao as N'Tôn giáo', QuocTich as N'Quốc tịch', CMND_CCCD as N'Số CMND/ CCCD', ChucVu as N'Chức vụ'
	from NhanVien 
	where ChucVu = N'Lao công'
go

CREATE VIEW view_NhanVienGiuXe
as
	select MaNhanVien as N'Mã nhân viên', TenNhanVien as N'Tên nhân viên', SoDienThoai as N'Số điện thoại', GioiTinh as N'Giới tính',
			TonGiao as N'Tôn giáo', QuocTich as N'Quốc tịch', CMND_CCCD as N'Số CMND/ CCCD', ChucVu as N'Chức vụ'
	from NhanVien 
	where ChucVu = N'Giữ Xe'
go

CREATE VIEW view_NhanVienBaoVe
as
	select MaNhanVien as N'Mã nhân viên', TenNhanVien as N'Tên nhân viên', SoDienThoai as N'Số điện thoại', GioiTinh as N'Giới tính',
			TonGiao as N'Tôn giáo', QuocTich as N'Quốc tịch', CMND_CCCD as N'Số CMND/ CCCD', ChucVu as N'Chức vụ'
	from NhanVien 
	where ChucVu = N'Bảo vệ'
go

-- Done
-- Sử dụng view lọc ra tổng các phòng còn trống của các tòa cho admin xem
CREATE VIEW view_PhongTrong
as
	select b.TenToa as N'Tên tòa', c.TenNhanVien as N'Tên người quản lý', count(a.MaPhong) as N'Tổng số lượng phòng còn trống'
	from Phong as a, Toa as b, NhanVien as c
	where a.Toa = b.TenToa and b.MaNguoiQuanLy = c.MaNhanVien and a.SoLuongSinhVienHienTai =  0
	group by b.TenToa, c.TenNhanVien
go

-- Done
-- Sử dụng view lọc ra các phòng còn trống chỗ trong 1 tòa cho người quản lý (hoặc admin ) xem
CREATE VIEW view_PhongConCho
as
	select b.TenToa as N'Tên tòa', a.MaPhong as N'Số phòng', c.TenNhanVien as N'Tên người quản lý', 
	(a.SoLuongSinhVienToiDa - a.SoLuongSinhVienHienTai) as N'Số lượng chỗ còn trống'
	from Phong as a, Toa as b, NhanVien as c
	where a.Toa = b.TenToa and b.MaNguoiQuanLy = c.MaNhanVien and a.SoLuongSinhVienHienTai < a.SoLuongSinhVienToiDa
go
-- Done
-- Sử dụng view lọc ra các phòng trống trong 1 tòa cho người quản lý (hoặc admin ) xem
CREATE VIEW view_PhongTrongToa
as
	select b.TenToa as N'Tên tòa', a.MaPhong as N'Số phòng', c.TenNhanVien as N'Tên người quản lý', 
	a.SoLuongSinhVienHienTai as N'Số lượng sinh viên hiện tại' , a.SoLuongSinhVienHienTai as N'Số lượng sinh viên tối đa'
	from Phong as a, Toa as b, NhanVien as c
	where a.Toa = b.TenToa and b.MaNguoiQuanLy = c.MaNhanVien and a.SoLuongSinhVienHienTai =  0
go


--															 View
--Done
-- View lọc các hóa đơn lệ phí chưa thanh toán 
CREATE VIEW [view_HoaDonDienNuocChuaThanhToan] AS
select HD.MaHoaDon as [Mã Hóa Đơn],
	   HD.MaPhong as [Mã Phòng],
	   HD.TienDien as [Tiền Điện],
	   HD.TienNuoc as [Tiền Nước],
	   HD.NgayTao as [Ngày Tạo],
	   HD.TrangThai as [Trạng Thái]
from HoaDonDienNuoc as HD 
where HD.TrangThai = N'Chưa Thanh Toán'
GO

--DONE
-- View lọc sinh viên nam  
CREATE VIEW [view_SinhVienNam] AS
select SV.MaSinhVien as [Mã Sinh Viên],
	   SV.HoTen as [Họ Tên],
	   SV.SoDienThoai as [Số Điện Thoại],
	   SV.GioiTinh as [Giới Tính],
	   SV.NamHoc as [Năm Học],
	   SV.TonGiao as [Tôn Giáo],
	   SV.QuocTich as [Quốc Tịch],
	   SV.CMND_CCCD as [CMND/CCCD]
from SinhVien as SV
	where SV.GioiTinh = N'Nam'
GO
--DONE
-- View lọc sinh viên nữ
CREATE VIEW [view_SinhVienNu] AS
select SV.MaSinhVien as [Mã Sinh Viên],
	   SV.HoTen as [Họ Tên],
	   SV.SoDienThoai as [Số Điện Thoại],
	   SV.GioiTinh as [Giới Tính],
	   SV.NamHoc as [Năm Học],
	   SV.TonGiao as [Tôn Giáo],
	   SV.QuocTich as [Quốc Tịch],
	   SV.CMND_CCCD as [CMND/CCCD]
from SinhVien as SV
	where SV.GioiTinh = N'Nữ'
go

	--							Thủ tục
	------------
--- Thiết bị
create procedure [dbo].[proc_ThemThietBi] (@matb char(10), @tentb nvarchar(20), @tongsl int)
as insert into TrangThietBi values(@matb, @tentb, @tongsl );
go

create procedure [dbo].[proc_XoaThietBi] (@matb char(10) )
as delete TrangThietBi where MaThietBi = @matb;
go

create procedure [dbo].[proc_SuaThietBi] (@matb char(10), @tentb nvarchar(50), @tongsl int)
as update TrangThietBi
set MaThietBi = @matb,
	TenThietBi = @tentb,
	TongSoLuong = @tongsl
where MaThietBi = @matb;
go
--- Sinh viên
create procedure [dbo].[proc_ThemSinhVien]
(@masv char(10), @tensv nvarchar(50), @sdt nchar(50), @gioitinh nvarchar(10),
 @namhoc int, @tongiao nvarchar(10), @quoctich nvarchar(10), @cmnd_cccd char(15), @maphong char(10) )
as insert into SinhVien values(@masv, @tensv, @sdt, @gioitinh, @namhoc, @tongiao, @quoctich, @cmnd_cccd, @maphong);
go

create procedure [dbo].[proc_XoaSinhVien]
( @masv char(10) )
as delete SinhVien where MaSinhVien = @masv;
go 

create procedure [dbo].[proc_SuaSinhVien]
(	@masv char(10) ,
	@tensv nvarchar(50),
	@sdt nchar(50),
	@gioitinh nvarchar(10),
	@namhoc int,
	@tongiao nvarchar(10),
	@quoctich nvarchar(10),
	@cmnd_cccd char(15),
	@maphong char(10) )
as update SinhVien
set MaSinhVien = @masv,
	HoTen = @tensv,
	SoDienThoai = @sdt,
	GioiTinh = @gioitinh,
	NamHoc = @namhoc,
	TonGiao = @tongiao,
	QuocTich = @quoctich,
	CMND_CCCD = @cmnd_cccd,
	MaPhong = @maphong
where MaSinhVien = @masv
go
---   Hóa đơn điện nước
create procedure [dbo].[proc_ThemHoaDonDienNuoc]
(	@mahd char(10),
	@maphong char(10),
	@trangthai nvarchar(20),
	@td float,
	@tn float,
	@ngaytao Date)
as insert into HoaDonDienNuoc Values(@mahd, @maphong, @trangthai, @td, @tn, @ngaytao);
go

create procedure [dbo].[proc_XoaHoaDonDienNuoc]
(	@mahd char(10)	)
as delete HoaDonDienNuoc where MaHoaDon = @mahd
go

create procedure [dbo].[proc_SuaHoaDonDienNuoc] (@mahd char(10), @maphong char(10), @trangthai nvarchar(20), @td float,
						@tn float,@ngaytao Date)
as update HoaDonDienNuoc 
set MaHoaDon = @mahd,
	MaPhong = @maphong,
	TrangThai = @trangthai,
	TienDien = @td,
	TienNuoc = @tn,
	NgayTao = @ngaytao
where MaHoaDon = @mahd
go
--- nhân viên
create procedure [dbo].[proc_ThemNhanVien]
(	@manv char(10),
	@tennv nvarchar(50),
	@sdtnv char(15),
	@gioitinhnv nvarchar(10),
	@tongiaonv nvarchar(10),
	@quoctichnv nvarchar(10),
	@cmnd_cccd_nv char(20),
	@cv nvarchar(20),
	@manql char(10)
)
as insert into NhanVien Values(@manv, @tennv, @sdtnv, @gioitinhnv, @tongiaonv, @quoctichnv, @cmnd_cccd_nv, @cv, @manql);
go

create procedure [dbo].[proc_XoaNhanVien] (@manv char(10))
as delete NhanVien where MaNhanVien = @manv;
go


create procedure [dbo].[proc_SuaNhanVien] (@manv char(10), @tennv nvarchar(50), @sdtnv char(15), @gioitinhnv nvarchar(10),
@tongiaonv nvarchar(10), @quoctichnv nvarchar(10), @cmnd_cccd_nv char(20), @cv nvarchar(20), @manql char(10))
as update NhanVien
set MaNhanVien = @manv,
	TenNhanVien = @tennv,
	SoDienThoai = @sdtnv,
	GioiTinh = @gioitinhnv, 
	TonGiao =  @tongiaonv,
	QuocTich = @quoctichnv,
	CMND_CCCD = @cmnd_cccd_nv,
	ChucVu = @cv,
	MaNQL = @manql
where MaNhanVien = @manv
go

-- đổi mật khẩu

create procedure [dbo].[proc_DoiMatKhau] (@tentk char(15), @mk char(20) )
as begin
	set nocount on;
	update TaiKhoan
	set MatKhau = @mk
	where TenTaiKhoan = @tentk
end
go

-- Tòa
create procedure [dbo].[proc_ThemToa] (@TenToa nvarchar(5), @SoPhong int, @MaNguoiQuanLy char(10))
as insert into Toa values(@TenToa, @SoPhong, @MaNguoiQuanLy );
go

create procedure [dbo].[proc_SuaToa] (@TenToa nvarchar(5), @SoPhong int, @MaNguoiQuanLy char(10))
as update Toa
set TenToa = @TenToa,
	SoPhong = @SoPhong,
	MaNguoiQuanLy = @MaNguoiQuanLy
where TenToa = @TenToa;
go

create procedure [dbo].[pro_DanhSachSinhVienTrong1Phong] (@maphong char(10))
as 
begin
	SET NOCOUNT ON;
	select SV.MaSinhVien as [Mã Sinh Viên],
	   SV.HoTen as [Họ Tên],
	   SV.SoDienThoai as [Số Điện Thoại],
	   SV.GioiTinh as [Giới Tính],
	   SV.NamHoc as [Năm Học],
	   SV.TonGiao as [Tôn Giáo],
	   SV.QuocTich as [Quốc Tịch],
	   SV.CMND_CCCD as [CMND/CCCD]
	   FROM SinhVien as SV
	   Where SV.MaPhong=@maphong
end 
go

create procedure [dbo].[pro_DanhSachPhongTheoToa] (@matoa nvarchar(5))
as
begin 
	SET NOCOUNT ON;
	select Phong.MaPhong
	From Toa inner join Phong on Toa.TenToa=Phong.Toa
	Where Toa.TenToa=@matoa
end
go

create procedure [dbo].[pro_TrangThietBiTrongPhong]
@matoa nvarchar(5),@maphong char(10)
as 
begin 
	SET NOCOUNT ON;
	select TrangThietBi.MaThietBi,TrangThietBi.TenThietBi,ThietBiTrongPhong.SoLuongHong,ThietBiTrongPhong.SoLuongTot
	from Toa,Phong,ThietBiTrongPhong,TrangThietBi
	Where Toa.TenToa=Phong.Toa and
		Phong.MaPhong = ThietBiTrongPhong.MaPhong and
		ThietBiTrongPhong.MaThietBiTrongPhong=TrangThietBi.MaThietBi and
		Toa.TenToa=@matoa and Phong.MaPhong=@maphong
end
go


----							Hàm
--Danh sách Sinh Vien
create function [dbo].[func_DanhSachSinhVien]()
returns table as
return(select SV.MaSinhVien as [Mã Sinh Viên],
	   SV.HoTen as [Họ Tên],
	   SV.SoDienThoai as [Số Điện Thoại],
	   SV.GioiTinh as [Giới Tính],
	   SV.NamHoc as [Năm Học],
	   SV.TonGiao as [Tôn Giáo],
	   SV.QuocTich as [Quốc Tịch],
	   SV.CMND_CCCD as [CMND/CCCD]
	   FROM SinhVien as SV);
Go
--Danh sach Hóa đơn 
create function [dbo].[func_DanhSachHoaDon]()
returns table as
return(select HD.MaHoaDon as [Mã Hóa Đơn],
	   HD.MaPhong as [Mã phòng],
	   HD.TrangThai as [Trạng thái],
	   HD.TienDien as [Tiền điện],
	   HD.TienNuoc as [Tiền nước],
	   HD.NgayTao as [Ngày tạo]
	   FROM HoaDonDienNuoc as HD);
Go
create function [dbo].[func_SoLuongSinhVienTheoGioiTinh] (@gioitinh nvarchar(5))
returns int
as
begin 
	declare @soluong int
	select @soluong = count(MaSinhVien)
	from SinhVien
	where GioiTinh = @gioitinh
	return @soluong
end
go

create function [dbo].[func_SoLuongNhanVienTheoChucVu] (@cv nvarchar(20))
returns int
as
begin 
	declare @soluong int
	select @soluong = count(MaNhanVien)
	from NhanVien
	where ChucVu = @cv
	return @soluong
end
go

create function [dbo].[func_SoLuongSinhVienTHeoNamHoc] (@namhoc int)
returns int
as
begin 
	declare @soluong int
	select @soluong = count(MaSinhVien)
	from SinhVien
	where NamHoc = @namhoc
	return @soluong
end
go

create function [dbo].[func_KiemTraDangNhap] (@TenTK char(15), @MK char(20), @Vaitro nvarchar(10))
returns int
	as
		begin
			declare @check int
			if exists (select * from TaiKhoan
						where @TenTK=TaiKhoan.TenTaiKhoan and @MK=TaiKhoan.MatKhau and
							@Vaitro=VaiTro)
						set @check=1
			else	
					set @check=0
			return @check
		end
go

create function [dbo].[func_DanhSachHoaDonTheoThang] (@ThangTaoHoaDon date)
	returns table
	as 
		return 
			select MaHoaDon as N'Mã Hóa Đơn', TienDien as N'Tiền Điện', TienNuoc as N'Tiền Nước',
					NgayTao as N'Ngày tạo hóa đơn' , TrangThai as N'Tình trạng thanh toán',
					MaPhong as N'Mã Phòng'
			from HoaDonDienNuoc
				where Month(@ThangTaoHoaDon) = Month(NgayTao) and YEAR(@ThangTaoHoaDon) = YEAR(NgayTao)

go
create function [dbo].[func_DanhSachNGQLQuanLyNhanVien] (@MaNQL char(10))
returns table
	as
		return 
			select nv1.MaNhanVien , nv1.TenNhanVien, nv1.SoDienThoai, nv1.GioiTinh, nv1.TonGiao, nv1.QuocTich, nv1.CMND_CCCD , nv1.ChucVu,
					nv1.MaNQL
				from NhanVien nv1 , NhanVien nv2
				where nv1.MaNQL = nv2.MaNhanVien and nv1.MaNQL = @MaNQL
				



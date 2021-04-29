CREATE TABLE DANGNHAP(
	MANDN VARCHAR(12) NOT NULL, --Mã người dùng
	TENDANGNHAP NVARCHAR(50) unique, --Tên đăng nhập
	MATKHAU NCHAR(50),
	CONSTRAINT PK_DANGNHAP PRIMARY KEY (MANDN)
)
CREATE TABLE THONGTIN_NGUOIDUNG(
	MAND VARCHAR(12) NOT NULL,
	TENND NVARCHAR(50),
	EMAIL VARCHAR(50),
	NGAYSINH DATE,
	MANDN VARCHAR(12),
	CONSTRAINT PK_THONGTIN_NGUOIDUNG PRIMARY KEY (MAND),
	CONSTRAINT FK_THONGTIN_NGUOIDUNG_DANGNHAP FOREIGN KEY (MANDN) REFERENCES DANGNHAP(MANDN)
)

CREATE TABLE NHOMLIENHE(
	MANHOM VARCHAR(12) NOT NULL,
	TENNHOMLH NVARCHAR(60),
	CONSTRAINT PK_NLH PRIMARY KEY (MANHOM)
)

CREATE TABLE DANHBA(
	MADB VARCHAR(12) NOT NULL,
	SDT VARCHAR(12) unique,
	TENDANHBA NVARCHAR(50), --Tên liên hệ
	EMAIL VARCHAR(50),
	GHICHU NVARCHAR(MAX),
	MANHOMLH VARCHAR(12), --NHÓM LIÊN HỆ: CÓ THỂ LÀ BẠN BÈ, ĐỒNG NGHIỆP, NULL
	CONSTRAINT PK_THONGTINLIENHE PRIMARY KEY (MADB),
	CONSTRAINT FK_THONGTINLIENHE_NHOMLH FOREIGN KEY (MANHOMLH) REFERENCES NHOMLIENHE(MANHOMLH)
)

CREATE TABLE THONGTINDANHBA(
	MANDN VARCHAR(12) NOT NULL,
	MADB VARCHAR(12) NOT NULL,
	NGAYLUU DATE,
	CONSTRAINT PK_THONGTINDANHBA PRIMARY KEY (MANDN,MADB),
	CONSTRAINT FK_THONGTINDANHBA_DANGNHAP FOREIGN KEY (MANDN) REFERENCES DANGNHAP(MANDN),
	CONSTRAINT FK_THONGTINDANHBA_DANHBA FOREIGN KEY (MADB) REFERENCES DANHBA(MADB)
)

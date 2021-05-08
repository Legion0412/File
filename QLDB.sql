CREATE DATABASE QLDB
GO
USE QLDB
GO
CREATE TABLE DANGNHAP(
	MANDN CHAR(5) NOT NULL, --Mã người dùng
	TENDANGNHAP VARCHAR(50) unique, --Tên đăng nhập
	MATKHAU VARCHAR(50),
	TRANGTHAI VARCHAR(30),
	CONSTRAINT PK_DANGNHAP PRIMARY KEY (MANDN)
)
CREATE TABLE THONGTIN_NGUOIDUNG(
	MAND CHAR(5) NOT NULL,
	TENND NVARCHAR(50),
	EMAIL VARCHAR(50),
	NGAYSINH DATE,
	MANDN CHAR(5),
	CONSTRAINT PK_THONGTIN_NGUOIDUNG PRIMARY KEY (MAND),
	CONSTRAINT FK_THONGTIN_NGUOIDUNG_DANGNHAP FOREIGN KEY (MANDN) REFERENCES DANGNHAP(MANDN)
)

CREATE TABLE NHOMLIENHE(
	MANHOM CHAR(5) NOT NULL,
	TENNHOMLH NVARCHAR(60),
	CONSTRAINT PK_NLH PRIMARY KEY (MANHOM)
)

CREATE TABLE DANHBA(
	MADB CHAR(5) NOT NULL,
	SDT VARCHAR(12),
	TENDANHBA NVARCHAR(50), --Tên liên hệ
	EMAIL VARCHAR(50),
	GHICHU NVARCHAR(MAX),
	MANHOMLH CHAR(5), --NHÓM LIÊN HỆ: CÓ THỂ LÀ BẠN BÈ, ĐỒNG NGHIỆP, NULL
	CONSTRAINT PK_THONGTINLIENHE PRIMARY KEY (MADB),
	CONSTRAINT FK_THONGTINLIENHE_NHOMLH FOREIGN KEY (MANHOMLH) REFERENCES NHOMLIENHE(MANHOM)
)

CREATE TABLE THONGTINDANHBA(
	MANDN CHAR(5) NOT NULL,
	MADB CHAR(5) NOT NULL,
	NGAYLUU DATE,
	CONSTRAINT PK_THONGTINDANHBA PRIMARY KEY (MANDN,MADB),
	CONSTRAINT FK_THONGTINDANHBA_DANGNHAP FOREIGN KEY (MANDN) REFERENCES DANGNHAP(MANDN),
	CONSTRAINT FK_THONGTINDANHBA_DANHBA FOREIGN KEY (MADB) REFERENCES DANHBA(MADB)
)
CREATE TABLE SAOLUUDANHBA(
	MANDN CHAR(5) NOT NULL,
	MADB CHAR(5) NOT NULL,
	NGAYLUU DATE,
	CONSTRAINT PK_SAOLUUDANHBA PRIMARY KEY (MANDN,MADB),
	CONSTRAINT FK_SAOLUUDANHBA_DANGNHAP FOREIGN KEY (MANDN) REFERENCES DANGNHAP(MANDN),
	CONSTRAINT FK_SAOLUUDANHBA_DANHBA FOREIGN KEY (MADB) REFERENCES DANHBA(MADB)
)
ALTER TABLE DANGNHAP 
ADD CONSTRAINT DF_TRANGTHAI DEFAULT 'DISCONNECT' FOR TRANGTHAI,
	CONSTRAINT DF_MANDN DEFAULT DBO.AUTO_IDDN() FOR MANDN

ALTER TABLE THONGTIN_NGUOIDUNG
ADD CONSTRAINT DF_MAND DEFAULT DBO.AUTO_IDND() FOR MAND

ALTER TABLE THONGTINDANHBA
ADD CONSTRAINT DF_MDB DEFAULT DBO.GETMAFROMDANHBA() FOR MADB,
	CONSTRAINT DF_NGAYLUU DEFAULT GETDATE() FOR NGAYLUU

ALTER TABLE DANHBA
ADD CONSTRAINT DF_MADB DEFAULT DBO.AUTO_IDDB() FOR MADB
 
ALTER TABLE NHOMLIENHE
ADD CONSTRAINT DF_MANLH DEFAULT DBO.AUTO_IDNLH() FOR MANHOM
-- check mã danh bạ
GO
CREATE PROC CKMADB(@mandn CHAR(5), @ma VARCHAR(12))
AS
	IF EXISTS(
		SELECT * 
		FROM THONGTINDANHBA
		WHERE MANDN=@mandn AND MADB=@ma
	) RETURN 1
	RETURN 0
GO
-- check DANHBA
GO
CREATE PROC CKDB(@mandn CHAR(5), @sdt VARCHAR(12))
AS
	IF EXISTS(
		SELECT * 
		FROM THONGTINDANHBA INNER JOIN DANHBA
			ON THONGTINDANHBA.MADB = DANHBA.MADB
		WHERE MANDN=@mandn AND SDT=@sdt
	) RETURN 1
	RETURN 0
GO
-- check nhóm liên hệ
GO
CREATE PROC CKNLH(@mandn CHAR(5), @tenNhomLH NVARCHAR(60))
AS
	IF EXISTS(
		SELECT * 
		FROM THONGTINDANHBA INNER JOIN DANHBA
			ON THONGTINDANHBA.MADB = DANHBA.MADB INNER JOIN NHOMLIENHE
			ON DANHBA.MANHOMLH=NHOMLIENHE.MANHOM
		WHERE MANDN=@mandn AND TENNHOMLH=@tenNhomLH
	) RETURN 1
	RETURN 0
GO
-- check uid
GO
CREATE PROC CKUID(@username NVARCHAR(50))
AS
	IF EXISTS(SELECT * FROM DANGNHAP WHERE TENDANGNHAP=@username) RETURN 1
	RETURN 0
GO
-- check đăng nhập
GO
CREATE PROC CKDANGNHAP(@username NVARCHAR(50), @pwd NVARCHAR(50))
AS
	IF NOT EXISTS(SELECT * FROM DANGNHAP WHERE TENDANGNHAP=@username) RETURN 0
	IF @pwd = (SELECT MATKHAU FROM DANGNHAP WHERE TENDANGNHAP=@username) RETURN 1
	RETURN 0
GO
declare @ma char(5)=  dbo.GETMANDN()
print @ma
-- LẤY MANDN
GO
CREATE FUNCTION GETUID(@maNDN CHAR(5))
RETURNS VARCHAR(50) 
AS
BEGIN
	DECLARE @UID VARCHAR(50) 
	SELECT @UID=TENDANGNHAP FROM DANGNHAP WHERE MANDN=@maNDN
	RETURN @UID
END
GO
-- LẤY MÃ DANH BA TỪ BẢNG DANH BẠ MỚI TẠO
CREATE FUNCTION GETMAFROMDANHBA()
RETURNS VARCHAR(50) 
AS
BEGIN
	DECLARE @maDB VARCHAR(50) 
	SELECT TOP(1)@maDB=MADB FROM DANHBA ORDER BY MADB DESC
	RETURN @maDB
END
--lấy username online
GO
CREATE FUNCTION GETMANDN(@uid VARCHAR(50))
RETURNS CHAR(5)
AS
BEGIN
	DECLARE @MANDN CHAR(5)
	SELECT @MANDN=MANDN FROM DANGNHAP WHERE TENDANGNHAP=@uid
	RETURN @MANDN
END
GO
-- MÃ NHÓM
CREATE FUNCTION GETMANLH(@maNDN CHAR(5), @tenNLH NVARCHAR(60))
RETURNS CHAR(5)
AS
BEGIN
	DECLARE @MANLH CHAR(5)
	SELECT @MANLH=MANHOM 
	FROM THONGTINDANHBA INNER JOIN DANHBA
			ON THONGTINDANHBA.MADB = DANHBA.MADB INNER JOIN NHOMLIENHE
			ON DANHBA.MANHOMLH=NHOMLIENHE.MANHOM
	WHERE MANDN=@mandn AND TENNHOMLH=@tenNLH
	RETURN @MANLH
END
GO
CREATE FUNCTION AUTO_IDDB()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MADB) FROM DANHBA) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MADB, 3)) FROM DANHBA
		SELECT @ID = CASE
			WHEN @ID >=  0 and @ID < 9 THEN 'DB00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >=  9 THEN 'DB0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 THEN 'DB' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
CREATE FUNCTION AUTO_IDND()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MAND) FROM THONGTIN_NGUOIDUNG) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MAND, 3)) FROM THONGTIN_NGUOIDUNG
		SELECT @ID = CASE
			WHEN @ID >=  0 and @ID < 9 THEN 'KH00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >=  9 THEN 'UN0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 THEN 'UN' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
CREATE FUNCTION AUTO_IDDN()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MANDN) FROM DANGNHAP) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MANDN, 3)) FROM DANGNHAP
		SELECT @ID = CASE
			WHEN @ID >=  0 and @ID < 9 THEN 'DN00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >=  9 THEN 'DN0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 THEN 'DN' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
CREATE FUNCTION AUTO_IDNLH()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MANHOM) FROM NHOMLIENHE) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MANHOM, 3)) FROM NHOMLIENHE
		SELECT @ID = CASE
			WHEN @ID >=  0 and @ID < 9 THEN 'LH00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >=  9 THEN 'LH0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 THEN 'LH' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END

GO
CREATE TRIGGER CKTENNHOMLH ON NHOMLIENHE
INSTEAD OF INSERT
AS
	DECLARE @TENNHOMLH NVARCHAR(60) = (SELECT TENNHOMLH FROM inserted)
	IF NOT EXISTS(SELECT * FROM NHOMLIENHE WHERE TENNHOMLH=@TENNHOMLH)
GO


SELECT * FROM DANGNHAP
SELECT * FROM DANHBA
SELECT * FROM THONGTINDANHBA
SELECT * FROM NHOMLIENHE
SELECT * FROM THONGTIN_NGUOIDUNG ORDER BY MAND DESC
UPDATE THONGTIN_NGUOIDUNG SET MANDN='DN002'
WHERE MAND=(SELECT TOP(1) MAND FROM THONGTIN_NGUOIDUNG ORDER BY MAND DESC)

SELECT TOP(1) MANHOM FROM NHOMLIENHE ORDER BY MANHOM DESC

SELECT DANHBA.* FROM THONGTINDANHBA INNER JOIN DANHBA ON THONGTINDANHBA.MADB=DANHBA.MADB WHERE MANDN='DN001'

SELECT THONGTINDANHBA.* FROM NHOMLIENHE INNER JOIN DANHBA ON NHOMLIENHE.MANHOM=DANHBA.MANHOMLH INNER JOIN THONGTINDANHBA ON DANHBA.MADB=THONGTINDANHBA.MADB WHERE MANDN='DN001'
SELECT DISTINCT * FROM NHOMLIENHE INNER JOIN DANHBA ON NHOMLIENHE.MANHOM=DANHBA.MANHOMLH INNER JOIN THONGTINDANHBA ON DANHBA.MADB=THONGTINDANHBA.MADB WHERE MANDN='DN002'

SELECT DANHBA.*, NGAYLUU FROM NHOMLIENHE INNER JOIN DANHBA ON NHOMLIENHE.MANHOM=DANHBA.MANHOMLH INNER JOIN THONGTINDANHBA ON DANHBA.MADB=THONGTINDANHBA.MADB WHERE MANDN='DN001'

SELECT * FROM SAOLUUDANHBA inner join DANHBA on SAOLUUDANHBA.MADB=DANHBA.MADB
DELETE SAOLUUDANHBA  WHERE MANDN='DN001'

print dbo.GETMANDN( 'admin')
/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.5.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: btl
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `DichVu`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DichVu` (
  `maDichVu` char(255) NOT NULL,
  `tenDichVu` char(255) DEFAULT NULL,
  `donGia` float DEFAULT NULL,
  PRIMARY KEY (`maDichVu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DichVu`
--

LOCK TABLES `DichVu` WRITE;
/*!40000 ALTER TABLE `DichVu` DISABLE KEYS */;
INSERT INTO `DichVu` VALUES
('dien','Điện hàng tháng',50000),
('giatla','Giặt là',40000),
('internet','Internet',120000),
('nuoc','Nước hàng tháng',2500);
/*!40000 ALTER TABLE `DichVu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HoaDon`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HoaDon` (
  `maHoaDon` char(255) NOT NULL,
  `thang` int DEFAULT NULL,
  `nam` int DEFAULT NULL,
  `tongTien` float DEFAULT NULL,
  `SinhVienmaSInhVien` char(255) NOT NULL,
  PRIMARY KEY (`maHoaDon`),
  KEY `FKHoaDon442829` (`SinhVienmaSInhVien`),
  CONSTRAINT `FKHoaDon442829` FOREIGN KEY (`SinhVienmaSInhVien`) REFERENCES `SinhVien` (`maSInhVien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HoaDon`
--

LOCK TABLES `HoaDon` WRITE;
/*!40000 ALTER TABLE `HoaDon` DISABLE KEYS */;
/*!40000 ALTER TABLE `HoaDon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HopDongThuePhong`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HopDongThuePhong` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ngayBatDau` date DEFAULT NULL,
  `ngayKetThuc` date DEFAULT NULL,
  `SinhVienmaSInhVien` char(255) NOT NULL,
  `PhongmaPhong` char(255) NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKHopDongThu825893` (`PhongmaPhong`),
  KEY `FKHopDongThu671245` (`SinhVienmaSInhVien`),
  CONSTRAINT `FKHopDongThu671245` FOREIGN KEY (`SinhVienmaSInhVien`) REFERENCES `SinhVien` (`maSInhVien`),
  CONSTRAINT `FKHopDongThu825893` FOREIGN KEY (`PhongmaPhong`) REFERENCES `Phong` (`maPhong`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HopDongThuePhong`
--

LOCK TABLES `HopDongThuePhong` WRITE;
/*!40000 ALTER TABLE `HopDongThuePhong` DISABLE KEYS */;
INSERT INTO `HopDongThuePhong` VALUES
(1,'2024-06-01','2024-12-31','B19DCCN443','101',1),
(2,'2024-06-01','2024-12-31','B20DCCN443','102',1),
(3,'2024-06-01','2024-12-31','B21DCCN443','101',1),
(4,'2024-06-01','2024-12-31','B22DCCN443','102',1);
/*!40000 ALTER TABLE `HopDongThuePhong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KTX`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `KTX` (
  `id` int NOT NULL AUTO_INCREMENT,
  `diaDiem` char(255) NOT NULL,
  `trangThaiHoatDong` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KTX`
--

LOCK TABLES `KTX` WRITE;
/*!40000 ALTER TABLE `KTX` DISABLE KEYS */;
INSERT INTO `KTX` VALUES
(1,'Tòa B2 học viện',1);
/*!40000 ALTER TABLE `KTX` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Khach`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Khach` (
  `cccd` char(32) NOT NULL,
  `hoTen` char(255) DEFAULT NULL,
  `ngayDenChoi` date DEFAULT NULL,
  `SinhVienmaSInhVien` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cccd`),
  KEY `FKKhach826350` (`SinhVienmaSInhVien`),
  CONSTRAINT `FKKhach826350` FOREIGN KEY (`SinhVienmaSInhVien`) REFERENCES `SinhVien` (`maSInhVien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Khach`
--

LOCK TABLES `Khach` WRITE;
/*!40000 ALTER TABLE `Khach` DISABLE KEYS */;
/*!40000 ALTER TABLE `Khach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LoaiPhong`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LoaiPhong` (
  `maLoaiPhong` char(255) NOT NULL,
  `ten` char(255) NOT NULL,
  `giaChung` float DEFAULT NULL,
  `ghiChu` char(255) DEFAULT NULL,
  `id` int DEFAULT NULL,
  PRIMARY KEY (`maLoaiPhong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoaiPhong`
--

LOCK TABLES `LoaiPhong` WRITE;
/*!40000 ALTER TABLE `LoaiPhong` DISABLE KEYS */;
INSERT INTO `LoaiPhong` VALUES
('thuong','Thường',300000,NULL,1);
/*!40000 ALTER TABLE `LoaiPhong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LuotGuiXe`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LuotGuiXe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `thoiGianGui` date NOT NULL,
  `thoiGianLay` date NOT NULL,
  `SinhVienmaSInhVien` char(255) NOT NULL,
  `VeXeThangid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKLuotGuiXe34001` (`VeXeThangid`),
  KEY `FKLuotGuiXe731882` (`SinhVienmaSInhVien`),
  CONSTRAINT `FKLuotGuiXe34001` FOREIGN KEY (`VeXeThangid`) REFERENCES `VeXeThang` (`id`),
  CONSTRAINT `FKLuotGuiXe731882` FOREIGN KEY (`SinhVienmaSInhVien`) REFERENCES `SinhVien` (`maSInhVien`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LuotGuiXe`
--

LOCK TABLES `LuotGuiXe` WRITE;
/*!40000 ALTER TABLE `LuotGuiXe` DISABLE KEYS */;
INSERT INTO `LuotGuiXe` VALUES
(1,'2024-09-01','2024-09-01','B19DCCN443',1),
(2,'2024-09-01','2024-09-01','B20DCCN443',2),
(3,'2024-09-01','2024-09-01','B19DCCN443',1),
(4,'2024-09-01','2024-09-01','B20DCCN443',2),
(5,'2024-09-01','2024-09-01','B21DCCN443',3),
(6,'2024-09-01','2024-09-01','B22DCCN443',4),
(7,'2024-09-02','2024-09-02','B19DCCN443',1),
(8,'2024-09-02','2024-09-02','B20DCCN443',2),
(9,'2024-09-02','2024-09-02','B21DCCN443',3),
(10,'2024-09-02','2024-09-02','B22DCCN443',4),
(11,'2024-09-03','2024-09-03','B19DCCN443',1),
(12,'2024-09-04','2024-09-04','B20DCCN443',2),
(13,'2024-09-04','2024-09-04','B21DCCN443',3),
(14,'2024-09-03','2024-09-03','B22DCCN443',4),
(15,'2024-09-03','2024-09-03','B22DCCN443',4),
(16,'2024-09-04','2024-09-04','B21DCCN443',3),
(17,'2024-09-04','2024-09-04','B20DCCN443',2),
(18,'2024-09-03','2024-09-03','B19DCCN443',1),
(19,'2024-09-03','2024-09-03','B19DCCN443',1),
(20,'2024-09-04','2024-09-04','B20DCCN443',2),
(21,'2024-09-04','2024-09-04','B21DCCN443',3),
(22,'2024-09-03','2024-09-03','B22DCCN443',4),
(23,'2024-09-03','2024-09-03','B19DCCN443',1),
(24,'2024-09-03','2024-09-03','B19DCCN443',1),
(25,'2024-09-03','2024-09-03','B19DCCN443',1);
/*!40000 ALTER TABLE `LuotGuiXe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Phong`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Phong` (
  `id` int DEFAULT NULL,
  `maPhong` char(255) NOT NULL,
  `soNguoiToiDa` int DEFAULT NULL,
  `soNguoiHienTai` int DEFAULT NULL,
  `giaPhong` float DEFAULT NULL,
  `moTa` char(255) DEFAULT NULL,
  `ghiChu` char(255) DEFAULT NULL,
  `LoaiPhongmaLoaiPhong` char(255) NOT NULL,
  `KTXid` int NOT NULL,
  PRIMARY KEY (`maPhong`),
  KEY `FKPhong22841` (`KTXid`),
  KEY `FKPhong379194` (`LoaiPhongmaLoaiPhong`),
  CONSTRAINT `FKPhong22841` FOREIGN KEY (`KTXid`) REFERENCES `KTX` (`id`),
  CONSTRAINT `FKPhong379194` FOREIGN KEY (`LoaiPhongmaLoaiPhong`) REFERENCES `LoaiPhong` (`maLoaiPhong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Phong`
--

LOCK TABLES `Phong` WRITE;
/*!40000 ALTER TABLE `Phong` DISABLE KEYS */;
INSERT INTO `Phong` VALUES
(1,'101',12,3,300000,'Phong mới',NULL,'thuong',1),
(2,'102',12,5,3000000,'Phòng mới','','thuong',1),
(3,'104',12,7,3000000,'Phòng mới','','thuong',1),
(4,'105',12,9,3000000,'Phòng mới','','thuong',1);
/*!40000 ALTER TABLE `Phong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SinhVien`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SinhVien` (
  `id` int DEFAULT NULL,
  `maSInhVien` char(255) NOT NULL,
  `hoTen` char(255) DEFAULT NULL,
  `ngaySinh` date DEFAULT NULL,
  `queQuan` char(255) DEFAULT NULL,
  `sdt` char(31) DEFAULT NULL,
  `lop` char(63) DEFAULT NULL,
  `gioiTinh` char(31) DEFAULT NULL,
  `cccd` char(31) DEFAULT NULL,
  `ghiChu` char(255) DEFAULT NULL,
  PRIMARY KEY (`maSInhVien`),
  UNIQUE KEY `cccd` (`cccd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SinhVien`
--

LOCK TABLES `SinhVien` WRITE;
/*!40000 ALTER TABLE `SinhVien` DISABLE KEYS */;
INSERT INTO `SinhVien` VALUES
(1,'B19DCCN443','Trần Quang Minh','2001-02-02','Hà Nội','0986659886','D19CQCN11-B','Nam','023665553224',''),
(2,'B20DCCN443','Trần Thị Hạnh','2002-03-03','Hà Nội','0365569004','D20','Nữ','0215152654265','D20DCCN443'),
(3,'B21DCCN443','Ngô Lan Hương','2003-04-04','Hà nội','0265587156','D22','Nữ','021233658825',''),
(4,'B22DCCN443','Ngô Lan Hương','2003-04-04','Hà nội','0265587156','D22','Nữ','0458556525546','');
/*!40000 ALTER TABLE `SinhVien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SuDungDichVu`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SuDungDichVu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `thoiGianSuDung` date DEFAULT NULL,
  `soLuong` int NOT NULL,
  `thanhTien` float DEFAULT NULL,
  `SinhVienmaSInhVien` char(255) NOT NULL,
  `DichVumaDichVu` char(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKSuDungDich683762` (`DichVumaDichVu`),
  KEY `FKSuDungDich881804` (`SinhVienmaSInhVien`),
  CONSTRAINT `FKSuDungDich683762` FOREIGN KEY (`DichVumaDichVu`) REFERENCES `DichVu` (`maDichVu`),
  CONSTRAINT `FKSuDungDich881804` FOREIGN KEY (`SinhVienmaSInhVien`) REFERENCES `SinhVien` (`maSInhVien`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SuDungDichVu`
--

LOCK TABLES `SuDungDichVu` WRITE;
/*!40000 ALTER TABLE `SuDungDichVu` DISABLE KEYS */;
INSERT INTO `SuDungDichVu` VALUES
(1,'2024-09-01',1,0,'B19DCCN443','nuoc'),
(2,'2024-09-01',30,0,'B19DCCN443','dien'),
(3,'2024-09-01',1,0,'B19DCCN443','internet'),
(4,'2024-09-01',1,0,'B20DCCN443','internet'),
(5,'2024-09-01',1,0,'B21DCCN443','internet'),
(6,'2024-09-01',1,0,'B22DCCN443','internet'),
(7,'2024-09-01',2,0,'B22DCCN443','nuoc'),
(8,'2024-09-01',2,0,'B21DCCN443','nuoc'),
(9,'2024-09-01',2,0,'B20DCCN443','nuoc'),
(10,'2024-09-01',43,0,'B20DCCN443','dien'),
(11,'2024-09-01',57,0,'B21DCCN443','dien'),
(12,'2024-09-01',36,0,'B22DCCN443','dien'),
(13,'2024-09-01',5,0,'B22DCCN443','giatla'),
(14,'2024-09-20',5,0,'B22DCCN443','giatla'),
(15,'2024-09-23',4,0,'B21DCCN443','giatla'),
(16,'2024-09-14',6,0,'B21DCCN443','giatla');
/*!40000 ALTER TABLE `SuDungDichVu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VeXeThang`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VeXeThang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bienSoXe` char(31) NOT NULL,
  `ngayBatDau` date DEFAULT NULL,
  `ngayKetThuc` date DEFAULT NULL,
  `SinhVienmaSInhVien` char(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKVeXeThang826350` (`SinhVienmaSInhVien`),
  CONSTRAINT `FKVeXeThang826350` FOREIGN KEY (`SinhVienmaSInhVien`) REFERENCES `SinhVien` (`maSInhVien`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VeXeThang`
--

LOCK TABLES `VeXeThang` WRITE;
/*!40000 ALTER TABLE `VeXeThang` DISABLE KEYS */;
INSERT INTO `VeXeThang` VALUES
(1,'88F1-00203','2024-09-01','2024-12-01','B19DCCN443'),
(2,'30X2-5457','2024-09-01','2025-09-01','B20DCCN443'),
(3,'29V1-2239','2024-09-01','2025-09-01','B21DCCN443'),
(4,'29V1-18273','2024-09-01','2025-09-01','B22DCCN443');
/*!40000 ALTER TABLE `VeXeThang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'btl'
--

--
-- Dumping routines for database 'btl'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-09-28 19:45:34

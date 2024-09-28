package btl;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MySQLConnection {

    static Connection getConnection(String url, String user, String password) {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url, user, password);
            System.out.println("Successfully connected to the database!");
        } catch (SQLException e) {
            System.out.println("Connection failed. Error: " + e.getMessage());
        }
        return connection;
    }

    static ResultSet getValue1(Connection conn) {
        ResultSet rs = null;
        String query = """
                select sv.maSInhVien,sv.hoTen,p.maPhong, SUM(sddv.soLuong*dv.donGia) +  AVG(p.giaPhong )+IF(COUNT(lgx.SinhVienmaSInhVien)>2,(COUNT(lgx.SinhVienmaSInhVien)-2)*3000, 0) as tong
                from  SuDungDichVu sddv
                LEFT JOIN SinhVien sv
                on sv.maSInhVien = sddv.SinhVienmaSInhVien and MONTH(sddv.thoiGianSuDung) = MONTH(NOW()) and YEAR(sddv.thoiGianSuDung) = YEAR(NOW())
                LEFT JOIN DichVu dv 
                on sddv.DichVumaDichVu  = dv.maDichVu
                left join LuotGuiXe lgx 
                on lgx.SinhVienmaSInhVien  = sv.maSInhVien and MONTH(lgx.thoiGianGui) = MONTH(NOW())
                left join HopDongThuePhong hdtp 
                on hdtp.SinhVienmaSInhVien = sv.maSInhVien and hdtp.active = true 
                left join Phong p 
                on p.maPhong = hdtp.PhongmaPhong 
                group by sv.maSInhVien, p.maPhong
                """;
        try {
            Statement stmt = (Statement) conn.createStatement();
            rs = (ResultSet) stmt.executeQuery(query);
        } catch (SQLException e) {
            System.out.println("Connection failed. Error: " + e.getMessage());
        }
        return rs;
    }

    static ResultSet getValue2(Connection conn) {
        ResultSet rs = null;
        String query = """
                select sv.maSInhVien, sv.hoTen , dv.maDichVu , dv.tenDichVu,  SUM(sddv.soLuong*dv.donGia) as tong
                from SuDungDichVu sddv
                left join  SinhVien sv
                on sv.maSInhVien = sddv.SinhVienmaSInhVien and sddv.thoiGianSuDung >= '2024-09-01' and sddv.thoiGianSuDung < '2024-09-31'
                left join DichVu dv 
                on sddv.DichVumaDichVu  = dv.maDichVu
                group by sv.maSInhVien, dv.maDichVu
                order by sv.maSInhVien
                """;
        try {
            Statement stmt = (Statement) conn.createStatement();
            rs = (ResultSet) stmt.executeQuery(query);
        } catch (SQLException e) {
            System.out.println("Connection failed. Error: " + e.getMessage());
        }
        return rs;
    }

    static ResultSet getValue3(Connection conn) {
        ResultSet rs = null;
        String query = """
                select k.hoTen ,k.cccd ,sv.maSInhVien , sv.hoTen, COUNT(k.cccd) as soLan
                from Khach k
                left join SinhVien sv 
                on sv.maSInhVien = k.SinhVienmaSInhVien and MONTH(k.ngayDenChoi) = MONTH(NOW()) and YEAR(k.ngayDenChoi) = YEAR(NOW())
                group by k.cccd, sv.maSInhVien
                """;
        try {
            Statement stmt = (Statement) conn.createStatement();
            rs = (ResultSet) stmt.executeQuery(query);
        } catch (SQLException e) {
            System.out.println("Connection failed. Error: " + e.getMessage());
        }
        return rs;
    }

    static ResultSet getValue4(Connection conn) {
        ResultSet rs = null;
        String query = """
                select dv.maDichVu , dv.tenDichVu , SUM(dv.donGia * sddv.soLuong) as doanhThu
                from DichVu dv 
                left join SuDungDichVu sddv 
                on sddv.DichVumaDichVu  = dv.maDichVu and MONTH(sddv.thoiGianSuDung) = MONTH(NOW())
                group by dv.maDichVu
                """;
        try {
            Statement stmt = (Statement) conn.createStatement();
            rs = (ResultSet) stmt.executeQuery(query);
        } catch (SQLException e) {
            System.out.println("Connection failed. Error: " + e.getMessage());
        }
        return rs;
    }

    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/btl?allowPublicKeyRetrieval=true";
        String user = "root";
        String password = "ript";

        Connection conn = getConnection(url, user, password);
        Scanner scanner = new Scanner(System.in);
        String choseOption = """
                    Chose option:
                    1. Liệt kê thông tin sinh viên , tiền cần đóng theo tháng
                    2. Liệt kê thông tin sinh viên và các dịch vụ từ ngày bắt đầu tới ngày kết thúc
                    3. Liệt kê khách tới thăm sinh viên và tần suất theo tuần hoặc tháng
                    4. Liệt kê các dịch vụ kinh doanh cùng doanh thu theo tháng
                """;
        if (conn != null) {
            while (true) {
                System.out.println(choseOption);
                int option = scanner.nextInt();
                try {
                    ResultSet datas = null;
                    switch (option) {
                        case 1:
                            System.out.format("Nhập tháng-năm: ");
                            datas = getValue1(conn);
                            System.out.format("Mã sinh viên, Tên sinh viên, Phòng, Thành tiền\n");
                            while (datas.next()) {
                                String maSInhVien = datas.getString("maSInhVien");
                                String hoTen = datas.getString("hoTen");
                                String maPhong = datas.getString("maPhong");
                                float tong = datas.getFloat("tong");
                                // print the results
                                if (maSInhVien != null)
                                    System.out.format("%s, %s, %s, %.0f \n", maSInhVien, hoTen, maPhong, tong);
                            }
                            break;
                        case 2:
                            datas = getValue2(conn);
                            System.out.format("Mã sinh viên, Tên sinh viên, Mã dịch vụ, Tên dịch vụ, Tổng thu\n");
                            while (datas.next()) {
                                String maSInhVien = datas.getString("maSInhVien");
                                String hoTen = datas.getString("hoTen");
                                String maDichVu = datas.getString("maDichVu");
                                String tenDichVu = datas.getString("tenDichVu");
                                float tong = datas.getFloat("tong");
                                // print the results
                                if (maSInhVien != null)
                                System.out.format("%s, %s, %s, %s, %.0f\n", maSInhVien, hoTen, maDichVu, tenDichVu, tong);
                            }
                            break;
                        case 3:
                            datas = getValue3(conn);
                            System.out.format("Tên khách, CCCD, Mã sinh viên, Tên sinh viên, Số lần thăm\n");
                            while (datas.next()) {
                                String tenKhach = datas.getString("tenKhach");
                                String cccd = datas.getString("cccd");
                                String maSInhVien = datas.getString("maSInhVien");
                                String hoTen = datas.getString("hoTen");
                                int soLan = datas.getInt("soLan");
                                // print the results
                                if (maSInhVien != null)
                                    System.out.format("%s, %s, %s, %s, %d\n", tenKhach, cccd, maSInhVien, hoTen, soLan);
                            }
                            break;
                        case 4:
                            datas = getValue4(conn);
                            System.out.format("Mã dịch vụ, Tên dịch vụ, Doanh thu\n");
                            while (datas.next()) {
                                String maDichVu = datas.getString("maDichVu");
                                String tenDichVu = datas.getString("tenDichVu");
                                float doanhThu = datas.getFloat("doanhThu");
                                // print the results
                                if (maDichVu != null)
                                    System.out.format("%s, %s, %.0f\n", maDichVu, tenDichVu, doanhThu);
                            }
                            break;
                        default:
                            break;
                    }
                } catch (SQLException e) {
                    System.out.println("Connection failed. Error: " + e.getMessage());
                }
            }
        } else {
            System.out.println("Connection failed");
        }

    }
}
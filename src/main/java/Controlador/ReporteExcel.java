import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import servicios.conexiones.conexionBD;

@WebServlet("/ReporteExcel")
public class ReporteExcel extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=clientes.xlsx");

        try (OutputStream out = response.getOutputStream()) {
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Clientes");

            // Encabezados
            Row headerRow = sheet.createRow(0);
            String[] columnHeadings = {"Usuario", "Contraseña", "DNI", "Correo Electrónico", "Fecha de Nacimiento"};
            for (int i = 0; i < columnHeadings.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columnHeadings[i]);
                CellStyle headerCellStyle = workbook.createCellStyle();
                headerCellStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());
                headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
                cell.setCellStyle(headerCellStyle);
            }

            // Obtener los datos de la base de datos
            String query = "SELECT usuario, contra, dniLog, correoLog, fechaNaci FROM login WHERE rol = 'cliente'";
            try (Connection conn = new conexionBD().getConexion();
                 PreparedStatement ps = conn.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {

                int rowNum = 1;
                while (rs.next()) {
                    Row row = sheet.createRow(rowNum++);

                    row.createCell(0).setCellValue(rs.getString("usuario"));
                    row.createCell(1).setCellValue(rs.getString("contra"));
                    row.createCell(2).setCellValue(rs.getString("dniLog"));
                    row.createCell(3).setCellValue(rs.getString("correoLog"));
                    row.createCell(4).setCellValue(rs.getString("fechaNaci"));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            // Autosize columns
            for (int i = 0; i < columnHeadings.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
            workbook.close();
        }
    }
}

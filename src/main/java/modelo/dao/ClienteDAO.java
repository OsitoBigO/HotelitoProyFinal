/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.Cliente;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import servicios.conexiones.conexionBD;

/**
 *
 * @author LAB-USR-LNORTE
 */
public class ClienteDAO {

    Connection cnx;
    servicios.conexiones.conexionBD cn = new conexionBD();
    PreparedStatement ps;
    ResultSet rs;

    public List listar() {
        List<Cliente> clientes = new ArrayList();
        String sql = "select * from login";
        try {
            cnx = cn.getConexion();
            ps = cnx.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Cliente p = new Cliente();
                p.setIdCliente(rs.getInt(1));
                p.setDni(rs.getString(2));
                p.setNombres(rs.getString(3));
                p.setDireccion(rs.getString(4));
                p.setEmail(rs.getString(5));
                p.setPassword(rs.getString(6));
                clientes.add(p);

            }
        } catch (Exception e) {

        }
        return clientes;
    }

    public ByteArrayInputStream exportarExcel() throws IOException {
        // Chicana

        Workbook workbook = new HSSFWorkbook();
        ByteArrayOutputStream flujo = new ByteArrayOutputStream();
        Sheet hoja = (Sheet) workbook.createSheet("cliente");

        // Chicana
        Row filaTitulo = hoja.createRow(0);
        Cell celda = filaTitulo.createCell(0);
        celda.setCellValue("Lista de Clientes");

        Row filaData = hoja.createRow(2);
        String[] cols = {"idCliente", "Dni", "Nombres", "Direccion","Email","Password"};
        for (int i = 0; i < cols.length; i++) {
            celda = filaData.createCell(i);
            celda.setCellValue(cols[i]);
        }
        List<Cliente> lista = this.listar();
        int fila = 3;
        for (Cliente m : lista) {
            filaData = hoja.createRow(fila);
            filaData.createCell(0).setCellValue(m.getIdCliente());
            filaData.createCell(1).setCellValue(m.getDni());
            filaData.createCell(2).setCellValue(m.getNombres());
            filaData.createCell(3).setCellValue(m.getDireccion());
            filaData.createCell(4).setCellValue(m.getEmail());
            filaData.createCell(5).setCellValue(m.getPassword());

            fila++;
        }
        workbook.write(flujo);
        workbook.close();
        return new ByteArrayInputStream(flujo.toByteArray());
    }

}

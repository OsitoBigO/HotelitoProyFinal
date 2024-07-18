package Controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import servicios.conexiones.conexionBD;

@WebServlet(name = "ControladorLogin", urlPatterns = {"/ControladorLogin"})
public class ControladorLogin extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("usuario");
        String password = request.getParameter("contra");

        // Verificar las credenciales en la base de datos
        String rol = validateAndGetRole(username, password);

        if (rol != null) {
            // Redirigir según el rol
            if (rol.equals("admin")) {
                response.sendRedirect("index.jsp");
            } else if (rol.equals("cliente")) {
                response.sendRedirect("Cliente.jsp");
            }
        } else {
            // Login fallido, mostrar mensaje de error
            request.setAttribute("mensaje", "Datos no válidos, intente nuevamente.");
            request.getRequestDispatcher("vista/login.jsp").forward(request, response);
        }
    }

    private String validateAndGetRole(String username, String password) {
        String query = "SELECT rol FROM login WHERE usuario = ? AND contra = ?";
        try (Connection conn = new conexionBD().getConexion();
             PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, password);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getString("rol");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String username = request.getParameter("usuario");
    String password = request.getParameter("contra");
    String dni = request.getParameter("dniLog");
    String correo = request.getParameter("correoLog");
    String fechaNaci = request.getParameter("fechaNaci");

    if (registerUser(username, password, dni, correo, fechaNaci)) {
        response.sendRedirect("./vista/login.jsp");
    } else {
        response.sendRedirect("registro_fallido.jsp");
    }
}

   private boolean registerUser(String username, String password, String dni, String correo, String fechaNaci) {
    String query = "INSERT INTO login (usuario, contra, rol, dniLog, correoLog, fechaNaci) VALUES (?, ?, 'cliente', ?, ?, ?)";
    try (Connection conn = new conexionBD().getConexion();
         PreparedStatement statement = conn.prepareStatement(query)) {
        statement.setString(1, username);
        statement.setString(2, password);
        statement.setString(3, dni);
        statement.setString(4, correo);
        statement.setString(5, fechaNaci);
        int rowsInserted = statement.executeUpdate();
        return rowsInserted > 0;
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return false;
}
}

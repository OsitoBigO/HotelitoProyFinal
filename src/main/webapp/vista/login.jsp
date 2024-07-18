<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="<%= request.getContextPath()%>/css/Login.css" rel="stylesheet" type="text/css"/>
        <title>Login-Hotel Paradise</title>
    </head>
    <body>

        <form action="<%= request.getContextPath()%>/ControladorLogin" method="post">
            <h1>Hotel Paradise</h1>
            <input type="hidden" name="action" value="login">
            <label for="usuario">Usuario:</label>
            <input type="text" id="usuario" name="usuario" required><br><br>

            <label for="contra">Contraseña:</label>
            <input type="password" id="contra" name="contra" required><br><br>

            <input type="submit" value="Ingresar">
            <button class="agregar" type="button" onclick="location.href = '<%= request.getContextPath()%>/RegistroCliente.jsp'">Agregar Cliente</button>
        </form>
    </body>
</html>

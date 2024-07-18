<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="<%= request.getContextPath()%>/css/Login.css" rel="stylesheet" type="text/css"/>
        <title>Registro Cliente - Hotel Paradise</title>
    </head>
    <body>

        <form action="<%= request.getContextPath()%>/ControladorLogin" method="post">
            <h1>Registro de Cliente</h1>
            <input type="hidden" name="action" value="register">

            <label for="usuario">Usuario:</label>
            <input type="text" id="usuario" name="usuario" required><br><br>

            <label for="contra">Contraseña:</label>
            <input type="password" id="contra" name="contra" required><br><br>

            <label for="dniLog">DNI:</label>
            <input type="text" id="dniLog" name="dniLog" required><br><br>

            <label for="correoLog">Correo Electrónico:</label>
            <input type="text" id="correoLog" name="correoLog" required><br><br>

            <label for="fechaNaci">Fecha de Nacimiento:</label>

            <input type="text" id="fechaNaci" name="fechaNaci" required><br><br>

            <button class="agregar" type="button" onclick="window.location.href = '<%= request.getContextPath()%>/vista/login.jsp'">Ir a Login</button>
            <input type="submit" value="Registrar">

        </form>
    </body>
</html>

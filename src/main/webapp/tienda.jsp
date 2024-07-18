<%-- 
    Document   : tienda
    Created on : 16 jul 2024, 0:52:19
    Author     : USUARIO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Tienda</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="logoHotel.ico">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="icon" type="image/png" href="images/icons/favicon.png" />
        <script src="https://kit.fontawesome.com/15feb8d600.js" crossorigin="anonymous"></script>
        <link href="../CSS/productos.css" rel="stylesheet" type="text/css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.32/sweetalert2.min.js"
                integrity="sha512-3PL7jW3xI1EjF2Hfqwv5u6nKG/BnUbWytnJDhsY/q5CbIB5XzoHNhJvgmFeVD7xgC9DbKDm+gPP9uDAAfLAZUA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.32/sweetalert2.css"
              integrity="sha512-eRBMRR/qeSlGYAb6a7UVwNFgXHRXa62u20w4veTi9suM2AkgkJpjcU5J8UVcoRCw0MS096e3n716Qe9Bf14EyQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/home.css" rel="stylesheet" type="text/css"/>
        <script src="JS/productos.js" type="text/javascript"></script>
        <link href="css/nosotros.css" rel="stylesheet" type="text/css"/>
        <link href="css/productos.css" rel="stylesheet" type="text/css"/>
        <%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>
        <%@ page import="servicios.conexiones.conexionBD" %>
    </head>

    <body class="animsition">
        <nav>
            <div id="my-nav" class="menu-desktop">

                <!-- Logo desktop -->
                <!-- Menu desktop -->
                <ul class="main-menu">
                    <li class="nav-item active">
                        <a class="nav-link" href="Cliente.jsp">Home <span class="sr-only"></span></a>
                    </li>


                    <li class="nav-item active">
                        <a class="nav-link" href="nosotros.jsp">About <span class="sr-only"></span></a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="contact.jsp">contact <span class="sr-only"></span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="Controlador?accion=home">Reservas</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="tienda.jsp">Tienda <span class="sr-only"></span></a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="Controlador?accion=Carrito"><i class="fas fa-cart-plus">(<label style="color: brown">${contador}</label>)</i> Carrito</a>
                    </li>

                    
                    <!-- Icon header -->
                    <li class="nav-item active">
                    <a href="vista/login.jsp" class="logo3" data-notify="0">
                        <img src="IMAGES/PRINCIPAL/icon-inicio.png" alt="IMG-LOGO3" />
                    </a>    
                    </li>
                  
            </div>
        </nav>>
        
        <br>

        <!-- Productos -->
        <div class="row">
            <%
                Connection conexion = null;
                Statement statement = null;
                ResultSet resultSet = null;
                try {
                    // Usa la clase conexionBD para obtener la conexión
                    conexionBD db = new conexionBD();
                    conexion = db.getConexion();

                    statement = conexion.createStatement();
                    String query = "SELECT DISTINCT Categoria FROM tblproductos";
                    resultSet = statement.executeQuery(query);
                    while (resultSet.next()) {
                        String categoria = resultSet.getString("Categoria");
                        out.println("<h2>" + categoria + "</h2>");
                        Statement statementProductos = conexion.createStatement();
                        String queryProductos = "SELECT * FROM tblproductos WHERE Categoria = '" + categoria + "'";
                        ResultSet resultSetProductos = statementProductos.executeQuery(queryProductos);
                        out.println("<div class='product-container'>");
                        while (resultSetProductos.next()) {
                            String nombre = resultSetProductos.getString("Nombre");
                            String descripcion = resultSetProductos.getString("Descripcion");
                            String imagen = resultSetProductos.getString("Imagen");
                            double precio = resultSetProductos.getDouble("Precio");
                            int id = resultSetProductos.getInt("ID");

                            out.println("<div class='col-3'>");
                            out.println("<div class='card'>");
                            out.println("<div class='product-image'>");
                            out.println("<img title='" + nombre + "' src='PRODUCTOS/" + imagen + "' alt='" + nombre + "'>");
                            out.println("</div>");
                            out.println("<div class='card-body'>");
                            out.println("<h5 class='card-title'>" + nombre + "</h5>");
                            out.println("<p class='card-text'>" + descripcion + "</p>");
                            out.println("<p class='card-price'>S/" + precio + "</p>");
                            // Elimina la verificación de la sesión
                            out.println("</div>");
                            out.println("</div>");
                            out.println("</div>");
                        }
                        out.println("</div>");
                        resultSetProductos.close();
                        statementProductos.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) {
                            resultSet.close();
                        }
                        if (statement != null) {
                            statement.close();
                        }
                        if (conexion != null) {
                            conexion.close();
                        }
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            %>

        </div>

        <!-- mostrar el carrito -->
        <div id="carrito" style="display: none;">
            <ul id="lista-productos">
            </ul>
            <p><center>Total: S/.<span id="cart-total">0</span></center>
            <button id="vaciar-carrito">Vaciar Carrito</button> <!-- Botón para vaciar el carrito -->
            <button id="ver-carrito" onclick="mostrarSweetAlert()">Procesar</button>
            <script>
                function mostrarSweetAlert() {
                    Swal.fire({
                        title: '¿Deseas guardar los cambios?',
                        showDenyButton: true,
                        showCancelButton: true,
                        confirmButtonText: 'Guardar',
                        denyButtonText: `No guardar`
                    }).then((result) => {
                        /* Lee más acerca de isConfirmed, isDenied a continuación */
                        if (result.isConfirmed) {
                            Swal.fire('¡Compra realizada!', '', 'success').then(() => {
                                // Redirige a otra ventana o página después de guardar
                                window.location.href = 'index.jsp'; // Cambia 'nuevaPagina.html' por la URL que desees
                            });
                        } else if (result.isDenied) {
                            Swal.fire('La compra no se realizo!!', '', 'info');
                        }
                    });
                }
            </script>
        </div>
        <br><br><br>
        <!-- Footer -->
        <footer>
            <div class="footer-container">
                <div class="contact-info">
                    <h3>CONTACTANOS:</h3>
                    <p>Correo: <a href="mailto:info@hotelparadise.com">info@hotelparadise.com</a></p>
                    <p>Teléfono: <a href="tel:+5116104000">+51 1 610 4000</a></p>
                    <p>Dirección: Av. Canta Callao, San Martín de Porres 15112</p>
                </div>
                <div class="social-media">
                    <h3>REDES SOCIALES:</h3>
                    <a href="https://www.facebook.com/HotelParadise2016/?locale=es_LA">
                        <i class="fab fa-facebook"></i> Facebook
                    </a>
                    <a href="https://www.instagram.com/hotelparadise.peru/?hl=es">
                        <i class="fab fa-instagram"></i> Instagram
                    </a>
                    <h3>UBICANOS:</h3>
                    <a href="https://maps.app.goo.gl/mM8aNPLB1n8vP8R8A">
                        <i class="fas fa-map-marker-alt"></i> Google Maps
                    </a>
                </div>
                <div class="buttons">
                    <h3>OTRAS OPCIONES:</h3>
                    <a href="<%= request.getContextPath()%>/ControladorSugerencias?accion=principal">
                        <button class="suggestions">Formulario de Sugerencias</button>
                    </a>
                    <a href="<%= request.getContextPath()%>/ControladorReclamaciones?accion=principal">
                        <button class="complaints">Libro de Reclamaciones</button>
                    </a>
                    <a href="preguntasFrecuentes.jsp">
                        <button class="faq">Preguntas Frecuentes</button>
                    </a>
                </div>

            </div>
        </footer>
        <script src="../JS/productos.js" type="text/javascript"></script>
    </body>



</html>
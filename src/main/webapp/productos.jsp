<%-- 
    Document   : index
    Created on : 6 jun 2024, 2:19:42
    Author     : MOTITA2204
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Reserva Habitaciones</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP - 2024</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" integrity="sha512-vKMx8UnXk60zUwyUnUPM3HbQo8QfmNx7+ltw8Pm5zLusl1XIfwcxo8DbWCqMGKaWeNxWA8yrx5v3SaVpMvR3CA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/home.css" rel="stylesheet" type="text/css"/>
        <%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>
        <script src="JS/productos.js" type="text/javascript"></script>
        <link href="css/productos.css" rel="stylesheet" type="text/css"/>
        <%@ page import="servicios.conexiones.conexionBD" %>
    </head>
    <body>
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
                </ul>
            </div>
        </nav>>

        <div class="container mt-2">
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
                        String query = "SELECT * FROM cuartos";
                        resultSet = statement.executeQuery(query);

                        out.println("<div class='product-container'>");
                        while (resultSet.next()) {
                            int id = resultSet.getInt("ID");
                            String nombre = resultSet.getString("Nombre");
                            String descripcion = resultSet.getString("Descripcion");
                            String imagen = resultSet.getString("Foto");
                            double precio = resultSet.getDouble("Precio");
                            int stock = resultSet.getInt("Stock");

                            out.println("<div class='col-3'>");
                            out.println("<div class='card'>");
                            out.println("<div class='product-image'>");
                            out.println("<img title='" + nombre + "' src='ROOMS/" + imagen + "' alt='" + nombre + "'>");
                            out.println("</div>");
                            out.println("<div class='card-body'>");
                            out.println("<h5 class='card-title'>" + nombre + "</h5>");
                            out.println("<p class='card-text'>" + descripcion + "</p>");
                            out.println("<p class='card-price'>S/" + precio + "</p>");
                            if (stock > 0) {
                                out.println("<button class='btn btn-primary' name='btnAccion' data-nombre='" + nombre + "' data-precio='" + precio + "' data-id='" + id + "' type='button'>Agregar al carrito</button>");
                            } else {
                                out.println("<p class='out-of-stock'>Sin stock</p>");
                            }
                            out.println("</div>");
                            out.println("</div>");
                            out.println("</div>");
                        }
                        out.println("</div>");
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



        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>

</html>

<%-- 
    Document   : index2
    Created on : 11 jun. 2024, 08:41:06
    Author     : LAB-USR-LNORTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/listaSugerenciaAdmin.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="listadoMateriales">
            <table id="materialesTable" class="display">
                <thead>
                    <tr>
                        <th>Codigo</th>
                        <th>Nombre</th>
                        <th>Informacion</th>
                        <th>Correo</th>
                        <th>Tipo de Sugerencia</th>
                        <th>Opciones</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.21/js/jquery.dataTables.min.js" integrity="sha512-BkpSL20WETFylMrcirBahHfSnY++H2O1W+UnEEO4yNIl+jI2+zowyoGJpbtk6bx97fBXf++WJHSSK2MV4ghPcg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>        <script type="text/javascript">
            $(document).ready(function () {
               $.ajax({
                    url: '<%= request.getContextPath()%>/ControladorSugerencias?accion=listarSugerencias',
                    method: 'GET',
                    success: function (data) {
                        $('#materialesTable').DataTable({
                            data: data,
                            destroy: true,
                            columns: [
                                {data: 'idsugerencia'},
                                {data: 'nombresuge'},
                                {data: 'correosuge'},
                                {data: 'infosuge'},
                                {data: 'nombresugerencia.nombretiposuge'},
                                {
                                    data: null,
                                    render: function (data, type, row) {
                                        return '<button class="btn btn-primary btn-edit" data-id="' + row.idsugerencia + '">Editar</button>' +
                                                ' <button class="btn btn-danger btn-delete" data-id="' + row.idsugerencia + '">Eliminar</button>';
                                    },
                                    orderable: false,
                                    searchable: false
                                }
                            ]
                        });
                    },
                    error: function (error) {
                        console.error('Error fetching sugerencias:', error);
                    }
                });
            });

        </script>
       
    </body>
</html>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Citas</title>
    <!-- Include necessary CSS and JavaScript libraries -->
    <link rel="stylesheet" href="ruta_a_tu_bootstrap.css">
    <link rel="stylesheet" href="ruta_a_tu_datatables.css">
</head>
<body>
    <?php require_once "ParteSuperior_Vigilante.php"?>

    <div class="container">
        <h1 class="text-center mb-4">Citas</h1>
        <div class="row"></div>    
    </div>    
    <br>  

    <div class="container caja">
        <div class="row"> 
            <div class="col-lg-12">
                <div class="table-responsive">        
                    <table id="tablaCitas" class="table table-striped table-bordered table-condensed" style="width:100%">
                        <thead class="text-center">
                            <tr>
                                <th>id_Cita</th>
                                <th>Fecha_Cita</th>
                                <th>Hora_Cita</th>                                
                                <th>Descripcion</th>  
                                <th>id_Operador</th>
                                <th>Ruta</th>
                                <th>Transporte</th>
                                <th>Estado</th>
                                <th>Codigo_QR</th>
                                <th>Acciones</th>
                                
                            </tr>
                        </thead>
                        <tbody></tbody>        
                    </table>               
                </div>
            </div>
        </div>  
    </div>   

      <!-- Modal para mostrar detalles -->
<div class="modal fade" id="modalDetalles" tabindex="-1" role="dialog" aria-labelledby="modalDetallesLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalDetallesLabel">Detalles de la Cita</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Contenido del modal -->
                <div id="detallesCita"></div>
            </div>
            <div class="modal-body">
                <!-- Caja de Texto -->
                <input type="text" id="textoCita" class="form-control" placeholder="Ingresa texto aquí">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                <!-- Modifica el botón Guardar -->
                <button type="button" class="btn btn-primary" onclick="guardarTextoCita()">Guardar</button>
            </div>
        </div>
    </div>
</div>




    <?php require_once "ParteInferior.php"?>
</body>
</html>
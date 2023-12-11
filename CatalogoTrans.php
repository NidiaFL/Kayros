<?php require_once "ParteSuperior.php"?>
<!-- INICIO -->

<h2>CATALOGO TRANSPORTES</h2>
<br>    
   <div class="container">
        <div class="row">
            <div class="col-lg-12">            
            <button id="btnNuevo" type="button" class="btn btn-info" data-toggle="modal"><i class="material-icons">Nuevo</i></button>    
            </div>    
        </div>    
    </div>    
    <br>  

    <div class="container caja">
        <div class="row">
            <div class="col-lg-12">
            <div class="table-responsive">        
                <table id="tablaTransportes" class="table table-striped table-bordered table-condensed" style="width:100%" >
                    <thead class="text-center">
                        <tr>
                            <th>id Transportes</th>
                            <th>Año</th>
                            <th>Placas</th>                                
                            <th>Capacidad Carga</th>  
                            <th>Modelo</th>
                            <th>Numero Economico</th>
                            <th>Contenedor Asignado</th>
                            <th>Proveedores</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>                           
                    </tbody>        
                </table>               
            </div>
            </div>
        </div>  
    </div>   

<!--Modal para CRUD-->
<div class="modal fade" id="modalCRUDTrans" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
            </div>
        <form id="formTransportes">    
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-6">
                    <div class="form-group">
                    <label  class="col-form-label">Año:</label>
                    <input type="text" class="form-control" id="Ano">
                    </div>
                    </div>
                    <div class="col-lg-6">
                    <div class="form-group">
                    <label  class="col-form-label">Placas</label>
                    <input type="text" class="form-control" id="Placas">
                    </div> 
                    </div>    
                </div>
                <div class="row"> 
                    <div class="col-lg-6">
                    <div class="form-group">
                    <label  class="col-form-label">Capacidad Carga</label>
                    <input type="text" class="form-control" id="Capacidad_Carga">
                    </div>               
                    </div>
                    <div class="col-lg-6">
                    <div class="form-group">
                    <label class="col-form-label">Modelo</label>
                    <input type="text" class="form-control" id="Modelo">
                    </div>
                    </div>  
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                        <label  class="col-form-label">Número Economico</label>
                        <input type="text" class="form-control" id="Numero_Economico">
                        </div>
                    </div>    
                    <div class="col-lg-6">    
                        <div class="form-group">
                        <label  class="col-form-label">Contenedor Asignado</label>
                        <input type="text" class="form-control" id="Tipo_Contenedor_Asignado">
                        </div>            
                    </div>    
                </div> 
                <div class="form-group">
                    <label class="col-form-label">Proveedor Asignado</label>
                    <select class="form-control" id="Proveedor_id">
                        <!-- Opciones del select se cargarán dinámicamente -->
                    </select>
                </div>
               
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal">Cancelar</button>
                <button type="submit" id="btnGuardar" class="btn btn-dark">Guardar</button>
            </div>
        </form>    
        </div>
    </div>
</div>

<!-- Modal para mostrar proveedores asignados 
<div class="modal fade" id="modalProveedoresAsignados" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Proveedores Asignados a Transporte</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="proveedoresAsignadosTabla">
                     Los datos de los proveedores se mostrarán aquí 
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div> -->
      


 <!-- FIN --> 

    <?php require_once "ParteInferior.php"?>


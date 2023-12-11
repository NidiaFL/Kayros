<?php require_once "ParteSuperior.php"?>
<!-- INICIO -->

<div class="text-center"><h2>Usuarios</h2></div>
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
                <table id="tablaUsuarios" class="table table-striped table-bordered table-condensed" style="width:100%" >
                    <thead class="text-center">
                        <tr>
                            <th>id Usuario</th>
                            <th>Nombre</th>
                            <th>Apellido Paterno</th>              
                            <th>Apellido Materno</th>  
                            <th>Teléfono</th>
                            <th>Dirección</th>
                            <th>CURP</th>
                            <th>Licencia</th>
                            <th>Rol</th>
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

<!-- Modal para CRUD -->
<div class="modal fade" id="modalCRUDUsu" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <form id="formUsuarios">    
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">Nombre:</label>
                                <input type="text" class="form-control" id="Nombre" pattern="[A-Za-z]+" required>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">Apellido Paterno</label>
                                <input type="text" class="form-control" id="Apellido_Paterno" pattern="[A-Za-z]+" required>
                            </div> 
                        </div>    
                    </div>
                    <div class="row"> 
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">Apellido Materno</label>
                                <input type="text" class="form-control" id="Apellido_Materno" pattern="[A-Za-z]+" required>
                            </div>               
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">Telefono</label>
                                <input type="tel" class="form-control" id="Telefono" pattern="[0-9]+" required>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">Direccion</label>
                                <input type="text" class="form-control" id="Direccion" required>
                            </div>
                        </div>  
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">CURP</label>
                                <input type="text" class="form-control" id="CURP" pattern="[A-Za-z0-9]+" required>
                            </div>
                        </div>    
                        <div class="col-lg-6">    
                            <div class="form-group">
                                <label class="col-form-label">Licencia</label>
                                <input type="text" class="form-control" id="Licencia_de_conducir" pattern="[A-Za-z0-9]+" required>
                            </div>            
                        </div>    
                    </div> 
                    <div class="form-group">
                        <label class="col-form-label">Rol</label>
                        <select class="form-control" id="Rol_id" required>
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

<?php require_once "ParteInferior.php"?>

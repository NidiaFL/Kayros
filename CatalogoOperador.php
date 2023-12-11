<?php require_once "ParteSuperior.php"; ?>
<!-- INICIO -->
<div class="text-center"><h2>Catalogo operador</h2></div>

<br>
<br>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <button id="btnNuevo" type="button" class="btn btn-info" data-toggle="modal"><i class="material-icons"></i> Nuevo</button>
        </div>
    </div>
</div>
<br>

<div class="container caja">
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
                <table id="tablaOperadorInterno" class="table table-striped table-bordered table-condensed" style="width:100%">
                    <thead class="text-center">
                        <tr>
                            <th>id Operador</th>
                            <th>Nombre</th>
                            <th>Apellido Paterno</th>
                            <th>Apellido Materno</th>
                            <th>Curp</th>
                            <th>Usuario id</th>
                            <th>Proveedor id</th>
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
<div class="modal fade" id="modalCRUDOpera" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <form id="formOperador">
                <div class="modal-body">
                    <!-- <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">Nombre</label>
                                <input type="text" class="form-control" id="Nombre">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">Apellido Paterno</label>
                                <input type="text" class="form-control" id="Apellido_Paterno">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">Apellido Materno</label>
                                <input type="text" class="form-control" id="Apellido_Materno">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-form-label">CURP</label>
                                <input type="text" class="form-control" id="CUPR">
                            </div>
                        </div>
                    </div> -->

                    <div class="form-group">
                    <label class="col-form-label">Usuario</label>
                    <select class="form-control" id="Usuario_id">
                        <!-- Opciones del select se cargarán dinámicamente -->
                    </select>
                </div>

                <div class="form-group">
                    <label class="col-form-label">Proveedor</label>
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
 <!-- FIN --> 
<?php require_once "ParteInferior.php"; ?>

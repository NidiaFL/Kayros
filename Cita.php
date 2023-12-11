<?php require_once "ParteSuperior.php"; ?>

<!-- INICIO -->
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h1>Generar Cita</h1>
            <form id="Citas" action="GenerarCita.php" method="POST">
                <table class="table">
                    <tr>
                        <td><label for="fecha">Fecha:</label></td>
                        <td><input type="date" name="fecha" required></td>
                    </tr>
                    <tr>
                        <td><label for="hora">Hora:</label></td>
                        <td><input type="time" name="hora" required></td>
                    </tr>
                    <tr>
                        <td><label for="descripcion">Descripción:</label></td>
                        <td><textarea name="descripcion" rows="4" cols="50" required></textarea></td>
                    </tr>
                    <tr>
                        <td><label for="operador">Operador:</label></td>
                        <td>
                            <select name="operador" class="form-select">
                                <option value="0">Seleccione</option>
                                <?php
                                include("Conexion.php");

                                // Consulta de la base de datos
                                $Operador = "SELECT id_Operador_interno FROM operador_interno";
                                $result = mysqli_query($conn, $Operador);

                                while ($valores = mysqli_fetch_array($result)) {
                                    echo '<option value="' . $valores['id_Operador_interno'] . '">' . $valores['id_Operador_interno'] . ' ' . $valores['id_Operador_interno'] . ' ' . $valores['id_Operador_interno'] . '</option>';
                                }
                                ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="rutas">Ruta:</label></td>
                        <td>
                            <select name="rutas" class="form-select">
                                <option value="0">Seleccione</option>
                                <?php
                                include("Conexion.php");
                                // Consulta de la base de datos para obtener las rutas
                                $Rutas = "SELECT id_Rutas, Destino FROM ruta";
                                $resultRutas = mysqli_query($conn, $Rutas);

                                while ($valoresRutas = mysqli_fetch_array($resultRutas)) {
                                    echo '<option value="' . $valoresRutas['id_Rutas'] . '">' . $valoresRutas['Destino'] . '</option>';
                                }
                                ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="transporte">Transporte:</label></td>
                        <td>
                            <select name="transporte" class="form-select">
                                <option value="0">Seleccione</option>
                                <?php
                                include("Conexion.php");
                                // Consulta de la base de datos para obtener los transportes
                                $Transportes = "SELECT id_Transportes FROM transportes";
                                $resultTransportes = mysqli_query($conn, $Transportes);

                                while ($valoresTransportes = mysqli_fetch_array($resultTransportes)) {
                                    echo '<option value="' . $valoresTransportes['id_Transportes'] . '">' . $valoresTransportes['id_Transportes'] . '</option>';
                                }
                                ?>
                            </select>
                        </td>
                    </tr>
                </table>
                <div class="text-center">
                    <input type="submit" value="Registrar" class="btn btn-primary">
                </div>
            </form>
        </div>
    </div>
</div>
<!-- FIN -->

<?php require_once "ParteInferior.php"; ?>

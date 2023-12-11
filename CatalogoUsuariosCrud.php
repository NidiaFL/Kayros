<?php
include("Conexion.php");

$Nombre = isset($_POST['Nombre']) ? $_POST['Nombre'] : '';
$Apellido_Paterno = isset($_POST['Apellido_Paterno']) ? $_POST['Apellido_Paterno'] : '';
$Apellido_Materno = isset($_POST['Apellido_Materno']) ? $_POST['Apellido_Materno'] : '';
$Telefono = isset($_POST['Telefono']) ? $_POST['Telefono'] : '';
$Direccion = isset($_POST['Direccion']) ? $_POST['Direccion'] : '';
$CURP = isset($_POST['CURP']) ? $_POST['CURP'] : '';
$Licencia_de_conducir = isset($_POST['Licencia_de_conducir']) ? $_POST['Licencia_de_conducir'] : '';
$Rol_id = isset($_POST['Rol_id']) ? $_POST['Rol_id'] : '';

$opcion = isset($_POST['opcion']) ? $_POST['opcion'] : '';
$id_Usuario = isset($_POST['id_Usuario']) ? $_POST['id_Usuario'] : '';

try {
    $conexion = new PDO("mysql:host=localhost;dbname=gg", "root", "");

    switch ($opcion) {
        case 1:
            $consulta = "INSERT INTO Usuarios (Nombre, Apellido_Paterno, Apellido_Materno, Telefono, Direccion, CURP, Licencia_de_conducir, Rol_id) 
                VALUES (:Nombre, :Apellido_Paterno, :Apellido_Materno, :Telefono, :Direccion, :CURP, :Licencia_de_conducir, :Rol_id)";
            $stmt = $conexion->prepare($consulta);
            $stmt->bindParam(':Nombre', $Nombre);
            $stmt->bindParam(':Apellido_Paterno', $Apellido_Paterno);
            $stmt->bindParam(':Apellido_Materno', $Apellido_Materno);
            $stmt->bindParam(':Telefono', $Telefono);
            $stmt->bindParam(':Direccion', $Direccion);
            $stmt->bindParam(':CURP', $CURP);
            $stmt->bindParam(':Licencia_de_conducir', $Licencia_de_conducir);
            $stmt->bindParam(':Rol_id', $Rol_id);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro insertado correctamente'];
            } else {
                $data = ['error' => 'Error al insertar el registro'];
            }
            break;

        case 2:
            $consulta = "UPDATE Usuarios 
                SET Nombre = :Nombre, Apellido_Paterno = :Apellido_Paterno, Apellido_Materno = :Apellido_Materno, 
                    Telefono = :Telefono, Direccion = :Direccion, 
                    CURP = :CURP, Licencia_de_conducir = :Licencia_de_conducir, Rol_id = :Rol_id
                WHERE id_Usuario = :id_Usuario";
            $stmt = $conexion->prepare($consulta);
            $stmt->bindParam(':Nombre', $Nombre);
            $stmt->bindParam(':Apellido_Paterno', $Apellido_Paterno);
            $stmt->bindParam(':Apellido_Materno', $Apellido_Materno);
            $stmt->bindParam(':Telefono', $Telefono);
            $stmt->bindParam(':Direccion', $Direccion);
            $stmt->bindParam(':CURP', $CURP);
            $stmt->bindParam(':Licencia_de_conducir', $Licencia_de_conducir);
            $stmt->bindParam(':Rol_id', $Rol_id);
            $stmt->bindParam(':id_Usuario', $id_Usuario, PDO::PARAM_INT);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro actualizado correctamente'];
            } else {
                $data = ['error' => 'Error al actualizar el registro'];
            }
            break;

        case 3:
            $consulta = "DELETE FROM Usuarios WHERE id_Usuario = :id_Usuario";
            $stmt = $conexion->prepare($consulta);
            $stmt->bindParam(':id_Usuario', $id_Usuario, PDO::PARAM_INT);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro eliminado correctamente'];
            } else {
                $data = ['error' => 'Error al eliminar el registro'];
            }
            break;

        case 4:
            $consulta = "SELECT * FROM Usuarios";
            $stmt = $conexion->prepare($consulta);
            $stmt->execute();

            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Obtener proveedores asignados al transporte
            // foreach ($data as &$transporte) {
            //     $consultaProveedores = "SELECT p.Nombre, p.Direccion, p.Telefono
            //         FROM proveedores p
            //         JOIN transportes t ON p.id_Proveedor = t.Rol_id
            //         WHERE t.id_Usuario = :id_Usuario";
            //     $stmtProveedores = $conexion->prepare($consultaProveedores);
            //     $stmtProveedores->bindParam(':id_Usuario', $transporte['id_Usuario']);
            //     $stmtProveedores->execute();
            //     $proveedores = $stmtProveedores->fetchAll(PDO::FETCH_ASSOC);
            //     $transporte['ProveedoresAsignados'] = $proveedores;
            

            break;
    }
} catch (PDOException $e) {
    $data = ['error' => $e->getMessage()];
}

header('Content-Type: application/json');
echo json_encode($data, JSON_UNESCAPED_UNICODE);
?>

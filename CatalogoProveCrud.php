<?php
include("Conexion.php");

$Nombre = (isset($_POST['Nombre'])) ? $_POST['Nombre'] : '';
$Direccion = (isset($_POST['Direccion'])) ? $_POST['Direccion'] : '';
$Telefono = (isset($_POST['Telefono'])) ? $_POST['Telefono'] : '';

$opcion = (isset($_POST['opcion'])) ? $_POST['opcion'] : '';
$ID_Proveedor = (isset($_POST['ID_Proveedor'])) ? $_POST['ID_Proveedor'] : '';

try {
    $conexion = new PDO("mysql:host=localhost;dbname=kayros", "root", "");

    switch($opcion) {
        case 1:
            $consulta = "INSERT INTO proveedores (Nombre, Direccion, Telefono) VALUES (:Nombre, :Direccion, :Telefono)";
            $stmt = $conexion->prepare($consulta);
            $stmt->bindParam(':Nombre', $Nombre);
            $stmt->bindParam(':Direccion', $Direccion);
            $stmt->bindParam(':Telefono', $Telefono);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro insertado correctamente'];
            } else {
                $data = ['error' => 'Error al insertar el registro'];
            }
            break;

        case 2:
            $consulta = "UPDATE proveedores SET Nombre = :Nombre, Direccion = :Direccion, Telefono = :Telefono WHERE ID_Proveedor = :ID_Proveedor";
            $stmt = $conexion->prepare($consulta);
            $stmt->bindParam(':Nombre', $Nombre);
            $stmt->bindParam(':Direccion', $Direccion);
            $stmt->bindParam(':Telefono', $Telefono);
            $stmt->bindParam(':ID_Proveedor', $ID_Proveedor, PDO::PARAM_INT);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro actualizado correctamente'];
            } else {
                $data = ['error' => 'Error al actualizar el registro'];
            }
            break;

        case 3:
            $consulta = "DELETE FROM proveedores WHERE ID_Proveedor = :ID_Proveedor";
            $stmt = $conexion->prepare($consulta);
            $stmt->bindParam(':ID_Proveedor', $ID_Proveedor, PDO::PARAM_INT);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro eliminado correctamente'];
            } else {
                $data = ['error' => 'Error al eliminar el registro'];
            }
            break;

        case 4:
            $consulta = "SELECT * FROM proveedores";
            $stmt = $conexion->prepare($consulta);
            $stmt->execute();

            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
            break;
    }
} catch (PDOException $e) {
    $data = ['error' => $e->getMessage()];
}

header('Content-Type: application/json');
echo json_encode($data, JSON_UNESCAPED_UNICODE);
?>

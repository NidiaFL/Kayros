<?php
include("Conexion.php");

$Usuario_id = (isset($_POST['Usuario_id'])) ? $_POST['Usuario_id'] : '';
$Proveedor_id = (isset($_POST['Proveedor_id'])) ? $_POST['Proveedor_id'] : '';
$opcion = (isset($_POST['opcion'])) ? $_POST['opcion'] : '';
$id_Operador_Interno = (isset($_POST['id_Operador_Interno'])) ? $_POST['id_Operador_Interno'] : '';

try {
    $conn = new PDO("mysql:host=localhost;dbname=kayros", "root", "");

    switch ($opcion) {
        case 1:
            $consulta = "INSERT INTO Operador_Interno (Usuario_id, Proveedor_id) VALUES (:Usuario_id, :Proveedor_id)";
            $stmt = $conn->prepare($consulta);
            $stmt->bindParam(':Usuario_id', $Usuario_id);
            $stmt->bindParam(':Proveedor_id', $Proveedor_id);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro insertado correctamente'];
            } else {
                $data = ['error' => 'Error al insertar el registro'];
            }
            break;

        case 2:
            $consulta = "UPDATE Operador_Interno SET Proveedor_id = :Proveedor_id WHERE id_Operador_Interno = :id_Operador_Interno";
            $stmt = $conn->prepare($consulta);
            //$stmt->bindParam(':Usuario_id', $Usuario_id);
            $stmt->bindParam(':Proveedor_id', $Proveedor_id);
            $stmt->bindParam(':id_Operador_Interno', $id_Operador_Interno, PDO::PARAM_INT);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro actualizado correctamente'];
            } else {
                $data = ['error' => 'Error al actualizar el registro'];
            }
            break;

        case 3:
            $consulta = "DELETE FROM Operador_Interno WHERE id_Operador_Interno = :id_Operador_Interno";
            $stmt = $conn->prepare($consulta);
            $stmt->bindParam(':id_Operador_Interno', $id_Operador_Interno, PDO::PARAM_INT);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro eliminado correctamente'];
            } else {
                $data = ['error' => 'Error al eliminar el registro'];
            }
            break;

        case 4:
            $consulta = "SELECT Operador_Interno.id_Operador_Interno, Usuarios.Nombre, Usuarios.Apellido_Paterno, Usuarios.Apellido_Materno, Usuarios.Curp, Operador_Interno.Usuario_id, Proveedores.Nombre as Proveedor_Nombre
                         FROM Operador_Interno
                         INNER JOIN Usuarios ON Operador_Interno.Usuario_id = Usuarios.id_Usuario
                         INNER JOIN Proveedores ON Operador_Interno.Proveedor_id = Proveedores.id_Proveedor";
            $stmt = $conn->prepare($consulta);
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

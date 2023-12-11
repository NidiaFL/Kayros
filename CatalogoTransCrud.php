<?php
include("Conexion.php");

$Ano = isset($_POST['Ano']) ? $_POST['Ano'] : '';
$Placas = isset($_POST['Placas']) ? $_POST['Placas'] : '';
$Capacidad_Carga = isset($_POST['Capacidad_Carga']) ? $_POST['Capacidad_Carga'] : '';
$Modelo = isset($_POST['Modelo']) ? $_POST['Modelo'] : '';
$Numero_Economico = isset($_POST['Numero_Economico']) ? $_POST['Numero_Economico'] : '';
$Tipo_Contenedor_Asignado = isset($_POST['Tipo_Contenedor_Asignado']) ? $_POST['Tipo_Contenedor_Asignado'] : '';
$Proveedor_id = isset($_POST['Proveedor_id']) ? $_POST['Proveedor_id'] : '';

$opcion = isset($_POST['opcion']) ? $_POST['opcion'] : '';
$id_Transportes = isset($_POST['id_Transportes']) ? $_POST['id_Transportes'] : '';

try {
    $conexion = new PDO("mysql:host=localhost;dbname=kayros", "root", "");

    switch ($opcion) {
        case 1:
            $consulta = "INSERT INTO transportes (Ano, Placas, Capacidad_Carga, Modelo, Numero_Economico, Tipo_Contenedor_Asignado, Proveedor_id) 
                VALUES (:Ano, :Placas, :Capacidad_Carga, :Modelo, :Numero_Economico, :Tipo_Contenedor_Asignado, :Proveedor_id)";
            $stmt = $conexion->prepare($consulta);
            $stmt->bindParam(':Ano', $Ano);
            $stmt->bindParam(':Placas', $Placas);
            $stmt->bindParam(':Capacidad_Carga', $Capacidad_Carga);
            $stmt->bindParam(':Modelo', $Modelo);
            $stmt->bindParam(':Numero_Economico', $Numero_Economico);
            $stmt->bindParam(':Tipo_Contenedor_Asignado', $Tipo_Contenedor_Asignado);
            $stmt->bindParam(':Proveedor_id', $Proveedor_id);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro insertado correctamente'];
            } else {
                $data = ['error' => 'Error al insertar el registro'];
            }
            break;

        case 2:
            $consulta = "UPDATE transportes 
                SET Ano = :Ano, Placas = :Placas, Capacidad_Carga = :Capacidad_Carga, 
                    Modelo = :Modelo, Numero_Economico = :Numero_Economico, 
                    Tipo_Contenedor_Asignado = :Tipo_Contenedor_Asignado, Proveedor_id = :Proveedor_id
                WHERE id_Transportes = :id_Transportes";
            $stmt = $conexion->prepare($consulta);
            $stmt->bindParam(':Ano', $Ano);
            $stmt->bindParam(':Placas', $Placas);
            $stmt->bindParam(':Capacidad_Carga', $Capacidad_Carga);
            $stmt->bindParam(':Modelo', $Modelo);
            $stmt->bindParam(':Numero_Economico', $Numero_Economico);
            $stmt->bindParam(':Tipo_Contenedor_Asignado', $Tipo_Contenedor_Asignado);
            $stmt->bindParam(':Proveedor_id', $Proveedor_id);
            $stmt->bindParam(':id_Transportes', $id_Transportes, PDO::PARAM_INT);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro actualizado correctamente'];
            } else {
                $data = ['error' => 'Error al actualizar el registro'];
            }
            break;

        case 3:
            $consulta = "DELETE FROM transportes WHERE id_Transportes = :id_Transportes";
            $stmt = $conexion->prepare($consulta);
            $stmt->bindParam(':id_Transportes', $id_Transportes, PDO::PARAM_INT);

            if ($stmt->execute()) {
                $data = ['message' => 'Registro eliminado correctamente'];
            } else {
                $data = ['error' => 'Error al eliminar el registro'];
            }
            break;

        case 4:
            $consulta = "SELECT * FROM transportes";
            $stmt = $conexion->prepare($consulta);
            $stmt->execute();

            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Obtener proveedores asignados al transporte
            foreach ($data as &$transporte) {
                $consultaProveedores = "SELECT p.Nombre, p.Direccion, p.Telefono
                    FROM proveedores p
                    JOIN transportes t ON p.id_Proveedor = t.Proveedor_id
                    WHERE t.id_Transportes = :id_Transportes";
                $stmtProveedores = $conexion->prepare($consultaProveedores);
                $stmtProveedores->bindParam(':id_Transportes', $transporte['id_Transportes']);
                $stmtProveedores->execute();
                $proveedores = $stmtProveedores->fetchAll(PDO::FETCH_ASSOC);
                $transporte['ProveedoresAsignados'] = $proveedores;
            }

            break;
    }
} catch (PDOException $e) {
    $data = ['error' => $e->getMessage()];
}

header('Content-Type: application/json');
echo json_encode($data, JSON_UNESCAPED_UNICODE);
?>

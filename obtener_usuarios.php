<?php
// Conectar a la base de datos
include("Conexion.php");

// Realizar la consulta para obtener la lista de proveedores
$query = "SELECT id_Usuario, Nombre, Apellido_Paterno, Apellido_Materno, Rol_id FROM Usuarios WHERE Rol_id = 3";
$stmt = $conn->prepare($query);
$stmt->execute();

// Vincular variables a los resultados
$stmt->bind_result($id_Usuario, $Nombre, $Apellido_Paterno, $Apellido_Materno, $Rol_id);

// Generar las opciones en formato HTML
$options = '';
while ($stmt->fetch()) {
    $options .= "<option value='{$id_Usuario}'>{$Nombre} {$Apellido_Paterno} {$Apellido_Materno} </option>";
}

echo $options;

// Cerrar la declaración y la conexión
$stmt->close();
$conn->close();
?>

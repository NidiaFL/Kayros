<?php
// Conectar a la base de datos
include("Conexion.php");

// Realizar la consulta para obtener la lista de proveedores
$query = "SELECT id_Rol, Nombre_Rol FROM roles";
$stmt = $conn->prepare($query);
$stmt->execute();

// Vincular variables a los resultados
$stmt->bind_result($id_Rol, $Nombre_Rol);

// Generar las opciones en formato HTML
$options = '';
while ($stmt->fetch()) {
    $options .= "<option value='{$id_Rol}'>{$Nombre_Rol}</option>";
}

echo $options;

// Cerrar la declaración y la conexión
$stmt->close();
$conn->close();
?>

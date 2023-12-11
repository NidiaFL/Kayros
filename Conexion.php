<?php
// Establece la conexión a la base de datos (debes completar con tus propios datos)
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "kayros";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}



?>

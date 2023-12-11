<?php
include("Conexion.php");


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Realiza la consulta en la base de datos para verificar las credenciales
    $sql = "SELECT * FROM credenciales WHERE correo = '$email' AND contrasena = '$password'";
    $result = $conn->query($sql);

    if ($result->num_rows == 1) {
        // Las credenciales son válidas, redirige al usuario a la página de inicio
        header("Location: index.php");
    } else {
        // Las credenciales son inválidas, muestra un mensaje de error
        echo "Credenciales incorrectas. Por favor, intenta de nuevo.";
    }
}

// Cierra la conexión a la base de datos
$conn->close();
?>

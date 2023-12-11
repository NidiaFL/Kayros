<?php require_once "ParteSuperior.php"; ?>
<?php
require('phpqrcode/qrlib.php');
include("Conexion.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $fecha = $_POST['fecha'];
    $hora = $_POST['hora'];
    $descripcion = $_POST['descripcion'];
    $operador = $_POST['operador'];
    $rutas = $_POST['rutas'];
    $transporte = $_POST['transporte'];

    // Insertar datos en la base de datos
    $sql_insert_cita = "INSERT INTO cita (Fecha_Cita, Hora_Cita, Descripcion, id_Operador_Interno, id_RutaCitas, id_TransporteCitas, Estado) VALUES ('$fecha', '$hora', '$descripcion', '$operador', '$rutas', '$transporte', 'Agendada')";

    if (mysqli_query($conn, $sql_insert_cita)) {
        // Éxito al insertar en la base de datos
        $idCita = mysqli_insert_id($conn);

        // Generar código QR
        $cita_info = "Fecha: $fecha\nHora: $hora\nDescripcion: $descripcion\nOperador: $operador\nruta: $rutas\nTransporte: $transporte";
        $qr_filename = uniqid() . '.png'; // Genera un nombre de archivo único
        $qr_path = 'qrcodes/' . $qr_filename;
        QRcode::png($cita_info, $qr_path); // Guarda el código QR en una carpeta

        // Insertar el código QR en la tabla QR_Cita y relacionarlo con la cita
        $sql_insert_qr = "INSERT INTO QR_Cita (Codigo_QR, id_Cita) VALUES ('$qr_filename', '$idCita')";
        if (mysqli_query($conn, $sql_insert_qr)) {
            // Cambiar el estado de la cita a 'Agendada'
            
            
                echo '
                <!DOCTYPE html>
                <html lang="es">
                <head>
                    <title>Cita Generada</title>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
                </head>
                <body>
                    <div class="container mt-5">
                        <h1 class="text-center">Cita Generada</h1>
                        <div class="text-center">
                            <img src="' . $qr_path . '" class="img-fluid" alt="Código QR">
                        </div>
                        <div class="text-center mt-3">
                            <a href="' . $qr_path . '" class="btn btn-primary" download>Descargar Código QR</a>
                            <button id="shareByEmail" class="btn btn-success">Compartir por Correo</button>
                            <a href="Cita.php" class="btn btn-secondary">Regresar a Cita</a>
                        </div>
                        <script>
                            document.getElementById("shareByEmail").addEventListener("click", function () {
                                var correo_destino = "correo@ejemplo.com"; // Reemplaza con tu dirección de correo
                                var asunto = "Código QR de la cita";
                                var cuerpo = "Adjunto encontrarás el código QR de la cita. Puedes descargarlo haciendo clic en el siguiente enlace: ' . $qr_path . '";
                                var mailto_link = "mailto:" + correo_destino + "?subject=" + asunto + "&body=" + cuerpo;
                                window.location.href = mailto_link;
                            });
                        </script>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                </body>
                </html>';
            
        } else {
            echo "Error al insertar código QR en la base de datos: " . mysqli_error($conn);
        }
    } else {
        // Error al insertar en la base de datos
        echo "Error: " . $sql_insert_cita . "<br>" . mysqli_error($conn);
    }
}

// Cierre de la conexión
$conn->close();
?>



<?php require_once "ParteInferior.php"; ?>

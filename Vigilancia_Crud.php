<?php
// Conexión a la base de datos (ajusta según tu configuración)
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "kayros";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    http_response_code(500);
    die("Conexión fallida: " . $conn->connect_error);
}

// Establecer el conjunto de caracteres a utf8
$conn->set_charset("utf8");

// Configurar el charset en la respuesta HTTP
header('Content-Type: application/json; charset=utf-8');

// Opción enviada desde DataTables
$opcion = isset($_POST['opcion']) ? $_POST['opcion'] : null;

// Validación de la opción (puedes agregar más validaciones según tus necesidades)
if ($opcion === null || !is_numeric($opcion)) {
    http_response_code(400);
    die("Opción no válida");
}

// Consulta SQL para obtener datos según la opción
if ($opcion == 4) {
    $query = "SELECT cita.*, QR_Cita.Codigo_QR
              FROM cita
              LEFT JOIN QR_Cita ON cita.id_Cita = QR_Cita.id_Cita";
    
    $stmt = $conn->prepare($query);

    if ($stmt === false) {
        http_response_code(500);
        die("Error en la preparación de la consulta: " . $conn->error);
    }

    $stmt->execute();

    $result = $stmt->get_result();

    if ($result === false) {
        http_response_code(500);
        die("Error en la ejecución de la consulta: " . $stmt->error);
    }

    $data = array();
    while ($row = $result->fetch_assoc()) {     
        $data[] = $row;
    }

    echo json_encode($data);
}

// Agregar código para guardar datos en la base de datos
if ($opcion == 5) {
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Obtener el contenido de la caja de texto
        $texto = $_POST['texto'];

        // Preparar la consulta SQL para insertar en la tabla 'tu_tabla'
        $query_insert = "INSERT INTO comentarios (texto) VALUES ('$texto')";

        // Ejecutar la consulta
        if ($conn->query($query_insert) === TRUE) {
            echo json_encode(array("mensaje" => "Registro guardado con éxito"));
        } else {
            http_response_code(500);
            echo json_encode(array("error" => "Error al guardar el registro: " . $conn->error));
        }
    }
}




$stmt->close();
$conn->close();
?>
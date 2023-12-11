<?php require_once "ParteSuperior.php"; ?>
<?php
// Realiza la conexión a la base de datos y otras configuraciones
include('Conexion.php');
// Recupera los datos de la base de datos
$sql = "SELECT Estado, COUNT(*) AS Cantidad FROM Cita GROUP BY Estado";
$result = mysqli_query($conn, $sql);

// Crear un array asociativo con el conteo de citas por estado
$citas_por_estado = [];
while ($row = mysqli_fetch_assoc($result)) {
    $estado = $row['Estado'];
    $cantidad = $row['Cantidad'];
    $citas_por_estado[$estado] = $cantidad;
}

// Cierra la conexión a la base de datos
$conn->close();
?>

<!-- Muestra las cards con iconos correspondientes a los estados -->
<!DOCTYPE html>
<html lang="es">
<head>
    <title>MONITOREO</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">MONITOREO</h1>

        <div class="row">
            <?php
            // Verifica si hay una card con el estado "Agendada" y muéstrala primero
            if (isset($citas_por_estado['Agendada'])):
            ?>
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Agendada</h5>
                            <p class="card-text">Número de Citas: <?php echo $citas_por_estado['Agendada']; ?></p>
                            <p class="card-text">Icono: 📅</p>
                            
                        </div>
                    </div>
                </div>
            <?php
            endif;

            // Muestra las otras cards
            foreach ($citas_por_estado as $estado => $cantidad):
                if ($estado !== 'Agendada'):
            ?>
                    <div class="col-md-4 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title"><?php echo $estado; ?></h5>
                                <p class="card-text">Número de Citas: <?php echo $cantidad; ?></p>
                                <!-- Puedes personalizar los iconos según tus necesidades -->
                                <?php
                                $icono = '';
                                switch ($estado) {
                                    case 'En Camino':
                                        $icono = '🚗'; // Icono para citas en camino
                                        break;
                                    // Agrega más casos según tus estados
                                    default:
                                        $icono = '🚗'; // Icono para otros estados
                                        break;
                                }
                                ?>
                                <p class="card-text">Icono: <?php echo $icono; ?></p>

                                <!-- Información adicional -->
                                <?php
                                $informacion_adicional = '';
                                switch ($estado) {
                                    case 'En Camino':
                                        $informacion_adicional = 'Detalles sobre citas en camino';
                                        break;
                                    // Agrega más casos según tus estados
                                    default:
                                        $informacion_adicional = 'Detalles sobre otros estados';
                                        break;
                                }
                                ?>
                                
                            </div>
                        </div>
                    </div>
            <?php
                endif;
            endforeach;
            ?>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<?php require_once "ParteInferior.php"; ?>

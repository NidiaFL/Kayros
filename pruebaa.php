<?php
// Definir un array de tarjetas con diferentes estados
$tarjetas = [
    ['id' => 1, 'titulo' => 'Tarjeta 1', 'estado' => 'pendiente'],
    ['id' => 2, 'titulo' => 'Tarjeta 2', 'estado' => 'en_progreso'],
    ['id' => 3, 'titulo' => 'Tarjeta 3', 'estado' => 'completada'],
];

// Función para obtener la ruta de la imagen según el estado de la tarjeta
function obtenerImagenEstado($estado) {
    switch ($estado) {
        case 'pendiente':
            return 'img/pendiente.png';
        case 'en_progreso':
            return 'img/en_progreso.png';
        case 'completada':
            return 'img/completada.png';
        default:
            return '';
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Sistema de Estatus</title>
</head>
<body>
    <div class="contenedor-tarjetas">
        <?php foreach ($tarjetas as $tarjeta): ?>
            <div class="tarjeta">
                <img src="<?= obtenerImagenEstado($tarjeta['estado']) ?>" alt="<?= $tarjeta['estado'] ?>">
                <h3><?= $tarjeta['titulo'] ?></h3>
                <p>Estado: <?= $tarjeta['estado'] ?></p>
            </div>
        <?php endforeach; ?>
    </div>
</body>
</html>
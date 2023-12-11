$(document).ready(function() {
    var opcion = 4;

    // Check if DataTable is already initialized
    if ($.fn.DataTable.isDataTable('#tablaCitas')) {
        // If already initialized, destroy the existing instance
        $('#tablaCitas').DataTable().destroy();
    }

    // Initialize DataTable
    tablaCitas = $('#tablaCitas').DataTable({
        "ajax": {
            "url": "Vigilancia_Crud.php",
            "method": 'POST',
            "data": { opcion: opcion },
            "dataSrc": ""
        },
        "columns": [
            { "data": "id_Cita" },
            { "data": "Fecha_Cita" },
            { "data": "Hora_Cita" },
            {"data": "Descripcion"},
            {"data": "id_Operador_Interno"},
            {"data": "id_RutaCitas"},
            {"data": "id_TransporteCitas"},
            { "data": "Estado" },
            { "data": "Codigo_QR" },
            
            {
                "data": null,
                "render": function(data, type, row) {
                    return "<button class='btn btn-primary btn-sm' onclick='verDetalles(" + JSON.stringify(row) + ")'>Ver Detalles</button>";
                }
            }
        ],
        "columnDefs": [
            {
                "targets": -1,
                "orderable": false,
            }
        ]
    });
});

// Function to display appointment details in the modal
function verDetalles(cita) {
    var modalContent = "<p>ID Cita: " + cita.id_Cita + "</p>";
    modalContent += "<p>Fecha: " + cita.Fecha_Cita + "</p>";
    modalContent += "<p>Hora: " + cita.Hora_Cita + "</p>";
    modalContent += "<p>Descripcion: " + cita.Descripcion + "</p>";
    modalContent += "<p>id_Operador_Interno: " + cita.id_Operador_Interno+ "</p>";
    modalContent += "<p>id_RutaCitas: " + cita.id_RutaCitas + "</p>";
    modalContent += "<p>id_TransporteCitas: " + cita.id_TransporteCitas + "</p>";
    modalContent += "<p>Estado: " + cita.Estado + "</p>";
    modalContent += "<p>Codigo_QR: " + cita.Codigo_QR + "</p>";

    // Update the modal content
    $("#detallesCita").html(modalContent);

    // Show the modal
    $("#modalDetalles").modal("show");
}   
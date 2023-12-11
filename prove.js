$(document).ready(function() {
    
var ID_Proveedor, opcion;

opcion = 4;

tablaProveedores = $('#tablaProveedores').DataTable({
    "ajax": {
        "url": "CatalogoProveCrud.php",
        "method": 'POST',
        "data": { opcion: opcion },
        "dataSrc": ""
    },
    "columns": [
        { "data": "ID_Proveedor" },
        { "data": "Nombre" },
        { "data": "Direccion" },
        { "data": "Telefono" },
        { "defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-primary btn-sm btnEditar'><i class='material-icons'>Editar</i></button><button class='btn btn-danger btn-sm btnBorrar'><i class='material-icons'>Borrar</i></button></div></div>" }
    ]
});

var fila; //captura la fila para editar o eliminar

// Manejo del formulario para Alta y Actualización
$('#formProveedores').submit(function(e) {
    e.preventDefault();
    Nombre = $.trim($('#Nombre').val());
    Direccion = $.trim($('#Direccion').val());
    Telefono = $.trim($('#Telefono').val());

    $.ajax({
        url: "CatalogoProveCrud.php",
        type: "POST",
        dataType: "json",
        data: { ID_Proveedor: ID_Proveedor, Nombre: Nombre, Direccion: Direccion, Telefono: Telefono, opcion: opcion },
        success: function(data) {
            tablaProveedores.ajax.reload(null, false);
        }
    });

    $('#modalCRUDProve').modal('hide');
});

// Limpiar los campos antes de dar de Alta un Proveedor
$("#btnNuevoProveedor").click(function() {
    opcion = 1; // Alta
    ID_Proveedor = null;
    $("#formProveedores").trigger("reset");
    $(".modal-header").css("background-color", "#17a2b8");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("Nuevo Proveedor");
    $('#modalCRUDProve').modal('show');
});

// Editar un Proveedor
$(document).on("click", ".btnEditar", function() {
    opcion = 2; // Editar
    fila = $(this).closest("tr");
    ID_Proveedor = parseInt(fila.find('td:eq(0)').text());
    Nombre = fila.find('td:eq(1)').text();
    Direccion = fila.find('td:eq(2)').text();
    Telefono = fila.find('td:eq(3)').text();

    $("#Nombre").val(Nombre);
    $("#Direccion").val(Direccion);
    $("#Telefono").val(Telefono);
    $(".modal-header").css("background-color", "#007bff");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("Editar Proveedor");
    $('#modalCRUDProve').modal('show');
});

// Borrar un Proveedor
$(document).on("click", ".btnBorrar", function() {
    fila = $(this);
    ID_Proveedor = parseInt($(this).closest('tr').find('td:eq(0)').text());
    opcion = 3; // Eliminar
    var respuesta = confirm("¿Está seguro de borrar el registro " + ID_Proveedor + "?");
    if (respuesta) {
        $.ajax({
            url: "CatalogoProveCrud.php",
            type: "POST",
            dataType: "json",
            data: { opcion: opcion, ID_Proveedor: ID_Proveedor },
            success: function() {
                tablaProveedores.row(fila.parents('tr')).remove().draw();
            }
        });
    }
});

     
});//FINAL   
$(document).ready(function() {
var id_Operador_Interno, opcion;
    opcion = 4;
    
 tablaOperadorInterno = $('#tablaOperadorInterno').DataTable({  
        "ajax": {            
            "url": "CatalogoOperaCrud.php", 
            "method": 'POST',
            "data": { opcion: opcion },
            "dataSrc": ""
        },
        "columns": [
            {"data": "id_Operador_Interno"},
            { "data": "Nombre" },
            { "data": "Apellido_Paterno" },
            { "data": "Apellido_Materno" },
            { "data": "Curp" },
            { "data": "Usuario_id" },
            { "data": "Proveedor_Nombre" },
            {
                "defaultContent": 
                "<div class='text-center'>" +
                "<div class='btn-group'>" +
                "<button class='btn btn-primary btn-sm btnEditar'><i class='material-icons'>Editar</i></button>" +
                "<button class='btn btn-danger btn-sm btnBorrar'><i class='material-icons'>Borrar</i></button>" +
                "</div>" +
                "</div>"
            }
        ]
    });


var fila; //captura la fila, para editar o eliminar

 //submit para el Alta y Actualización
    $('#formOperador').submit(function(e) {
        e.preventDefault();
        Usuario_id = $.trim($('#Usuario_id').val());
        Proveedor_id = $.trim($('#Proveedor_id').val());
        // Apellido_Materno = $.trim($('#Apellido_Materno').val());
        // Telefono = $.trim($('#Telefono').val());
        // Direccion = $.trim($('#Direccion').val());
        // CURP = $.trim($('#CURP').val());
        // Licencia_de_conducir = $.trim($('#Licencia_de_conducir').val());
        // Rol_id = $.trim($('#Rol_id').val());  // Agregado el campo Proveedor_Id

        $.ajax({
            url: "CatalogoOperaCrud.php",
            type: "POST",
            datatype: "json",
            data: { id_Operador_Interno: id_Operador_Interno, Usuario_id: Usuario_id, Proveedor_id: Proveedor_id, opcion: opcion },
            success: function(data) {
                tablaOperadorInterno.ajax.reload(null, false);
            }
        });
        $('#modalCRUDOpera').modal('hide');
    });
        
 $('#modalCRUDOpera').on('shown.bs.modal', function () {
    // Cargar las opciones del select desde el servidor y actualizar el select
    $.ajax({
        url: 'obtener_usuarios.php', // Nombre del archivo PHP que obtiene la lista de proveedores
        type: 'GET',
        success: function (data) {
            // Llenar el select con las opciones
            $('#Usuario_id').html(data);
        },
        error: function () {
            // Manejo de errores si la carga de proveedores falla
            alert('Error al cargar la lista de usuarios.');
        }
    });
});

 $('#modalCRUDOpera').on('shown.bs.modal', function () {
    // Cargar las opciones del select desde el servidor y actualizar el select
    $.ajax({
        url: 'obtener_proveedores.php', // Nombre del archivo PHP que obtiene la lista de proveedores
        type: 'GET',
        success: function (data) {
            // Llenar el select con las opciones
            $('#Proveedor_id').html(data);
        },
        error: function () {
            // Manejo de errores si la carga de proveedores falla
            alert('Error al cargar la lista de proveedores.');
        }
    });
});

 //para limpiar los campos antes de dar de Alta una Persona
$("#btnNuevo").click(function(){
    opcion = 1; //alta           
    id_Operador_Interno=null;
    $("#formOperador").trigger("reset");
    $(".modal-header").css( "background-color", "#17a2b8");
    $(".modal-header").css( "color", "white" );
    $(".modal-title").text("Nuevo Operador");
    $('#modalCRUDOpera').modal('show');      
});

//Editar        
$(document).on("click", ".btnEditar", function(){               
    opcion = 2;//editar
    fila = $(this).closest("tr");           
    id_Operador_Interno = parseInt(fila.find('td:eq(0)').text()); //capturo el ID                    
    Usuario_id = fila.find('td:eq(1)').text();
    Proveedor_id = fila.find('td:eq(2)').text();
    
    $("#Proveedor_id").val(Proveedor_id);
    $(".modal-header").css("background-color", "#007bff");
    $(".modal-header").css("color", "white" );
    $(".modal-title").text("Editar Operador");        
    $('#modalCRUDOpera').modal('show');         
});

//Borrar
$(document).on("click", ".btnBorrar", function(){
    fila = $(this);           
    id_Operador_Interno = parseInt($(this).closest('tr').find('td:eq(0)').text()) ;      
    opcion = 3; //eliminar        
    var respuesta = confirm("¿Está seguro de borrar el registro "+id_Operador_Interno+"?");                
    if (respuesta) {            
        $.ajax({
          url: "CatalogoOperaCrud.php",
          type: "POST",
          datatype:"json",    
          data:  {opcion:opcion, id_Operador_Interno:id_Operador_Interno},    
          success: function() {
              tablaOperadorInterno.row(fila.parents('tr')).remove().draw();                  
           }
        }); 
    }
 });





     
});//FINAL   
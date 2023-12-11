$(document).ready(function() {
 var id_Usuario, opcion;
    opcion = 4;
    
    tablaUsuarios = $('#tablaUsuarios').DataTable({  
        "ajax": {            
            "url": "CatalogoUsuariosCrud.php", 
            "method": 'POST',
            "data": { opcion: opcion },
            "dataSrc": ""
        },
        "columns": [
            {"data": "id_Usuario"},
            {"data": "Nombre"},
            {"data": "Apellido_Paterno"},
            {"data": "Apellido_Materno"},
            {"data": "Telefono"},
            {"data": "Direccion"},
            {"data": "CURP"},
            {"data": "Licencia_de_conducir"},
            {"data": "Rol_id"},
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
    $('#formUsuarios').submit(function(e) {
        e.preventDefault();
        Nombre = $.trim($('#Nombre').val());
        Apellido_Paterno = $.trim($('#Apellido_Paterno').val());
        Apellido_Materno = $.trim($('#Apellido_Materno').val());
        Telefono = $.trim($('#Telefono').val());
        Direccion = $.trim($('#Direccion').val());
        CURP = $.trim($('#CURP').val());
        Licencia_de_conducir = $.trim($('#Licencia_de_conducir').val());
        Rol_id = $.trim($('#Rol_id').val());  // Agregado el campo Proveedor_Id

        $.ajax({
            url: "CatalogoUsuariosCrud.php",
            type: "POST",
            datatype: "json",
            data: { id_Usuario: id_Usuario, Nombre: Nombre, Apellido_Paterno: Apellido_Paterno, Apellido_Materno: Apellido_Materno, Telefono: Telefono, Direccion: Direccion, CURP: CURP, Licencia_de_conducir: Licencia_de_conducir, Rol_id: Rol_id, opcion: opcion },
            success: function(data) {
                tablaUsuarios.ajax.reload(null, false);
            }
        });
        $('#modalCRUDUsu').modal('hide');
    });
        
 $('#modalCRUDUsu').on('shown.bs.modal', function () {
    // Cargar las opciones del select desde el servidor y actualizar el select
    $.ajax({
        url: 'obtener_roles.php', // Nombre del archivo PHP que obtiene la lista de proveedores
        type: 'GET',
        success: function (data) {
            // Llenar el select con las opciones
            $('#Rol_id').html(data);
        },
        error: function () {
            // Manejo de errores si la carga de proveedores falla
            alert('Error al cargar la lista de roles.');
        }
    });
});


//para limpiar los campos antes de dar de Alta una Persona
$("#btnNuevo").click(function(){
    opcion = 1; //alta           
    id_Usuario=null;
    $("#formUsuarios").trigger("reset");
    $(".modal-header").css( "background-color", "#17a2b8");
    $(".modal-header").css( "color", "white" );
    $(".modal-title").text("Nuevo Usuario");
    $('#modalCRUDUsu').modal('show');      
});

//Editar        
$(document).on("click", ".btnEditar", function(){               
    opcion = 2;//editar
    fila = $(this).closest("tr");           
    id_Usuario = parseInt(fila.find('td:eq(0)').text()); //capturo el ID                    
    Nombre = fila.find('td:eq(1)').text();
    Apellido_Paterno = fila.find('td:eq(2)').text();
    Apellido_Materno = fila.find('td:eq(3)').text();
    Telefono = fila.find('td:eq(4)').text();
    Direccion = fila.find('td:eq(5)').text();
    CURP = fila.find('td:eq(6)').text();
    Licencia_de_conducir = fila.find('td:eq(7)').text();
    Rol_id = fila.find('td:eq(8)').text();
    $("#Nombre").val(Nombre);
    $("#Apellido_Paterno").val(Apellido_Paterno);
    $("#Apellido_Materno").val(Apellido_Materno);
    $("#Telefono").val(Telefono);
    $("#Direccion").val(Direccion);
    $("#CURP").val(CURP);
    $("#Licencia_de_conducir").val(Licencia_de_conducir);
    $("#Rol_id").val(Rol_id);
    $(".modal-header").css("background-color", "#007bff");
    $(".modal-header").css("color", "white" );
    $(".modal-title").text("Editar Usuario");        
    $('#modalCRUDUsu').modal('show');         
});

//Borrar
$(document).on("click", ".btnBorrar", function(){
    fila = $(this);           
    id_Usuario = parseInt($(this).closest('tr').find('td:eq(0)').text()) ;      
    opcion = 3; //eliminar        
    var respuesta = confirm("¿Está seguro de borrar el registro "+id_Usuario+"?");                
    if (respuesta) {            
        $.ajax({
          url: "CatalogoUsuariosCrud.php",
          type: "POST",
          datatype:"json",    
          data:  {opcion:opcion, id_Usuario:id_Usuario},    
          success: function() {
              tablaUsuarios.row(fila.parents('tr')).remove().draw();                  
           }
        }); 
    }
 });

     
});//FINAL   
$(document).ready(function() {
    var id_Transportes, opcion;
    opcion = 4;
    
    tablaTransportes = $('#tablaTransportes').DataTable({  
        "ajax": {            
            "url": "CatalogoTransCrud.php", 
            "method": 'POST',
            "data": { opcion: opcion },
            "dataSrc": ""
        },
        "columns": [
            {"data": "id_Transportes"},
            {"data": "Ano"},
            {"data": "Placas"},
            {"data": "Capacidad_Carga"},
            {"data": "Modelo"},
            {"data": "Numero_Economico"},
            {"data": "Tipo_Contenedor_Asignado"},
            {"data": "Proveedor_id"},
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
    $('#formTransportes').submit(function(e) {
        e.preventDefault();
        Ano = $.trim($('#Ano').val());
        Placas = $.trim($('#Placas').val());
        Capacidad_Carga = $.trim($('#Capacidad_Carga').val());
        Modelo = $.trim($('#Modelo').val());
        Numero_Economico = $.trim($('#Numero_Economico').val());
        Tipo_Contenedor_Asignado = $.trim($('#Tipo_Contenedor_Asignado').val());
        Proveedor_id = $.trim($('#Proveedor_id').val());  // Agregado el campo Proveedor_id

        $.ajax({
            url: "CatalogoTransCrud.php",
            type: "POST",
            datatype: "json",
            data: { id_Transportes: id_Transportes, Ano: Ano, Placas: Placas, Capacidad_Carga: Capacidad_Carga, Modelo: Modelo, Numero_Economico: Numero_Economico, Tipo_Contenedor_Asignado: Tipo_Contenedor_Asignado, Proveedor_id: Proveedor_id, opcion: opcion },
            success: function(data) {
                tablaTransportes.ajax.reload(null, false);
            }
        });
        $('#modalCRUDTrans').modal('hide');
    });
        
 $('#modalCRUDTrans').on('shown.bs.modal', function () {
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
    id_Transportes=null;
    $("#formTransportes").trigger("reset");
    $(".modal-header").css( "background-color", "#17a2b8");
    $(".modal-header").css( "color", "white" );
    $(".modal-title").text("Nuevo Transporte");
    $('#modalCRUDTrans').modal('show');	    
});

//Editar        
$(document).on("click", ".btnEditar", function(){		        
    opcion = 2;//editar
    fila = $(this).closest("tr");	        
    id_Transportes = parseInt(fila.find('td:eq(0)').text()); //capturo el ID		            
    Ano = fila.find('td:eq(1)').text();
    Placas = fila.find('td:eq(2)').text();
    Capacidad_Carga = fila.find('td:eq(3)').text();
    Modelo = fila.find('td:eq(4)').text();
    Numero_Economico = fila.find('td:eq(5)').text();
    Tipo_Contenedor_Asignado = fila.find('td:eq(6)').text();
    Proveedor_id = fila.find('td:eq(7)').text();
    $("#Ano").val(Ano);
    $("#Placas").val(Placas);
    $("#Capacidad_Carga").val(Capacidad_Carga);
    $("#Modelo").val(Modelo);
    $("#Numero_Economico").val(Numero_Economico);
    $("#Tipo_Contenedor_Asignado").val(Tipo_Contenedor_Asignado);
    $("#Proveedor_id").val(Proveedor_id);
    $(".modal-header").css("background-color", "#007bff");
    $(".modal-header").css("color", "white" );
    $(".modal-title").text("Editar Transporte");		
    $('#modalCRUDTrans').modal('show');		   
});

//Borrar
$(document).on("click", ".btnBorrar", function(){
    fila = $(this);           
    id_Transportes = parseInt($(this).closest('tr').find('td:eq(0)').text()) ;		
    opcion = 3; //eliminar        
    var respuesta = confirm("¿Está seguro de borrar el registro "+id_Transportes+"?");                
    if (respuesta) {            
        $.ajax({
          url: "CatalogoTransCrud.php",
          type: "POST",
          datatype:"json",    
          data:  {opcion:opcion, id_Transportes:id_Transportes},    
          success: function() {
              tablaTransportes.row(fila.parents('tr')).remove().draw();                  
           }
        });	
    }
 });






     
});//FINAL   
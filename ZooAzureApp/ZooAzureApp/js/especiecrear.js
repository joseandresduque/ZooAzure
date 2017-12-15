$(document).ready(function () {
   
    var urlAPI = '/api/ListaClasificacionTipoAnimal';
     $(".loader").show();
    $.get(urlAPI, function (respuesta, estado) {
        var cargarSelectClasi = '';
        var cargarSelectTipoAnimal = '';
        // COMPRUEBO EL ESTADO DE LA LLAMADA
        if (estado === 'success') {
           // cargarSelectClasi += '<option class="bs-title-option" value="">Seleccione una Clasificación</option>';
          //  cargarSelectTipoAnimal += '<option class="bs-title-option"  value="">Seleccionar un tipo de animal</option>';
            $.each(respuesta.data, function (indice, elemento) {
                if (elemento.tipo === "clasificacion") {
                    cargarSelectClasi += '<option value="' + elemento.listaClasificaciones[0].idClasificacion + '">' + elemento.listaClasificaciones[0].denominacion + '</option>';

                } else {
                    cargarSelectTipoAnimal += '<option value="'
                                                + elemento.listaTipoAnimal[0].idTipoAnimal
                                                + '">'
                                                + elemento.listaTipoAnimal[0].denominacion
                                                + '</option>';
                }
            });
        } else {
            console.log("Error ", respuesta);
        }
        $("#idClasificacion").append(cargarSelectClasi);
        $("#idTipoAnimal").append(cargarSelectTipoAnimal);
        $(".loader").hide();
    });

    $('#btnCrearEspecie').click(function () {
        var selectClasificacion = document.getElementById("idClasificacion");
        var idClasificacion = selectClasificacion.options[selectClasificacion.selectedIndex].value;
        var selectTipoAnimal = document.getElementById("idTipoAnimal");
        var idTipoAnimal = selectTipoAnimal.options[selectTipoAnimal.selectedIndex].value;
        var radios = document.getElementsByName("optionsRadios");
        
        var mascota = document.querySelector('input[name = "optionsRadios"]:checked').value;

        console.log(mascota);
        var dataNuevaEspecie = {
            nombre: $('#nombre').val(),
            nPatas: $('#nPatas').val(),
            clasificacion: {
                idClasificacion: idClasificacion
            },
            tipoAnimal: {
                idTipoAnimal: idTipoAnimal
            },
            esMascota: mascota
        };
        console.log(dataNuevaEspecie);
        debugger;
        $.ajax({
            url: '/api/Especies',
            type: "POST",
            dataType: 'json',
            data: dataNuevaEspecie,
            success: function (respuesta) {
                window.location.href = '/index.html';
            },
            error: function (xhr, textStatus, errorThrown) {
                var mensajeError = "ERROR: " + JSON.stringify(errorThrown) +
                                  "\n xhr: " + JSON.stringify(xhr) +
                           "\n textStatus: " + JSON.stringify(textStatus);
                mensajes.showSwal('error','error',mensajeError);
            }
        });
    });

    $('#btnRegresarEspecies').click(function () {
        window.location.href = '/index.html';
    });
});
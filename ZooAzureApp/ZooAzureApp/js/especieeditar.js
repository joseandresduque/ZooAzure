$(document).ready(function () {
   
    var id = window.location.search.substring(1).split('=')[1];
    var urlAPI = '/api/Especies/' + id;

    var clasificacion = '';
    var tipoAnimal = '';

    $(".loader").show();

    var promise = $.get(urlAPI, function (respuesta, estado) {

        if (estado === 'success') {

            $.each(respuesta.data, function (indice, elemento) {

                console.log("Elemento:  ", elemento);
                $('#nombre').val(elemento.nombre);
                $('#nPatas').val(elemento.nPatas);
                clasificacion = elemento.clasificacion.denominacion;
                tipoAnimal = elemento.tipoAnimal.denominacion;
                var mascotas = elemento.esMascotas ? $("#siMascota").addClass("checked") : $("#noMascota").addClass("checked");
            });
        }
    });

    promise.then(function () {
        var urlAPI = '/api/ListaClasificacionTipoAnimal';
         $(".loader").show();
        $.get(urlAPI, function (respuesta, estado) {
            var cargarSelectClasi = '';
            var cargarSelectTipoAnimal = '';
            // COMPRUEBO EL ESTADO DE LA LLAMADA
            if (estado === 'success') {
                //cargarSelectClasi += '<option class="bs-title-option" value="">Seleccione una Clasificación</option>';
                //cargarSelectTipoAnimal += '<option class="bs-title-option"  value="">Seleccionar un tipo de animal</option>';
                $.each(respuesta.data, function (indice, elemento) {
                    if (elemento.tipo === "clasificacion") {
                        if (clasificacion == elemento.listaClasificaciones[0].denominacion) {
                            cargarSelectClasi += '<option value="' + elemento.listaClasificaciones[0].idClasificacion + '"selected>' + elemento.listaClasificaciones[0].denominacion + '</option>';
                        } else {
                            cargarSelectClasi += '<option value="' + elemento.listaClasificaciones[0].idClasificacion + '">' + elemento.listaClasificaciones[0].denominacion + '</option>';
                        }
                    } else {
                        if (tipoAnimal == elemento.listaTipoAnimal[0].denominacion) {
                            cargarSelectTipoAnimal += '<option value="'
                                                    + elemento.listaTipoAnimal[0].idTipoAnimal
                                                    + '"selected>'
                                                    + elemento.listaTipoAnimal[0].denominacion
                                                    + '</option>';
                        } else {
                            cargarSelectTipoAnimal += '<option value="'
                                                        + elemento.listaTipoAnimal[0].idTipoAnimal
                                                        + '">'
                                                        + elemento.listaTipoAnimal[0].denominacion
                                                        + '</option>';
                        }
                    }
                });
            } else {
                console.log("Error ", respuesta);
            }
            $("#idClasificacion").append(cargarSelectClasi);
            $("#idTipoAnimal").append(cargarSelectTipoAnimal);
            $(".loader").hide();
        });
    });

    $('#btnEditarEspecie').click(function () {
        var selectClasificacion = document.getElementById("idClasificacion");
        var idClasificacion = selectClasificacion.options[selectClasificacion.selectedIndex].value;
        var selectTipoAnimal = document.getElementById("idTipoAnimal");
        var idTipoAnimal = selectTipoAnimal.options[selectTipoAnimal.selectedIndex].value;
        var radios = document.getElementsByName("optionsRadios");
       /* if (document.getElementById("option1").checked == true) {
            alert("You have selected Option 1");
        }*/
        var mascotaEdit;
        if ($("#noMascota").hasClass("checked")) {
            mascotaEdit = false;
        } else {
            mascotaEdit = true;
        }
        console.log("Mascota ", mascotaEdit);
       // var mascota = document.querySelector('input[name = "optionsRadios"]:checked').value;

        console.log(mascotaEdit);
        var dataNuevaEspecie = {
            nombre: $('#nombre').val(),
            nPatas: $('#nPatas').val(),
            esMascotas: mascotaEdit,
            clasificacion: {
                idClasificacion: idClasificacion
            },
            tipoAnimal: {
                idTipoAnimal: idTipoAnimal
            }
        };
        $.ajax({
            url: '/api/Especies/' + id,
            type: "PUT",
            dataType: 'json',
            data: dataNuevaEspecie,
            success: function (respuesta) {
                window.location.href = '/index.html';
            },
            error: function (xhr, textStatus, errorThrown) {
                var mensajeError = "ERROR: " + JSON.stringify(errorThrown) +
                                  "\n xhr: " + JSON.stringify(xhr) +
                           "\n textStatus: " + JSON.stringify(textStatus);
                mensajes.showSwal('error');
            }
        });
    });
    $('#btnRegresarEspecies').click(function () {
        window.location.href = '/index.html';       
    });
});
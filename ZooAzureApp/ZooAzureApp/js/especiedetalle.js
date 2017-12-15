$(document).ready(function () {

    var id = window.location.search.substring(1).split('=')[1];
    var urlAPI = '/api/Especies/' + id;
    // PREPARAR LA LLAMDA AJAX 
    $.get(urlAPI, function (respuesta, estado) {

        if (estado === 'success') {

            $.each(respuesta.data, function (indice, elemento) {

                console.log("Elemento:  ", elemento);
                $('#nombre').val(elemento.nombre);
                $('#nPatas').val(elemento.nPatas);
                $('#clasificacion').val(elemento.clasificacion.denominacion);
                $('#tipoAnimal').val(elemento.tipoAnimal.denominacion);
                var mascota = elemento.esMascotas ? 'SI' : 'NO';
                $('#esMascotas').val(mascota);
            });
        }
    });

    $('#btnVovlerEspecie').click(function () {
        window.location.href = '/index.html';
    });
});
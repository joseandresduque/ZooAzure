type = ['', 'info', 'success', 'warning', 'danger'];

mensajes = {
    showSwal: function (type, title, text) {
        if (type == 'aviso') {
            swal({
                title: "Mensaje de aviso",
                text: "¿Estás seguro?",
                type: "info"
            });

        } else if (type == 'error') {
            swal({
                title: "Mensaje de error",
                text: "Esto es un error",
                type: "danger"
            });
        } else if (type == 'exito') {
            swal({
                title: "Éxito",
                text: "Muy bien",
                type: "success"
            });
        }
    },
    checkLogin: function (email, password, cb) {
        //debugger;
        $.ajax({
            type: 'POST',
            url: '/api/login',
            data: {
                email: email,
                password: password
            },
            dataType: 'json',
            success: function (respuesta, textStatus, xhr) {
                if (respuesta !== null && respuesta.error !== '') {
                    //mensajes.showSwal('aviso', 'Aviso', 'Usuario encontrado');

                    return cb(null, respuesta.error);
                }
                if (respuesta.data !== null && respuesta.error === '' && parseInt(respuesta.totalElementos) === 0) {
                    //mensajes.showSwal('error', 'Atención', "Usuario no encontrado ", respuesta.error);
                    // return;

                    return cb(null, 'Usario no encontrado');
                }
                if (respuesta !== null && respuesta.error === '') {
                    //mensajes.showSwal('exito', 'éxito', 'Usuario encontrado');

                    //hacer la reidirección al dashboard.html
                    //window.location.href = "/dashboard.html";
                    //debugger;
                    return cb(respuesta.data[0], null);
                }
                console.log("Correcto " + JSON.stringify(respuesta));
            },
            error: function (xhr, textStatus, errorThrown) {
                console.log("ERROR: " + JSON.stringify(errorThrown) +
                           "\n xhr: " + JSON.stringify(xhr) +
                    "\n textStatus: " + JSON.stringify(textStatus));
            }
        });
    },
    cargarDatosUsuario: function (cb) {
        var datosUsuario = null;
        var obj = localStorage.getItem("usuarioLogeado");
        if (obj !== null && obj !== undefined) {
            datosUsuario = JSON.parse(obj);
        }
        return cb(datosUsuario,null);
    },
    dateToString: function (stringDate) {
        var fechaFomateada = '';
        var fecha = new Date(stringDate);
        var dia = fecha.getDate();
        var mes = fecha.getMonth() + 1;
        fechaFomateada = (dia < 10 ? '0' + dia : dia) + '/' + (mes < 10 ? '0' + mes : mes) + '/' + fecha.getFullYear();
        return fechaFomateada;
    }
};
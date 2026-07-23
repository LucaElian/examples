function iniciarFunciones() {
    const btnVerPassword = document.getElementById("btnVerPassword");
    const btnToggleSidebar = document.getElementById("btnToggleSidebar");

    if (btnVerPassword) {
        btnVerPassword.addEventListener("click", mostrarOcultarPassword);
    }

    if (btnToggleSidebar) {
        btnToggleSidebar.addEventListener("click", mostrarOcultarSidebar);
        cargarEstadoSidebar();
    }

    iniciarSelect2Turnos();
}

if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", iniciarFunciones);
} else {
    iniciarFunciones();
}

/// LOGIN

function mostrarOcultarPassword() {
    const password = document.getElementById("txtPassword");
    const icono = document.getElementById("iconPassword");

    if (!password || !icono) {
        return;
    }

    if (password.type === "password") {
        password.type = "text";
        icono.classList.remove("bi-eye");
        icono.classList.add("bi-eye-slash");
    } else {
        password.type = "password";
        icono.classList.remove("bi-eye-slash");
        icono.classList.add("bi-eye");
    }
}

/// SIDEBAR

function mostrarOcultarSidebar() {
    const layout = document.getElementById("pnlLayout");

    if (!layout) {
        return;
    }

    layout.classList.toggle("sidebar-hidden");

    const estaOculto = layout.classList.contains("sidebar-hidden");

    localStorage.setItem("sidebarHidden", estaOculto);
}

function cargarEstadoSidebar() {
    const layout = document.getElementById("pnlLayout");

    if (!layout) {
        return;
    }

    const sidebarOculto = localStorage.getItem("sidebarHidden");

    if (sidebarOculto === "true") {
        layout.classList.add("sidebar-hidden");
    }
}

/// SELECT2 TURNOS

function iniciarSelect2Turnos() {
    if (typeof $ === "undefined" || !$.fn.select2) {
        return;
    }

    $(".select2-turno").each(function () {
        const select = $(this);

        if (select.hasClass("select2-hidden-accessible")) {
            select.select2("destroy");
        }

        select.select2({
            width: "100%",
            dropdownParent: select.closest(".abml-modal"),
        });
    });
}

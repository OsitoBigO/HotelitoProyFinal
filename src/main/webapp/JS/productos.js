document.addEventListener("DOMContentLoaded", function () {
// Obtener elementos del carrito y botones
    const carrito = document.getElementById("carrito");
    const listaProductos = document.getElementById("lista-productos");
    const verCarritoButton = document.getElementById("ver-carrito");
    const vaciarCarritoButton = document.getElementById("vaciar-carrito");
    const totalcarrito = document.getElementById("cart-total");
    // Verificar si el título del carrito ya se ha agregado
    const carritoTitulo = document.getElementById("carrito-titulo");
    if (!carritoTitulo) {
// Si no existe el título, crearlo
        const nuevoTitulo = document.createElement("h3");
        nuevoTitulo.textContent = "Carrito de Compras";
        nuevoTitulo.style.backgroundColor = "#333"; // Cambiar el color de fondo
        nuevoTitulo.style.color = "#fff"; // Cambiar el color del texto
        nuevoTitulo.id = "carrito-titulo";
        carrito.insertBefore(nuevoTitulo, listaProductos); // Agregar el título antes de la lista de productos
    }

// Manejar clic en "Agregar al carrito"
    const addToCartButtons = document.querySelectorAll("button[name='btnAccion']");
    let total = 0;
    addToCartButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            const productId = button.getAttribute("data-id");
            const nombre = button.getAttribute("data-nombre");
            const precio = button.getAttribute("data-precio");
            // Crear un elemento de lista para mostrar el producto
            const li = document.createElement("li");
            li.textContent = `${nombre} - S/${precio}`;
            listaProductos.appendChild(li);
            total += parseFloat(precio);
            totalcarrito.innerHTML = total;
            console.log(total);
            // Mostrar el carrito
            carrito.style.display = "block";
        });
    });
    
    // 
    const ButtonInicio = document.querySelectorAll("button[name='btnIniciarSesion']");
    ButtonInicio.forEach(function (button) {
        button.addEventListener("click", function () {
            alert("INICIA SESION");
        });
    });

    // Manejar clic en "Ver Carrito"
    verCarritoButton.addEventListener("click", function () {
        if (carrito.style.display === "block") {
            carrito.style.display = "none"; // Si ya está abierto, ciérralo
        } else {
            carrito.style.display = "block"; // Si está cerrado, ábrelo
        }
    });
    // Manejar clic en "Vaciar Carrito"
    vaciarCarritoButton.addEventListener("click", function () {
        listaProductos.innerHTML = ""; // Vaciar la lista de productos
        carrito.style.display = "none"; // Ocultar el carrito
    });
}); 
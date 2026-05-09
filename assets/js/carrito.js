let contadorCarrito = 0;
let contadorFavoritos = 0;

const contadorCarritoElemento = document.getElementById("contador-carrito");
const contadorFavoritosElemento = document.getElementById("contador-favoritos");

const botonesCarrito = document.querySelectorAll(".btn-agregar-carrito");
const botonesFavoritos = document.querySelectorAll(".btn-agregar-favorito");

botonesCarrito.forEach((boton) => {
  boton.addEventListener("click", function () {
    contadorCarrito++;
    contadorCarritoElemento.textContent = contadorCarrito;

    const nombreProducto = boton.dataset.nombre;
    alert(nombreProducto + " fue agregado al carrito");
  });
});

botonesFavoritos.forEach((boton) => {
  boton.addEventListener("click", function () {
    contadorFavoritos++;
    contadorFavoritosElemento.textContent = contadorFavoritos;

    const nombreProducto = boton.dataset.nombre;
    alert(nombreProducto + " fue agregado a favoritos");
  });
});

const listaCarrito = document.getElementById("lista-carrito");
const totalElemento = document.getElementById("resumen-total");
const cantidadTexto = document.getElementById("cantidad-items-texto");

function formatearPrecio(valor) {
  return "$" + valor.toLocaleString("es-CL");
}

function actualizarResumen() {
  const items = document.querySelectorAll(".item-carrito");
  let total = 0;

  items.forEach((item) => {
    total += parseInt(item.dataset.precio);
  });

  totalElemento.textContent = formatearPrecio(total);
  cantidadTexto.textContent = items.length;

  if (items.length === 0) {
    listaCarrito.innerHTML = `
      <div class="alert alert-light border rounded-4 p-4">
        Tu carrito está vacío.
      </div>
    `;
    totalElemento.textContent = "$0";
  }
}

document.addEventListener("click", function (e) {
  if (e.target.classList.contains("btn-eliminar-item")) {
    const item = e.target.closest(".item-carrito");
    item.remove();
    actualizarResumen();
  }
});

actualizarResumen();
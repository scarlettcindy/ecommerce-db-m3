let contadorFavoritos = Number(localStorage.getItem("contadorFavoritos")) || 0;

const contadorCarritoElemento = document.getElementById("contador-carrito");
const contadorFavoritosElemento = document.getElementById("contador-favoritos");

const botonesCarrito = document.querySelectorAll(".btn-agregar-carrito");
const botonesFavoritos = document.querySelectorAll(".btn-agregar-favorito");

const listaCarrito = document.getElementById("lista-carrito");
const cantidadCarrito = document.getElementById("cantidad-carrito");
const totalCarrito = document.getElementById("total-carrito");

function obtenerCarrito() {
  return JSON.parse(localStorage.getItem("carrito")) || [];
}

function guardarCarrito(carrito) {
  localStorage.setItem("carrito", JSON.stringify(carrito));
  localStorage.setItem("contadorCarrito", carrito.length);
}

function pintarContadores() {
  const carrito = obtenerCarrito();

  if (contadorCarritoElemento) {
    contadorCarritoElemento.textContent = carrito.length;
  }

  if (contadorFavoritosElemento) {
    contadorFavoritosElemento.textContent = contadorFavoritos;
  }
}

function pintarCarrito() {
  const carrito = obtenerCarrito();

  if (cantidadCarrito) {
    cantidadCarrito.textContent = `${carrito.length} taller(es) en tu carrito`;
  }

  if (listaCarrito) {
    listaCarrito.innerHTML = "";

    if (carrito.length === 0) {
      listaCarrito.innerHTML = `<p class="carrito-vacio">Tu carrito está vacío.</p>`;
    } else {
      carrito.forEach((producto, index) => {
        const nombre = producto.nombre || "Taller sin nombre";
        const precio = Number(producto.precio) || 0;

        listaCarrito.innerHTML += `
          <div class="item-carrito">
            <div class="item-info">
              <h3>${nombre}</h3>
              <p class="item-autor">Taller digital Klicalia</p>

              <div class="item-detalles">
                <span>Acceso inmediato</span>
                <span>•</span>
                <span>Carrito simulado</span>
              </div>

              <button class="btn-eliminar-item" data-index="${index}">
                Eliminar
              </button>
            </div>

            <div class="item-precio">
              <span class="precio-actual-item">
                $${precio.toLocaleString("es-CL")}
              </span>
            </div>
          </div>
        `;
      });
    }
  }

  if (totalCarrito) {
    const total = carrito.reduce((suma, producto) => {
      return suma + (Number(producto.precio) || 0);
    }, 0);

    totalCarrito.textContent = `$${total.toLocaleString("es-CL")}`;
  }
}

botonesCarrito.forEach((boton) => {
  boton.addEventListener("click", function () {
    const producto = {
      nombre: boton.dataset.nombre || "Taller sin nombre",
      precio: Number(boton.dataset.precio) || 0
    };

    const carrito = obtenerCarrito();
    carrito.push(producto);

    guardarCarrito(carrito);
    pintarContadores();
    pintarCarrito();

    const mensaje = document.getElementById("mensaje-carrito");

    if (mensaje) {
      mensaje.textContent = `${producto.nombre} fue agregado al carrito`;
      mensaje.classList.remove("d-none");

      setTimeout(() => {
        mensaje.classList.add("d-none");
      }, 2000);
    }
  });
});

botonesFavoritos.forEach((boton) => {
  boton.addEventListener("click", function () {
    contadorFavoritos++;
    localStorage.setItem("contadorFavoritos", contadorFavoritos);

    pintarContadores();

    alert((boton.dataset.nombre || "El taller") + " fue agregado a favoritos");
  });
});

document.addEventListener("click", function (e) {
  if (e.target.classList.contains("btn-eliminar-item")) {
    const index = Number(e.target.dataset.index);
    const carrito = obtenerCarrito();

    carrito.splice(index, 1);

    guardarCarrito(carrito);
    pintarCarrito();
    pintarContadores();
  }
});

pintarCarrito();
pintarContadores();
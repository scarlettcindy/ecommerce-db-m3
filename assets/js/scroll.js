console.log("Desde el script externo");

let boton = document.getElementById("btn-arriba");

boton.onclick = function () {
  window.scrollTo({
    top: 0,
    behavior: "smooth"
  });
};

window.addEventListener("scroll", function () {
  if (window.scrollY > 300) {
    boton.style.display = "flex";
  } else {
    boton.style.display = "none";
  }
});
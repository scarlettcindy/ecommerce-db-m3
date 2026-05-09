## Descripción del proyecto

Base de datos relacional para un ecommerce de cursos y talleres digitales.

---

## Objetivo

Simular el funcionamiento de una plataforma donde los usuarios pueden:
- revisar cursos,
- realizar compras,
- registrar pagos.

---

## Planificación de la base de datos

Para desarrollar la base de datos se identificó la información más importante del ecommerce y cómo se relacionaban los datos entre sí.

---

## Entidades identificadas

- Categorias
- Cursos_Talleres
- Clientes
- Ordenes
- Detalle_Orden
- Pagos

---

## Relaciones principales

- Una categoría puede tener muchos cursos.
- Un cliente puede realizar muchas órdenes.
- Una orden puede contener varios cursos.
- Cada orden tiene un pago asociado.
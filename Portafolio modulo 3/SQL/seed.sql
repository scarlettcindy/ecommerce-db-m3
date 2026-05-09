INSERT INTO categorias (nombre, descripcion)
VALUES
('Idiomas', 'Cursos de idiomas'),
('Arte', 'Cursos artisticos'),
('Matematicas', 'Cursos de matematicas'),
('Lectoescritura', 'Cursos de lectura y escritura');

INSERT INTO productos
(id_categoria, nombre, descripcion, precio, activo)
VALUES
(1, 'Ingles Basico', 'Curso inicial de ingles', 5990, TRUE),
(1, 'Ingles Intermedio', 'Curso intermedio de ingles', 7990, TRUE),
(2, 'Arte para Niños', 'Taller creativo infantil', 4990, TRUE),
(3, 'Matematicas Divertidas', 'Curso matematico infantil', 6990, TRUE),
(4, 'Lectoescritura Inicial', 'Aprendizaje de lectura', 5990, TRUE);

INSERT INTO clientes
(nombre, correo, telefono)
VALUES
('Ana Torres', 'ana@gmail.com', '912345678'),
('Luis Rojas', 'luis@gmail.com', '923456789');

INSERT INTO ordenes
(id_cliente, estado, total)
VALUES
(1, 'pagado', 11980),
(2, 'pendiente', 6990);

INSERT INTO detalle_orden
(id_orden, id_producto, cantidad, precio_unitario, subtotal)
VALUES
(1, 1, 1, 5990, 5990),
(1, 5, 1, 5990, 5990),
(2, 4, 1, 6990, 6990);

INSERT INTO pagos
(id_orden, metodo_pago, estado_pago, monto)
VALUES
(1, 'Tarjeta', 'completado', 11980),
(2, 'Transferencia', 'pendiente', 6990);
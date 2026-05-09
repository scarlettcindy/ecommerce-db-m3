-- Búsqueda de productos por categoría
SELECT p.nombre, p.precio, c.nombre AS categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE c.nombre = 'Idiomas';

-- Top 5 productos por ventas
SELECT p.nombre, SUM(d.cantidad) AS cantidad_vendida
FROM detalle_orden d
JOIN productos p ON d.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY cantidad_vendida DESC
LIMIT 5;

-- Ventas por mes y categoría
SELECT 
    DATE_TRUNC('month', o.fecha_orden) AS mes,
    c.nombre AS categoria,
    SUM(d.subtotal) AS total_ventas,
    COUNT(d.id_detalle) AS cantidad_items
FROM detalle_orden d
JOIN ordenes o ON d.id_orden = o.id_orden
JOIN productos p ON d.id_producto = p.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY mes, c.nombre
ORDER BY mes, c.nombre;

-- Ticket promedio en rango de fechas
SELECT AVG(total) AS ticket_promedio
FROM ordenes
WHERE fecha_orden BETWEEN '2026-01-01' AND '2026-12-31';

SELECT ROUND(AVG(total), 0) AS ticket_promedio
FROM ordenes
WHERE fecha_orden BETWEEN '2026-01-01' AND '2026-12-31';

-- Productos sin ventas
SELECT p.nombre
FROM productos p
LEFT JOIN detalle_orden d ON p.id_producto = d.id_producto
WHERE d.id_producto IS NULL;

-- Clientes frecuentes
SELECT c.nombre, COUNT(o.id_orden) AS cantidad_ordenes
FROM clientes c
JOIN ordenes o ON c.id_cliente = o.id_cliente
GROUP BY c.nombre
HAVING COUNT(o.id_orden) >= 2;

-- Consulta relevante para productos digitales: productos activos
SELECT nombre, precio
FROM productos
WHERE activo = TRUE
ORDER BY precio ASC;

-- Transacción: crear una orden con sus productos y recalcular el total

BEGIN;

INSERT INTO ordenes (id_cliente, estado, total)
VALUES (1, 'pagado', 0);

INSERT INTO detalle_orden 
(id_orden, id_producto, cantidad, precio_unitario, subtotal)
VALUES
(currval('ordenes_id_orden_seq'), 1, 1, 5990, 5990),
(currval('ordenes_id_orden_seq'), 3, 1, 4990, 4990);

UPDATE ordenes
SET total = (
    SELECT SUM(subtotal)
    FROM detalle_orden
    WHERE id_orden = currval('ordenes_id_orden_seq')
)
WHERE id_orden = currval('ordenes_id_orden_seq');

INSERT INTO pagos
(id_orden, metodo_pago, estado_pago, monto)
VALUES (
    currval('ordenes_id_orden_seq'),
    'Tarjeta',
    'completado',
    (
        SELECT total
        FROM ordenes
        WHERE id_orden = currval('ordenes_id_orden_seq')
    )
);

COMMIT;

SELECT * FROM ordenes;
SELECT * FROM detalle_orden;
SELECT * FROM pagos;

INSERT INTO detalle_orden
(id_orden, id_producto, cantidad, precio_unitario, subtotal)
VALUES
(1, 1, 2, 5990, 11980),
(1, 5, 1, 5990, 5990),
(2, 4, 3, 6990, 20970);
CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    id_categoria INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio INT NOT NULL CHECK (precio > 0),
    activo BOOLEAN NOT NULL DEFAULT TRUE,

    FOREIGN KEY (id_categoria)
    REFERENCES categorias(id_categoria)
);

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_registro DATE DEFAULT CURRENT_DATE
);

CREATE TABLE ordenes (
    id_orden SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_orden TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(30),
    total INT NOT NULL CHECK (total >= 0),

    FOREIGN KEY (id_cliente)
    REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_orden (
    id_detalle SERIAL PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario INT NOT NULL CHECK (precio_unitario >= 0),
    subtotal INT NOT NULL CHECK (subtotal >= 0),

    FOREIGN KEY (id_orden)
    REFERENCES ordenes(id_orden),

    FOREIGN KEY (id_producto)
    REFERENCES productos(id_producto)
);

CREATE TABLE pagos (
    id_pago SERIAL PRIMARY KEY,
    id_orden INT UNIQUE NOT NULL,
    metodo_pago VARCHAR(50),
    estado_pago VARCHAR(30),
    monto INT NOT NULL CHECK (monto > 0),
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_orden)
    REFERENCES ordenes(id_orden)
);


CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE usuarios (
    id INT  PRIMARY KEY identity(1,1) ,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL CHECK (rol IN ('Cliente', 'Administrador'))
);

CREATE TABLE productos (
    id INT  PRIMARY KEY identity(1,1),
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    marca VARCHAR(100),
    categoria VARCHAR(100),
    estilo VARCHAR(100),
    modelo VARCHAR(100),
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE tallas (
    id INT PRIMARY KEY identity(1,1),
    numero FLOAT NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE colores (
    id INT PRIMARY KEY identity(1,1),
    nombre VARCHAR(50) NOT NULL,
    codigo VARCHAR(10) NOT NULL
);

CREATE TABLE stock (
    id INT PRIMARY KEY identity(1,1),
    producto_id INT NOT NULL,
    talla_id INT NOT NULL,
    color_id INT NOT NULL,
    cantidad_tienda INT DEFAULT 0,
    cantidad_almacen INT DEFAULT 0,
    ubicacion VARCHAR(255),
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
    FOREIGN KEY (talla_id) REFERENCES tallas(id) ON DELETE CASCADE,
    FOREIGN KEY (color_id) REFERENCES colores(id) ON DELETE CASCADE
);

CREATE TABLE carritos (
    id INT PRIMARY KEY identity(1,1),
    cliente_id INT NOT NULL,
    fecha_creacion datetime,
    estado VARCHAR(20) DEFAULT 'Activo' CHECK (estado IN ('Activo', 'Finalizado')),
    FOREIGN KEY (cliente_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE items_carrito (
    id INT PRIMARY KEY identity(1,1),
    carrito_id INT NOT NULL,
    producto_id INT NOT NULL,
    talla_id INT NOT NULL,
    color_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (carrito_id) REFERENCES carritos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
    FOREIGN KEY (talla_id) REFERENCES tallas(id) ON DELETE CASCADE,
    FOREIGN KEY (color_id) REFERENCES colores(id) ON DELETE CASCADE
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY identity(1,1),
    cliente_id INT NOT NULL,
    fecha datetime,
    estado VARCHAR(20) DEFAULT 'Pendiente' CHECK (estado IN ('Pendiente', 'Enviado', 'Entregado')),
    direccion_envio VARCHAR(255) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE detalle_pedidos (
    id INT PRIMARY KEY ,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    talla_id INT NOT NULL,
    color_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
    FOREIGN KEY (talla_id) REFERENCES tallas(id) ON DELETE CASCADE,
    FOREIGN KEY (color_id) REFERENCES colores(id) ON DELETE CASCADE
);

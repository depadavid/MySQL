CREATE DATABASE IF NOT EXISTS logistica;

USE logistica;

-- Gestión de Vehículos
CREATE TABLE IF NOT EXISTS vehiculos (
    vehiculo_id INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(20) UNIQUE NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    capacidad_carga DECIMAL(10,2),
    sucursal_id INT,
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

-- Gestión de Ciudades
CREATE TABLE IF NOT EXISTS ciudades (
    ciudad_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    pais_id INT,
    FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
);

-- Gestión de Sucursales
CREATE TABLE IF NOT EXISTS sucursales (
    sucursal_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(200),
    ciudad_id INT,
    FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

-- Gestión de Países
CREATE TABLE IF NOT EXISTS paises (
    pais_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Gestión de Paquetes
CREATE TABLE IF NOT EXISTS paquetes (
    paquete_id INT AUTO_INCREMENT PRIMARY KEY,
    numero_seguimiento VARCHAR(50) UNIQUE NOT NULL,
    peso DECIMAL(10,2),
    dimensiones VARCHAR(50),
    contenido TEXT,
    valor_declarado DECIMAL(10,2),
    tipo_servicio VARCHAR(50),
    estado VARCHAR(50)
);

-- Gestión de Envíos
CREATE TABLE IF NOT EXISTS envios (
    envio_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    paquete_id INT,
    fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    destino VARCHAR(200),
    ruta_id INT,
    sucursal_id INT,
    vehiculo_id INT,
    conductor_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id),
    FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id),
    FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(vehiculo_id),
    FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id)
);

-- Gestión de Clientes
CREATE TABLE IF NOT EXISTS clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100),
    direccion VARCHAR(200)
);

-- Gestión de Teléfonos de Clientes
CREATE TABLE IF NOT EXISTS telefonos_clientes (
    telefono_id INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(20),
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

-- Seguimiento de Paquetes
CREATE TABLE IF NOT EXISTS seguimiento (
    seguimiento_id INT AUTO_INCREMENT PRIMARY KEY,
    paquete_id INT,
    ubicacion VARCHAR(200),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(50),
    FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id)
);

-- Gestión de Conductores
CREATE TABLE IF NOT EXISTS conductores (
    conductor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Gestión de Teléfonos de Conductores
CREATE TABLE IF NOT EXISTS telefonos_conductores (
    telefono_id INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(20),
    conductor_id INT,
    FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id)
);

-- Gestión de Rutas
CREATE TABLE IF NOT EXISTS rutas (
    ruta_id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(200),
    sucursal_id INT,
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

-- Relación entre Conductores y Rutas
CREATE TABLE IF NOT EXISTS conductores_rutas (
    conductor_id INT,
    ruta_id INT,
    vehiculo_id INT,
    PRIMARY KEY (conductor_id, ruta_id),
    FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id),
    FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(vehiculo_id)
);

-- Gestión de Auxiliares de Reparto
CREATE TABLE IF NOT EXISTS auxiliares_reparto (
    auxiliar_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Relación entre Auxiliares de Reparto y Rutas
CREATE TABLE IF NOT EXISTS auxiliares_rutas (
    auxiliar_id INT,
    ruta_id INT,
    PRIMARY KEY (auxiliar_id, ruta_id),
    FOREIGN KEY (auxiliar_id) REFERENCES auxiliares_reparto(auxiliar_id),
    FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id)
);
CREATE DATABASE IF NOT EXISTS logistica;

USE logistica;

CREATE TABLE IF NOT EXISTS vehiculos (
    vehiculo_id INT,
    placa VARCHAR(20),
    marca VARCHAR(50),
    modelo VARCHAR(50),
    capacidad_carga DECIMAL(10,2),
    sucursal_id INT
);

CREATE TABLE IF NOT EXISTS ciudades (
    ciudad_id INT,
    nombre VARCHAR(100),
    pais_id INT
);

CREATE TABLE IF NOT EXISTS sucursales (
    sucursal_id INT,
    nombre VARCHAR(100),
    direccion VARCHAR(200),
    ciudad_id INT
);

CREATE TABLE IF NOT EXISTS paises (
    pais_id INT,
    nombre VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS paquetes (
    paquete_id INT,
    numero_seguimiento VARCHAR(50),
    peso DECIMAL(10,2),
    dimensiones VARCHAR(50),
    contenido TEXT,
    valor_declarado DECIMAL(10,2),
    tipo_servicio VARCHAR(50),
    estado VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS envios (
    envio_id INT,
    cliente_id INT,
    paquete_id INT,
    fecha_envio TIMESTAMP,
    destino VARCHAR(200),
    ruta_id INT,
    sucursal_id INT
);

CREATE TABLE IF NOT EXISTS clientes (
    cliente_id INT,
    nombre VARCHAR(100),
    email VARCHAR(100),
    direccion VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS seguimiento (
    seguimiento_id INT,
    paquete_id INT,
    ubicacion VARCHAR(200),
    fecha_hora TIMESTAMP,
    estado VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS telefonos_clientes (
    telefono_id INT,
    numero VARCHAR(20),
    cliente_id INT
);

CREATE TABLE IF NOT EXISTS conductores (
    conductor_id INT,
    nombre VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS telefonos_conductores (
    telefono_id INT,
    numero VARCHAR(20),
    conductor_id INT
);

CREATE TABLE IF NOT EXISTS rutas (
    ruta_id INT,
    descripcion VARCHAR(200),
    sucursal_id INT
);

CREATE TABLE IF NOT EXISTS conductores_rutas (
    conductor_id INT,
    ruta_id INT
);
complemente la siguiente base de datos tipo mysql: CREATE DATABASE IF NOT EXISTS logistica; USE logistica; CREATE TABLE IF NOT EXISTS vehiculos (    vehiculo_id INT,    placa VARCHAR(20),    marca VARCHAR(50),    modelo VARCHAR(50),    capacidad_carga DECIMAL(10,2),    sucursal_id INT ); CREATE TABLE IF NOT EXISTS ciudades (    ciudad_id INT,    nombre VARCHAR(100),    pais_id INT ); CREATE TABLE IF NOT EXISTS sucursales (    sucursal_id INT,    nombre VARCHAR(100),    direccion VARCHAR(200),    ciudad_id INT ); CREATE TABLE IF NOT EXISTS paises (    pais_id INT,    nombre VARCHAR(100) ); CREATE TABLE IF NOT EXISTS paquetes (    paquete_id INT,    numero_seguimiento VARCHAR(50),    peso DECIMAL(10,2),    dimensiones VARCHAR(50),    contenido TEXT,    valor_declarado DECIMAL(10,2),    tipo_servicio VARCHAR(50),    estado VARCHAR(50) ); CREATE TABLE IF NOT EXISTS envios (    envio_id INT,    cliente_id INT,    paquete_id INT,    fecha_envio TIMESTAMP,    destino VARCHAR(200),    ruta_id INT,    sucursal_id INT ); CREATE TABLE IF NOT EXISTS clientes (    cliente_id INT,    nombre VARCHAR(100),    email VARCHAR(100),    direccion VARCHAR(200) ); CREATE TABLE IF NOT EXISTS seguimiento (    seguimiento_id INT,    paquete_id INT,    ubicacion VARCHAR(200),    fecha_hora TIMESTAMP,    estado VARCHAR(50) ); CREATE TABLE IF NOT EXISTS telefonos_clientes (    telefono_id INT,    numero VARCHAR(20),    cliente_id INT ); CREATE TABLE IF NOT EXISTS conductores (    conductor_id INT,    nombre VARCHAR(100) ); CREATE TABLE IF NOT EXISTS telefonos_conductores (    telefono_id INT,    numero VARCHAR(20),    conductor_id INT ); CREATE TABLE IF NOT EXISTS rutas (    ruta_id INT,    descripcion VARCHAR(200),    sucursal_id INT ); CREATE TABLE IF NOT EXISTS conductores_rutas (    conductor_id INT,    ruta_id INT ); con la siguiente informacion y cree una base de datos nueva: Gestión de Ubicaciones: Registrar y actualizar información de países y ciudades. Relacionar las sucursales con sus respectivas ciudades y países. 2. Gestión de Sucursales: Registrar y actualizar información de sucursales (nombre, dirección). Clasificar sucursales según su ubicación geográfica. 3. Gestión de Paquetes: Registrar y actualizar información de paquetes (número de seguimiento, peso,  dimensiones, contenido, valor declarado). Clasificar paquetes según su destino y tipo de servicio (nacional, internacional, exprés,  estándar). 4. Gestión de Clientes: Registrar información de los clientes (nombre, correo electrónico, dirección, teléfono). Mantener el historial de envíos de cada cliente. 5. Gestión de Envíos: Procesar envíos realizados por los clientes. Asignar números de seguimiento únicos a cada paquete. Actualizar el estado del envío (recibido, en tránsito, entregado, retenido en aduana). 6. Seguimiento de Paquetes: Registrar eventos de seguimiento de paquetes (ubicación, fecha y hora, estado). Permitir a los clientes y al personal de la empresa rastrear el estado y la ubicación de los  paquetes en tiempo real. 7. Gestión de Rutas, Conductores, Auxiliares de Reparto y Vehículos: Registrar rutas de distribución y los conductores asignados. Registrar vehículos y asignarlos a los conductores. Cada vehículo se identifica por su  placa única. Registrar auxiliares de reparto y asignarlos a conductores y rutas. Cada ruta puede tener  varios auxiliares ayudando al conductor. Optimizar rutas para la entrega eficiente de paquetes. 8. Reportes y Estadísticas: Generar reportes de envíos por cliente y por ruta. Monitorear el estado de los envíos y generar alertas para retrasos. Estadísticas de entrega y eficiencia de las rutas.



GPT-4o + You.com AI

### Complementando la Base de Datos MySQL para Gestión Logística

Para cumplir con los requisitos adicionales de gestión de ubicaciones, sucursales, paquetes, clientes, envíos, seguimiento de paquetes, rutas, conductores, auxiliares de reparto y vehículos, se deben realizar algunas modificaciones y adiciones a la estructura de la base de datos. Aquí está la base de datos complementada:

sql

```sql
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
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id),
    FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
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
    PRIMARY KEY (conductor_id, ruta_id),
    FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id),
    FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id)
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
```

### Explicación de las Modificaciones

1. **Gestión de Ubicaciones**:
   - Se han añadido claves foráneas para relacionar las sucursales con sus respectivas ciudades y países.
2. **Gestión de Sucursales**:
   - Se ha añadido la relación de sucursales con ciudades.
3. **Gestión de Paquetes**:
   - Se ha añadido la columna `numero_seguimiento` como única para asegurar que cada paquete tenga un número de seguimiento único.
4. **Gestión de Clientes**:
   - Se ha añadido la tabla `telefonos_clientes` para registrar múltiples teléfonos por cliente.
5. **Gestión de Envíos**:
   - Se han añadido claves foráneas para relacionar envíos con clientes, paquetes, rutas y sucursales.
6. **Seguimiento de Paquetes**:
   - Se ha añadido la tabla `seguimiento` para registrar eventos de seguimiento de paquetes.
7. **Gestión de Rutas, Conductores, Auxiliares de Reparto y Vehículos**:
   - Se han añadido tablas para gestionar conductores, auxiliares de reparto y sus relaciones con rutas.
   - Se ha añadido la tabla `vehiculos` con una clave foránea para relacionar vehículos con sucursales.

Estas modificaciones aseguran que la base de datos cumpla con los requisitos de gestión logística especificados.

D

a la base de datos actual, agregue las siguientes entidades y atributos necesarios para responder las siguientes consultas: Caso de Uso 1: Registrar un Nuevo País   Descripción: Un administrador desea agregar un nuevo país a la base de datos. Caso de Uso 2: Registrar una Nueva Ciudad   Descripción: Un administrador desea agregar una nueva ciudad asociada a un país existente. Caso de Uso 3: Registrar una Nueva Sucursal   Descripción: Un administrador desea agregar una nueva sucursal asociada a una ciudad  existente. Caso de Uso 4: Registrar un Nuevo Cliente   Descripción: Un administrador desea registrar un nuevo cliente en la base de datos. Caso de Uso 5: Registrar un Nuevo Teléfono para un Cliente   Descripción: Un administrador desea agregar un número de teléfono para un cliente existente. Caso de Uso 6: Registrar un Nuevo Paquete   Descripción: Un administrador desea registrar un nuevo paquete en la base de datos. Caso de Uso 7: Registrar un Nuevo Envío   Descripción: Un administrador desea registrar un nuevo envío, asociando un cliente, paquete,  ruta y sucursal. Caso de Uso 8: Registrar un Nuevo Vehículo   Descripción: Un administrador desea agregar un nuevo vehículo a la base de datos. Caso de Uso 9: Registrar un Nuevo Conductor   Descripción: Un administrador desea agregar un nuevo conductor a la base de datos. Caso de Uso 10: Registrar un Nuevo Teléfono para un  Conductor  Descripción: Un administrador desea agregar un número de teléfono para un conductor  existente. Caso de Uso 11: Asignar un Conductor a una Ruta y un  Vehículo  Descripción: Un administrador desea asignar un conductor a una ruta específica utilizando un  vehículo. Caso de Uso 12: Registrar un Nuevo Auxiliar   Descripción: Un administrador desea agregar un nuevo auxiliar de reparto a la base de datos. Caso de Uso 13: Asignar un Auxiliar a una Ruta   Descripción: Un administrador desea asignar un auxiliar de reparto a una ruta específica. Caso de Uso 14: Registrar un Evento de Seguimiento para un  Paquete  Descripción: Un administrador desea registrar un evento de seguimiento para un paquete. Caso de Uso 15: Generar un Reporte de Envíos por Cliente   Descripción: Un administrador desea generar un reporte de todos los envíos realizados por un  cliente específico. Caso de Uso 16: Actualizar el Estado de un Paquete   Descripción: Un administrador desea actualizar el estado de un paquete específico. Caso de Uso 17: Rastrear la Ubicación Actual de un Paquete   Descripción: Un administrador desea rastrear la ubicación actual de un paquete específico. Casos Multitabla   Caso de Uso 1: Obtener Información Completa de Envíos   Descripción: Un administrador desea obtener la información completa de todos los envíos,  incluyendo detalles del cliente, paquete, ruta, conductor, y sucursal. Caso de Uso 2: Obtener Historial de Envíos de un Cliente   Descripción: Un administrador desea obtener el historial completo de envíos de un cliente  específico, incluyendo detalles de los paquetes y los eventos de seguimiento. Caso de Uso 3: Listar Conductores y sus Rutas Asignadas   Descripción: Un administrador desea obtener una lista de todos los conductores y las rutas a las  que están asignados, incluyendo detalles del vehículo utilizado y la sucursal correspondiente. Caso de Uso 4: Obtener Detalles de Rutas y Auxiliares  Asignados  Descripción: Un administrador desea obtener detalles de todas las rutas, incluyendo los  auxiliares asignados a cada ruta. Caso de Uso 5: Generar Reporte de Paquetes por Sucursal y  Estado  Descripción: Un administrador desea generar un reporte de todos los paquetes agrupados por  sucursal y estado. Caso de Uso 6: Obtener Información Completa de un Paquete  y su Historial de Seguimiento  Descripción: Un administrador desea obtener la información completa de un paquete específico  y su historial de seguimiento. Casos de uso Between, In y Not In   Caso de Uso 1: Obtener Paquetes Enviados Dentro de un  Rango de Fechas  Descripción: Un administrador desea obtener todos los paquetes que fueron enviados dentro de  un rango de fechas específico. Caso de Uso 2: Obtener Paquetes con Ciertos Estados   Descripción: Un administrador desea obtener todos los paquetes que tienen ciertos estados  específicos (por ejemplo, 'en tránsito' o 'entregado'). Caso de Uso 3: Obtener Paquetes Excluyendo Ciertos Estados   Descripción: Un administrador desea obtener todos los paquetes excluyendo aquellos que tienen  ciertos estados específicos (por ejemplo, 'recibido' o 'retenido en aduana'). Caso de Uso 4: Obtener Clientes con Envíos Realizados  Dentro de un Rango de Fechas  Descripción: Un administrador desea obtener todos los clientes que realizaron envíos dentro de  un rango de fechas específico. Caso de Uso 5: Obtener Conductores Disponibles que No  Están Asignados a Ciertas Rutas  Descripción: Un administrador desea obtener todos los conductores que no están asignados a  ciertas rutas específicas. Caso de Uso 6: Obtener Información de Paquetes con Valor  Declarado Dentro de un Rango Específico  Descripción: Un administrador desea obtener todos los paquetes cuyo valor declarado está  dentro de un rango específico. Caso de Uso 7: Obtener Auxiliares Asignados a Rutas  Específicas  Descripción: Un administrador desea obtener todos los auxiliares de reparto que están  asignados a ciertas rutas específicas. Caso de Uso 8: Obtener Envíos a Destinos Excluyendo Ciertas  Ciudades  Descripción: Un administrador desea obtener todos los envíos cuyos destinos no están en ciertas  ciudades específicas. Caso de Uso 9: Obtener Seguimientos de Paquetes en un  Rango de Fechas  Descripción: Un administrador desea obtener todos los eventos de seguimiento de paquetes que  ocurrieron dentro de un rango de fechas específico. Caso de Uso 10: Obtener Clientes que Tienen Ciertos Tipos de  Paquetes  Descripción: Un administrador desea obtener todos los clientes que tienen paquetes de ciertos  tipos específicos (por ejemplo, 'nacional' o 'internacional').



GPT-4o + You.com AI

Para responder a los casos de uso especificados, se deben agregar las siguientes entidades y atributos a la base de datos actual. Aquí está la estructura SQL complementada:

sql

```sql
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
```

### Explicación de las Modificaciones

1. **Registrar un Nuevo País**:
   - La tabla `paises` ya está creada y permite agregar nuevos países.
2. **Registrar una Nueva Ciudad**:
   - La tabla `ciudades` ya está creada y permite agregar nuevas ciudades asociadas a un país existente.
3. **Registrar una Nueva Sucursal**:
   - La tabla `sucursales` ya está creada y permite agregar nuevas sucursales asociadas a una ciudad existente.
4. **Registrar un Nuevo Cliente**:
   - La tabla `clientes` ya está creada y permite registrar nuevos clientes.
5. **Registrar un Nuevo Teléfono para un Cliente**:
   - La tabla `telefonos_clientes` ya está creada y permite agregar números de teléfono para clientes existentes.
6. **Registrar un Nuevo Paquete**:
   - La tabla `paquetes` ya está creada y permite registrar nuevos paquetes.
7. **Registrar un Nuevo Envío**:
   - La tabla `envios` ya está creada y permite registrar nuevos envíos, asociando un cliente, paquete, ruta, sucursal, vehículo y conductor.
8. **Registrar un Nuevo Vehículo**:
   - La tabla `vehiculos` ya está creada y permite agregar nuevos vehículos.
9. **Registrar un Nuevo Conductor**:
   - La tabla `conductores` ya está creada y permite agregar nuevos conductores.
10. **Registrar un Nuevo Teléfono para un Conductor**:
    - La tabla `telefonos_conductores` ya está creada y permite agregar números de teléfono para conductores existentes.
11. **Asignar un Conductor a una Ruta y un Vehículo**:
    - La tabla `conductores_rutas` permite asignar conductores a rutas específicas utilizando un vehículo.
12. **Registrar un Nuevo Auxiliar**:
    - La tabla `auxiliares_reparto` ya está creada y permite agregar nuevos auxiliares de reparto.
13. **Asignar un Auxiliar a una Ruta**:
    - La tabla `auxiliares_rutas` permite asignar auxiliares de reparto a rutas específicas.
14. **Registrar un Evento de Seguimiento para un Paquete**:
    - La tabla `seguimiento` ya está creada y permite registrar eventos de seguimiento para paquetes.
15. **Generar un Reporte de Envíos por Cliente**:
    - Se pueden generar reportes utilizando consultas SQL que unan las tablas `envios` y `clientes`.
16. **Actualizar el Estado de un Paquete**:
    - La tabla `paquetes` permite actualizar el estado de un paquete específico.
17. **Rastrear la Ubicación Actual de un Paquete**:
    - La tabla `seguimiento` permite rastrear la ubicación actual de un paquete específico.

### Consultas Multitabla y Casos de Uso Avanzados

Para los casos de uso multitabla y avanzados, se pueden utilizar consultas SQL que unan múltiples tablas para obtener la información requerida. Aquí algunos ejemplos de consultas:

1. **Obtener Información Completa de Envíos**:

   sql

   ```sql
   SELECT e.envio_id, c.nombre AS cliente, p.numero_seguimiento, r.descripcion AS ruta, d.nombre AS conductor, s.nombre AS sucursal
   FROM envios e
   JOIN clientes c ON e.cliente_id = c.cliente_id
   JOIN paquetes p ON e.paquete_id = p.paquete_id
   JOIN rutas r ON e.ruta_id = r.ruta_id
   JOIN conductores d ON e.conductor_id = d.conductor_id
   JOIN sucursales s ON e.sucursal_id = s.sucursal_id;
   ```

2. **Obtener Historial de Envíos de un Cliente**:

   sql

   ```sql
   SELECT e.envio_id, p.numero_seguimiento, s.ubicacion, s.fecha_hora, s.estado
   FROM envios e
   JOIN paquetes p ON e.paquete_id = p.paquete_id
   JOIN seguimiento s ON p.paquete_id = s.paquete_id
   WHERE e.cliente_id = [ID_DEL_CLIENTE];
   ```

3. **Listar Conductores y sus Rutas Asignadas**:

   sql

   ```sql
   SELECT d.nombre AS conductor, r.descripcion AS ruta, v.placa AS vehiculo, s.nombre AS sucursal
   FROM conductores_rutas cr
   JOIN conductores d ON cr.conductor_id = d.conductor_id
   JOIN rutas r ON cr.ruta_id = r.ruta_id
   JOIN vehiculos v ON cr.vehiculo_id = v.vehiculo_id
   JOIN sucursales s ON r.sucursal_id = s.sucursal_id;
   ```

4. **Obtener Detalles de Rutas y Auxiliares Asignados**:

   sql

   ```sql
   SELECT r.descripcion AS ruta, a.nombre AS auxiliar
   FROM auxiliares_rutas ar
   JOIN rutas r ON ar.ruta_id =
   ```

### Notas Adicionales

- **Referencias**: En MongoDB, las referencias entre documentos se manejan utilizando los `_id` de los documentos referenciados. Esto es similar a las claves foráneas en bases de datos relacionales.
- **Anidamiento**: MongoDB permite anidar documentos, lo que puede ser útil para almacenar datos relacionados directamente dentro de un documento, como los teléfonos de clientes y conductores.
- **Flexibilidad**: MongoDB no requiere un esquema fijo, lo que permite una gran flexibilidad en la estructura de los documentos. Sin embargo, es recomendable mantener cierta coherencia en los campos utilizados para facilitar las consultas y el mantenimiento de la base de datos.

Esta estructura de MongoDB proporciona una base sólida para gestionar la información de logística de manera eficiente y flexible.

Para crear las colecciones y documentos en MongoDB usando `mongosh`, puedes seguir los siguientes pasos. Asegúrate de reemplazar los `ObjectId` con los valores que desees utilizar.

#### Conectar a la Base de Datos

**Primero, abre `mongosh` y conéctate a tu base de datos:**

```sql
show databases
use LogisticaBD
```

Indicaciones para la IA

dame el codigo mongsh que valide los datos para lo siguiente:

Dame un lista de todos los paises para insertar con mongosh

genera el insert many y los id para insertar los paises desde mongosh

genera un objectId aleatorio para cada pais y dame el codigo mongosh para insertarlos todos

#### 1. Crear Colección con validación para Países

**1.1. Primero ingresar lo siguiente:** 

```sql
db.createCollection("paises", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["_id", "nombre"],
      properties: {
        _id: {
          bsonType: "objectId",
          description: "Debe ser un ObjectId y es obligatorio"
        },
        nombre: {
          bsonType: "string",
          description: "Debe ser una cadena de texto y es obligatorio"
        }
      }
    }
  }
})

```

**1.2. Segundo crear la colección**

```sql
db.paises.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4567"),
  nombre: "Nombre del País"
})
```

**1.3. Tercero inseretar la lista de los paises**

```sql
db.paises.insertMany([
  { _id: ObjectId(), nombre: "Afganistán" },
  { _id: ObjectId(), nombre: "Albania" },
  { _id: ObjectId(), nombre: "Alemania" },
  { _id: ObjectId(), nombre: "Andorra" },
  { _id: ObjectId(), nombre: "Angola" },
  { _id: ObjectId(), nombre: "Antigua y Barbuda" },
  { _id: ObjectId(), nombre: "Arabia Saudita" },
  { _id: ObjectId(), nombre: "Argelia" },
  { _id: ObjectId(), nombre: "Argentina" },
  { _id: ObjectId(), nombre: "Armenia" },
  { _id: ObjectId(), nombre: "Australia" },
  { _id: ObjectId(), nombre: "Austria" },
  { _id: ObjectId(), nombre: "Azerbaiyán" },
  { _id: ObjectId(), nombre: "Bahamas" },
  { _id: ObjectId(), nombre: "Bangladés" },
  { _id: ObjectId(), nombre: "Barbados" },
  { _id: ObjectId(), nombre: "Baréin" },
  { _id: ObjectId(), nombre: "Bélgica" },
  { _id: ObjectId(), nombre: "Belice" },
  { _id: ObjectId(), nombre: "Benín" },
  { _id: ObjectId(), nombre: "Bielorrusia" },
  { _id: ObjectId(), nombre: "Birmania" },
  { _id: ObjectId(), nombre: "Bolivia" },
  { _id: ObjectId(), nombre: "Bosnia y Herzegovina" },
  { _id: ObjectId(), nombre: "Botsuana" },
  { _id: ObjectId(), nombre: "Brasil" },
  { _id: ObjectId(), nombre: "Brunéi" },
  { _id: ObjectId(), nombre: "Bulgaria" },
  { _id: ObjectId(), nombre: "Burkina Faso" },
  { _id: ObjectId(), nombre: "Burundi" },
  { _id: ObjectId(), nombre: "Bután" },
  { _id: ObjectId(), nombre: "Cabo Verde" },
  { _id: ObjectId(), nombre: "Camboya" },
  { _id: ObjectId(), nombre: "Camerún" },
  { _id: ObjectId(), nombre: "Canadá" },
  { _id: ObjectId(), nombre: "Catar" },
  { _id: ObjectId(), nombre: "Chad" },
  { _id: ObjectId(), nombre: "Chile" },
  { _id: ObjectId(), nombre: "China" },
  { _id: ObjectId(), nombre: "Chipre" },
  { _id: ObjectId(), nombre: "Ciudad del Vaticano" },
  { _id: ObjectId(), nombre: "Colombia" },
  { _id: ObjectId(), nombre: "Comoras" },
  { _id: ObjectId(), nombre: "Corea del Norte" },
  { _id: ObjectId(), nombre: "Corea del Sur" },
  { _id: ObjectId(), nombre: "Costa de Marfil" },
  { _id: ObjectId(), nombre: "Costa Rica" },
  { _id: ObjectId(), nombre: "Croacia" },
  { _id: ObjectId(), nombre: "Cuba" },
  { _id: ObjectId(), nombre: "Dinamarca" },
  { _id: ObjectId(), nombre: "Dominica" },
  { _id: ObjectId(), nombre: "Ecuador" },
  { _id: ObjectId(), nombre: "Egipto" },
  { _id: ObjectId(), nombre: "El Salvador" },
  { _id: ObjectId(), nombre: "Emiratos Árabes Unidos" },
  { _id: ObjectId(), nombre: "Eritrea" },
  { _id: ObjectId(), nombre: "Eslovaquia" },
  { _id: ObjectId(), nombre: "Eslovenia" },
  { _id: ObjectId(), nombre: "España" },
  { _id: ObjectId(), nombre: "Estados Unidos" },
  { _id: ObjectId(), nombre: "Estonia" },
  { _id: ObjectId(), nombre: "Etiopía" },
  { _id: ObjectId(), nombre: "Filipinas" },
  { _id: ObjectId(), nombre: "Finlandia" },
  { _id: ObjectId(), nombre: "Fiyi" },
  { _id: ObjectId(), nombre: "Francia" },
  { _id: ObjectId(), nombre: "Gabón" },
  { _id: ObjectId(), nombre: "Gambia" },
  { _id: ObjectId(), nombre: "Georgia" },
  { _id: ObjectId(), nombre: "Ghana" },
  { _id: ObjectId(), nombre: "Granada" },
  { _id: ObjectId(), nombre: "Grecia" },
  { _id: ObjectId(), nombre: "Guatemala" },
  { _id: ObjectId(), nombre: "Guinea" },
  { _id: ObjectId(), nombre: "Guinea-Bisáu" },
  { _id: ObjectId(), nombre: "Guinea Ecuatorial" },
  { _id: ObjectId(), nombre: "Guyana" },
  { _id: ObjectId(), nombre: "Haití" },
  { _id: ObjectId(), nombre: "Honduras" },
  { _id: ObjectId(), nombre: "Hungría" },
  { _id: ObjectId(), nombre: "India" },
  { _id: ObjectId(), nombre: "Indonesia" },
  { _id: ObjectId(), nombre: "Irak" },
  { _id: ObjectId(), nombre: "Irán" },
  { _id: ObjectId(), nombre: "Irlanda" },
  { _id: ObjectId(), nombre: "Islandia" },
  { _id: ObjectId(), nombre: "Islas Marshall" },
  { _id: ObjectId(), nombre: "Islas Salomón" },
  { _id: ObjectId(), nombre: "Israel" },
  { _id: ObjectId(), nombre: "Italia" },
  { _id: ObjectId(), nombre: "Jamaica" },
  { _id: ObjectId(), nombre: "Japón" },
  { _id: ObjectId(), nombre: "Jordania" },
  { _id: ObjectId(), nombre: "Kazajistán" },
  { _id: ObjectId(), nombre: "Kenia" },
  { _id: ObjectId(), nombre: "Kirguistán" },
  { _id: ObjectId(), nombre: "Kiribati" },
  { _id: ObjectId(), nombre: "Kuwait" },
  { _id: ObjectId(), nombre: "Laos" },
  { _id: ObjectId(), nombre: "Lesoto" },
  { _id: ObjectId(), nombre: "Letonia" },
  { _id: ObjectId(), nombre: "Líbano" },
  { _id: ObjectId(), nombre: "Liberia" },
  { _id: ObjectId(), nombre: "Libia" },
  { _id: ObjectId(), nombre: "Liechtenstein" },
  { _id: ObjectId(), nombre: "Lituania" },
  { _id: ObjectId(), nombre: "Luxemburgo" },
  { _id: ObjectId(), nombre: "Madagascar" },
  { _id: ObjectId(), nombre: "Malasia" },
  { _id: ObjectId(), nombre: "Malaui" },
  { _id: ObjectId(), nombre: "Maldivas" },
  { _id: ObjectId(), nombre: "Malí" },
  { _id: ObjectId(), nombre: "Malta" },
  { _id: ObjectId(), nombre: "Marruecos" },
  { _id: ObjectId(), nombre: "Mauricio" },
  { _id: ObjectId(), nombre: "Mauritania" },
  { _id: ObjectId(), nombre: "México" },
  { _id: ObjectId(), nombre: "Micronesia" },
  { _id: ObjectId(), nombre: "Moldavia" },
  { _id: ObjectId(), nombre: "Mónaco" },
  { _id: ObjectId(), nombre: "Mongolia" },
  { _id: ObjectId(), nombre: "Montenegro" },
  { _id: ObjectId(), nombre: "Mozambique" },
  { _id: ObjectId(), nombre: "Namibia" },
  { _id: ObjectId(), nombre: "Nauru" },
  { _id: ObjectId(), nombre: "Nepal" },
  { _id: ObjectId(), nombre: "Nicaragua"}
])
```

#### 2. Crear Colección con validación para Ciudades

**2.1. Primero ingresar lo siguiente para validacion:** 

```sql
db.createCollection("ciudades", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["_id", "nombre", "pais_id"],
      properties: {
        _id: {
          bsonType: "objectId",
          description: "Debe ser un ObjectId y es obligatorio"
        },
        nombre: {
          bsonType: "string",
          description: "Debe ser una cadena de texto y es obligatorio"
        },
        pais_id: {
          bsonType: "objectId",
          description: "Debe ser un ObjectId que referencia a un documento en la colección `paises` y es obligatorio"
        }
      }
    }
  }
})

```

**2.2. Segundo crear la colección Ciudades**

```sql
db.ciudades.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4568"),
  nombre: "Nombre de la Ciudad",
  pais_id: ObjectId("60d5ec49f1b2c72f9c8b4567")  // Referencia al documento en la colección `paises`
})
```

**2.3. Tercero inseretar la lista de los ciudades** principales por cada país

```sql
db.ciudades.insertMany([
  { _id: ObjectId(), nombre: "Ciudad Principal del País", pais_id: ObjectId("60d5ec49f1b2c72f9c8b4567") }, // Nombre del País
  { _id: ObjectId(), nombre: "Kabul", pais_id: ObjectId("668d4e58639be215a52c8193") }, // Afganistán
  { _id: ObjectId(), nombre: "Tirana", pais_id: ObjectId("668d4e58639be215a52c8194") }, // Albania
  { _id: ObjectId(), nombre: "Berlín", pais_id: ObjectId("668d4e58639be215a52c8195") }, // Alemania
  { _id: ObjectId(), nombre: "Andorra la Vieja", pais_id: ObjectId("668d4e58639be215a52c8196") }, // Andorra
  { _id: ObjectId(), nombre: "Luanda", pais_id: ObjectId("668d4e58639be215a52c8197") }, // Angola
  { _id: ObjectId(), nombre: "Saint John's", pais_id: ObjectId("668d4e58639be215a52c8198") }  // Antigua y Barbuda
])

db.ciudades.insertMany([
  { _id: ObjectId(), nombre: "Riad", pais_id: ObjectId("668d4e58639be215a52c8199") }, // Arabia Saudita
  { _id: ObjectId(), nombre: "Yeda", pais_id: ObjectId("668d4e58639be215a52c8199") }, // Arabia Saudita
  { _id: ObjectId(), nombre: "La Meca", pais_id: ObjectId("668d4e58639be215a52c8199") }, // Arabia Saudita
  { _id: ObjectId(), nombre: "Argel", pais_id: ObjectId("668d4e58639be215a52c819a") }, // Argelia
  { _id: ObjectId(), nombre: "Orán", pais_id: ObjectId("668d4e58639be215a52c819a") }, // Argelia
  { _id: ObjectId(), nombre: "Constantina", pais_id: ObjectId("668d4e58639be215a52c819a") }, // Argelia
  { _id: ObjectId(), nombre: "Buenos Aires", pais_id: ObjectId("668d4e58639be215a52c819b") }, // Argentina
  { _id: ObjectId(), nombre: "Córdoba", pais_id: ObjectId("668d4e58639be215a52c819b") }, // Argentina
  { _id: ObjectId(), nombre: "Rosario", pais_id: ObjectId("668d4e58639be215a52c819b") }, // Argentina

  { _id: ObjectId(), nombre: "Ereván", pais_id: ObjectId("668d4e58639be215a52c819c") }, // Armenia
  { _id: ObjectId(), nombre: "Gyumri", pais_id: ObjectId("668d4e58639be215a52c819c") }, // Armenia
  { _id: ObjectId(), nombre: "Vanadzor", pais_id: ObjectId("668d4e58639be215a52c819c") }, // Armenia

  { _id: ObjectId(), nombre: "Kabul", pais_id: ObjectId("668d4e9f639be215a52c819d") }, // Afganistán
  { _id: ObjectId(), nombre: "Herat", pais_id: ObjectId("668d4e9f639be215a52c819d") }, // Afganistán
  { _id: ObjectId(), nombre: "Kandahar", pais_id: ObjectId("668d4e9f639be215a52c819d") }, // Afganistán

  { _id: ObjectId(), nombre: "Tirana", pais_id: ObjectId("668d4e9f639be215a52c819e") }]), // Albania
    
db.ciudades.insertMany([
  { _id: ObjectId(), nombre: "Riad", pais_id: ObjectId("668d4e9f639be215a52c81a3") }, // Arabia Saudita
  { _id: ObjectId(), nombre: "Yeda", pais_id: ObjectId("668d4e9f639be215a52c81a3") }, // Arabia Saudita
  { _id: ObjectId(), nombre: "La Meca", pais_id: ObjectId("668d4e9f639be215a52c81a3") }, // Arabia Saudita

  { _id: ObjectId(), nombre: "Argel", pais_id: ObjectId("668d4e9f639be215a52c81a4") }, // Argelia
  { _id: ObjectId(), nombre: "Orán", pais_id: ObjectId("668d4e9f639be215a52c81a4") }, // Argelia
  { _id: ObjectId(), nombre: "Constantina", pais_id: ObjectId("668d4e9f639be215a52c81a4") }, // Argelia

  { _id: ObjectId(), nombre: "Buenos Aires", pais_id: ObjectId("668d4e9f639be215a52c81a5") }, // Argentina
  { _id: ObjectId(), nombre: "Córdoba", pais_id: ObjectId("668d4e9f639be215a52c81a5") }, // Argentina
  { _id: ObjectId(), nombre: "Rosario", pais_id: ObjectId("668d4e9f639be215a52c81a5") }, // Argentina

  { _id: ObjectId(), nombre: "Ereván", pais_id: ObjectId("668d4e9f639be215a52c81a6") }, // Armenia
  { _id: ObjectId(), nombre: "Gyumri", pais_id: ObjectId("668d4e9f639be215a52c81a6") }, // Armenia
  { _id: ObjectId(), nombre: "Vanadzor", pais_id: ObjectId("668d4e9f639be215a52c81a6") }, // Armenia

  { _id: ObjectId(), nombre: "Sídney", pais_id: ObjectId("668d4e9f639be215a52c81a7") }, // Australia
  { _id: ObjectId(), nombre: "Melbourne", pais_id: ObjectId("668d4e9f639be215a52c81a7") }, // Australia
  { _id: ObjectId(), nombre: "Brisbane", pais_id: ObjectId("668d4e9f639be215a52c81a7") }, // Australia

  { _id: ObjectId(), nombre: "Viena", pais_id: ObjectId("668d4e9f639be215a52c81a8") }, // Austria
  { _id: ObjectId(), nombre: "Graz", pais_id: ObjectId("668d4e9f639be215a52c81a8") }, // Austria
  { _id: ObjectId(), nombre: "Linz", pais_id: ObjectId("668d4e9f639be215a52c81a8") }  // Austria
])

db.ciudades.insertMany([
  { _id: ObjectId(), nombre: "Bakú", pais_id: ObjectId("668d4e9f639be215a52c81a9") }, // Azerbaiyán
  { _id: ObjectId(), nombre: "Ganja", pais_id: ObjectId("668d4e9f639be215a52c81a9") }, // Azerbaiyán
  { _id: ObjectId(), nombre: "Sumqayit", pais_id: ObjectId("668d4e9f639be215a52c81a9") }, // Azerbaiyán

  { _id: ObjectId(), nombre: "Nassau", pais_id: ObjectId("668d4e9f639be215a52c81aa") }, // Bahamas
  { _id: ObjectId(), nombre: "Freeport", pais_id: ObjectId("668d4e9f639be215a52c81aa") }, // Bahamas
  { _id: ObjectId(), nombre: "West End", pais_id: ObjectId("668d4e9f639be215a52c81aa") }, // Bahamas

  { _id: ObjectId(), nombre: "Daca", pais_id: ObjectId("668d4e9f639be215a52c81ab") }, // Bangladés
  { _id: ObjectId(), nombre: "Chittagong", pais_id: ObjectId("668d4e9f639be215a52c81ab") }, // Bangladés
  { _id: ObjectId(), nombre: "Khulna", pais_id: ObjectId("668d4e9f639be215a52c81ab") }, // Bangladés

  { _id: ObjectId(), nombre: "Bridgetown", pais_id: ObjectId("668d4e9f639be215a52c81ac") }, // Barbados
  { _id: ObjectId(), nombre: "Speightstown", pais_id: ObjectId("668d4e9f639be215a52c81ac") }, // Barbados
  { _id: ObjectId(), nombre: "Oistins", pais_id: ObjectId("668d4e9f639be215a52c81ac") }, // Barbados

  { _id: ObjectId(), nombre: "Manama", pais_id: ObjectId("668d4e9f639be215a52c81ad") }, // Baréin
  { _id: ObjectId(), nombre: "Riffa", pais_id: ObjectId("668d4e9f639be215a52c81ad") }, // Baréin
  { _id: ObjectId(), nombre: "Muharraq", pais_id: ObjectId("668d4e9f639be215a52c81ad") }, // Baréin

  { _id: ObjectId(), nombre: "Bruselas", pais_id: ObjectId("668d4e9f639be215a52c81ae") }, // Bélgica
  { _id: ObjectId(), nombre: "Amberes", pais_id: ObjectId("668d4e9f639be215a52c81ae") }, // Bélgica
  { _id: ObjectId(), nombre: "Gante", pais_id: ObjectId("668d4e9f639be215a52c81ae") }  // Bélgica
])

db.ciudades.insertMany([
  { _id: ObjectId(), nombre: "Belmopán", pais_id: ObjectId("668d4e9f639be215a52c81af") }, // Belice
  { _id: ObjectId(), nombre: "Ciudad de Belice", pais_id: ObjectId("668d4e9f639be215a52c81af") }, // Belice
  { _id: ObjectId(), nombre: "San Ignacio", pais_id: ObjectId("668d4e9f639be215a52c81af") }, // Belice
  { _id: ObjectId(), nombre: "Porto-Novo", pais_id: ObjectId("668d4e9f639be215a52c81b0") }, // Benín
  { _id: ObjectId(), nombre: "Cotonú", pais_id: ObjectId("668d4e9f639be215a52c81b0") }, // Benín
  { _id: ObjectId(), nombre: "Parakou", pais_id: ObjectId("668d4e9f639be215a52c81b0") }, // Benín
  { _id: ObjectId(), nombre: "Minsk", pais_id: ObjectId("668d4e9f639be215a52c81b1") }, // Bielorrusia
  { _id: ObjectId(), nombre: "Gomel", pais_id: ObjectId("668d4e9f639be215a52c81b1") }, // Bielorrusia
  { _id: ObjectId(), nombre: "Mogilev", pais_id: ObjectId("668d4e9f639be215a52c81b1") }, // Bielorrusia
  { _id: ObjectId(), nombre: "Naypyidó", pais_id: ObjectId("668d4e9f639be215a52c81b2") }, // Birmania
  { _id: ObjectId(), nombre: "Yangón", pais_id: ObjectId("668d4e9f639be215a52c81b2") }, // Birmania
  { _id: ObjectId(), nombre: "Mandalay", pais_id: ObjectId("668d4e9f639be215a52c81b2") }, // Birmania
  { _id: ObjectId(), nombre: "Sucre", pais_id: ObjectId("668d4e9f639be215a52c81b3") }, // Bolivia
  { _id: ObjectId(), nombre: "La Paz", pais_id: ObjectId("668d4e9f639be215a52c81b3") }, // Bolivia
  { _id: ObjectId(), nombre: "Santa Cruz de la Sierra", pais_id: ObjectId("668d4e9f639be215a52c81b3") }  // Bolivia
])

db.ciudades.insertMany([
  { _id: ObjectId(), nombre: "Sarajevo", pais_id: ObjectId("668d4e9f639be215a52c81b4") }, // Bosnia y Herzegovina
  { _id: ObjectId(), nombre: "Mostar", pais_id: ObjectId("668d4e9f639be215a52c81b4") }, // Bosnia y Herzegovina
  { _id: ObjectId(), nombre: "Banja Luka", pais_id: ObjectId("668d4e9f639be215a52c81b4") }, // Bosnia y Herzegovina
  { _id: ObjectId(), nombre: "Gaborone", pais_id: ObjectId("668d4e9f639be215a52c81b5") }, // Botsuana
  { _id: ObjectId(), nombre: "Francistown", pais_id: ObjectId("668d4e9f639be215a52c81b5") }, // Botsuana
  { _id: ObjectId(), nombre: "Molepolole", pais_id: ObjectId("668d4e9f639be215a52c81b5") }, // Botsuana
  { _id: ObjectId(), nombre: "Brasilia", pais_id: ObjectId("668d4e9f639be215a52c81b6") }, // Brasil
  { _id: ObjectId(), nombre: "São Paulo", pais_id: ObjectId("668d4e9f639be215a52c81b6") }, // Brasil
  { _id: ObjectId(), nombre: "Río de Janeiro", pais_id: ObjectId("668d4e9f639be215a52c81b6") }, // Brasil
  { _id: ObjectId(), nombre: "Bandar Seri Begawan", pais_id: ObjectId("668d4e9f639be215a52c81b7") }, // Brunéi
  { _id: ObjectId(), nombre: "Kuala Belait", pais_id: ObjectId("668d4e9f639be215a52c81b7") }, // Brunéi
  { _id: ObjectId(), nombre: "Seria", pais_id: ObjectId("668d4e9f639be215a52c81b7") }, // Brunéi
  { _id: ObjectId(), nombre: "Sofía", pais_id: ObjectId("668d4e9f639be215a52c81b8") }, // Bulgaria
  { _id: ObjectId(), nombre: "Plovdiv", pais_id: ObjectId("668d4e9f639be215a52c81b8") }, // Bulgaria
  { _id: ObjectId(), nombre: "Varna", pais_id: ObjectId("668d4e9f639be215a52c81b8") }, // Bulgaria
  { _id: ObjectId(), nombre: "Uagadugú", pais_id: ObjectId("668d4e9f639be215a52c81b9") }, // Burkina Faso
  { _id: ObjectId(), nombre: "Bobo-Dioulasso", pais_id: ObjectId("668d4e9f639be215a52c81b9") }, // Burkina Faso
  { _id: ObjectId(), nombre: "Koudougou", pais_id: ObjectId("668d4e9f639be215a52c81b9") }  // Burkina Faso
])
db.ciudades.insertMany([
  { _id: ObjectId(), nombre: "Buyumbura", pais_id: ObjectId("668d4e9f639be215a52c81ba") }, // Burundi
  { _id: ObjectId(), nombre: "Gitega", pais_id: ObjectId("668d4e9f639be215a52c81ba") }, // Burundi
  { _id: ObjectId(), nombre: "Ngozi", pais_id: ObjectId("668d4e9f639be215a52c81ba") }, // Burundi
  { _id: ObjectId(), nombre: "Timbu", pais_id: ObjectId("668d4e9f639be215a52c81bb") }, // Bután
  { _id: ObjectId(), nombre: "Phuntsholing", pais_id: ObjectId("668d4e9f639be215a52c81bb") }, // Bután
  { _id: ObjectId(), nombre: "Punakha", pais_id: ObjectId("668d4e9f639be215a52c81bb") }, // Bután
  { _id: ObjectId(), nombre: "Praia", pais_id: ObjectId("668d4e9f639be215a52c81bc") }, // Cabo Verde
  { _id: ObjectId(), nombre: "Mindelo", pais_id: ObjectId("668d4e9f639be215a52c81bc") }, // Cabo Verde
  { _id: ObjectId(), nombre: "Santa Maria", pais_id: ObjectId("668d4e9f639be215a52c81bc") }, // Cabo Verde
  { _id: ObjectId(), nombre: "Nom Pen", pais_id: ObjectId("668d4e9f639be215a52c81bd") }, // Camboya
  { _id: ObjectId(), nombre: "Siem Reap", pais_id: ObjectId("668d4e9f639be215a52c81bd") }, // Camboya
  { _id: ObjectId(), nombre: "Battambang", pais_id: ObjectId("668d4e9f639be215a52c81bd") }, // Camboya
  { _id: ObjectId(), nombre: "Yaundé", pais_id: ObjectId("668d4e9f639be215a52c81be") }, // Camerún
  { _id: ObjectId(), nombre: "Douala", pais_id: ObjectId("668d4e9f639be215a52c81be") }, // Camerún
  { _id: ObjectId(), nombre: "Garoua", pais_id: ObjectId("668d4e9f639be215a52c81be") }  // Camerún
])

db.ciudades.insertMany([
  { _id: ObjectId(), nombre: "Ottawa", pais_id: ObjectId("668d4e9f639be215a52c81bf") }, // Canadá
  { _id: ObjectId(), nombre: "Toronto", pais_id: ObjectId("668d4e9f639be215a52c81bf") }, // Canadá
  { _id: ObjectId(), nombre: "Vancouver", pais_id: ObjectId("668d4e9f639be215a52c81bf") }, // Canadá
  { _id: ObjectId(), nombre: "Doha", pais_id: ObjectId("668d4e9f639be215a52c81c0") }, // Catar
  { _id: ObjectId(), nombre: "Al Rayyan", pais_id: ObjectId("668d4e9f639be215a52c81c0") }, // Catar
  { _id: ObjectId(), nombre: "Umm Salal", pais_id: ObjectId("668d4e9f639be215a52c81c0") }, // Catar
  { _id: ObjectId(), nombre: "Yamena", pais_id: ObjectId("668d4e9f639be215a52c81c1") }, // Chad
  { _id: ObjectId(), nombre: "Moundou", pais_id: ObjectId("668d4e9f639be215a52c81c1") }, // Chad
  { _id: ObjectId(), nombre: "Sarh", pais_id: ObjectId("668d4e9f639be215a52c81c1") }, // Chad
  { _id: ObjectId(), nombre: "Santiago", pais_id: ObjectId("668d4e9f639be215a52c81c2") }, // Chile
  { _id: ObjectId(), nombre: "Valparaíso", pais_id: ObjectId("668d4e9f639be215a52c81c2") }, // Chile
  { _id: ObjectId(), nombre: "Concepción", pais_id: ObjectId("668d4e9f639be215a52c81c2") }, // Chile
  { _id: ObjectId(), nombre: "Pekín", pais_id: ObjectId("668d4e9f639be215a52c81c3") }, // China
  { _id: ObjectId(), nombre: "Shanghái", pais_id: ObjectId("668d4e9f639be215a52c81c3") }, // China
  { _id: ObjectId(), nombre: "Cantón", pais_id: ObjectId("668d4e9f639be215a52c81c3") }, // China
  { _id: ObjectId(), nombre: "Nicosia", pais_id: ObjectId("668d4e9f639be215a52c81c4") }, // Chipre
  { _id: ObjectId(), nombre: "Limassol", pais_id: ObjectId("668d4e9f639be215a52c81c4") }, // Chipre
  { _id: ObjectId(), nombre: "Lárnaca", pais_id: ObjectId("668d4e9f639be215a52c81c4") }, // Chipre
  { _id: ObjectId(), nombre: "Ciudad del Vaticano", pais_id: ObjectId("668d4e9f639be215a52c81c5") }, // Ciudad del Vaticano
  { _id: ObjectId(), nombre: "Bogotá", pais_id: ObjectId("668d4e9f639be215a52c81c6") }, // Colombia
  { _id: ObjectId(), nombre: "Medellín", pais_id: ObjectId("668d4e9f639be215a52c81c6") }, // Colombia
  { _id: ObjectId(), nombre: "Cali", pais_id: ObjectId("668d4e9f639be215a52c81c6") }  // Colombia
])

db.ciudades.insertMany([
  // Comoras
  { _id: ObjectId(), nombre: "Moroni", pais_id: ObjectId("668d4e9f639be215a52c81c7") },
  { _id: ObjectId(), nombre: "Mutsamudu", pais_id: ObjectId("668d4e9f639be215a52c81c7") },
  { _id: ObjectId(), nombre: "Fomboni", pais_id: ObjectId("668d4e9f639be215a52c81c7") },

  // Corea del Norte
  { _id: ObjectId(), nombre: "Pionyang", pais_id: ObjectId("668d4e9f639be215a52c81c8") },
  { _id: ObjectId(), nombre: "Hamhung", pais_id: ObjectId("668d4e9f639be215a52c81c8") },
  { _id: ObjectId(), nombre: "Chongjin", pais_id: ObjectId("668d4e9f639be215a52c81c8") },

  // Corea del Sur
  { _id: ObjectId(), nombre: "Seúl", pais_id: ObjectId("668d4e9f639be215a52c81c9") },
  { _id: ObjectId(), nombre: "Busan", pais_id: ObjectId("668d4e9f639be215a52c81c9") },
  { _id: ObjectId(), nombre: "Incheon", pais_id: ObjectId("668d4e9f639be215a52c81c9") },

  // Costa de Marfil
  { _id: ObjectId(), nombre: "Abiyán", pais_id: ObjectId("668d4e9f639be215a52c81ca") },
  { _id: ObjectId(), nombre: "Bouaké", pais_id: ObjectId("668d4e9f639be215a52c81ca") },
  { _id: ObjectId(), nombre: "Daloa", pais_id: ObjectId("668d4e9f639be215a52c81ca") },

  // Costa Rica
  { _id: ObjectId(), nombre: "San José", pais_id: ObjectId("668d4e9f639be215a52c81cb") },
  { _id: ObjectId(), nombre: "Alajuela", pais_id: ObjectId("668d4e9f639be215a52c81cb") },
  { _id: ObjectId(), nombre: "Cartago", pais_id: ObjectId("668d4e9f639be215a52c81cb") },

  // Croacia
  { _id: ObjectId(), nombre: "Zagreb", pais_id: ObjectId("668d4e9f639be215a52c81cc") },
  { _id: ObjectId(), nombre: "Split", pais_id: ObjectId("668d4e9f639be215a52c81cc") },
  { _id: ObjectId(), nombre: "Rijeka", pais_id: ObjectId("668d4e9f639be215a52c81cc") },

  // Cuba
  { _id: ObjectId(), nombre: "La Habana", pais_id: ObjectId("668d4e9f639be215a52c81cd") },
  { _id: ObjectId(), nombre: "Santiago de Cuba", pais_id: ObjectId("668d4e9f639be215a52c81cd") },
  { _id: ObjectId(), nombre: "Camagüey", pais_id: ObjectId("668d4e9f639be215a52c81cd") },

  // Dinamarca
  { _id: ObjectId(), nombre: "Copenhague", pais_id: ObjectId("668d4e9f639be215a52c81ce") },
  { _id: ObjectId(), nombre: "Aarhus", pais_id: ObjectId("668d4e9f639be215a52c81ce") },
  { _id: ObjectId(), nombre: "Odense", pais_id: ObjectId("668d4e9f639be215a52c81ce") },

  // Dominica
  { _id: ObjectId(), nombre: "Roseau", pais_id: ObjectId("668d4e9f639be215a52c81cf") },
  { _id: ObjectId(), nombre: "Portsmouth", pais_id: ObjectId("668d4e9f639be215a52c81cf") },
  { _id: ObjectId(), nombre: "Marigot", pais_id: ObjectId("668d4e9f639be215a52c81cf") }
])

db.ciudades.insertMany([
  // Ecuador
  { _id: ObjectId(), nombre: "Quito", pais_id: ObjectId("668d4e9f639be215a52c81d0") },
  { _id: ObjectId(), nombre: "Guayaquil", pais_id: ObjectId("668d4e9f639be215a52c81d0") },
  { _id: ObjectId(), nombre: "Cuenca", pais_id: ObjectId("668d4e9f639be215a52c81d0") },

  // Egipto
  { _id: ObjectId(), nombre: "El Cairo", pais_id: ObjectId("668d4e9f639be215a52c81d1") },
  { _id: ObjectId(), nombre: "Alejandría", pais_id: ObjectId("668d4e9f639be215a52c81d1") },
  { _id: ObjectId(), nombre: "Giza", pais_id: ObjectId("668d4e9f639be215a52c81d1") },

  // El Salvador
  { _id: ObjectId(), nombre: "San Salvador", pais_id: ObjectId("668d4e9f639be215a52c81d2") },
  { _id: ObjectId(), nombre: "Santa Ana", pais_id: ObjectId("668d4e9f639be215a52c81d2") },
  { _id: ObjectId(), nombre: "San Miguel", pais_id: ObjectId("668d4e9f639be215a52c81d2") },

  // Emiratos Árabes Unidos
  { _id: ObjectId(), nombre: "Dubái", pais_id: ObjectId("668d4e9f639be215a52c81d3") },
  { _id: ObjectId(), nombre: "Abu Dabi", pais_id: ObjectId("668d4e9f639be215a52c81d3") },
  { _id: ObjectId(), nombre: "Sharjah", pais_id: ObjectId("668d4e9f639be215a52c81d3") },

  // Eritrea
  { _id: ObjectId(), nombre: "Asmara", pais_id: ObjectId("668d4e9f639be215a52c81d4") },
  { _id: ObjectId(), nombre: "Keren", pais_id: ObjectId("668d4e9f639be215a52c81d4") },
  { _id: ObjectId(), nombre: "Massawa", pais_id: ObjectId("668d4e9f639be215a52c81d4") },

  // Eslovaquia
  { _id: ObjectId(), nombre: "Bratislava", pais_id: ObjectId("668d4e9f639be215a52c81d5") },
  { _id: ObjectId(), nombre: "Košice", pais_id: ObjectId("668d4e9f639be215a52c81d5") },
  { _id: ObjectId(), nombre: "Prešov", pais_id: ObjectId("668d4e9f639be215a52c81d5") },

  // Eslovenia
  { _id: ObjectId(), nombre: "Liubliana", pais_id: ObjectId("668d4e9f639be215a52c81d6") },
  { _id: ObjectId(), nombre: "Maribor", pais_id: ObjectId("668d4e9f639be215a52c81d6") },
  { _id: ObjectId(), nombre: "Celje", pais_id: ObjectId("668d4e9f639be215a52c81d6") },

  // España
  { _id: ObjectId(), nombre: "Madrid", pais_id: ObjectId("668d4e9f639be215a52c81d7") },
  { _id: ObjectId(), nombre: "Barcelona", pais_id: ObjectId("668d4e9f639be215a52c81d7") },
  { _id: ObjectId(), nombre: "Valencia", pais_id: ObjectId("668d4e9f639be215a52c81d7") },

  // Estados Unidos
  { _id: ObjectId(), nombre: "Nueva York", pais_id: ObjectId("668d4e9f639be215a52c81d8") },
  { _id: ObjectId(), nombre: "Los Ángeles", pais_id: ObjectId("668d4e9f639be215a52c81d8") },
  { _id: ObjectId(), nombre: "Chicago", pais_id: ObjectId("668d4e9f639be215a52c81d8") }
])

db.ciudades.insertMany([
  // Estonia
  { _id: ObjectId(), nombre: "Tallin", pais_id: ObjectId("668d4e9f639be215a52c81d9") },
  { _id: ObjectId(), nombre: "Tartu", pais_id: ObjectId("668d4e9f639be215a52c81d9") },
  { _id: ObjectId(), nombre: "Narva", pais_id: ObjectId("668d4e9f639be215a52c81d9") },

  // Etiopía
  { _id: ObjectId(), nombre: "Adís Abeba", pais_id: ObjectId("668d4e9f639be215a52c81da") },
  { _id: ObjectId(), nombre: "Dire Dawa", pais_id: ObjectId("668d4e9f639be215a52c81da") },
  { _id: ObjectId(), nombre: "Mekele", pais_id: ObjectId("668d4e9f639be215a52c81da") },

  // Filipinas
  { _id: ObjectId(), nombre: "Manila", pais_id: ObjectId("668d4e9f639be215a52c81db") },
  { _id: ObjectId(), nombre: "Quezon City", pais_id: ObjectId("668d4e9f639be215a52c81db") },
  { _id: ObjectId(), nombre: "Caloocan", pais_id: ObjectId("668d4e9f639be215a52c81db") },

  // Finlandia
  { _id: ObjectId(), nombre: "Helsinki", pais_id: ObjectId("668d4e9f639be215a52c81dc") },
  { _id: ObjectId(), nombre: "Espoo", pais_id: ObjectId("668d4e9f639be215a52c81dc") },
  { _id: ObjectId(), nombre: "Tampere", pais_id: ObjectId("668d4e9f639be215a52c81dc") },

  // Fiyi
  { _id: ObjectId(), nombre: "Suva", pais_id: ObjectId("668d4e9f639be215a52c81dd") },
  { _id: ObjectId(), nombre: "Nadi", pais_id: ObjectId("668d4e9f639be215a52c81dd") },
  { _id: ObjectId(), nombre: "Lautoka", pais_id: ObjectId("668d4e9f639be215a52c81dd") },

  // Francia
  { _id: ObjectId(), nombre: "París", pais_id: ObjectId("668d4e9f639be215a52c81de") },
  { _id: ObjectId(), nombre: "Marsella", pais_id: ObjectId("668d4e9f639be215a52c81de") },
  { _id: ObjectId(), nombre: "Lyon", pais_id: ObjectId("668d4e9f639be215a52c81de") },

  // Gabón
  { _id: ObjectId(), nombre: "Libreville", pais_id: ObjectId("668d4e9f639be215a52c81df") },
  { _id: ObjectId(), nombre: "Port-Gentil", pais_id: ObjectId("668d4e9f639be215a52c81df") },
  { _id: ObjectId(), nombre: "Franceville", pais_id: ObjectId("668d4e9f639be215a52c81df") },

  // Gambia
  { _id: ObjectId(), nombre: "Banjul", pais_id: ObjectId("668d4e9f639be215a52c81e0") },
  { _id: ObjectId(), nombre: "Serekunda", pais_id: ObjectId("668d4e9f639be215a52c81e0") },
  { _id: ObjectId(), nombre: "Brikama", pais_id: ObjectId("668d4e9f639be215a52c81e0") },

  // Georgia
  { _id: ObjectId(), nombre: "Tiflis", pais_id: ObjectId("668d4e9f639be215a52c81e1") },
  { _id: ObjectId(), nombre: "Kutaisi", pais_id: ObjectId("668d4e9f639be215a52c81e1") },
  { _id: ObjectId(), nombre: "Batumi", pais_id: ObjectId("668d4e9f639be215a52c81e1") },

  // Ghana
  { _id: ObjectId(), nombre: "Acra", pais_id: ObjectId("668d4e9f639be215a52c81e2") },
  { _id: ObjectId(), nombre: "Kumasi", pais_id: ObjectId("668d4e9f639be215a52c81e2") },
  { _id: ObjectId(), nombre: "Tamale", pais_id: ObjectId("668d4e9f639be215a52c81e2") },

  // Granada
  { _id: ObjectId(), nombre: "Saint George's", pais_id: ObjectId("668d4e9f639be215a52c81e3") },
  { _id: ObjectId(), nombre: "Gouyave", pais_id: ObjectId("668d4e9f639be215a52c81e3") },
  { _id: ObjectId(), nombre: "Grenville", pais_id: ObjectId("668d4e9f639be215a52c81e3") },

  // Grecia
  { _id: ObjectId(), nombre: "Atenas", pais_id: ObjectId("668d4e9f639be215a52c81e4") },
  { _id: ObjectId(), nombre: "Salónica", pais_id: ObjectId("668d4e9f639be215a52c81e4") },
  { _id: ObjectId(), nombre: "Patras", pais_id: ObjectId("668d4e9f639be215a52c81e4") },

  // Guatemala
  { _id: ObjectId(), nombre: "Ciudad de Guatemala", pais_id: ObjectId("668d4e9f639be215a52c81e5") },
  { _id: ObjectId(), nombre: "Mixco", pais_id: ObjectId("668d4e9f639be215a52c81e5") },
  { _id: ObjectId(), nombre: "Villa Nueva", pais_id: ObjectId("668d4e9f639be215a52c81e5") }
])
db.ciudades.insertMany([
  // Guinea
  { _id: ObjectId(), nombre: "Conakri", pais_id: ObjectId("668d4e9f639be215a52c81e6") },
  { _id: ObjectId(), nombre: "Nzérékoré", pais_id: ObjectId("668d4e9f639be215a52c81e6") },
  { _id: ObjectId(), nombre: "Kankan", pais_id: ObjectId("668d4e9f639be215a52c81e6") },

  // Guinea-Bisáu
  { _id: ObjectId(), nombre: "Bisáu", pais_id: ObjectId("668d4e9f639be215a52c81e7") },
  { _id: ObjectId(), nombre: "Bafatá", pais_id: ObjectId("668d4e9f639be215a52c81e7") },
  { _id: ObjectId(), nombre: "Gabú", pais_id: ObjectId("668d4e9f639be215a52c81e7") },

  // Guinea Ecuatorial
  { _id: ObjectId(), nombre: "Malabo", pais_id: ObjectId("668d4e9f639be215a52c81e8") },
  { _id: ObjectId(), nombre: "Bata", pais_id: ObjectId("668d4e9f639be215a52c81e8") },
  { _id: ObjectId(), nombre: "Ebebiyín", pais_id: ObjectId("668d4e9f639be215a52c81e8") },

  // Guyana
  { _id: ObjectId(), nombre: "Georgetown", pais_id: ObjectId("668d4e9f639be215a52c81e9") },
  { _id: ObjectId(), nombre: "Linden", pais_id: ObjectId("668d4e9f639be215a52c81e9") },
  { _id: ObjectId(), nombre: "New Amsterdam", pais_id: ObjectId("668d4e9f639be215a52c81e9") },

  // Haití
  { _id: ObjectId(), nombre: "Puerto Príncipe", pais_id: ObjectId("668d4e9f639be215a52c81ea") },
  { _id: ObjectId(), nombre: "Cap-Haïtien", pais_id: ObjectId("668d4e9f639be215a52c81ea") },
  { _id: ObjectId(), nombre: "Gonaïves", pais_id: ObjectId("668d4e9f639be215a52c81ea") },

  // Honduras
  { _id: ObjectId(), nombre: "Tegucigalpa", pais_id: ObjectId("668d4e9f639be215a52c81eb") },
  { _id: ObjectId(), nombre: "San Pedro Sula", pais_id: ObjectId("668d4e9f639be215a52c81eb") },
  { _id: ObjectId(), nombre: "La Ceiba", pais_id: ObjectId("668d4e9f639be215a52c81eb") },

  // Hungría
  { _id: ObjectId(), nombre: "Budapest", pais_id: ObjectId("668d4e9f639be215a52c81ec") },
  { _id: ObjectId(), nombre: "Debrecen", pais_id: ObjectId("668d4e9f639be215a52c81ec") },
  { _id: ObjectId(), nombre: "Szeged", pais_id: ObjectId("668d4e9f639be215a52c81ec") },

  // India
  { _id: ObjectId(), nombre: "Nueva Delhi", pais_id: ObjectId("668d4e9f639be215a52c81ed") },
  { _id: ObjectId(), nombre: "Bombay", pais_id: ObjectId("668d4e9f639be215a52c81ed") },
  { _id: ObjectId(), nombre: "Bangalore", pais_id: ObjectId("668d4e9f639be215a52c81ed") },

  // Indonesia
  { _id: ObjectId(), nombre: "Yakarta", pais_id: ObjectId("668d4e9f639be215a52c81ee") },
  { _id: ObjectId(), nombre: "Surabaya", pais_id: ObjectId("668d4e9f639be215a52c81ee") },
  { _id: ObjectId(), nombre: "Bandung", pais_id: ObjectId("668d4e9f639be215a52c81ee") },

  // Irak
  { _id: ObjectId(), nombre: "Bagdad", pais_id: ObjectId("668d4e9f639be215a52c81ef") },
  { _id: ObjectId(), nombre: "Basora", pais_id: ObjectId("668d4e9f639be215a52c81ef") },
  { _id: ObjectId(), nombre: "Mosul", pais_id: ObjectId("668d4e9f639be215a52c81ef") },

  // Irán
  { _id: ObjectId(), nombre: "Teherán", pais_id: ObjectId("668d4e9f639be215a52c81f0") },
  { _id: ObjectId(), nombre: "Mashhad", pais_id: ObjectId("668d4e9f639be215a52c81f0") },
  { _id: ObjectId(), nombre: "Isfahán", pais_id: ObjectId("668d4e9f639be215a52c81f0") },

  // Irlanda
  { _id: ObjectId(), nombre: "Dublín", pais_id: ObjectId("668d4e9f639be215a52c81f1") },
  { _id: ObjectId(), nombre: "Cork", pais_id: ObjectId("668d4e9f639be215a52c81f1") },
  { _id: ObjectId(), nombre: "Limerick", pais_id: ObjectId("668d4e9f639be215a52c81f1") },

  // Islandia
  { _id: ObjectId(), nombre: "Reikiavik", pais_id: ObjectId("668d4e9f639be215a52c81f2") },
  { _id: ObjectId(), nombre: "Kópavogur", pais_id: ObjectId("668d4e9f639be215a52c81f2") },
  { _id: ObjectId(), nombre: "Hafnarfjörður", pais_id: ObjectId("668d4e9f639be215a52c81f2") },

  // Islas Marshall
  { _id: ObjectId(), nombre: "Majuro", pais_id: ObjectId("668d4e9f639be215a52c81f3") },
  { _id: ObjectId(), nombre: "Ebeye", pais_id: ObjectId("668d4e9f639be215a52c81f3") },
  { _id: ObjectId(), nombre: "Rongelap", pais_id: ObjectId("668d4e9f639be215a52c81f3") },

  // Islas Salomón
  { _id: ObjectId(), nombre: "Honiara", pais_id: ObjectId("668d4e9f639be215a52c81f4") },
  { _id: ObjectId(), nombre: "Gizo", pais_id: ObjectId("668d4e9f639be215a52c81f4") },
  { _id: ObjectId(), nombre: "Auki", pais_id: ObjectId("668d4e9f639be215a52c81f4") },

  // Israel
  { _id: ObjectId(), nombre: "Jerusalén", pais_id: ObjectId("668d4e9f639be215a52c81f5") },
  { _id: ObjectId(), nombre: "Tel Aviv", pais_id: ObjectId("668d4e9f639be215a52c81f5") },
  { _id: ObjectId(), nombre: "Haifa", pais_id: ObjectId("668d4e9f639be215a52c81f5") }
])

db.ciudades.insertMany([
  // Italia
  { _id: ObjectId(), nombre: "Roma", pais_id: ObjectId("668d4e9f639be215a52c81f6") },
  { _id: ObjectId(), nombre: "Milán", pais_id: ObjectId("668d4e9f639be215a52c81f6") },
  { _id: ObjectId(), nombre: "Nápoles", pais_id: ObjectId("668d4e9f639be215a52c81f6") },

  // Jamaica
  { _id: ObjectId(), nombre: "Kingston", pais_id: ObjectId("668d4e9f639be215a52c81f7") },
  { _id: ObjectId(), nombre: "Montego Bay", pais_id: ObjectId("668d4e9f639be215a52c81f7") },
  { _id: ObjectId(), nombre: "Spanish Town", pais_id: ObjectId("668d4e9f639be215a52c81f7") },

  // Japón
  { _id: ObjectId(), nombre: "Tokio", pais_id: ObjectId("668d4e9f639be215a52c81f8") },
  { _id: ObjectId(), nombre: "Osaka", pais_id: ObjectId("668d4e9f639be215a52c81f8") },
  { _id: ObjectId(), nombre: "Yokohama", pais_id: ObjectId("668d4e9f639be215a52c81f8") },

  // Jordania
  { _id: ObjectId(), nombre: "Ammán", pais_id: ObjectId("668d4e9f639be215a52c81f9") },
  { _id: ObjectId(), nombre: "Zarqa", pais_id: ObjectId("668d4e9f639be215a52c81f9") },
  { _id: ObjectId(), nombre: "Irbid", pais_id: ObjectId("668d4e9f639be215a52c81f9") },

  // Kazajistán
  { _id: ObjectId(), nombre: "Nursultán", pais_id: ObjectId("668d4e9f639be215a52c81fa") },
  { _id: ObjectId(), nombre: "Almatý", pais_id: ObjectId("668d4e9f639be215a52c81fa") },
  { _id: ObjectId(), nombre: "Shymkent", pais_id: ObjectId("668d4e9f639be215a52c81fa") },

  // Kenia
  { _id: ObjectId(), nombre: "Nairobi", pais_id: ObjectId("668d4e9f639be215a52c81fb") },
  { _id: ObjectId(), nombre: "Mombasa", pais_id: ObjectId("668d4e9f639be215a52c81fb") },
  { _id: ObjectId(), nombre: "Kisumu", pais_id: ObjectId("668d4e9f639be215a52c81fb") },

  // Kirguistán
  { _id: ObjectId(), nombre: "Biskek", pais_id: ObjectId("668d4e9f639be215a52c81fc") },
  { _id: ObjectId(), nombre: "Osh", pais_id: ObjectId("668d4e9f639be215a52c81fc") },
  { _id: ObjectId(), nombre: "Jalal-Abad", pais_id: ObjectId("668d4e9f639be215a52c81fc") },

  // Kiribati
  { _id: ObjectId(), nombre: "Tarawa", pais_id: ObjectId("668d4e9f639be215a52c81fd") },
  { _id: ObjectId(), nombre: "Betio", pais_id: ObjectId("668d4e9f639be215a52c81fd") },
  { _id: ObjectId(), nombre: "Bikenibeu", pais_id: ObjectId("668d4e9f639be215a52c81fd") }
])

db.ciudades.insertMany([
  // Kuwait
  { _id: ObjectId(), nombre: "Kuwait City", pais_id: ObjectId("668d4e9f639be215a52c81fe") },
  { _id: ObjectId(), nombre: "Al Ahmadi", pais_id: ObjectId("668d4e9f639be215a52c81fe") },
  { _id: ObjectId(), nombre: "Hawalli", pais_id: ObjectId("668d4e9f639be215a52c81fe") },

  // Laos
  { _id: ObjectId(), nombre: "Vientián", pais_id: ObjectId("668d4e9f639be215a52c81ff") },
  { _id: ObjectId(), nombre: "Luang Prabang", pais_id: ObjectId("668d4e9f639be215a52c81ff") },
  { _id: ObjectId(), nombre: "Pakse", pais_id: ObjectId("668d4e9f639be215a52c81ff") },

  // Lesoto
  { _id: ObjectId(), nombre: "Maseru", pais_id: ObjectId("668d4e9f639be215a52c8200") },
  { _id: ObjectId(), nombre: "Teyateyaneng", pais_id: ObjectId("668d4e9f639be215a52c8200") },
  { _id: ObjectId(), nombre: "Mafeteng", pais_id: ObjectId("668d4e9f639be215a52c8200") },

  // Letonia
  { _id: ObjectId(), nombre: "Riga", pais_id: ObjectId("668d4e9f639be215a52c8201") },
  { _id: ObjectId(), nombre: "Daugavpils", pais_id: ObjectId("668d4e9f639be215a52c8201") },
  { _id: ObjectId(), nombre: "Liepāja", pais_id: ObjectId("668d4e9f639be215a52c8201") },

  // Líbano
  { _id: ObjectId(), nombre: "Beirut", pais_id: ObjectId("668d4e9f639be215a52c8202") },
  { _id: ObjectId(), nombre: "Trípoli", pais_id: ObjectId("668d4e9f639be215a52c8202") },
  { _id: ObjectId(), nombre: "Sidón", pais_id: ObjectId("668d4e9f639be215a52c8202") },

  // Liberia
  { _id: ObjectId(), nombre: "Monrovia", pais_id: ObjectId("668d4e9f639be215a52c8203") },
  { _id: ObjectId(), nombre: "Gbarnga", pais_id: ObjectId("668d4e9f639be215a52c8203") },
  { _id: ObjectId(), nombre: "Kakata", pais_id: ObjectId("668d4e9f639be215a52c8203") }
])

db.ciudades.insertMany([
  // Libia
  { _id: ObjectId(), nombre: "Trípoli", pais_id: ObjectId("668d4e9f639be215a52c8204") },
  { _id: ObjectId(), nombre: "Bengasi", pais_id: ObjectId("668d4e9f639be215a52c8204") },
  { _id: ObjectId(), nombre: "Misurata", pais_id: ObjectId("668d4e9f639be215a52c8204") },

  // Liechtenstein
  { _id: ObjectId(), nombre: "Vaduz", pais_id: ObjectId("668d4e9f639be215a52c8205") },
  { _id: ObjectId(), nombre: "Schaan", pais_id: ObjectId("668d4e9f639be215a52c8205") },
  { _id: ObjectId(), nombre: "Balzers", pais_id: ObjectId("668d4e9f639be215a52c8205") },

  // Lituania
  { _id: ObjectId(), nombre: "Vilna", pais_id: ObjectId("668d4e9f639be215a52c8206") },
  { _id: ObjectId(), nombre: "Kaunas", pais_id: ObjectId("668d4e9f639be215a52c8206") },
  { _id: ObjectId(), nombre: "Klaipėda", pais_id: ObjectId("668d4e9f639be215a52c8206") },

  // Luxemburgo
  { _id: ObjectId(), nombre: "Luxemburgo", pais_id: ObjectId("668d4e9f639be215a52c8207") },
  { _id: ObjectId(), nombre: "Esch-sur-Alzette", pais_id: ObjectId("668d4e9f639be215a52c8207") },
  { _id: ObjectId(), nombre: "Differdange", pais_id: ObjectId("668d4e9f639be215a52c8207") },

  // Madagascar
  { _id: ObjectId(), nombre: "Antananarivo", pais_id: ObjectId("668d4e9f639be215a52c8208") },
  { _id: ObjectId(), nombre: "Toamasina", pais_id: ObjectId("668d4e9f639be215a52c8208") },
  { _id: ObjectId(), nombre: "Antsirabe", pais_id: ObjectId("668d4e9f639be215a52c8208") },

  // Malasia
  { _id: ObjectId(), nombre: "Kuala Lumpur", pais_id: ObjectId("668d4e9f639be215a52c8209") },
  { _id: ObjectId(), nombre: "George Town", pais_id: ObjectId("668d4e9f639be215a52c8209") },
  { _id: ObjectId(), nombre: "Ipoh", pais_id: ObjectId("668d4e9f639be215a52c8209") }
])

db.ciudades.insertMany([
  // Malaui
  { _id: ObjectId(), nombre: "Lilongüe", pais_id: ObjectId("668d4e9f639be215a52c820a") },
  { _id: ObjectId(), nombre: "Blantyre", pais_id: ObjectId("668d4e9f639be215a52c820a") },
  { _id: ObjectId(), nombre: "Mzuzu", pais_id: ObjectId("668d4e9f639be215a52c820a") },

  // Maldivas
  { _id: ObjectId(), nombre: "Malé", pais_id: ObjectId("668d4e9f639be215a52c820b") },
  { _id: ObjectId(), nombre: "Addu City", pais_id: ObjectId("668d4e9f639be215a52c820b") },
  { _id: ObjectId(), nombre: "Fuvahmulah", pais_id: ObjectId("668d4e9f639be215a52c820b") },

  // Malí
  { _id: ObjectId(), nombre: "Bamako", pais_id: ObjectId("668d4e9f639be215a52c820c") },
  { _id: ObjectId(), nombre: "Sikasso", pais_id: ObjectId("668d4e9f639be215a52c820c") },
  { _id: ObjectId(), nombre: "Kayes", pais_id: ObjectId("668d4e9f639be215a52c820c") },

  // Malta
  { _id: ObjectId(), nombre: "La Valeta", pais_id: ObjectId("668d4e9f639be215a52c820d") },
  { _id: ObjectId(), nombre: "Birkirkara", pais_id: ObjectId("668d4e9f639be215a52c820d") },
  { _id: ObjectId(), nombre: "Mosta", pais_id: ObjectId("668d4e9f639be215a52c820d") },

  // Marruecos
  { _id: ObjectId(), nombre: "Rabat", pais_id: ObjectId("668d4e9f639be215a52c820e") },
  { _id: ObjectId(), nombre: "Casablanca", pais_id: ObjectId("668d4e9f639be215a52c820e") },
  { _id: ObjectId(), nombre: "Marrakech", pais_id: ObjectId("668d4e9f639be215a52c820e") },

  // Mauricio
  { _id: ObjectId(), nombre: "Port Louis", pais_id: ObjectId("668d4e9f639be215a52c820f") },
  { _id: ObjectId(), nombre: "Beau Bassin-Rose Hill", pais_id: ObjectId("668d4e9f639be215a52c820f") },
  { _id: ObjectId(), nombre: "Vacoas-Phoenix", pais_id: ObjectId("668d4e9f639be215a52c820f") }
])

db.ciudades.insertMany([
  // Mauritania
  { _id: ObjectId(), nombre: "Nuakchot", pais_id: ObjectId("668d4e9f639be215a52c8210") },
  { _id: ObjectId(), nombre: "Nuadibú", pais_id: ObjectId("668d4e9f639be215a52c8210") },
  { _id: ObjectId(), nombre: "Kaédi", pais_id: ObjectId("668d4e9f639be215a52c8210") },

  // México
  { _id: ObjectId(), nombre: "Ciudad de México", pais_id: ObjectId("668d4e9f639be215a52c8211") },
  { _id: ObjectId(), nombre: "Guadalajara", pais_id: ObjectId("668d4e9f639be215a52c8211") },
  { _id: ObjectId(), nombre: "Monterrey", pais_id: ObjectId("668d4e9f639be215a52c8211") },

  // Micronesia
  { _id: ObjectId(), nombre: "Palikir", pais_id: ObjectId("668d4e9f639be215a52c8212") },
  { _id: ObjectId(), nombre: "Weno", pais_id: ObjectId("668d4e9f639be215a52c8212") },
  { _id: ObjectId(), nombre: "Kolonia", pais_id: ObjectId("668d4e9f639be215a52c8212") },

  // Moldavia
  { _id: ObjectId(), nombre: "Chisináu", pais_id: ObjectId("668d4e9f639be215a52c8213") },
  { _id: ObjectId(), nombre: "Tiráspol", pais_id: ObjectId("668d4e9f639be215a52c8213") },
  { _id: ObjectId(), nombre: "Bălți", pais_id: ObjectId("668d4e9f639be215a52c8213") },

  // Mónaco
  { _id: ObjectId(), nombre: "Mónaco", pais_id: ObjectId("668d4e9f639be215a52c8214") },

  // Mongolia
  { _id: ObjectId(), nombre: "Ulán Bator", pais_id: ObjectId("668d4e9f639be215a52c8215") },
  { _id: ObjectId(), nombre: "Erdenet", pais_id: ObjectId("668d4e9f639be215a52c8215") },
  { _id: ObjectId(), nombre: "Darkhan", pais_id: ObjectId("668d4e9f639be215a52c8215") },

  // Montenegro
  { _id: ObjectId(), nombre: "Podgorica", pais_id: ObjectId("668d4e9f639be215a52c8216") },
  { _id: ObjectId(), nombre: "Nikšić", pais_id: ObjectId("668d4e9f639be215a52c8216") },
  { _id: ObjectId(), nombre: "Herceg Novi", pais_id: ObjectId("668d4e9f639be215a52c8216") },

  // Mozambique
  { _id: ObjectId(), nombre: "Maputo", pais_id: ObjectId("668d4e9f639be215a52c8217") },
  { _id: ObjectId(), nombre: "Matola", pais_id: ObjectId("668d4e9f639be215a52c8217") },
  { _id: ObjectId(), nombre: "Beira", pais_id: ObjectId("668d4e9f639be215a52c8217") },

  // Namibia
  { _id: ObjectId(), nombre: "Windhoek", pais_id: ObjectId("668d4e9f639be215a52c8218") },
  { _id: ObjectId(), nombre: "Rundu", pais_id: ObjectId("668d4e9f639be215a52c8218") },
  { _id: ObjectId(), nombre: "Walvis Bay", pais_id: ObjectId("668d4e9f639be215a52c8218") },

  // Nauru
  { _id: ObjectId(), nombre: "Yaren", pais_id: ObjectId("668d4e9f639be215a52c8219") },
  { _id: ObjectId(), nombre: "Boe", pais_id: ObjectId("668d4e9f639be215a52c8219") },
  { _id: ObjectId(), nombre: "Aiwo", pais_id: ObjectId("668d4e9f639be215a52c8219") },

  // Nepal
  { _id: ObjectId(), nombre: "Katmandú", pais_id: ObjectId("668d4e9f639be215a52c821a") },
  { _id: ObjectId(), nombre: "Pokhara", pais_id: ObjectId("668d4e9f639be215a52c821a") },
  { _id: ObjectId(), nombre: "Lalitpur", pais_id: ObjectId("668d4e9f639be215a52c821a") },

  // Nicaragua
  { _id: ObjectId(), nombre: "Managua", pais_id: ObjectId("668d4e9f639be215a52c821b") },
  { _id: ObjectId(), nombre: "León", pais_id: ObjectId("668d4e9f639be215a52c821b") },
  { _id: ObjectId(), nombre: "Masaya", pais_id: ObjectId("668d4e9f639be215a52c821b") }
])
```

**2.4. Tercero inseretar la lista 50 ciudades de Colombia**

```sql
db.ciudades.insertMany([
  { _id: ObjectId(), nombre: "Bogotá", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Medellín", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Cali", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Barranquilla", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Cartagena", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Cúcuta", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Bucaramanga", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Pereira", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Santa Marta", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Ibagué", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Manizales", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Villavicencio", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Pasto", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Montería", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Neiva", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Armenia", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Popayán", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Sincelejo", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Tunja", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Florencia", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Riohacha", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Quibdó", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Mocoa", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "San Andrés", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Leticia", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Inírida", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Mitú", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Puerto Carreño", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Yopal", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Arauca", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Valledupar", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Buenaventura", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Ipiales", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Tumaco", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Turbo", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Apartadó", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Caucasia", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Magangué", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Girardot", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Zipaquirá", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Facatativá", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Fusagasugá", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Chía", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Soacha", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Sogamoso", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Duitama", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Chiquinquirá", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Pamplona", pais_id: ObjectId("668d4e9f639be215a52c81c6") },
  { _id: ObjectId(), nombre: "Ocaña", pais_id: ObjectId("668d4e9f639be215a52c81c6") }
])
```

#### 3. Crear Documentos en la Colección `sucursales`

Indicaciones para la IA

dame el codigo mongsh que valide los datos para lo siguiente:

Dame un lista de todos los paises para insertar con mongosh

genera el insert many y los id para insertar los paises desde mongosh

genera un objectId aleatorio para cada pais y dame el codigo mongosh para insertarlos todos

**3.1. Crear la validación:** **

```sql
db.createCollection("sucursales", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["_id", "nombre", "direccion", "ciudad_id"],
      properties: {
        _id: {
          bsonType: "objectId",
          description: "Debe ser un ObjectId y es obligatorio"
        },
        nombre: {
          bsonType: "string",
          description: "Debe ser una cadena de texto y es obligatorio"
        },
        direccion: {
          bsonType: "string",
          description: "Debe ser una cadena de texto y es obligatorio"
        },
        ciudad_id: {
          bsonType: "objectId",
          description: "Debe ser un ObjectId y es obligatorio"
        }
      }
    }
  }
})
```

**3.2. Segundo crear la colección** **sucursales.**

```sql
db.sucursales.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4569"),
  nombre: "Nombre de la Sucursal",
  direccion: "Dirección de la Sucursal",
  ciudad_id: ObjectId("60d5ec49f1b2c72f9c8b4568")  // Referencia al documento en la colección `ciudades`
})

```

**3.3. Tercero insertar sucursales de manera aleatoria en distintos paises y ciudades**

**3.3.1. Genera 100 surcursales aleatoriamente**

```javascript
//Genera 100 surcursales aleatoriamente

const sucursales = [];
const nombresSucursales = ["Sucursal A", "Sucursal B", "Sucursal C", "Sucursal D", "Sucursal E"];
const direcciones = ["Calle 1", "Calle 2", "Calle 3", "Calle 4", "Calle 5"];
const ciudades = [
  ObjectId("60d5ec49f1b2c72f9c8b4561"), // Ciudad 1
  ObjectId("60d5ec49f1b2c72f9c8b4562"), // Ciudad 2
  ObjectId("60d5ec49f1b2c72f9c8b4563"), // Ciudad 3
  ObjectId("60d5ec49f1b2c72f9c8b4564"), // Ciudad 4
  ObjectId("60d5ec49f1b2c72f9c8b4565"), // Ciudad 5
  ObjectId("60d5ec49f1b2c72f9c8b4566"), // Ciudad 6
  ObjectId("60d5ec49f1b2c72f9c8b4567"), // Ciudad 7
  ObjectId("60d5ec49f1b2c72f9c8b4568"), // Ciudad 8
  ObjectId("60d5ec49f1b2c72f9c8b4569"), // Ciudad 9
  ObjectId("60d5ec49f1b2c72f9c8b4570")  // Ciudad 10
];

for (let i = 0; i < 100; i++) {
  const sucursal = {
    _id: ObjectId(),
    nombre: nombresSucursales[Math.floor(Math.random() * nombresSucursales.length)] + " " + (i + 1),
    direccion: direcciones[Math.floor(Math.random() * direcciones.length)] + " #" + (Math.floor(Math.random() * 100) + 1),
    ciudad_id: ciudades[Math.floor(Math.random() * ciudades.length)]
  };
  sucursales.push(sucursal);
}

//Inserta las sucursales en la colección

db.sucursales.insertMany(sucursales);

```

**3.3.2. Genera 2 sucursales en cada una de las ciudades de Colombia**

```javascript
use miBaseDeDatos

// Lista de ciudades con sus ObjectId
const ciudades = [
  { _id: ObjectId("668d4e9f639be215a52c81c6"), nombre: "Bogotá" },
  { _id: ObjectId("668d4e9f639be215a52c81c7"), nombre: "Medellín" },
  { _id: ObjectId("668d4e9f639be215a52c81c8"), nombre: "Cali" },
  { _id: ObjectId("668d4e9f639be215a52c81c9"), nombre: "Barranquilla" },
  { _id: ObjectId("668d4e9f639be215a52c81ca"), nombre: "Cartagena" },
  { _id: ObjectId("668d4e9f639be215a52c81cb"), nombre: "Cúcuta" },
  { _id: ObjectId("668d4e9f639be215a52c81cc"), nombre: "Bucaramanga" },
  { _id: ObjectId("668d4e9f639be215a52c81cd"), nombre: "Pereira" },
  { _id: ObjectId("668d4e9f639be215a52c81ce"), nombre: "Santa Marta" },
  { _id: ObjectId("668d4e9f639be215a52c81cf"), nombre: "Ibagué" },
  { _id: ObjectId("668d4e9f639be215a52c81d0"), nombre: "Manizales" },
  { _id: ObjectId("668d4e9f639be215a52c81d1"), nombre: "Villavicencio" },
  { _id: ObjectId("668d4e9f639be215a52c81d2"), nombre: "Pasto" },
  { _id: ObjectId("668d4e9f639be215a52c81d3"), nombre: "Montería" },
  { _id: ObjectId("668d4e9f639be215a52c81d4"), nombre: "Neiva" },
  { _id: ObjectId("668d4e9f639be215a52c81d5"), nombre: "Armenia" },
  { _id: ObjectId("668d4e9f639be215a52c81d6"), nombre: "Popayán" },
  { _id: ObjectId("668d4e9f639be215a52c81d7"), nombre: "Sincelejo" },
  { _id: ObjectId("668d4e9f639be215a52c81d8"), nombre: "Tunja" },
  { _id: ObjectId("668d4e9f639be215a52c81d9"), nombre: "Florencia" },
  { _id: ObjectId("668d4e9f639be215a52c81da"), nombre: "Riohacha" },
  { _id: ObjectId("668d4e9f639be215a52c81db"), nombre: "Quibdó" },
  { _id: ObjectId("668d4e9f639be215a52c81dc"), nombre: "Mocoa" },
  { _id: ObjectId("668d4e9f639be215a52c81dd"), nombre: "San Andrés" },
  { _id: ObjectId("668d4e9f639be215a52c81de"), nombre: "Leticia" },
  { _id: ObjectId("668d4e9f639be215a52c81df"), nombre: "Inírida" },
  { _id: ObjectId("668d4e9f639be215a52c81e0"), nombre: "Mitú" },
  { _id: ObjectId("668d4e9f639be215a52c81e1"), nombre: "Puerto Carreño" },
  { _id: ObjectId("668d4e9f639be215a52c81e2"), nombre: "Yopal" },
  { _id: ObjectId("668d4e9f639be215a52c81e3"), nombre: "Arauca" },
  { _id: ObjectId("668d4e9f639be215a52c81e4"), nombre: "Valledupar" },
  { _id: ObjectId("668d4e9f639be215a52c81e5"), nombre: "Buenaventura" },
  { _id: ObjectId("668d4e9f639be215a52c81e6"), nombre: "Ipiales" },
  { _id: ObjectId("668d4e9f639be215a52c81e7"), nombre: "Tumaco" },
  { _id: ObjectId("668d4e9f639be215a52c81e8"), nombre: "Turbo" },
  { _id: ObjectId("668d4e9f639be215a52c81e9"), nombre: "Apartadó" },
  { _id: ObjectId("668d4e9f639be215a52c81ea"), nombre: "Caucasia" },
  { _id: ObjectId("668d4e9f639be215a52c81eb"), nombre: "Magangué" },
  { _id: ObjectId("668d4e9f639be215a52c81ec"), nombre: "Girardot" },
  { _id: ObjectId("668d4e9f639be215a52c81ed"), nombre: "Zipaquirá" },
  { _id: ObjectId("668d4e9f639be215a52c81ee"), nombre: "Facatativá" },
  { _id: ObjectId("668d4e9f639be215a52c81ef"), nombre: "Fusagasugá" },
  { _id: ObjectId("668d4e9f639be215a52c81f0"), nombre: "Chía" },
  { _id: ObjectId("668d4e9f639be215a52c81f1"), nombre: "Soacha" },
  { _id: ObjectId("668d4e9f639be215a52c81f2"), nombre: "Sogamoso" },
  { _id: ObjectId("668d4e9f639be215a52c81f3"), nombre: "Duitama" },
  { _id: ObjectId("668d4e9f639be215a52c81f4"), nombre: "Chiquinquirá" },
  { _id: ObjectId("668d4e9f639be215a52c81f5"), nombre: "Pamplona" },
  { _id: ObjectId("668d4e9f639be215a52c81f6"), nombre: "Ocaña" }
];

// Generar 2 sucursales para cada ciudad
const sucursales = [];
const nombresSucursales = ["Sucursal A", "Sucursal B", "Sucursal C", "Sucursal D", "Sucursal E"];
const direcciones = ["Calle 1", "Calle 2", "Calle 3", "Calle 4", "Calle 5"];

ciudades.forEach(ciudad => {
  for (let i = 0; i < 2; i++) {
    const sucursal = {
      _id: ObjectId(),
      nombre: nombresSucursales[Math.floor(Math.random() * nombresSucursales.length)] + " " + (i + 1),
      direccion: direcciones[Math.floor(Math.random() * direcciones.length)] + " #" + (Math.floor(Math.random() * 100) + 1),
      ciudad_id: ciudad._id
    };
    sucursales.push(sucursal);
  }
});

// Insertar las sucursales en la colección
db.sucursales.insertMany(sucursales);
```

#### Crear Documentos en la Colección `vehiculos`

Indicaciones para la IA

dame el codigo mongsh que valide los datos para lo siguiente:

Dame un lista de todos los paises para insertar con mongosh

genera el insert many y los id para insertar los paises desde mongosh

genera un objectId aleatorio para cada pais y dame el codigo mongosh para insertarlos todos



**3.1. Crear la validación para vehículos:** 

```javascript
use miBaseDeDatos

db.createCollection("vehiculos", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["_id", "placa", "marca", "modelo", "capacidad_carga", "sucursal_id"],
      properties: {
        _id: {
          bsonType: "objectId",
          description: "Debe ser un ObjectId y es obligatorio"
        },
        placa: {
          bsonType: "string",
          pattern: "^[A-Z]{3}[0-9]{3}$",
          description: "Debe ser una cadena de texto con 3 letras mayúsculas y 3 números, y es obligatorio"
        },
        marca: {
          bsonType: "string",
          description: "Debe ser una cadena de texto que representa una marca válida y es obligatorio"
        },
        modelo: {
          bsonType: "int",
          minimum: 2000,
          maximum: 2024,
          description: "Debe ser un número entero entre 2000 y 2024, y es obligatorio"
        },
        capacidad_carga: {
          bsonType: "double",
          minimum: 0,
          maximum: 100000,
          description: "Debe ser un número decimal entre 0 y 100000, y es obligatorio"
        },
        sucursal_id: {
          bsonType: "objectId",
          description: "Debe ser un ObjectId y es obligatorio"
        }
      }
    }
  }
})
```

**3.2. Segundo crear la colección** **vehículos.**

```javascript
db.vehiculos.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4570"),
  placa: "ABC123",
  marca: "Mercedes-Benz",
  modelo: 2022,
  capacidad_carga: 1000.00,
  sucursal_id: ObjectId("60d5ec49f1b2c72f9c8b4569")  // Referencia al documento en la colección `sucursales`
})
```

**3.3. Crear y asignar 3 vehículos por cada sucursal existente de manera aleatoria en distintos paises y ciudades**

```javascript
use miBaseDeDatos

// Obtener todas las sucursales existentes
const sucursales = db.sucursales.find().toArray();

// Lista de marcas de vehículos
const marcas = ["Mercedes-Benz", "Hino", "Chevrolet", "Ford", "Toyota", "Nissan", "Hyundai", "Isuzu", "Mitsubishi", "Volkswagen", "Foton", "JAC", "Dongfeng", "Kenworth", "Freightliner", "International", "Scania", "Volvo", "MAN", "Iveco", "Renault", "Kia", "Mazda", "Tata", "Sinotruk", "FAW", "Shacman", "Mack", "Peterbilt", "Western Star", "UD Trucks", "DAF", "Kamaz", "Mahindra", "Ashok Leyland", "SsangYong", "Changan", "Great Wall", "JMC", "ZNA"];

// Función para generar una placa aleatoria
function generarPlaca() {
  const letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  const numeros = "0123456789";
  let placa = "";
  for (let i = 0; i < 3; i++) {
    placa += letras.charAt(Math.floor(Math.random() * letras.length));
  }
  for (let i = 0; i < 3; i++) {
    placa += numeros.charAt(Math.floor(Math.random() * numeros.length));
  }
  return placa;
}

// Generar y asignar 3 vehículos por cada sucursal
const vehiculos = [];
sucursales.forEach(sucursal => {
  for (let i = 0; i < 3; i++) {
    const vehiculo = {
      _id: ObjectId(),
      placa: generarPlaca(),
      marca: marcas[Math.floor(Math.random() * marcas.length)],
      modelo: Math.floor(Math.random() * (2024 - 2000 + 1)) + 2000,
      capacidad_carga: Math.random() * (100000 - 0) + 0,
      sucursal_id: sucursal._id
    };
    vehiculos.push(vehiculo);
  }
});

// Insertar los vehículos en la colección
db.vehiculos.insertMany(vehiculos);

```

**3.3.2. Crear y asignar 5 vehículos sucursales en cada una de las ciudades de Colombia**

```

```



#### Crear Documentos en la Colección `vehiculos`

```javascript
db.vehiculos.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4570"),
  placa: "Placa del Vehículo debe contener 3 letras y 3 números",
  marca: "Marca del Vehículo",
  modelo: "Modelo del Vehículo a partir del año 2000 hasta el 2024",
  capacidad_carga: minimo: 0, maximo: 100000. 
    unidad de medida: kilogramo
  sucursal_id: ObjectId("60d5ec49f1b2c72f9c8b4569")  // Referencia al documento en la colección `sucursales`
})
```

#### Crear Documentos en la Colección `clientes`

javascript

```javascript
db.clientes.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4571"),
  nombre: "Nombre del Cliente",
  email: "Email del Cliente",
  direccion: "Dirección del Cliente",
  telefonos: [
    {
      numero: "Número de Teléfono"
    }
  ]
})
```

#### Crear Documentos en la Colección `paquetes`

javascript

```javascript
db.paquetes.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4572"),
  numero_seguimiento: "Número de Seguimiento",
  peso: 10.00,
  dimensiones: "Dimensiones del Paquete",
  contenido: "Contenido del Paquete",
  valor_declarado: 100.00,
  tipo_servicio: "Tipo de Servicio",
  estado: "Estado del Paquete"
})
```

#### Crear Documentos en la Colección `envios`

javascript

```javascript
db.envios.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4573"),
  cliente_id: ObjectId("60d5ec49f1b2c72f9c8b4571"),  // Referencia al documento en la colección `clientes`
  paquete_id: ObjectId("60d5ec49f1b2c72f9c8b4572"),  // Referencia al documento en la colección `paquetes`
  fecha_envio: ISODate("2024-07-08T10:00:00Z"),
  destino: "Destino del Envío",
  ruta_id: ObjectId("60d5ec49f1b2c72f9c8b4574"),  // Referencia al documento en la colección `rutas`
  sucursal_id: ObjectId("60d5ec49f1b2c72f9c8b4569"),  // Referencia al documento en la colección `sucursales`
  vehiculo_id: ObjectId("60d5ec49f1b2c72f9c8b4570"),  // Referencia al documento en la colección `vehiculos`
  conductor_id: ObjectId("60d5ec49f1b2c72f9c8b4575")  // Referencia al documento en la colección `conductores`
})
```

#### Crear Documentos en la Colección `seguimiento`

javascript

```javascript
db.seguimiento.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4576"),
  paquete_id: ObjectId("60d5ec49f1b2c72f9c8b4572"),  // Referencia al documento en la colección `paquetes`
  ubicacion: "Ubicación del Paquete",
  fecha_hora: ISODate("2024-07-08T10:00:00Z"),
  estado: "Estado del Paquete"
})
```

#### Crear Documentos en la Colección `conductores`

javascript

```javascript
db.conductores.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4575"),
  nombre: "Nombre del Conductor",
  telefonos: [
    {
      numero: "Número de Teléfono"
    }
  ]
})
```

#### Crear Documentos en la Colección `rutas`

javascript

```javascript
f
```

#### Crear Documentos en la Colección `conductores_rutas`

javascript

```javascript
db.conductores_rutas.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4577"),
  conductor_id: ObjectId("60d5ec49f1b2c72f9c8b4575"),  // Referencia al documento en la colección `conductores`
  ruta_id: ObjectId("60d5ec49f1b2c72f9c8b4574"),  // Referencia al documento en la colección `rutas`
  vehiculo_id: ObjectId("60d5ec49f1b2c72f9c8b4570")  // Referencia al documento en la colección `vehiculos`
})
```

#### Crear Documentos en la Colección `auxiliares_reparto`

javascript

```javascript
db.auxiliares_reparto.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4578"),
  nombre: "Nombre del Auxiliar"
})
```

#### Crear Documentos en la Colección `auxiliares_rutas`

javascript

```javascript
db.auxiliares_rutas.insertOne({
  _id: ObjectId("60d5ec49f1b2c72f9c8b4579"),
  auxiliar_id: ObjectId("60d5ec49f1b2c72f9c8b4578"),  // Referencia al documento en la colección `auxiliares_reparto`
  ruta_id: ObjectId("60d5ec49f1b2c72f9c8b4574")  // Referencia al documento en la colección `rutas`
})
```

Estos comandos insertarán los documentos en las colecciones correspondientes con las referencias adecuadas. Si tienes más preguntas o necesitas más ayuda, no dudes en preguntar.
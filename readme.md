# **Caso de Estudio: Sistema de Gestión de Distribución de**

**Paquetes para una Empresa de Logística**
**Introducción:**

Como una firma de consultoría que se especializa en el desarrollo de bases de datos, ha obtenido una licitación para el desarrollo de un modelo de datos y un sistema de gestión de distribución de paquetes para un proveedor de logística cuya operación es a nivel nacional e internacional con sucursales y operaciones similares a las de Amazon. Ofrece servicios de distribución de paquetes a nivel nacional e internacional con sucursales en diferentes ciudades y países. El sistema se ocupará de la gestión de paquetes, el seguimiento de envíos, la información de los clientes, el control de sucursales, vehículos, chóferes y asistentes de distribución, así como.

#### Requisitos del Sistema:

1. ##### Gestión de Ubicaciones:

  Registrar y actualizar información de países y ciudades.

  ```
  
  ```

  Relacionar las sucursales con sus respectivas ciudades y países.

  ```
  
  ```

  
2. ##### Gestión de Sucursales:

  Registrar y actualizar información de sucursales (nombre, dirección).

  ```
  
  ```

  Clasificar sucursales según su ubicación geográfica.

  ```
  
  ```

  
3. ##### Gestión de Paquetes:

  Registrar y actualizar información de paquetes (número de seguimiento, peso, dimensiones, contenido, valor declarado).

  ```
  
  ```

  Clasificar paquetes según su destino y tipo de servicio (nacional, internacional, exprés, estándar).

  ```
  
  ```

  
4. ##### Gestión de Clientes:

  Registrar información de los clientes (nombre, correo electrónico, dirección, teléfono).

  ```
  
  ```

  Mantener el historial de envíos de cada cliente.

  ```
  
  ```

  
5. ##### Gestión de Envíos:

  Procesar envíos realizados por los clientes.

  ```
  
  ```

  Asignar números de seguimiento únicos a cada paquete.

  ```
  
  ```

  Actualizar el estado del envío (recibido, en tránsito, entregado, retenido en aduana).

  ```
  
  ```

  
6. ##### Seguimiento de Paquetes:

  Registrar eventos de seguimiento de paquetes (ubicación, fecha y hora, estado).

  ```
  
  ```

  Permitir a los clientes y al personal de la empresa rastrear el estado y la ubicación de los paquetes en tiempo real.

  ```
  
  ```

  
7. ##### Gestión de Rutas, Conductores, Auxiliares de Reparto y Vehículos:

  Registrar rutas de distribución y los conductores asignados.

  ```
  
  ```

  Registrar vehículos y asignarlos a los conductores. Cada vehículo se identifica por su placa única.

  ```
  
  ```

  Registrar auxiliares de reparto y asignarlos a conductores y rutas. Cada ruta puede tener varios auxiliares ayudando al conductor.

  ```
  
  ```

  Optimizar rutas para la entrega eficiente de paquetes.

  ```
  
  ```

  
8. ##### Reportes y Estadísticas:

  Generar reportes de envíos por cliente y por ruta.

  ```
  
  ```

  Monitorear el estado de los envíos y generar alertas para retrasos.

  ```
  
  ```

  Estadísticas de entrega y eficiencia de las rutas.

  ```
  
  ```

  

  La empresa cuenta con un DER base y usted debe realizar el analisis del modelo suministrado y
  determinar si es necesario normalizar la base de datos.



##### Caso de Uso 1: Registrar un Nuevo País

Descripción: Un administrador desea agregar un nuevo país a la base de datos.

```

```

##### Caso de Uso 2: Registrar una Nueva Ciudad

Descripción: Un administrador desea agregar una nueva ciudad asociada a un país existente.

```

```

##### Caso de Uso 3: Registrar una Nueva Sucursal

Descripción: Un administrador desea agregar una nueva sucursal asociada a una ciudad existente.

##### Caso de Uso 4: Registrar un Nuevo Cliente

Descripción: Un administrador desea registrar un nuevo cliente en la base de datos.

```

```

##### Caso de Uso 5: Registrar un Nuevo Teléfono para un Cliente

Descripción: Un administrador desea agregar un número de teléfono para un cliente existente.

```

```

##### Caso de Uso 6: Registrar un Nuevo Paquete

Descripción: Un administrador desea registrar un nuevo paquete en la base de datos.

```

```

##### Caso de Uso 7: Registrar un Nuevo Envío

Descripción: Un administrador desea registrar un nuevo envío, asociando un cliente, paquete, ruta y sucursal.

```

```

##### Caso de Uso 8: Registrar un Nuevo Vehículo

Descripción: Un administrador desea agregar un nuevo vehículo a la base de datos.

```

```

##### Caso de Uso 9: Registrar un Nuevo Conductor

Descripción: Un administrador desea agregar un nuevo conductor a la base de datos.

```

```

##### Caso de Uso 10: Registrar un Nuevo Teléfono para un Conductor

Descripción: Un administrador desea agregar un número de teléfono para un conductor existente.

```

```

##### Caso de Uso 11: Asignar un Conductor a una Ruta y un Vehículo

Descripción: Un administrador desea asignar un conductor a una ruta específica utilizando un vehículo.

```

```

##### Caso de Uso 12: Registrar un Nuevo Auxiliar

Descripción: Un administrador desea agregar un nuevo auxiliar de reparto a la base de datos.

```

```

##### Caso de Uso 13: Asignar un Auxiliar a una Ruta

Descripción: Un administrador desea asignar un auxiliar de reparto a una ruta específica.

```

```

##### Caso de Uso 14: Registrar un Evento de Seguimiento para un Paquete

Descripción: Un administrador desea registrar un evento de seguimiento para un paquete.

```

```

##### Caso de Uso 15: Generar un Reporte de Envíos por Cliente

Descripción: Un administrador desea generar un reporte de todos los envíos realizados por un cliente específico.

```

```

##### Caso de Uso 16: Actualizar el Estado de un Paquete

Descripción: Un administrador desea actualizar el estado de un paquete específico.

```

```

##### Caso de Uso 17: Rastrear la Ubicación Actual de un Paquete

Descripción: Un administrador desea rastrear la ubicación actual de un paquete específico.

```

```

##### Casos Multitabla

##### Caso de Uso 1: Obtener Información Completa de Envíos

Descripción: Un administrador desea obtener la información completa de todos los envíos, incluyendo detalles del cliente, paquete, ruta, conductor, y sucursal.

```

```

##### Caso de Uso 2: Obtener Historial de Envíos de un Cliente

Descripción: Un administrador desea obtener el historial completo de envíos de un cliente específico, incluyendo detalles de los paquetes y los eventos de seguimiento.

```

```

##### Caso de Uso 3: Listar Conductores y sus Rutas Asignadas

Descripción: Un administrador desea obtener una lista de todos los conductores y las rutas a las que están asignados, incluyendo detalles del vehículo utilizado y la sucursal correspondiente.

```

```

##### Caso de Uso 4: Obtener Detalles de Rutas y Auxiliares Asignados

Descripción: Un administrador desea obtener detalles de todas las rutas, incluyendo los auxiliares asignados a cada ruta.

```

```

##### Caso de Uso 5: Generar Reporte de Paquetes por Sucursal y Estado

Descripción: Un administrador desea generar un reporte de todos los paquetes agrupados por sucursal y estado.

```

```

##### Caso de Uso 6: Obtener Información Completa de un Paquete y su Historial de Seguimiento

Descripción: Un administrador desea obtener la información completa de un paquete específico y su historial de seguimiento.

##### Casos de uso Between, In y Not In

##### Caso de Uso 1: Obtener Paquetes Enviados Dentro de un Rango de Fechas

Descripción: Un administrador desea obtener todos los paquetes que fueron enviados dentro de un rango de fechas específico.

```

```

##### Caso de Uso 2: Obtener Paquetes con Ciertos Estados

Descripción: Un administrador desea obtener todos los paquetes que tienen ciertos estados específicos (por ejemplo, 'en tránsito' o 'entregado').

```

```

##### Caso de Uso 3: Obtener Paquetes Excluyendo Ciertos Estados

Descripción: Un administrador desea obtener todos los paquetes excluyendo aquellos que tienen ciertos estados específicos (por ejemplo, 'recibido' o 'retenido en aduana').

```

```

##### Caso de Uso 4: Obtener Clientes con Envíos Realizados

##### Dentro de un Rango de Fechas

Descripción: Un administrador desea obtener todos los clientes que realizaron envíos dentro de un rango de fechas específico.

```

```

##### Caso de Uso 5: Obtener Conductores Disponibles que No Están Asignados a Ciertas Rutas

Descripción: Un administrador desea obtener todos los conductores que no están asignados a ciertas rutas específicas.

```

```

##### Caso de Uso 6: Obtener Información de Paquetes con Valor Declarado Dentro de un Rango Específico

Descripción: Un administrador desea obtener todos los paquetes cuyo valor declarado está dentro de un rango específico.

```

```

##### Caso de Uso 7: Obtener Auxiliares Asignados a Rutas Específicas

Descripción: Un administrador desea obtener todos los auxiliares de reparto que están asignados a ciertas rutas específicas.

```

```

##### Caso de Uso 8: Obtener Envíos a Destinos Excluyendo Ciertas Ciudades

Descripción: Un administrador desea obtener todos los envíos cuyos destinos no están en ciertas ciudades específicas.

```

```

##### Caso de Uso 9: Obtener Seguimientos de Paquetes en un Rango de Fechas

Descripción: Un administrador desea obtener todos los eventos de seguimiento de paquetes que ocurrieron dentro de un rango de fechas específico.

```

```

##### Caso de Uso 10: Obtener Clientes que Tienen Ciertos Tipos de Paquetes

Descripción: Un administrador desea obtener todos los clientes que tienen paquetes de ciertos tipos específicos (por ejemplo, 'nacional' o 'internacional').

```

```


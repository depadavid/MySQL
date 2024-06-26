## Parte 1/2

### Consultas de una sola tabla

1. **Recuperar todas las líneas de productos con sus descripciones:**

```sql
show tables;
select * from productlines;
```



2. **Encontrar todos los empleados que trabajan en la oficina de 'San Francisco':**

```sql
show tables;
select * from offices;
Codigo de oficina San Francisco (1)
show tables;
SELECT employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle
FROM employees
WHERE officeCode = 1;
```


3. **Listar todas las órdenes que tienen un estado de 'Enviado':**

   ```sql
   show tables;
   select * from orders;
   SELECT orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber
   FROM orders
   WHERE status = 'Shipped'
   AND status = 'Resolved';	
   ```

4. **Obtener los detalles de todos los pagos realizados por el cliente con el número de cliente 103:**

   ```sql
   show tables;
   select * from payments;
   SELECT customerNumber, checkNumber, paymentDate, amount
   FROM payments
   WHERE customerNumber = 103;
   ```

5. **Recuperar todos los clientes de 'USA' que tienen un límite de crédito superior a 50000:**

   ```sql
   show tables;
   select * from customers;
   SELECT customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit
   FROM customers
   WHERE country = 'USA' AND creditLimit > 50000;
   
   ```

### Consultas de múltiples tablas

1. **Listar todos los productos junto con las descripciones de sus líneas de productos:**

   ```sql
   show tables;
   SELECT p.productCode, p.productName, p.productLine, p.productScale, p.productVendor, p.productDescription, p.quantityInStock, p.buyPrice, p.MSRP, pl.textDescription
   FROM products p
   JOIN productlines pl ON p.productLine = pl.productLine;
   ```

2. **Obtener los nombres y direcciones de correo electrónico de los empleados que reportan al empleado con el número de empleado 1143:**

   ```sql
   show tables;
   select * from employees;
   SELECT firstName, lastName, email
   FROM employees
   WHERE reportsTo = 1143;
   ```

3. **Encontrar todas las órdenes realizadas por clientes de 'Francia':**

   ```sql
   show tables;
   SELECT orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber
   FROM orders
   WHERE customerNumber IN (
       SELECT customerNumber
       FROM customers
       WHERE country = 'France');
   ```

4. **Listar el monto total de los pagos recibidos de cada cliente:**

   ```sql
   show tables;
   SELECT customerNumber, SUM(amount) AS totalPayments
   FROM payments
   GROUP BY customerNumber;
   ```

5. **Recuperar los detalles de las órdenes, incluyendo los nombres de los productos, para todas las órdenes realizadas por el cliente con el número de cliente 101:**

   ```sql
   show tables;
   SELECT o.orderNumber, o.orderDate, o.requiredDate, o.shippedDate, o.status, o.comments, 
          od.productCode, p.productName, od.quantityOrdered, od.priceEach, od.orderLineNumber
   FROM orders o
   JOIN orderdetails od ON o.orderNumber = od.orderNumber
   JOIN products p ON od.productCode = p.productCode
   WHERE o.customerNumber = 103;
   ```



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



## Parte 2/2

### Consultas de una sola tabla

1. **Obtener el promedio del límite de crédito de todos los clientes:**

   ```sql
   SELECT AVG(creditLimit) AS promedio_credito
   FROM customers;
   ```

2. **Calcular el total de productos en stock:**

   ```sql
   SELECT SUM(quantityInStock) AS total_productos_en_stock
   FROM products;
   ```

3. **Encontrar el precio medio de compra de todos los productos:**

   ```sql
   SELECT AVG(buyPrice) AS precio_medio_compra
   FROM products;
   ```

4. **Contar la cantidad de oficinas en cada país:**

   ```sql
   SELECT country, COUNT(*) AS cantidad_oficinas
   FROM offices
   GROUP BY country;
   ```

5. **Calcular el total de pagos recibidos:**

   ```sql
   SELECT SUM(amount) AS total_pagos_recibidos
   FROM payments;
   ```

6. **Obtener la cantidad total de empleados:**

   ```sql
   SELECT COUNT(*) AS total_empleados
   FROM employees;
   ```

7. **Calcular la cantidad media de productos pedidos en las órdenes:**

   ```sql
   SELECT AVG(quantityOrdered) AS cantidad_media_productos_pedidos
   FROM orderdetails;
   ```

8. **Encontrar el precio total de todos los productos:**

   ```sql
   SELECT SUM(buyPrice * quantityInStock) AS precio_total_productos
   FROM products;
   ```

9. **Calcular el promedio del precio sugerido (MSRP) de los productos:**

   ```sql
   SELECT AVG(MSRP) AS promedio_precio_sugerido
   FROM products;
   ```

10. **Contar la cantidad de empleados por título de trabajo:**

```sql
SELECT jobTitle, COUNT(*) AS cantidad_empleados
FROM employees
GROUP BY jobTitle;
```

### Consultas de múltiples tablas

1. **Calcular el total de pagos recibidos por cada cliente:**

   ```sql
   SELECT customerNumber, SUM(amount) AS total_pagos_recibidos
   FROM payments
   GROUP BY customerNumber;
   ```

2. **Obtener el promedio del límite de crédito de los clientes por país:**

   ```sql
   SELECT country, AVG(creditLimit) AS promedio_limite_credito
   FROM customers
   GROUP BY country;
   ```

3. **Calcular el total de órdenes realizadas por cada cliente:**

   ```sql
   SELECT customerNumber, COUNT(*) AS total_ordenes
   FROM orders
   GROUP BY customerNumber;
   ```

4. **Encontrar la cantidad total de productos pedidos por cada cliente:**

   ```sql
   SELECT customerNumber, SUM(quantityOrdered) AS total_productos_pedidos
   FROM orderdetails
   JOIN orders ON orderdetails.orderNumber = orders.orderNumber
   GROUP BY customerNumber;
   ```

5. **Calcular el total de ventas (cantidad ordenada por precio cada uno) por cada cliente:**

   ```sql
   SELECT orders.customerNumber, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS total_ventas
   FROM orderdetails
   JOIN orders ON orderdetails.orderNumber = orders.orderNumber
   GROUP BY orders.customerNumber;
   ```

6. **Obtener el promedio de la cantidad de productos en stock por línea de productos:**

   ```sql
   SELECT productLine, AVG(quantityInStock) AS promedio_cantidad_en_stock
   FROM products
   GROUP BY productLine;
   ```

7. **Calcular el total de pagos recibidos por cada país:**

   ```sql
   SELECT customers.country, SUM(payments.amount) AS total_pagos_recibidos
   FROM payments
   JOIN customers ON payments.customerNumber = customers.customerNumber
   GROUP BY customers.country;
   ```

8. **Encontrar el promedio de ventas (cantidad ordenada por precio cada uno) por cada empleado:**

   ```sql
   SELECT employees.employeeNumber, AVG(orderdetails.quantityOrdered * orderdetails.priceEach) AS promedio_ventas
   FROM orderdetails
   JOIN orders ON orderdetails.orderNumber = orders.orderNumber
   JOIN customers ON orders.customerNumber = customers.customerNumber
   JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
   GROUP BY employees.employeeNumber;
   ```

9. **Calcular el total de órdenes gestionadas por cada empleado:**

   ```sql
   SELECT employees.employeeNumber, COUNT(*) AS total_ordenes_gestionadas
   FROM orders
   JOIN customers ON orders.customerNumber = customers.customerNumber
   JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
   GROUP BY employees.employeeNumber;
   ```

10. **Obtener la cantidad total de productos vendidos por cada línea de productos:**

    ```sql
    SELECT productLine, SUM(quantityOrdered) AS total_productos_vendidos
    FROM orderdetails
    JOIN products ON orderdetails.productCode = products.productCode
    GROUP BY productLine;
    ```

11. **Encontrar el promedio de la cantidad de productos ordenados por cada cliente:**

    ```
    
    ```

12. **Calcular el total de ventas realizadas en cada país:**

    ```
    
    ```

13. **Obtener el promedio del precio de compra de los productos por línea de productos:**

    ```
    
    ```

14. **Encontrar la cantidad total de productos vendidos por cada vendedor:**

    ```sql
    
    ```

15. **Calcular el total de pagos recibidos por cada vendedor:**

    ```sql
    
    ```

16. **Obtener el promedio del límite de crédito de los clientes atendidos por cada vendedor:**

    ```sql
    
    ```

17. **Encontrar el total de ventas realizadas por cada oficina:**

    ```sql
    
    ```

18. **Calcular la cantidad media de productos pedidos por cada cliente:**

    ```sql
    
    ```

19. **Obtener el total de pagos realizados en cada año:**

    ```sql
    
    ```

20. **Encontrar el promedio del precio de venta (priceEach) de los productos por línea de productos:**

    ```sql
    
    ```
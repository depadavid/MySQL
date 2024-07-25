[TOC]

# Problemática 

En el canal de noticias CNN, existe una creciente preocupación por la gestión de comentarios anónimos en su plataforma de noticias en línea. Aunque permitir comentarios enriquece la interacción con los lectores, la falta de verificación de identidad y la posibilidad de comentarios ofensivos o desinformativos plantean varios desafíos:



## Identificación de Usuarios Anónimos:

- Muchos comentarios son realizados por usuarios anónimos sin verificar, lo que dificulta la atribución de responsabilidad por comentarios difamatorios o inexactos.

## Calidad del Contenido:

- La falta de identificación puede llevar a una disminución en la calidad de los comentarios, con opiniones no fundamentadas o incluso ataques personales que afectan la reputación del canal.

## Gestión de Contenido Sensible:

- CNN debe asegurar que los comentarios no contengan contenido sensible o que promueva discursos de odio, lo cual puede comprometer la integridad editorial y generar controversias públicas.

## Experiencia del Usuario:

- Los lectores pueden sentirse desmotivados para participar si perciben un ambiente negativo o poco moderado en los comentarios, afectando la interacción y la fidelización de la audiencia.

 Para abordar esta problemática, CNN debe considerar implementar estrategias efectivas de verificación de identidad y moderación de comentarios, así como fomentar una comunidad en línea donde la discusión sea respetuosa y constructiva.



# Solución parcial

Se precisa diseñar un blog de noticias donde los usuarios registrados pueda publicar sus comentarios: 

• Cada autor tiene un nombre, un nombre de usuario, una cuenta de Twitter y una descripción. Además, de forma opcional, los usuarios pueden proporcionar como datos su dirección postal (calle, número, puerta, C.P., ciudad) o sus teléfonos de contacto (pueden tener varios). 

• Las noticias tienen un título, un cuerpo y una fecha de publicación. Son publicadas por un autor y pueden contener o no, una lista de tags. 

• Las noticias reciben comentarios, quedando registrado la persona que lo escribió, el comentario escrito y el momento en el que lo hizo.



 **Se recomienda explorar otras alternativas de solución o mejorar el diseño del diagrama propuesto.**

![](https://i.ibb.co/n78JF9n/RED.png)

## Consultas 

### 1. Consultas de los datos del usuario por nombre de usuario y por cuenta de Twitter: 

```javascript
db.user.find({
    "nickname": "user50",
    "account": "@user50"
})
```

### 2. Agrupación por código postal (contar el número de usuarios de cada C.P). 

```javascript
[
  {
    $project:{
      name:1,
      "address.postal_code":1,
      _id:0
    }
  }
]
```

### 3. Consultas por número de teléfono. 

```javascript
db.user.find({
    "phone": 6231454460011,
})
```

### 4. Consultas de noticias publicadas por usuarios.

```javascript

```

### 5. 10 últimas noticias publicadas ordenadas por fecha (de más reciente a más antigua). 

 ```javascript
db.noticia.find().sort(
    {date:-1}
)
 ```

### 6. Número de comentarios por noticia, por día o por usuario.

```javascript

```

### 7. Retornar al usuario con nombre de usuario “Frank_blog”. 

```javascript
db.user.find({
    "nickname": "Frank_blog"
})

```

### 8. Retornar los usuarios llamados “Peter”. 

```javascript
db.user.find({
    "nickname": "Peter"
})
```

### 9. Contar el número de usuarios con CP= “39005”. 

```javascript
db.user.find({
    "address.postal_code":"39005"
})
```

### 10. Retornar a un usuario con número de teléfono: “111111111”. 

```javascript
db.user.find({
    "phone": 111111111,
})
```

### 11. Retornar nombre_usuario y cuenta_twitter, sin _id, de usuarios con CP igual o mayor que “39005”.

```javascript
db.user.find(
    {
        "address.postal_code": { $gte: "39005" }
    },
    {
        nombre_usuario: 1,
        _id: 0
    }
)


```

### 12. Número de noticias publicadas por usuario. 

```javascript

```

### 13. últimas noticias publicadas.

```javascript
db.noticia.find({},{}).sort({
    date:-1
    }
).limit(10).toArray()
```

### 12. Noticias que no tienen el campo tag. 

 ```javascript
db.noticias.find({
    "tags": { "$exists": false }
})

 ```
---
layout: layout
title: "Posts"
---
# Interacción con Redis usando Node.js

Redis nos ofrece gran cantidad de clientes para interactuar con él mediante gran cantidad de lenguajes de programación ([Clientes Redis](http://redis.io/clients)). 

En nuestro ejemplo interactuaremos con Redis mediante el cliente Node.js denominado [node_redis](https://github.com/NodeRedis/node_redis). 

# Contenidos

* [Configuración del entorno](#configuración-del-entorno)
* [Uso básico de node_redis](#uso-básico_de-node_redis)
* [Desarrollo de una API REST para Redis con Express y Node.js](#desarrollo-de-una-api-rest-para-redis-con-express-y-node)

___

## Configuración del entorno

Para interactuar con Redis usando Node.js necesitaremos tener instalado previamiente Node.js y npm (el gestor de dependencias para Node.js

### Instalación de Node.js

El proceso de instalación de Node.js es muy sencillo y se encuentra en el propio [sitio web de Node.js](https://nodejs.org/) que nos llevará a una instalador en función del sistema operativo desde el que estemos accediendo. 

En nuestro caso, haremos la instalación para un Ubuntu Linux y lo haremos desde la línea de comandos.

```
sudo apt-get update
sudo apt-get install nodejs
```

> **Atención**
> 
> Dado que hemos instalado Node.js desde los repositorios de Ubuntu, debido a un conflicto con otro paquete, en nuestro caso las llamadas a Node.js serán `nodejs` en lugar de `node`, tal y como verás que ocurre en la mayor parte de las fuentes que consultes.

Para comprobar si Node.js se ha instalado correctamente haremos una prueba obteniendo la versión que tenemos instalada.

```
node -v
```

### Instalación de `npm`

`npm` es facilita a los desarrolladores JavaScript el compartir y reutilizar código y facilita la actualización del código que se ha compartido. En nuestro caso usaremos `npm` como gestor de dependencias.

Para su instalación, simplemente escribiremos 

```
sudo apt-get install npm
```

Para comprobar si `npm` se ha instalado correctamente haremos una prueba obteniendo la versión que tenemos instalada.

```
npm -v
```

A partir de ahora ya podremos instalar fácilmente los paquetes que necesitemos para nuestros proyectos. No obstante, conviene consultar, aunque sea brevemente, la [documentacion sobre la instalación de paquetes](https://docs.npmjs.com/getting-started/installing-npm-packages-locally) y la [documentación sobre la creación de un proyecto Node.js](https://docs.npmjs.com/getting-started/using-a-package.json).

En el [sitio web de la documentación sobre npm](https://docs.npmjs.com/) encontraremos gran cantidad de información útil sobre `npm`, al margen de su uso como gestor de paquetes.

### Instalación de node_redis

`node_redis` es uno de los clientes recomendados más usados para interactuar con Redis usando  Node.js. Su instalación es muy sencilla. Basta con instalar el paquete usando `npm` tal y como se muestra a continuación

```
npm install redis
```

## Uso básico de node_redis


### Conexión a Redis

La forma básica de obtener una conexión a Redis es llamar al método `createClient()` que creará un objeto (nuestro cliente). Dicho objeto será el que utilicemos para inteactuar con Redis desde Node.js.

```
var redis = require('redis');
var client = redis.createClient(); //creates a new client

client.on('connect', function() {
    console.log('connected');
});

```

> **Atención**
> 
>Si no indicamos ningún puerto ni host a `createClient()`, éste utilizará como valores predetedinados 6379 para el puerto y `localhost` como servidor. Si queremos cambiar los valores predeterminados, crearemos el cliente con 
>
>```
>var client = redis.createClient(port, host);
>```

La desconexión se realiza con el método `close()`.

```
client.close();
```

### set, get, mset, mget y del

Todos los comandos de Redis mediante métodos del objeto `client`. 

Con `set` asignamos un valor a una clave 

```
client.set('foo', 'bar');
```

Opcionalmente se puede pasar una función *callback* para obtener una notificación tras completarse la operación:

```
client.set('foo', 'bar', function(err, reply) {
  console.log(reply);
});
```

Si fallase la operación (p.e. no está disponible el servidor), el argumento `err` de la función *callback* representa el error.

Para recuperar el valor asociado a una clave usaremos el método `get()` de esta forma. Se accede al valor mediante un argumento de la función *callback*, en nuestro caso el argumento `reply`. Si no exitiese la clave, `reply` sería vacío.

```
client.get('foo', function(err, reply) {
    console.log(reply);
});
```

Con `mset()` asignamos una lista de pares clave-valor en una operación atómica. Con `mget()` obtenemos el array de valores asociado a una lista de claves pasadas como una serie clave, valor.

```
client.mset('a', 10, 'b', 20, 'c', 30);

client.mget(['a', 'b', 'c'], function (err, res) {
    for (var i = 0, len = res.length; i < len; i++) {
        console.log(res[i]);
    }
});
```

Con `del()` borramos una clave o lista de claves.

```
client.del('foo', function(err, reply) {
    console.log(reply);
});
```

### incr, decr, incrby, decrby

`incr` y `decr` incrementan o disminuyen en 1 el valor de la clave especificada.

`incrby` y `decrby` incrementan o disminuyen el valor de la clave especificada en el argumento proporcionado.

`incrbyfloat()` permite incrementar o disminuir en un valor decimal dependiendo de si el valor proporcionado es positivo o negativo.

```
client.set('counter', 100);
client.incr('counter');
client.incrby('counter', 9);
client.decrby('counter', 4);
client.decr('counter');
client.incrbyfloat('counter',1.5);
client.get('counter', function(err, reply) {
    console.log(reply);
});
```

### Comprobación de la existencia de una clave

El método `exist()` permite determinar si existe o no la clave pasada como parámetro. El ejemplo siguiente muestra si existe la clave `greeting`.

```
client.set('greeting', 'Hello World!!');
if (client.exists('greeting',  function(err, reply) {
    if (reply == 1) {
        console.log('exists');
    } else {
        console.log('doesn\'t exist');
    }
}));
```

### Listas

Las listas son colecciones de valores que admiten repetidos.

`lpush` inserta al principio (izquierda) de la clave especificada el valor proporcionado. `rpush` inserta al final (derecha).

`rpop` extrae un valor del final (derecha) de la clave especificada.

`linsert` inserta en la clave especificada el valor proporcionado. El valor se inserta antes `BEFORE` o después `AFTER` del valor especificado (*pivot*).

`lset` establece en la clave especificada el valor proporcionado en la posición especificada.
 

```
client.del('sessions:ggvd');

client.lpush('sessions:ggvd', 'Sesion02');
client.rpush('sessions:ggvd', ['Sesion04', 'Sesion05']);
client.lpush('sessions:ggvd', 'La Sesion 01');
client.rpop('sessions:ggvd');
client.linsert('sessions:ggvd', 'BEFORE', 'Sesion04', 'Sesion03');
client.lset('sessions:ggvd', 0, 'Sesion01');

client.lrange('sessions:ggvd', 0, -1, function(err, reply) {
        console.log(reply);
});

	
client.del('sessions:ggvd');
```

###  Conjuntos

Los conjuntos son colecciones de valores que no admiten repetidos.

`sadd` añade a la clave especificada los elementos proporcionados.

`sadd` elimina de la clave especificada los elementos proporcionados.

`smembers` devuelve todos los miembros del conjunto asociado a la clave especificada.

`scard` devuelve el número de elemetos del conjunto de la clave especificada.


```
client.del('students:ggvd');

client.sadd('students:ggvd', 'student1', 'student2', 'student3');
client.srem('students:ggvd', 'student3');

client.smembers('students:ggvd', function(err, reply) {
    console.log(reply);
});

client.scard('students:ggvd', function(err, reply){
        console.log(reply);
});

client.del('students:ggvd');
```

### Operaciones de conjuntos

`sunion`, `sinter` y `sdiff` obtienen, respectivamente, la unión, intersección y diferencia de conjuntos.

```
client.del('students:ggvd');

client.sadd('students:ggvd', 'student1', 'student2', 'student3');
client.sadd('students:bd', 'student3', 'student4', 'student5');

client.sunion('students:bd', 'students:ggvd', function(err, reply) {
    console.log('  >> Unión:');
    console.log(reply);
});

client.sinter('students:bd', 'students:ggvd', function(err, reply) {
    console.log('  >> Intersección:');
    console.log(reply);
});

client.sdiff('students:bd', 'students:ggvd', function(err, reply) {
    console.log('  >> Diferencia:');
    console.log(reply);
});

client.del('students:ggvd');
```

### Conjuntos ordenados

Los conjuntos ordenados son conjuntos cuyos elementos están acompañados de una puntuación que permite establecer un orden en el conjunto.

`zadd` añade a la clave especificada la puntuación y el elemento proporcionado.

`zincrby` añade el valor propocionado a la puntuación del elemento de la clave especificados.

`zcount` devuelve el número de elementos del conjunto que tienen su puntuación entre los límites propocionados

`zrangebyscore` devuelve los elementos del conjunto y clave especificados cuyas puntuaciones están en el rango proporcionado. 

```
client.del('scores:ggvd');

client.zadd('scores:ggvd', 9, 'student1');
client.zadd('scores:ggvd', 3, 'student2');
client.zadd('scores:ggvd', 8, 'student3');

client.zincrby('scores:ggvd', 1, 'student2');

client.zcount('scores:ggvd', 5, 10, function(err, reply) {
    console.log('Cantidad de estudiantes aprobados: ');
    console.log(reply);
});

client.zrangebyscore('scores:ggvd', 5, 10, function(err, reply) {
    console.log('Estudiantes que han aprobado: ');
    console.log(reply);
    
});

client.del('scores:ggvd');
```

### Hashes

Los hashes son listas de campo-valor asociados a una clave.

`hset` asigna a la clave especificada el campo y valor propocionados.

`hget` obtiene el valor asociado a la clave y campo especificados.

`hkeys` obtiene un array con la lista de campos de un clave.


```
client.del('profesor:mtorres');

client.hset('profesor:mtorres', 'email', 'mtorres@ual.es');
client.hset('profesor:mtorres', 'name', 'Manuel');
client.hset('profesor:mtorres', 'surname', 'Torres Gil');
client.hset('profesor:mtorres', 'twitter', '@ualmtorres');

client.hget('profesor:mtorres', 'email', function(err, reply) {
    console.log("Email " + reply);
});

client.hkeys('profesor:mtorres', function(err, keys) {
    console.log("Claves: ", keys);
});

client.del('profesor:mtorres');
```

### Transacciones

Las transacciones se inician con `multi()`. Para finalizar la transacción usaremos:

* `exec()`: ejecuta las instrucciones de una transacción.
* `discard()`: cancela las instrucciones de una transacción.

```
client.del('a', 'b');

t = client.multi();
t.set('a', '1');
t.set('b', '2');
t.exec();

client.get('a', function(err, reply) {
    console.log('a after exec: ' + reply);
});

client.get('b', function(err, reply) {
    console.log('b after exec: ' + reply);
});

t = client.multi();
t.set('a', '3');
t.set('b', '4');
t.discard();

client.get('a', function(err, reply) {
    console.log('a after discard: ' + reply);
});

client.get('b', function(err, reply) {
    console.log('b after discard: ' + reply);
});

client.del('a', 'b');
```

## Desarrollo de una API REST para Redis con Express y Node

TO DO
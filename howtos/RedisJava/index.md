---
layout: layout
title: "Posts"
---
# Interacción con Redis mediante Java

Redis nos ofrece gran cantidad de clientes para interactuar con él mediante gran cantidad de lenguajes de programación ([Clientes Redis](http://redis.io/clients)). 

En nuestro ejemplo interactuaremos con Redis mediante el cliente Java denominado [Jedis](https://github.com/xetorthio/jedis).

## Dependencias Maven

Comenzaremos creando un proyecto Maven incluyendo la depedencia siguiente en el `pom.xml`.

```
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>2.6.2</version>
    <type>jar</type>
    <scope>compile</scope>
</dependency>
```

No obstante, si aún no usas Maven y prefieres incluir el driver en el proyecto puedes [descargar el driver .jar de Redis](http://mvnrepository.com/artifact/redis.clients/jedis).

## Conexión a Redis

La forma básica de obtener una conexión a Redis es instanciando directamente la clase `Jedis`. Indicaremos el `host` y usaremos el puerto por defecto

```
Jedis jedis = new Jedis("localhost");
```

Otra forma básica de conexión a Redis consiste en instanciar la clase `Jedis` especificando el `host` y el puerto de conexión

```
Jedis jedis = new Jedis("localhost", 6379);
```

Sin embargo, no se recomienda utilizar la misma instancia desde threads diferentes, ya que podemos obtener errores inesperados. Además, tampoco es adecuado la creación de múltiples instancias de Jedis ya que acarrea la creación de múltiples sockets y conexiones, lo que también puede desencadenar errores. Esto se debe a que una instancia de Jedis no es *threadsafe*.

Para evitar estos problemas se debe utilizar `JedisPool`, un [pool de conexiones](http://es.wikipedia.org/wiki/Connection_pool) *threadsafe*. Utilizaremos el pool para crear de forma segura instancias de Jedis. De esta forma evitaremos errores y obtendremos un mejor rendimiento.

Iniciaremos un pool:

```
JedisPool pool = new JedisPool(new JedisPoolConfig(), "localhost");
```

`JedisPoolConfig` incluye una serie de valores predeterminados útiles. Por ejemplo, si usamos Jedis con `JedisPoolConfig` se liberará la conexión tras 300 segundos (5 minutos) de inactividad.

La conexión a Redis la obtendremos con el método `getResource()` de `JedisPoolConfig`

`Jedis jedis = pool.getResource();`

Cuando no ya no necesitemos una conexión la cerraremos con `close()` y quedará liberada.

`jedis.close();`

Cuando hayamos finalizado el trabajo destruiremos el pool con `destroy()`.

`pool.destroy();`

<script src="https://gist.github.com/ualmtorres/021029e1cf1ca5a0c475.js"></script>


## set, get, mset, mget y del

Con `set(key, value)` asignamos un valor a una clave y con `get(key)` recuperamos el valor asociado a una clave.

Con `mset(key1, value1 [, key n, value n])` asignamos una lista de pares clave-valor en una operación atómica. Con `mget(key1 [, key n])` obtenemos la lista de valores asociados a las claves pasadas como parámetro.

Con `del(key1 [, key n])` borramos una clave o lista de claves.

<script src="https://gist.github.com/ualmtorres/d0006849279588e03be1.js"></script>

La ejecución de este método imprime

```
bar
10
20
30
```

## incr, incrby, decr, decrby

`incr(key)` y `decr(key)` incrementan o disminuyen en 1 el valor de la clave especificada.

`incrby(key, quantity)` y `decrby(key, quantity)` incrementan o disminuyen el valor de la clave especificada en el argumento proporcionado.

<script src="https://gist.github.com/ualmtorres/d17e0927af5184db6c8b.js"></script>

La ejecución de este método imprime

```
counter: 105
```

## append, substr y strlen

`append(key, string)` añade la cadena propocionada al final del valor de la clave especificada.

`substr(key, left, right)` devuelve una subcadena de la clave especificada comprendida entre dos posiciones. 

`strlen(key)` devuelve el número de caracteres del valor de la clave especificada.

<script src="https://gist.github.com/ualmtorres/0ed9b91edb074bc3ded9.js"></script>

La ejecución de este método imprime

```
Appended greeting: Hello World!
Substring: World!
greeting: Hello World!
Length: 12
```

## Listas

Las listas son colecciones de valores que admiten repetidos.

`lpush(key, value)` inserta al principio (izquierda) de la clave especificada el valor proporcionado. `rpush(key, value)` inserta al final (derecha).

`rpop(key)` extrae un valor del final (derecha) de la clave especificada.

`linsert(key, beforeOrAfter, pivot, value)` inserta en la clave especificada el valor proporcionado. El valor se inserta antes `BinaryClient.LIST_POSITION.BEFORE` o después `BinaryClient.LIST_POSITION.AFTER` del valor especificado (*pivot*).

`lset(key, value, position)` establece en la clave especificada el valor proporcionado en la posición especificada.

`lrange(key, left, right)` devuelve los elementos de la lista de la clave especificada entre que estén entre las posiciones indicadas (-1 representa el final).

<script src="https://gist.github.com/ualmtorres/1c421ffd5a42227fc734.js"></script>

La ejecución de este método imprime

```
10/3
17/3
24/3
7/4
```

## Conjuntos

Los conjuntos son colecciones de valores que no admiten repetidos.

`sadd(key, value1 [,value n])` añade a la clave especificada los elementos proporcionados.

`srem(key, value1 [, value n])` elimina de la clave especificada los elementos proporcionados.

`smembers(key)` devuelve todos los miembros del conjunto asociado a la clave especificada.

`scard(key)` devuelve el número de elementos del conjunto de la clave especificada.

<script src="https://gist.github.com/ualmtorres/0127ee3ceb0564c54085.js"></script>

La ejecución de este método imprime

```
2 elements
student2
student1
```

## Operaciones de conjuntos

`sunion(set1, set2)`, `sinter(set1, set2)` y `sdiff(set1, set2)` obtienen, respectivamente, la unión, intersección y diferencia de conjuntos.

<script src="https://gist.github.com/ualmtorres/c3a445d4ced28f6aa29d.js"></script>

La ejecución de este método imprime

```
*** Total students:
student2
student1
student5
student4
student3
*** Common students:
student3
*** Students only in GGVD:
student2
student1
```	

## Conjuntos ordenados

Los conjuntos ordenados son conjuntos cuyos elementos están acompañados de una puntuación que permite establecer un orden en el conjunto.

`zadd(key, score, value)` añade a la clave especificada la puntuación y el elemento proporcionado.

`zincrby(key, increment, value)` añade el incremento propocionado a la puntuación del elemento y clave especificados.

`zcount(key, lower, higher)` devuelve el número de elementos del conjunto que tienen su puntuación entre los límites propocionados

`zRangeByScoreWithScores(key, lower, higher)` devuelve los elementos y puntuación del conjunto y clave especificados cuyas puntuaciones están en el rango proporcionado. 

<script src="https://gist.github.com/ualmtorres/0a823dab8516ef8dc2c0.js"></script>

La ejecución de este método imprime

```
*** Number of passed students: 2
student3 8.0
student1 9.0
```

## Hashes

Los hashes son listas de campo-valor asociados a una clave.

`hset(key, field, value)` asigna a la clave especificada el campo y valor propocionados.

`hget(key, field)` obtiene el valor asociado a la clave y campo especificados.

`hkeys(key)` obtiene un conjunto con la lista de campos de un clave.

<script src="https://gist.github.com/ualmtorres/210be8cb6ec002bb01c1.js"></script>

La ejecución de este método imprime

```
twitter: @ualmtorres
surname: Torres Gil
email: mtorres@ual.es
name: Manuel

```
## Transacciones

Las transacciones se inician con `multi()`. 

Para finalizar la transacción usaremos:

* `exec()`: ejecuta las instrucciones de una transacción.
* `discard()`: cancela las instrucciones de una transacción.

<script src="https://gist.github.com/ualmtorres/f247272dbe2a68d2a283.js"></script>

La ejecución de este método imprime

```
*** Keys after discarding: 
1
2
```			
Puedes [descargar el código de este tutorial](https://github.com/ualmtorres/RedisJava) que incluye una batería de juegos de prueba del GitHub.

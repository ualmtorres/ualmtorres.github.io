---
layout: layout
title: "Posts"
---

# Uso básico de PhpRedis

## Conexión a Redis

La forma básica de obtener una conexión a Redis es instanciando directamente la clase `Redis`. Indicaremos el `host` y usaremos el puerto por defecto

```
$redis = new Redis();
$redis->connect("localhost");
```

## set, get, mset, mget y del

Con `set` asignamos un valor a una clave y con `get` recuperamos el valor asociado a una clave.

Con `mset` asignamos una lista de pares clave-valor en una operación atómica. Con `mget` obtenemos el array de valores asociado a una lista de claves pasadas como un array.

Con `del` borramos una clave o lista de claves.

```
$redis->set("foo", "bar");
$value = $redis->get("foo");

echo $value . "</br>";
		
$redis->mset(array("a" => "10", "b" => "20", "c" => "30"));
$values= $redis->mget(array("a", "b", "c"));
foreach ($values as $v) {
	echo $v . "</br>";
}
```

## incr, decr, incrby, decrby

`incr` y `decr` incrementan o disminuyen en 1 el valor de la clave especificada.

`incrby` y `decrby` incrementan o disminuyen el valor de la clave especificada en el argumento proporcionado.

```
$redis->set("counter", "100");
$redis->incr("counter");
$redis->incrBy("counter", 9);
$redis->decrBy("counter", 4);
$counter = $redis->decr("counter");
```

`incrByFloat` permite incrementar o disminuir en un valor decimal.

## append, substr y strlen

`append` añade la cadena propocionada al final del valor de la clave especificada.

`substr` devuelve una cadena de la clave especificada comprendida entre dos posiciones. 

`strlen` devuelve el número de caracteres del valor de la clave especificada.

```
$redis->set("greeting", "Hello ");
if ($redis->exists("greeting")) {
	$redis->append("greeting", "World!");
}
		
echo $redis->substr("greeting", 6, -1) . "<br/>";
echo $redis->get("greeting")  . "<br/>";
echo "Length: " + $redis->strlen("greeting")  . "<br/>";

$redis->del("greeting");
```

## Listas

Las listas son colecciones de valores que admiten repetidos.

`lpush` inserta al principio (izquierda) de la clave especificada el valor proporcionado. `rpush` inserta al final (derecha).

`rpop` extrae un valor del final (derecha) de la clave especificada.

`linsert` inserta en la clave especificada el valor proporcionado. El valor se inserta antes `Redis::BEFORE` o después `Redis::AFTER` del valor especificado (*pivot*).

`lset` establece en la clave especificada el valor proporcionado en la posición especificada.
 

```
$redis->del("sessions:ggvd");

$redis->lpush("sessions:ggvd", "10/3");
$redis->rpush("sessions:ggvd", "24/3");
$redis->rpush("sessions:ggvd", "25/3");
$redis->rpop("sessions:ggvd");
$redis->linsert("sessions:ggvd", Redis::BEFORE, "24/3", "17/3");
$redis->rpush("sessions:ggvd", "31/3");
$redis->lset("sessions:ggvd", -1, "7/4");
		
$values = $redis->lrange("sessions:ggvd", 0, -1);

	
foreach ($values as $v) {
	echo $v . "</br>";
}
		
$redis->del("sessions:ggvd");
```

##  Sets

Los conjuntos son colecciones de valores que no admiten repetidos.

`sadd` añade a la clave especificada los elementos proporcionados.

`sadd` elimina de la clave especificada los elementos proporcionados.

`sMembers` devuelve todos los miembros del conjunto asociado a la clave especificada.

`scard` devuelve el número de elemetos del conjunto de la clave especificada.


```
$redis->del("students:ggvd");
		
$redis->sadd("students:ggvd", "student1", "student2", "student3");
$redis->srem("students:ggvd", "student3");

$students = $redis->sMembers("students:ggvd");

$numberOfStudents = $redis->scard("students:ggvd");
		
echo $numberOfStudents . "<br/>";

foreach ($students as $s) {
	echo $s . "<br/>";
}	
$redis->del("students:ggvd");
```

## Set Operations

`sunion`, `sinter` y `sdiff` obtienen, respectivamente, la unión, intersección y diferencia de conjuntos.

```
$redis->del("students:ggvd");

$redis->sadd("students:ggvd", "student1", "student2", "student3");
$redis->sadd("students:bd", "student3", "student4", "student5");

$totalStudents = $redis->sunion("students:bd", "students:ggvd");
$commonStudents = $redis->sinter("students:bd", "students:ggvd");
$studentsOnlyInGGVD = $redis->sdiff("students:ggvd", "students:bd");

echo "Total students: " . "<br/>";

foreach ($totalStudents as $s) {
	echo $s . "<br/>";
}

echo "Common students: " . "<br/>";

foreach ($commonStudents as $s) {
	echo $s . "<br/>";
}

echo "Students only in GGVD: " . "<br/>";

foreach ($studentsOnlyInGGVD as $s) {
	echo $s . "<br/>";
}

$redis->del("students:ggvd");
```

## Sorted Sets

Los conjuntos ordenados son conjuntos cuyos elementos están acompañados de una puntuación que permite establecer un orden en el conjunto.

`zadd` añade a la clave especificada la puntuación y el elemento proporcionado.

`zincrby` añade el valor propocionado a la puntuación del elemento de la clave especificados.

`zcount` devuelve el número de elementos del conjunto que tienen su puntuación entre los límites propocionados

`zRangeByScore` devuelve los elementos del conjunto y clave especificados cuyas puntuaciones están en el rango proporcionado. Hay dos opciones disponibles pasadas dentro de un array:

* `withscores => TRUE`
* `limit => array($offset, $count)`

```
$redis->del("scores:ggvd");
		
$redis->zadd("scores:ggvd", 9, "student1");
$redis->zadd("scores:ggvd", 3, "student2");
$redis->zadd("scores:ggvd", 8, "student3");
		
$redis->zincrby("scores:ggvd", 1, "student2");
		
$numberOfPassStudents = $redis->zcount("scores:ggvd", 5, 10);
	
echo $numberOfPassStudents . "<br/>";

$passStudents = $redis->zRangeByScore("scores:ggvd", 5, 10, array('withscores' => TRUE));

echo "Pass Students<br/>";

foreach ($passStudents as $s) {
	echo $s . "<br/>" ;
}

$redis->del("scores:ggvd");
```

## Hashes

Los hashes son listas de campo-valor asociados a una clave.

`hset` asigna a la clave especificada el campo y valor propocionados.

`hget` obtiene el valor asociado a la clave y campo especificados.

`hkeys` obtiene un array con la lista de campos de un clave.


```
echo "*** Hashes <br/>";

$redis->hset("profesor:mtorres", "email", "mtorres@ual.es");
$redis->hset("profesor:mtorres", "name", "Manuel");
$redis->hset("profesor:mtorres", "surname", "Torres Gil");
$redis->hset("profesor:mtorres", "twitter", "@ualmtorres");
		
$keys = $redis->hkeys("profesor:mtorres");
		
foreach ($keys as $k) {
	echo $k . ": " . $redis->hget("profesor:mtorres", $k) . "<br/>";
}
```

## Transactions

Las transacciones se inician con `multi()`. En Redis hay dos modos transaccionales:

* `REDIS:MULTI`: El bloque de instrucciones se ejecuta como una única transacción. Este es el valor predeterminado.
* `REDIS:PIPELINE`: El bloque de instrucciones se transmite más rápido al servidor, pero sin que quede garantizada la atomicidad.

Para finalizar la transacción usaremos:

* `exec()`: ejecuta las instrucciones de una transacción.
* `discard()`: cancela las instrucciones de una transacción.

```
echo "Transactions <br/>";

$t = $redis->multi();
$t->set("a", "1");
$t->set("b", "2");
$t->exec();

echo "After exec()<br/>";
echo "a: " . $redis->get("a") . "b: " . $redis->get("b") . "<br/>";

$t = $redis->multi();
$t->set("a", "3");
$t->set("b", "4");
$t->discard();

echo "After discard()<br/>";
echo "a: " . $redis->get("a") . "b: " . $redis->get("b") . "<br/>";
```

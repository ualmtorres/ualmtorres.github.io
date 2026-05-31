# Uso básico del driver Redis para Python

## Preparación del entorno

Para ejecutar el código de este tutorial, es necesario tener un servidor Redis en ejecución. Para ello, puedes utilizar el entorno preparado en Docker que se incluye en este repositorio. Para levantar el entorno, ejecuta el siguiente comando en la terminal:

```bash
docker-compose up --build -d
```

Esto iniciará un contenedor con Redis, otro con una interefaz gráfica para Redis y otro con Python. Para acceder al contenedor de Python, y poder ejecutar comandos en él, ejecuta el siguiente comando:

```bash
docker-compose exec python bash
```

El contenedor de Python tiene instalado el driver Redis para Python, por lo que ya puedes ejecutar el código de este tutorial. El acceso a Redis se realiza a través del host `redis` y el puerto `6379`, que es el puerto por defecto de Redis. En el entorno desplegado, ya se ha ejecutado un script de prueba (`sample-commands.py`). Puedes ver su resultado en los logs del contenedor de Python:

```bash
docker-compose logs python
```

También se ofrece Redis Commander, una interfaz gráfica para Redis. Para acceder a ella, abre un navegador y accede a `http://localhost:8081`. Las credenciales de acceso están en el archivo `docker-compose.yml`.

## Conexión a Redis

La forma básica de obtener una conexión a Redis es instanciando la clase `Redis` del módulo `redis`. Indicaremos el `host`, el `port` y habilitaremos `decode_responses=True` para que las respuestas sean cadenas en lugar de bytes.

```python
import redis

r = redis.Redis(host='redis', port=6379, decode_responses=True)
```

## set, get, mset, mget y delete

Con `set` asignamos un valor a una clave y con `get` recuperamos el valor asociado a una clave.

Con `mset` asignamos un diccionario de pares clave-valor en una operación atómica. Con `mget` obtenemos la lista de valores asociada a una lista de claves.

Con `delete` borramos una clave o lista de claves.

```python
r.set('foo', 'bar')
value = r.get('foo')
print(value)

r.mset({'a': '10', 'b': '20', 'c': '30'})
values = r.mget(['a', 'b', 'c'])
for v in values:
    print(v)
```

## incr, decr, incrby, decrby

`incr` y `decr` incrementan o disminuyen en 1 el valor de la clave especificada.

`incrby` y `decrby` incrementan o disminuyen el valor de la clave especificada en el argumento proporcionado.

```python
r.set('counter', '100')
r.incr('counter')
r.incrby('counter', 9)
r.decrby('counter', 4)
counter = r.decr('counter')
```

`incrbyfloat` permite incrementar o disminuir en un valor decimal.

## append, getrange y strlen

`append` añade la cadena proporcionada al final del valor de la clave especificada.

`getrange` devuelve una subcadena de la clave especificada comprendida entre dos posiciones.

`strlen` devuelve el número de caracteres del valor de la clave especificada.

```python
r.set('greeting', 'Hello ')
if r.exists('greeting'):
    r.append('greeting', 'World!')

print(r.getrange('greeting', 6, -1))
print(r.get('greeting'))
print('Length:', r.strlen('greeting'))

r.delete('greeting')
```

## Listas

Las listas son colecciones de valores que admiten repetidos.

`lpush` inserta al principio (izquierda) de la clave especificada el valor proporcionado. `rpush` inserta al final (derecha).

`rpop` extrae un valor del final (derecha) de la clave especificada.

`linsert` inserta en la clave especificada el valor proporcionado. El valor se inserta antes (`'BEFORE'`) o después (`'AFTER'`) del valor especificado (*pivot*).

`lset` establece en la clave especificada el valor proporcionado en la posición indicada.

```python
r.delete('sessions:ggvd')

r.lpush('sessions:ggvd', '10/3')
r.rpush('sessions:ggvd', '24/3')
r.rpush('sessions:ggvd', '25/3')
r.rpop('sessions:ggvd')
r.linsert('sessions:ggvd', 'BEFORE', '24/3', '17/3')
r.rpush('sessions:ggvd', '31/3')
r.lset('sessions:ggvd', -1, '7/4')

values = r.lrange('sessions:ggvd', 0, -1)
for v in values:
    print(v)

r.delete('sessions:ggvd')
```

## Sets

Los conjuntos son colecciones de valores que no admiten repetidos.

`sadd` añade a la clave especificada los elementos proporcionados.

`srem` elimina de la clave especificada los elementos proporcionados.

`smembers` devuelve todos los miembros del conjunto asociado a la clave especificada.

`scard` devuelve el número de elementos del conjunto de la clave especificada.

```python
r.delete('students:ggvd')

r.sadd('students:ggvd', 'student1', 'student2', 'student3')
r.srem('students:ggvd', 'student3')

students = r.smembers('students:ggvd')
number_of_students = r.scard('students:ggvd')

print(number_of_students)
for s in students:
    print(s)

r.delete('students:ggvd')
```

## Set Operations

`sunion`, `sinter` y `sdiff` obtienen, respectivamente, la unión, intersección y diferencia de conjuntos.

```python
r.delete('students:ggvd')

r.sadd('students:ggvd', 'student1', 'student2', 'student3')
r.sadd('students:bd', 'student3', 'student4', 'student5')

total_students = r.sunion('students:bd', 'students:ggvd')
common_students = r.sinter('students:bd', 'students:ggvd')
students_only_in_ggvd = r.sdiff('students:ggvd', 'students:bd')

print('Total students:')
for s in total_students:
    print(s)

print('Common students:')
for s in common_students:
    print(s)

print('Students only in GGVD:')
for s in students_only_in_ggvd:
    print(s)

r.delete('students:ggvd')
```

## Sorted Sets

Los conjuntos ordenados son conjuntos cuyos elementos están acompañados de una puntuación que permite establecer un orden en el conjunto.

`zadd` añade a la clave especificada un diccionario `{miembro: puntuación}`.

`zincrby` añade el valor proporcionado a la puntuación del elemento de la clave especificados.

`zcount` devuelve el número de elementos del conjunto que tienen su puntuación entre los límites proporcionados.

`zrangebyscore` devuelve los elementos del conjunto y clave especificados cuyas puntuaciones están en el rango proporcionado. Se puede usar `withscores=True` para incluir las puntuaciones en el resultado.

```python
r.delete('scores:ggvd')

r.zadd('scores:ggvd', {'student1': 9})
r.zadd('scores:ggvd', {'student2': 3})
r.zadd('scores:ggvd', {'student3': 8})

r.zincrby('scores:ggvd', 1, 'student2')

number_of_pass_students = r.zcount('scores:ggvd', 5, 10)
print(number_of_pass_students)

pass_students = r.zrangebyscore('scores:ggvd', 5, 10, withscores=True)
print('Pass Students')
for s, score in pass_students:
    print(s, score)

r.delete('scores:ggvd')
```

## Hashes

Los hashes son listas de campo-valor asociados a una clave.

`hset` asigna a la clave especificada el campo y valor proporcionados.

`hget` obtiene el valor asociado a la clave y campo especificados.

`hkeys` obtiene la lista de campos de una clave.

```python
print('*** Hashes')

r.hset('profesor:mtorres', 'email', 'mtorres@ual.es')
r.hset('profesor:mtorres', 'name', 'Manuel')
r.hset('profesor:mtorres', 'surname', 'Torres Gil')
r.hset('profesor:mtorres', 'twitter', '@ualmtorres')

keys = r.hkeys('profesor:mtorres')
for k in keys:
    print(k + ': ' + r.hget('profesor:mtorres', k))
```

## Transactions

Las transacciones se gestionan mediante pipelines. `pipeline()` crea un pipeline que agrupa los comandos y los envía al servidor en bloque.

Con `execute()` se ejecutan todos los comandos del pipeline de forma atómica. Con `reset()` se descartan los comandos pendientes.

```python
print('Transactions')

pipe = r.pipeline()
pipe.set('a', '1')
pipe.set('b', '2')
pipe.execute()

print('After execute()')
print('a:', r.get('a'), 'b:', r.get('b'))

pipe = r.pipeline()
pipe.set('a', '3')
pipe.set('b', '4')
pipe.reset()

print('After reset()')
print('a:', r.get('a'), 'b:', r.get('b'))
```

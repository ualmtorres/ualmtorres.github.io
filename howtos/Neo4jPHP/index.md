---
layout: layout
title: "Posts"
---

# Usando Neo4j y PHP

Neo4j nos ofrece gran cantidad de clientes para interactuar con él mediante diferentes lenguajes de programación ([Drivers Neo4j](http://neo4j.com/developer/language-guides/)).

En nuestro ejemplo interactuaremos con Neo4j mediante PHP. Para PHP existen varios drivers (Neo4jPHP, NeoClient, ...). En la web de Neo4j puedes encontrar una lista más completa de [clientes PHP para Neo4j](http://neo4j.com/developer/php/). En este tutorial usaremos [NeoClient](https://github.com/neoxygen/neo4j-neoclient).

## Instalación

Como paso previo a la instalación de NeoClient, necesitas tener instalado [Composer](https://getcomposer.org/), un gestor de dependencias para PHP. En el [Tutorial sobre configuración de un entorno LAMP+NoSQL](http://ualmtorres.github.io/howtos/ConfiguracionEntornoGGVD/) están disponibles los pasos para tener instalado todo lo necesario para usar Neo4j con PHP (Neo4j, Servidor Apache, PHP y Composer).

Siguiendo la [Información de instalación de NeoClient](https://github.com/neoxygen/neo4j-neoclient) hay que crear en la carpeta del proyecto un archivo `composer.json` en el que se especifica la dependencia con NeoClient. 

<script src="https://gist.github.com/ualmtorres/67333b8378ba9437a3a5.js"></script>

A continuación, en la carpeta del proyecto instalaremos las dependencias con el comando siguiente

```
composer install
```

## Conexión a Neo4j

Para usar las clases de NeoClient debemos hacer referencia el espacio de nombres de NeoClient (`Neoxygen\NeoClient`). Además, antes de proceder a crear la conexión tenemos que importar el archivo `autoload.php` generado por Composer al instalar las dependencias.

La conexión la crearemos mediante el método `create()` de la clase `ClientBuilder` de NeoClient. En ella indicaremos varios parámetros, destacando el *host* y el *puerto*. En nuestro caso hemos usado `localhost` y `7474` (el puerto predeterminado de Neo4j).
 
<script src="https://gist.github.com/ualmtorres/8543780ab3b973fa679b.js"></script>

Este código lo podemos guardar en un archivo (p.e. `connection.php`) para que pueda ser utilizado por cualquier script de nuestra aplicación que tenga que interactuar con Neo4j.

## Interacción con Neo4j

Básicamente, la interacción con Neo4j la realizaremos mediante el envío de consultas Cypher a través de la conexión que hemos establecido en el paso anterior.

El envío de estas consultas se realiza aplicando a una conexión el método `sendCypherQuery($query, [$params])`. Este método toma como argumento una consulta Cypher y opcionalmente un array asociativo de parámetros.


## Creación de nodos

Los nodos son creados definiendo expresiones en Cypher que serán pasadas como argumento al método `sendCypherQuery()` sobre la conexión creada.

A continuación vemos cómo crear un nodo `Person` para un actor con nombre (`name`) *John Doe*, y un nodo `Movie` para una película con título (`title`) *GGVD*. 

<script src="https://gist.github.com/ualmtorres/ffc12f086c65ced28fd7.js"></script>

## Creación de relaciones

Al igual que los nodos, las relaciones son creadas definiendo expresiones en Cypher que serán pasadas como argumento al método `sendCypherQuery()` sobre la conexión creada.

A continuación vemos cómo crear una relación entre los nodos `Person` y `Movie` creados anteriormente. La relación se denomina `ACTED_IN` y tiene asociada la propiedad `roles` con el valor `['Johnnie']` indicando que el actor *John Doe* tiene el papel (rol) de *Johnnie* en la película *GGVD*.

<script src="https://gist.github.com/ualmtorres/ac4f506ddce209b6dde3.js"></script>

## Uso de parámetros en las consultas

Las consultas Cypher que pasamos al método `sendCypherQuery()` se pueden definir parametrizadas. Los parámetros se asignarán posteriormente antes de enviar la consulta a Neo4j.

A continuación se muestra la misma consulta que usamos anteriormente para definir una relación `ACTED_IN` entre un nodo `Person` y un nodo `Movie`, pero ahora la crearemos de forma parametrizada. En este caso, el nombre de la persona es pasado como parámetro (`{theName}`), así como el título de la película (`{theTitle}`).

Para asignar valores a los parámetros crearemos un array asociativo que tendrá tantos elementos como parámetros hayamos definido. Cada elemento del array de parámetros tendrá como clave el parámetro, y como valor el valor del parámetro.

En el ejemplo, el array `$params` define los valores de los dos parámetros definidos en la consulta Cypher.

Por último, para ejecutar la consulta con el método `sendCypherQuery()` pasaremos la cadena de la consulta seguida del array de parámetros.

<script src="https://gist.github.com/ualmtorres/2e703823db3470e1d1cb.js"></script>
 
## Actualización y eliminación 

Como hemos comentado anteriormente, la interacción con Neo4j usando NeoClient se realiza enviando consultas Cypher al método `sendCypherQuery()`, independientemente de si son para crear nodos, para crear relaciones, o si son para actualizar o eliminar datos de la base de datos.

Por tanto, para actualizar o eliminar los ejemplos que añadimos anteriomente, basta con definir la expresión Cypher adecuada y ejecutarla con el método `sendCypherQuery()`.

El código siguiente elimina el *path* creado en los ejemplos anteriores formado por el actor *John Doe*, la película *GGVD*, y el papel de dicho actor en dicha película.

<script src="https://gist.github.com/ualmtorres/17fe11faf16d1abfd612.js"></script>

## Consulta básica

Los resultados que devuelve una consulta realizada con el método `sendCypherQuery()` lo asignaremos a un objeto que posteriormente procesaremos para mostrar el resultado de la consulta.

Básicamente se trata de hacer lo siguiente:

* Obtener los resultados mediante el método `getResult()`. Aplicaremos este método en cadena tras `sendCypherQuery()`. 
* Asignar los resultados de `getResult()` a un *resultset*.
* Recorrer el *resultset* obteniendo sus elementos (p.e. nodos). El método `getNodes()` devuelve los nodos de un *resultset*
* Recuperar el valor de una propiedad. El método `getProperty(<property>)` aplicado a un nodo devuelve el valor de la propiedad que le pasemos como parámetro.

El ejemplo siguiente muestra los títulos de las películas de 1998. 

<script src="https://gist.github.com/ualmtorres/a9e53e25653024fc25ee.js"></script>
 
## Consultas que devuelven un solo nodo

En ocasiones nuestras consultas sólo devuelven un nodo, o bien sólo estamos interesados en recuperar un solo nodo de un *resultset*. 

El método `getSingleNode()` aplicado a un *resultset* devuelve un nodo del *resultset*. Si el *resultset* contenía un solo nodo, `getSingleNode()` nos lo devuelve.

El ejemplo siguiente muestra el año de producción de la película *When Harry Met Sally*. La consulta recupera un nodo de la base de datos, y mediante `getSingleNode()` accedemos a él. Una vez recuperado ya le podemos aplicar los métodos aplicables a nodos, como `getProperty(<property>)`.

<script src="https://gist.github.com/ualmtorres/57c8c184a6d4c5030969.js"></script>

## ¿Y si RETURN devuelve varios elementos?

Es habitual que las expresiones Cypher incluyan en la cláusula `RETURN` varios elementos (p.e. varios tipos de nodos, relaciones, y demás).

Imaginemos la siguiente expresión Cypher:

```
MATCH (m: Movie {released: 1998})<-[r:ACTED_IN]-(p: Person) RETURN p, r, m
```

Para este caso, los métodos `getNodes()` y `getSingleNode()` no funcionarían correctamente al aplicarlos sobre el *resultset*, ya que no sabrían si actuar sobre los nodos `p`, las relaciones `r`, o los nodos `m`.

En casos como este, aplicaremos el método `get(<elemento>)` sobre el *resultset* para obtener el elemento del `RETURN` en el que estemos interesados.

El siguiente script ejecuta una consulta que devuelve los nodos película, persona y relación `ACTED_IN` para películas de 1998. A continuación, asigna los tres elementos del `RETURN` a tres variables. Para acceder a los elementos que devuelve el `RETURN` se usa el método `get(<elemento>)` sobre el *resultset*

<script src="https://gist.github.com/ualmtorres/97ed79f448a72b18b662.js"></script>

### Recorrido del conjunto de nodos

En el script anterior, `$actors` contiene la lista de nodos `Person` de las películas recuperadas. Para acceder a ellos, basta con iterar sobre `$actors` con un `foreach` y acceder a las propiedades de cada nodo con `getProperty(<propiedad>)`.

### Recorrido del conjunto de relaciones

En el script anterior, `$relationships` contiene la lista de relaciones entre los nodos de las películas recuperadas y los nodos de los actores que actuan en ellas. 

Cada relación tiene dos extremos, el nodo de inicio y el nodo de fin de la relación. Los métodos `getStartNode()` y `getEndNode()` aplicados a una relación devuelven, respectivamente, el nodo de inicio y el nodo de fin de la relación.

Para acceder a los nodos de las relaciones tendremos que iterar sobre `$relationships` con un `foreach`, y acceder a los nodos de inicio y fin con `getStartNode()` y `getEndNode()`, respectivamente. A continuación, y ya sobre cada nodo podremos acceder a las propiedades de cada nodo con `getProperty(<propiedad>)`.


## Obtener las relaciones de un nodo

Si la consulta que hemos realizado, además de los nodos, contiene los paths o relaciones con los nodos, podemos estar interesados en mostrar las relaciones que llegan o salen de un nodo.

Los métodos `getInboundRelationships()` y `getOutboundRelationships()` devuelven, respectivamente, las relaciones que llegan o salen de un nodo. El método `getRelationships()` devuelve todas las relaciones que mantiene un nodo, ya sean de entrada o de salida.

El script siguiente muestra un ejemplo en el que a partir de un conjunto de películas (`$movies`), realiza una iteración con un `foreach` y para cada película muestra su título, obtiene todos las relaciones de entrada con `getInboundRelationships()`, y finalmente para cada relación obtiene su nodo de origen (el actor) con `getStartNode()`, y muestra su nombre con `getProperty('name')`.

<script src="https://gist.github.com/ualmtorres/ab71dd9ee4258807487f.js"></script>

Otro ejemplo interesante lo podemos encontrar en el fragmento siguiente. A partir de un conjunto de películas (`$movies`) se realiza una iteración con un `foreach` y para cada película se muestra su título, y se obtienen todas las relaciones con `getRelationships(<relacion>)`.

Para cada relación se obtiene su nodo de origen (que podrá ser, según la relación, actor, director, guionista o productor) con `getStartNode()`, y muestra su nombre con `getProperty('name')`.

<script src="https://gist.github.com/ualmtorres/b67935b1d240c2f8643f.js"></script>


Puedes [descargar el código de este tutorial](https://github.com/ualmtorres/Neo4jPHP) del GitHub de este proyecto.
 


---
layout: layout
title: "Posts"
---
# Uso de los drivers Node.js de Redis, MongoDB y Neo4j en una API REST Express

[Express](https://expressjs.com/) es un framework de desarrollo web para Node.js. En este tutorial comenzaremos realizando una breve introducción a Express para crear un endpoint sencillo de una [API REST](http://en.wikipedia.org/wiki/Representational_state_transfer). Después, mostraremos cómo usar los drivers Node.js de [Redis](https://www.npmjs.com/package/redis), [MongoDB](https://www.npmjs.com/package/mongodb) y [Neo4j](https://www.npmjs.com/package/neo4j-driver) para crear una API REST en Express para este tipo de bases de datos NoSQL.

## Instalación de Express

Partimos de un equipo en el que ya están instalados Node.js y npm.

```
$ node --version
v16.13.0
$ npm --version
9.1.2
```

Para configurar nuestro equipo para el desarrollo con Express instalaremos los dos paquetes siguientes:

* `express-generator`: Crea de forma rápida el esqueleto de la aplicación
* `nodemon`: Herramienta útil en el desarrollo que permite recargar la aplicación en el navegador al modificar algún archivo en la carpeta de la aplicación

Los instalaremos con 

```
$ npm install -g express-generator
$ npm install -g nodemon
```

Una vez instalados comprobaremos su funcionamiento con

```
$ express --version
4.16.1
$ nodemon --version
2.0.21
```

## Preparación del entorno de bases de datos

Las bases de datos NoSQL que usaremos en este tutorial (Redis, MongoDB y Neo4j) las instalaremos mediante un scrript Docker Compose. Se trata de una instalación básica para poder trabajar en el tutorial.

<script src="https://gist.github.com/ualmtorres/c85c3caf61eb9db953ebd5bd9d77ab53.js"></script>

## Proyecto básico API REST con Express

Antes de ver cómo crear la API con Express para interactuar con Redis, MongoDB y Neo4j, veamos primero cómo montar un ejemplo sencillo sin complicarnos con la base de datos. Concretamente se trata de crear una API REST con dos métodos GET. El primer método es un método básico, sin parámetros, que devuelve un código de estado HTTP y un resultado en JSON. El segundo método GET usará un parámetro en la URL. Cuando trabajemos en la API con las bases de datos, estas situaciones de aceptar parámetros, devolver códigos de estado HTTP y resultados en JSON serán algo habitual, por lo que este ejercicio básico nos enseñará una serie de rudimentos que después usaremos continuamente en el desarrollo de la API REST con bases de datos NoSQL.

Comenzaremos creando un directorio para nuestro proyecto, inicializando a continuación un proyecto Express.

```
$ mkdir bdge-express-test
$ cd bdge-express-test
$ express
```
### Estructura predeterminada del proyecto

Tras inicializar el proyecto con Express, la estructura del proyecto es similar a la que se describe a continuación.

```
├── app.js 
├── bin
│   └── www
├── node_modules 
│   ├── ...
├── package.json 
├── public 
│   ├── images
│   ├── javascripts
│   └── stylesheets
├── routes 
│   ├── index.js
│   └── users.js
└── views 
    ├── error.jade
    ├── index.jade
    └── layout.jade
```

Destacamos lo siguiente:

* En el archivo `app.js` se definen, entre otros, los archivos de rutas (p.e. archivos de rutas de la aplicación y de la API), el motor de plantilla usado (p.e. [Jade](http://jade-lang.com/)) y la ubicación de la carpeta de vistas.
* El directorio `node_modules` contiene los módulos instalados de la aplicación.
* El archivo `package.json` contiene información descriptiva de la aplicación, punto de inicio (p.e. `bin/www`) y dependencias (p.e. Express, Jade, drivers de bases de datos, …​)
* En el directorio `public` colocaremos las imágenes, hojas de estilo y scripts que no queremos que bloqueen al servidor mientras son servidos a los clientes.
* El directorio `routes` contiene archivos de rutas que indican los controladores que dan respuesta a cada petición
* El directorio `views` contiene cada una de las vistas de presentación de datos de la aplicación.

### Configuración de carpetas

Express crea de forma predeterminada la estructura anterior. Sin embargo, de cara a desarollar la API es conveniente separar las carpetas que incluyan los modelos, rutas y controladores asociados. Esta es la organzación propuesta:

```
bdge-express-test/
├── controllers
├── models
└── routes
```

La carpeta `routes` ya está creada al iniciar el proyecto Express. Por tanto, sólo crearíamos las carpetas de `models` y `controllers`. Para crearlas, ejecutaríamos estos comandos desde la carpeta del proyecto

```
$ mkdir models
$ mkdir controllers
```

> **NOTA**
>
> En este proyecto no usaremos las carpeta `models`

Puedes [descargar este proyecto básico de API REST con Express](https://github.com/ualmtorres/bdge-express-test) desde un repositorio en GitHub.

### Ejecución inicial del proyecto

Antes de ejecutar el proyecto por primera vez instalaremos las dependencias definidas en el archivo `package.json` con

```
$ npm install
```

Si aparece que los paquetes actuales tienen algún tipo de vulnerabilidad reconocida, ejecuta el comando siguiente para que las corrija modificando las versiones definidas por versiones sin vulnerabilidades. Ejecuta el comando las veces que sea necesario.

```
$ npm audit fix --force
```

Una vez resueltas las vulnerabilidades, ejecuta el proyecto con 

```
$ nodemon
```

La aplicación estará disponible en `http://localhost:3000` y la podremos ver con un navegador.

![](images/express-home-page.png)

## Ruta y Controlador `users` preconfigurado

Al crear un proyecto Express, el generador del proyecto ha creado y configurado una ruta de prueba para `users`. Podemos acceder a ella a través de `http://localhost:3000/users`.

![](images/users-endpoint.png)

Lo que muestra el navegador obedece a lo siguiente:

* En `app.js` se carga el archivo del controlador mediante
  ```
	var usersRouter = require('./routes/users');
  ```
  
* Activar la ruta `/users` en la aplicación mediante
  
  ```
	app.use('/users', usersRouter);
  ```
* En `routes/users.js` se tiene el código siguiente, que define una ruta de ejecución (`/`) a añadir a la ruta URL `/users` definida en `app.js` y asocia un código para ejecutar. El código que se ejecuta es el código del controlador asociado a la ruta.

  ```
	var express = require('express');
	var router = express.Router();

	/* GET users listing. */
	router.get('/', function(req, res, next) {
		res.send('respond with a resource');
	});

	module.exports = router;
	```

Por tanto, en `app.js` se indica que el código de ejecución de la ruta `/users` se encuentra en el archivo `routes/users.js`. A su vez, en este archivo `routes/users.js` se indica que las peticiones a la raíz de este archivo de rutas, es decir, a `/users/` se resolverán enviando la respuesta

```
res.send('respond with a resource');
```
Por eso, es por lo que el navegador devuelve ese valor al enviar la petición `http://localhost:3000/users`

### Creación de un endpoint que devuelva la hora

Comenzamos creando un controlador `controllers/hello.js` con una función que devuelva un JSON con la hora actual del sistema y un estado `OK`.

```
exports.getCurrentDate = () => {
    return ({result: "OK", data: new Date()});
};
```

A continuación creamos el archivo de rutas `routes/hello.js` que define un ruta (`/`) asociada a la función de obtener la hora definida anteriormente. El resultado de dicha función se encapsulará dentro de un objeto JSON y se devolverá con un código de estado HTTP `200` para indicar que la petición se ha resuelto de forma satisfactoria.

```
var express = require('express');
var router = express.Router();
const helloController = require('../controllers/hello')

router.get('/', function(req, res, next) {
  res.status(200).json(helloController.getCurrentDate())
});

module.exports = router;
```

Por último, se cargará el archivo de rutas (`controllers/hello.js`) en `app.js` y se expondrá en la ruta `/hello`

```
...
var helloRouter = require('./routes/hello');
...
app.use('/hello', helloRouter);
...
```

Al llamar al endpoint `http://localhost:3000/hello` obtendremos la fecha actual en formato JSON

![](images/current-time.png)

### Creación de un endpoint que devuelva una lista de personas

En primer lugar añadimos al controlador `controllers/hello.js` la función que devuelva la lista de personas

```
...
exports.getPeople = (name) => {
    const people = [
        {name: "John"},
        {name: "Mary"}
    ]
    return ({result: "OK", data: people});
};
...
```

A continuación, añadimos al archivo de rutas `routes/hello.js` la nueva ruta y la llamada al método recién definido.

```
...
router.get('/people', function(req, res, next) {
  res.status(200).json(helloController.getPeople())
});
...
```

Al llamar al endpoint `http://localhost:3000/hello/people` obtendremos la lista de personas en formato JSON

![](images/people.png)

### Creación de un endpoint que devuelva una persona pasada como parámetro por la URL

En primer lugar añadimos al controlador `controllers/hello.js` la función que devuelva una persona a partir de su nombre

```
...
exports.getPeopleByName = (name) => {
    return ({result: "OK", data: {name: name}});
};
...
```

A continuación, añadimos al archivo de rutas `routes/hello.js` la nueva ruta y la llamada al método recién definido. Al parámetro se le asocia un nombre en la ruta que definirá una variable asociada con el nombre de parámetro utilizado (en nuestro caso `name`). Al parámetro se accederá con ese nombre, precedido de `req.params` (en nuestro caso `req.params.name`).

```
...
router.get('/people/:name', function(req, res, next) {
  res.status(200).json(helloController.getPeopleByName(req.params.name))
});
...
```

Al llamar al endpoint `http://localhost:3000/hello/people/mary` obtendremos la lista de personas en formato JSON

![](images/express-hello-mary.png)

> **NOTA**
>
> Si el parámetro se pasa como _query parameter_ (p.e. `/hello/people?name=mary`) se accederá a él con `req.query.name`, indicando que es un _query parameter_.

## Interacción con Redis

Comenzamos instalando el [paquete `npm` para Redis](https://www.npmjs.com/package/redis) con

```
$ npm install redis
```

### Datos de ejemplo

De cara a poder realizar una prueba inicial, vamos a introducir un par clave-valor en Redis a modo de ejemplo para recuperarlo y conseguir interactuar con Redis. Introduciremos el par `spain:capital Madrid` como cadena con RedisInsight en `http://localhost:8001` disponible en el entorno desplegado en el apartado [Preparación del entorno de bases de datos](preparación-del-entorno-de-bases-de-datos).

![](images/spain-madrid.png) 

### Descripción de la API

Ilustraremos la creación de la API con dos métodos básicos `GET` (uno de prueba de conexión y otro de recuperación de un valor a partir de la clave) y un método `POST` para almacenar un par clave-valor. A continuación se muestran los endpoints a implementar.

| Método  	| Path  	| Descripción  	| 
|:--:		|:---:		|---	|
| `GET`  	| `/test`  		| Prueba de conexión  	|
| `GET`  	| `/:key`  	| Para pares `string` recupera el valor de la clave introducida  |   
| `POST`	| `/`		| Para pares `string` almacena el par pasado como `body`

### Conexión con Redis

Creamos un archivo `routes/redis.js` con un código inicial para que realice la conexión con Redis. Comenzaremos con:

```
var express = require('express');
var router = express.Router();

var redis = require('redis');
var client = redis.createClient({host: 'localhost', port: 6379}); 

/* Connect to Redis */
router.get('/test',  async function(req, res, next) {
  await client.connect();
  await client.disconnect();
  res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
});

module.exports = router;
```

A continuación, añadimos la ruta a `app.js`

```
...
var redisRouter = require('./routes/redis');
...
app.use('/redis', redisRouter);
...
```

El endpoint para la prueba está en `http://localhost:3000/redis` y devuelve que la conexión se ha realizado correctamente.

![](images/redis-connected.png)

### Métodos del driver de Redis

El driver de Redis ofrece soporte para todos los comandos de Redis de estas dos formas:

* Nombres de comando Redis en mayúsculas (`SET, GET, HSET, HGETALL, ...`)
* Nombres de comamdo camel-case ('set, get, hSet, hGetAll, ...')

En el tutorial usaremos la opción camel-case.

### Recuperación de un par clave-valor

Para recuperar un par clave-valor de Redis, modificaremos el archivo `routes/redis.js` para añadir una nueva ruta `GET` que aceptará la clave a recuperar como un parámetro en la URL (`key`). 

```
var express = require('express');
var router = express.Router();

var redis = require('redis');
var client = redis.createClient({host: 'localhost', port: 6379}); 

/* Connect to Redis */
router.get('/test',  async function(req, res, next) {
  await client.connect();
  await client.disconnect();
  res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
});

/* GET Redis data. */
router.get('/:key',  async function(req, res, next) {
  await client.connect();
  const value = await client.get(req.params.key);
  await client.disconnect();
  res.status(200).json({result: 'OK', data: value});
});

module.exports = router;
```

Recuperaremos el valor de la clave `spain:capital` en la URL `http://localhost:3000/redis/spain:capital`

![](images/spain-madrid-get.png)

### Almacenamiento de un par clave-valor

Para almacenar un par clave-valor en Redis, modificaremos el archivo `routes/redis.js` para añadir una nueva ruta `POST` que aceptará en el `body` el par clave-valor a almacenar. El `body` lo pasaremos en este formato:

```
{
    "key": "france:capital",
    "value": "paris"
}
```

```
var express = require('express');
var router = express.Router();

var redis = require('redis');
var client = redis.createClient({host: 'localhost', port: 6379}); 

/* Connect to Redis */
router.get('/test',  async function(req, res, next) {
  await client.connect();
  await client.disconnect();
  res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
});

/* GET Redis data. */
router.get('/:key',  async function(req, res, next) {
  await client.connect();
  const value = await client.get(req.params.key);
  await client.disconnect();
  res.status(200).json({result: 'OK', data: value});
});

/* POST Redis data. */
router.post('/', async function(req, res, next) {
  await client.connect();
  const value = await client.set(req.body.key, req.body.value );
  await client.disconnect();
  res.status(201).send({result: value});
});

module.exports = router;
```

Probamos a introducir un nuevo par clave-valor con Postman en el endpoint `http://localhost:3000/redis`.

![](images/redis-post.png)

Con el endpoint de recuperación de clave-valor del apartado anterior comprobamos que podemos recuperar en `http://localhost:3000/redis/france:capital` los datos introducidos.

![](images/france-paris-get.png)

> **Redirección a `/test`**
>
> Como la ruta `/` no tiene ningún controlador asociado, podemos redirigir a la ruta `/test` las peticiones que lleguen a la ruta `/`
>
> ```
> /* Redirect to test */
> router.get('/', function(req, res, next) {
>     res.redirect('redis/test')
> })
> ```

## Interacción con MongoDB

Comenzamos instalando el [paquete `npm` para MongoDB](https://www.npmjs.com/package/mongodb) con

```
$ npm install mongodb
```

### Datos de ejemplo

De cara a poder realizar una prueba inicial, creaemos en MongoDB una base de datos denominada `BDGE`, una colección denominada `geo`  e introduciremos el documento siguiente a modo de ejemplo para recuperarlo y conseguir interactuar con MongoDB. Usaremos el cliente [MongoDB Compass](https://www.mongodb.com/products/compass), la GUI para MongoDB. 

![](images/mongodb-insert-document.png)

### Descripción de la API

Ilustraremos la creación de una API con tres métodos básicos `GET` (uno de prueba de conexión, uno de recuperación de todos los documentos de una colección y otro de recuperación de un documento a partir de un parámetro) y un método `POST` para almacenar un par clave-valor. A continuación se muestran los endpoints a implementar.

| Método  	| Path  	| Descripción  	| 
|:--:		|:---:		|---	|
| `GET`  	| `/test`  		| Prueba de conexión  	|
| `GET`  	| `/`  		| Recuperar todos los países  	|
| `GET`  	| `/:country`  	| Para recuperar el valor del país introducido  |   
| `POST`	| `/`		| Para almacenar el documento pasado como `body`

### Conexión con MongoDB

Creamos un archivo `routes/mongodb.js` con un código inicial para que realice la conexión con MongoDB. Comenzaremos con:

```
var express = require('express');
var router = express.Router();

const {MongoClient} = require('mongodb')
const url = 'mongodb://xxx:xxx@localhost:27017/?authMechanism=DEFAULT';
const client = new MongoClient(url);
const dbName = "bdge"

/* Connect to MongoDB. */
router.get('/test', async function(req, res, next) {
    await client.connect(dbName);
    const db = client.db(dbName)
    collection = db.collection('geo')
    res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
    await client.close();
});

module.exports = router;
```

A continuación, añadimos la ruta a `app.js`

```
...
var mongodbRouter = require('./routes/mongodb');
...
app.use('/mongodb', mongodbRouter);
...
```

El endpoint para la prueba está en `http://localhost:3000/mongodb/test` y devuelve que la conexión se ha realizado correctamente.

![](images/mongodb-connected.png)

### Métodos del driver de MongoDB

El driver de MongoDB ofrece soporte para todos los comandos de MongoDB respetando el nombre y la sintaxis (p.e. `find({ a: 3 }), insertMany([{ a: 1 }, { a: 2 }, { a: 3 }]), ...`)

### Recuperación de documentos

Para recuperar documentos de MongoDB, modificaremos el archivo `routes/mongodb.js` para añadir una nueva ruta `GET` que recuperará todos los documentos de la colección `geo`. 

```
var express = require('express');
var router = express.Router();

const {MongoClient} = require('mongodb')
const url = 'mongodb://xxx:xxx@localhost:27017/?authMechanism=DEFAULT';
const client = new MongoClient(url);
const dbName = "bdge"

/* Connect to MongoDB. */
router.get('/test', async function(req, res, next) {
    await client.connect(dbName);
    const db = client.db(dbName)
    collection = db.collection('geo')
    res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
    await client.close();
});

/* GET MongoDB data. */
router.get('/', async function(req, res, next) {
    await client.connect(dbName);
    const db = client.db(dbName)
    collection = db.collection('geo')
    const result = await collection.find(req.query).toArray();
    res.status(200).send(result);
	await client.close();
  });

module.exports = router;
```

Recuperaremos los documentos de `geo` en la URL `http://localhost:3000/mongodb`

![](images/mongodb-find.png)

### Recuperación de un documento

Para recuperar un documento concreto de MongoDB, modificaremos el archivo `routes/mongodb.js` para añadir una nueva ruta `GET` que recuperará un documento de la colección `geo` a partir del país introducido. 

```
var express = require('express');
var router = express.Router();

const {MongoClient} = require('mongodb')
const url = 'mongodb://xxx:xxx@localhost:27017/?authMechanism=DEFAULT';
const client = new MongoClient(url);
const dbName = "bdge"

/* Connect to MongoDB. */
router.get('/test', async function(req, res, next) {
    await client.connect(dbName);
    const db = client.db(dbName)
    collection = db.collection('geo')
    res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
    await client.close();
});

/* GET MongoDB data. */
router.get('/', async function(req, res, next) {
    await client.connect(dbName);
    const db = client.db(dbName)
    collection = db.collection('geo')
    const result = await collection.find(req.query).toArray();
    res.status(200).send(result);
    await client.close();
  });

/* GET MongoDB data by country. */
router.get('/:country',  async function(req, res, next) {
    await client.connect(dbName);
    const db = client.db(dbName)
    collection = db.collection('geo')
    const result = await collection.findOne({country: req.params.country});
    res.status(200).send(result);
    await client.close();
});

module.exports = router;
```

Recuperaremos el documento de `Spain` en la URL `http://localhost:3000/mongodb/Spain`

![](images/mongodb-spain.png)

### Almacenamiento de un documento

Para almacenar un documento en MongoDB, modificaremos el archivo `routes/mongodb.js` para añadir una nueva ruta `POST` que aceptará en el `body` el documento a almacenar. El `body` lo pasaremos en este formato:

```
{
    "country": "France",
    "capital": "Paris"
}
```

```
var express = require('express');
var router = express.Router();

const {MongoClient} = require('mongodb')
const url = 'mongodb://xxx:xxx@localhost:27017/?authMechanism=DEFAULT';
const client = new MongoClient(url);
const dbName = "bdge"

/* Connect to MongoDB. */
router.get('/test', async function(req, res, next) {
    await client.connect(dbName);
    const db = client.db(dbName)
    collection = db.collection('geo')
    res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
    await client.close();
});

/* GET MongoDB data. */
router.get('/', async function(req, res, next) {
    await client.connect(dbName);
    const db = client.db(dbName)
    collection = db.collection('geo')
    const result = await collection.find(req.query).toArray();
    res.status(200).send(result);
    await client.close();
  });

/* POST MongoDB data. */
router.post('/', async function(req, res, next) {
    await client.connect(dbName);
    const db = client.db(dbName)
    collection = db.collection('geo')
    const result = await collection.insertOne(req.body)
    res.status(201).send(result);
    await client.close();
  });
  
module.exports = router;
```

Probamos a introducir un nuevo documento con Postman en el endpoint `http://localhost:3000/mongodb`.

![](images/mongodb-post.png)

Con el endpoint de recuperación de documentos en `http://localhost:3000/mongodb` comprobamos que los datos se han almacenado.

![](images/mongodb-find-after-insert.png)


## Interacción con Neo4j

Comenzamos instalando el [paquete `npm` para Neo4j](https://www.npmjs.com/package/neo4j-driver) con

```
$ npm install neo4j-driver
```

### Datos de ejemplo

De cara a poder realizar una prueba inicial, utilizaremos la base de datos del tutorial disponible en la instalación de Neo4j sobre una base de datos cinematográfica. Podemos activarlo en el Neo4j Browser en `http://localhost:7474` disponible en el entorno desplegado en el apartado [Preparación del entorno de bases de datos](preparación-del-entorno-de-bases-de-datos).

### Descripción de la API

Ilustraremos la creación de una API con tres métodos básicos `GET` (uno de prueba de conexión, uno de recuperación de todas las películas y otro de recuperación de una película a partir de un parámetro) y un método `POST` para almacenar una película. A continuación se muestran los endpoints a implementar.

| Método  	| Path  	| Descripción  	| 
|:--:		|:---:		|---	|
| `GET`  	| `/test`  		| Prueba de conexión  	|
| `GET`  	| `/`  		| Recuperar todas las peliculas  	|
| `GET`  	| `/:movie`  	| Para recuperar la película introducida  |   
| `POST`	| `/`		| Para almacenar la película pasada como `body`

### Conexión con Neo4j

Creamos un archivo `routes/neo4j.js` con un código inicial para que realice la conexión con Neo4j. Comenzaremos con:

```
var express = require('express');
var router = express.Router();

const neo4j = require('neo4j-driver')
const driver = neo4j.driver('bolt://localhost:7687', neo4j.auth.basic('', ''))

/* Connect to Neo4j */
router.get('/test', async function(req, res, next) {
    const session = driver.session()
    res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
    await session.close()
});

module.exports = router;
```

A continuación, añadimos la ruta a `app.js`

```
...
var neo4jRouter = require('./routes/neo4j');
...
app.use('/neo4j', neo4jRouter);
...
```

El endpoint para la prueba está en `http://localhost:3000/neo4j/test` y devuelve que la conexión se ha realizado correctamente.

![](images/neo4j-connected.png)

### Métodos del driver de Neo4j

El driver de Neo4j ofrece soporte para ejecutar consultas pasando la consulta Cypher al método `run` de la clase `Session`.

### Recuperación de datos

Para recuperar datos de Neo4j, modificaremos el archivo `routes/neo4j.js` para añadir una nueva ruta `GET` que recuperará todos los títulos de películas en las que haya actuado alguien (`MATCH ()-[:ACTED_IN]->(m) RETURN m.title`). 

```
var express = require('express');
var router = express.Router();

const neo4j = require('neo4j-driver')
const driver = neo4j.driver('bolt://localhost:7687', neo4j.auth.basic('', ''))

/* Connect to Neo4j */
router.get('/test', async function(req, res, next) {
    const session = driver.session()
    res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
    await session.close()
});

/* GET Neo4j data. */
router.get('/', async function(req, res, next) {
    const session = driver.session()
    const query = 'MATCH ()-[:ACTED_IN]->(m) RETURN m.title'
    const result = await session.run(query);
    res.status(200).send(result);
    await session.close()
});

module.exports = router;
```

Recuperaremos los títulos de las películas en la URL `http://localhost:3000/neo4j`

![](images/neo4j-find.png)

### Recuperación de una película

Para recuperar una película concreta por título de Neo4j, modificaremos el archivo `routes/neo4j.js` para añadir una nueva ruta `GET`, que recuperará una película a partir dei título introducido. El título lo pasaremos como un _query parameter_.

```
var express = require('express');
var router = express.Router();

const neo4j = require('neo4j-driver')
const driver = neo4j.driver('bolt://localhost:7687', neo4j.auth.basic('', ''))

/* Connect to Neo4j */
router.get('/test', async function(req, res, next) {
    const session = driver.session()
    res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
    await session.close()
});

/* GET Neo4j data. */
router.get('/', async function(req, res, next) {
    const session = driver.session()
    const query = 'MATCH ()-[:ACTED_IN]->(m) RETURN m.title'
    const result = await session.run(query);
    res.status(200).send(result);
    await session.close()
});

/* GET Neo4j data by title. */
router.get('/movie', async function(req, res, next) {
    const session = driver.session()
    let query = `MATCH (m: Movie) RETURN m`

    if (title = req.query.title)
        query = `MATCH (m: Movie) WHERE m.title = "${title}" RETURN m`;
    
    const result = await session.run(query);
    res.status(200).send(result);
    await session.close()
});

module.exports = router;
```

Recuperaremos la película `The Matrix` en la URL `http://localhost:3000/neo4j/movie?title=The Matrix`

![](images/neo4j-the-matrix.png)

### Almacenamiento de una película

Para almacenar una película en Neo4j, modificaremos el archivo `routes/neo4j.js` para añadir una nueva ruta `POST`. La ruta aceptará en el `body` la película a almacenar. El `body` lo pasaremos en este formato:

```
{
    "title": "Babylon",
    "released": 2022,
    "tagline": "Historia de ambición y excesos desmesurados en los inicios de Hollywood"
}
```

```
var express = require('express');
var router = express.Router();

const neo4j = require('neo4j-driver')
const driver = neo4j.driver('bolt://localhost:7687', neo4j.auth.basic('', ''))

/* Connect to Neo4j */
router.get('/test', async function(req, res, next) {
    const session = driver.session()
    res.status(200).json({result: 'OK', data: 'Se realizado la conexión'});
    await session.close()
});

/* GET Neo4j data. */
router.get('/', async function(req, res, next) {
    const session = driver.session()
    const query = 'MATCH ()-[:ACTED_IN]->(m) RETURN m.title'
    const result = await session.run(query);
    res.status(200).send(result);
    await session.close()
});

/* GET Neo4j data by title. */
router.get('/movie', async function(req, res, next) {
    const session = driver.session()
    let query = `MATCH (m: Movie) RETURN m`

    if (title = req.query.title)
        query = `MATCH (m: Movie) WHERE m.title = "${title}" RETURN m`;
    
    const result = await session.run(query);
    res.status(200).send(result);
    await session.close()
});

/* POST MongoDB data. */
router.post('/', async function(req, res, next) {
    const session = driver.session()
    const query = `CREATE (m: Movie {title: "${req.body.title}",
        released: ${req.body.released}, 
        tagline: "${req.body.tagline}"
    })`
    
    const result = await session.run(query);
    res.status(201).send(result);
    await session.close()
});

module.exports = router;
```

Probamos a introducir una nueva película con Postman en el endpoint `http://localhost:3000/neo4j`.

![](images/neo4j-post.png)

Con el endpoint de recuperación de películas, en `http://localhost:3000/neo4j/movie?title=Babylon` comprobamos que los datos se han almacenado.

![](images/neo4j-find-after-insert.png)


### Descarga el código de este proyecto

Puedes [descargar el código del ejemplo básico de API REST en Express para bases de datos NoSQL](https://github.com/ualmtorres/bdge-express-test) del repositorio de GitHub.

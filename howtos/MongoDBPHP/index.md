---
layout: layout
title: "Posts"
---

# Usando MongoDB y PHP

MongoDB nos ofrece gran cantidad de clientes para interactuar con él mediante gran cantidad de lenguajes de programación ([Drivers MongoDB](https://docs.mongodb.com/ecosystem/drivers/)).

En nuestro ejemplo interactuaremos con MongoDB mediante la Librería PHP para MongoDB.

## Instalación

Siguiendo la [Información de instalación de la Librería PHP para MongoDB](https://docs.mongodb.com/php-library/master/tutorial/install-php-library/) podrás instalar estos dos componentes necesarios:

* La extensión `mongodb` para PHP en tu equipo a través del repositorio de extensiones PHP [PECL](http://pecl.php.net/).
* La Librería PHP en sí para MongoDB

Aquí mostraremos los pasos de instalación en un Ubuntu Linux que ya tiene instalado previamente MongoDB y un entorno LAMP ([Tutorial sobre configuración de un entorno LAMP+NoSQL](http://ualmtorres.github.io/howtos/ConfiguracionEntornoGGVD/)). Básicamente se trata de descargar e instalar el driver, añadir la extensión al `php.ini`, y reiniciar el servidor Apache.   

Si no tienes instalado `PEAR` y el paquete `php-dev` deberás instalarlos con

```
sudo apt-get install -y php-pear
sudo apt-get install -y php-dev
```

Para descargar e instalar el driver lo haremos con 

```
sudo pecl install mongodb
```

Esto hará que se descargue el driver, se compile y se instale en nuestro sistema como una extensión.
 
Si estuviésemos utilizando XAMPP, tendríamos que utilzar el `pecl` de XAMPP. Por ejemplo, podríamos hacerlo de una forma similiar a esta:

```
sudo /Applications/XAMPP/xamppfiles/bin/pecl install mongodb
```

A continuación hay que modificar el archivo `php.ini` para indicar que cargue la extensión de MongoDB (`mongodb.so`). `php.ini` se encuentra en `/etc/php/7.0/apache2/php.ini`. Tendrás que añadir lo siguiente en la zona de extensiones.

```
extension=mongodb.so
```

Ahora, reiniciaremos el servidor Apache para que tengan efecto los cambios

```
sudo service apache2 restart
```


##  Manos a la obra

En este [Tutorial sencillo de PHP con MongoDB](https://docs.mongodb.com/php-library/master/tutorial/) puedes encontrar un ejemplo guiado de cómo comenzar con los aspectos básicos del scripting PHP con MongoDB. Además, es muy conveniente tener a mano esta [Referencia] (https://docs.mongodb.com/php-library/master/reference/) en la que podrás encontrar casi todo lo que necesitas para tu aplicación PHP con MongoDB.

### Instalación de la librería

La [Librería PHP para MongoDB](https://docs.mongodb.com/php-library/master/) ofrece una abstracción de alto nivel sobre el [driver PHP para MongoDB](http://php.net/manual/en/set.mongodb.php).

Instalaremos la Librería PHP para MongoDB mediante `Composer` ejecutando el comando siguiente **sobre la raíz de nuestro proyecto**

```
composer require mongodb/mongodb
```

Esto instalará la librería en nuestro proyecto y generará los archivos de `autoload`.


Si se produce un error de este tipo

```
Your requirements could not be resolved to an installable set of packages.

  Problem 1
    - Installation request for mongodb/mongodb ^1.6 -> satisfiable by mongodb/mongodb[1.6.0].
    - mongodb/mongodb 1.6.0 requires ext-mongodb ^1.7 -> the requested PHP extension mongodb is missing from your system.

  To enable extensions, verify that they are enabled in your .ini files:
    - /etc/php/7.0/cli/php.ini
...
```
nos está informando que no puede encontrar la extensión de MongoDB para PHP. Esto se debe a que Composer no está usando el mismo archivo `php.ini` que hemos configurado anteiormente. Una opción es añadir al archivo `/etc/php/7.0/cli/php.ini` la extensión de MongoDB para PHP:

```
extension=mongodb.so
```


Para usar la librería en el proyecto comenzaremos con el script siguiente

```
<?php
require 'vendor/autoload.php';
?>
```

### Conexión a MongoDB

Una vez instalada la librería, el proceso de conexión es muy sencillo. Basta con instanciar la clase `MongoDB\Client`. Si no indicamos parámetros se conectará usando `localhost` y el puerto predeterminado (`27017`).

Esta clase sirve como punto de entrada a la MongoDB PHP Library. Usaremos la clase `\MongoDB\Client` para conectarnos a un servidor o cluster de servidores MongoDB y actúa como gateway para acceder a bases de datos o colecciones.

<script src="https://gist.github.com/ualmtorres/18da35108b1f9e96e310.js"></script>



### Selección de la colección

La conexión creada nos servirá para seleccionar la base de datos y la colección con la que queremos trabajar. Podremos crear un objeto para la base de datos y otro para la colección, o bien crear sólo el objeto de la colección si no queremos usar ninguno de los métodos aplicables a la base de datos (crear bases de datos, operaciones con el *profile*, *write  concern*, ...)

A continuación vemos cómo crear un objeto para una base de datos de ejemplo denominada `ggvdTest` y un objeto para una colección de prueba denominada `actor`, que incluirá actores.  
 
<script src="https://gist.github.com/ualmtorres/2ab2429f06b267f893b2.js"></script>

### Inserción de documentos

Los documentos se crean mediante arrays asociativos. Estos documentos se insertarán con los métodos `insertOne()` o `insertMany()` sobre la colección correspondiente, para insertar uno o varios documentos, respectivamente.

> NOTA
> 
> A los métodos de inserción, actualización y eliminación le podremos pasar opcionalmente un array de opciones (p.e. para especificar el `Write Concern`).


 <script src="https://gist.github.com/ualmtorres/03f1806501b4b5742c2d.js"></script>
 
### Actualización de documentos
 
Los documentos se actualizan mediante los métodos `updateOne()` o `updateMany()` sobre una colección. A los métodos le pasaremos el array asociativo con los criterios, el nuevo objeto (que podrá incluir operadores de actualización para modificar o reemplazar documentos), y de forma optativa las opciones de actualización. 

Entre las opciones de actualización más destacadas se encuentran `upsert` (`boolean`), que especifica si crear un documento nuevo o no si no hay ninguna coincidencia en la búsqueda, y `writeConcern`.

En el caso de que usemos el método `updateOne()` y existan varios documentos que cumplan los criterios, sólo se actualizará el primer documento que cumpla los criterios.

<script src="https://gist.github.com/ualmtorres/f49457b604734c48cde0.js"></script>

### Eliminación de documentos

La eliminación de documentos se realiza mediante los métodos `deleteOne()` o `deleteMany()` aplicados a una colección. A los métodos le pasaremos el array asociativo con los criterios, y de forma optativa las opciones de eliminación. 

Al igual que con el método `updateOne()`, en el caso de que usemos el método `deleteOne()` y existan varios documentos a que cumplan los criterios, sólo se eliminará el primer documento que cumpla los criterios.

<script src="https://gist.github.com/ualmtorres/186551788f68b0a9e182.js"></script>

### Búsqueda de documentos

La búsqueda de documentos se realiza básicamente mediante los métodos `findOne()` y  `find()` aplicados a una colección para buscar, respectivamente, uno o varios documentos que cumplan los criterios de búsqueda. En el caso de usar `find()`, recorreremos el resultado con un bucle `foreach` y en cada pasada cada documento será tratado como un array asociativo.

<script src="https://gist.github.com/ualmtorres/f210d59b0ffc8801654d.js"></script>
 
### Framework de agregación

Las operaciones relacionadas con el framework de agregación se realizan con el método `aggregate()`. A este método le proporcionaremos el *pipeline* de operaciones (`$match`, `$project`, `$group`, `$sort`, ...) en forma de array asociativo. El método devolverá el resultado en forma de array tal y como ocurre como cuando se usa el framework de agregación desde la shell.

<script src="https://gist.github.com/ualmtorres/70899dfccfbedaf5f59f.js"></script>

Puedes [descargar el código de este tutorial](https://github.com/ualmtorres/MongoDBPHPSampleProject) del GitHub de este proyecto.
 


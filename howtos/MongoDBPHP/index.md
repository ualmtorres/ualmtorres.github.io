---
layout: layout
title: "Posts"
---

# Usando MongoDB y PHP

MongoDB nos ofrece gran cantidad de clientes para interactuar con él mediante gran cantidad de lenguajes de programación ([Drivers MongoDB](http://api.mongodb.org/)).

En nuestro ejemplo interactuaremos con MongoDB mediante el driver PHP para MongoDB.

## Instalación

Siguiendo la [Información de instalación del driver PHP para MongoDB](http://php.net/manual/es/mongo.installation.php) podrás instalar fácilmente el driver MongoDB en tu equipo a través del respositorio de extensiones PHP [PECL](http://pecl.php.net/).

Aquí mostraremos los pasos de instalación en un Ubuntu Linux que ya tiene instalado previamente MongoDB y un entorno LAMP ([Tutorial sobre configuración de un entorno LAMP+NoSQL](http://ualmtorres.github.io/howtos/ConfiguracionEntornoGGVD/)). Básicamente se trata de descargar e instalar el driver, añadir la extensión al `php.ini`, y reiniciar el servidor Apache.   

Para descargar e instalar el driver lo haremos con 

```
sudo pecl install mongo
```

Esto hará que se descargue el driver, se compile y se instale en nuestro sistema como una extensión.
 
Si estuviésemos utilizando XAMPP, tendríamos que utilzar el `pecl` de XAMPP. Por ejemplo, podríamos hacerlo de una forma similiar a esta:

```
sudo /Applications/XAMPP/xamppfiles/bin/pecl install mongo
```

Si no tienes instalado `PEAR` y el paquete `php5-dev` deberás instalarlos con

```
sudo apt-get install -y php-pear
sudo apt-get install -y php5-dev
```

A continuación hay que modificar el archivo `php.ini` para indicar que cargue la extensión de MongoDB (`mongo.so`). `php.ini` se encuentra en `/etc/php5/apache2/php.ini`. Tendrás que añadir lo siguiente en la zona de extensiones.

```
extension=mongo.so
```

Ahora, reiniciaremos el servidor Apache para que tengan efecto los cambios

```
sudo service apache2 restart
```

## Manos a la obra

En este [Tutorial sencillo de PHP con MongoDB](http://php.net/manual/es/mongo.tutorial.php) puedes encontrar un ejemplo guiado de cómo comenzar con los aspectos básicos del scripting PHP con MongoDB. Además, es muy conveniente tener a mano esta referencia de [Clases principales del driver PHP para MongoDB](http://php.net/manual/en/mongo.core.php) en la que podrás encontrar una referencia de casi todo lo que necesitas para tu aplicación PHP con MongoDB.

### Conexión a MongoDB

El proceso de conexión es muy sencillo. Basta con instanciar la clase `MongoClient`. Si no indicamos parámetros se conectará usando `localhost` y el puerto predeterminado (`27017`).
 
<script src="https://gist.github.com/ualmtorres/18da35108b1f9e96e310.js"></script>


### Selección de la colección

La conexión creada nos servirá para seleccionar la base de datos y la colección con la que queremos trabajar. Podremos crear un objeto para la base de datos y otro para la colección, o bien crear sólo el objeto de la colección si no queremos usar ninguno de los métodos aplicables a la base de datos (crear bases de datos, operaciones con el *profile*, *write  concern*, ...)

A continuación vemos cómo crear un objeto para una base de datos de ejemplo denominada `ggvdTest` y un objeto para una colección de prueba denominada `actor`, que incluirá actores.  
 
<script src="https://gist.github.com/ualmtorres/2ab2429f06b267f893b2.js"></script>

### Inserción de documentos

Los documentos se crean mediante arrays asociativos. Estos documentos se insertarán con el método `insert` aplicado sobre la colección correspondiente.

 <script src="https://gist.github.com/ualmtorres/03f1806501b4b5742c2d.js"></script>
 
### Actualización de documentos
 
Los documentos se actualizan mediante el método `update()` aplicado a una colección. Al método le pasaremos el array asociativo con los criterios, el nuevo objeto (que podrá incluir operadores de actualización para modificar o reemplazar documentos), y de forma optativa las opciones de actualización. Entre las opciones, destacar que si queremos hacer una actualización múltiple, la palabra reservada es `multiple`, y no `multi` como en la shell de comandos de MongoDB. En la [Documentación del método update](http://php.net/manual/en/mongocollection.update.php) podrás ver esto con más detalle.

<script src="https://gist.github.com/ualmtorres/f49457b604734c48cde0.js"></script>

### Eliminación de documentos

La eliminación de documentos se realiza mediante el método `remove()` aplicado a una colección. Al método le pasaremos el array asociativo con los criterios, y de forma optativa las opciones de eliminación. De forma predeterminada se eliminarán todos los documentos que satisfagan los criterios proporcionados.

<script src="https://gist.github.com/ualmtorres/186551788f68b0a9e182.js"></script>

### Búsqueda de documentos

La búsqueda de documentos se realiza mediante el método `find()` aplicado a una colección. El resultado lo asignaremos a un *cursor* que recorreremos con el método `next()` aplicado al *cursor*. Una vez sobre el documento, éste será tratado como un array asociativo.

<script src="https://gist.github.com/ualmtorres/f210d59b0ffc8801654d.js"></script>
 
### Framework de agregación

Las operaciones relacionadas con el framework de agregación se realizan con el método `aggregate()`. A este método le proporcionaremos el *pipeline* de operaciones (`$match`, `$project`, `$group`, `$sort`, ...) en forma de array asociativo. El método devolverá un array asociativo `result` tal y como ocurre como cuando se usa el framework de agregación desde la shell.

<script src="https://gist.github.com/ualmtorres/70899dfccfbedaf5f59f.js"></script>

Puedes [descargar el código de este tutorial](https://github.com/ualmtorres/MongoDBPHPSampleProject) del GitHub de este proyecto.
 


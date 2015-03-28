---
layout: post
title: Uso de Git con varios repos remotos
category: posts
---

En ciertas situaciones nos podemos encontrar con que trabajamos con un repo remoto (p.e. BitBucket), pero también nos gustaría publicar nuestro trabajo en otro repo remoto (p.e. GitHub). Esto es útil si usamos, por ejemplo, BitBucket para tener todos nuestros repos (públicos y privados), y algunos de ellos también los queremos tener en GitHub como públicos.

Para resolver este problema en este post plantearemos dos escenarios:

* El repo remoto que actua como *copia* sólo es actualizado por un único usuario desde su equipo local. Esto permitirá actualizar los repos remotos con un único `push`.
* El repo remoto que actúa como *copia* tiene un uso compartido. 

## Actualización de repos remotos cuando el uso de la copia no es compartido

Este escenario es útil cuando tenemos un repo remoto de trabajo y queremos tener una copia en otro repo remoto. En este escenario, el repo remoto *principal* podrá ser compartido. Sin embargo, el repo remoto que actúa como *copia* no deberá ser usado por otras personas. Además, el repo remoto *copia* sólo debería ser actualizado desde el repo de nuestro equipo. Es decir, por ejemplo, si hablamos de un repo remoto en GitHub que actúa como *copia* de otro que tenemos en BitBucket, en este escenario, no podremos añadir archivos directamente desde GitHub (p.e. un archivo markdown).

**Paso 1**. Creamos el repo *principal* `ejemploRepoDoble` en BitBucket.

**Paso 2**. Creamos el repo *copia* `ejemploRepoDoble` en GitHub como un repo vacío.

**Paso 3**. Creamos el repo local estableciendo como `remote` el repo de BitBucket

<script src="https://gist.github.com/ualmtorres/c225682c5055ff3d68f8.js"></script>

**Paso 4**. Añadimos a nuestro repo local los repos a los que haremos `push` (el de BitBucket y el de GitHub)
<script src="https://gist.github.com/ualmtorres/42c8783c29abf8c4a258.js"></script>

**Paso 5**. Ahora si añadimos un nuevo archivo `newFile.md` a nuestro repo local, lo añadimos al `index`, hacemos `commit` y `push` veremos como aparece en los dos repositorios remotos, tanto en el de trabajo (BitBucket), como en el de copia (GitHub).

<script src="https://gist.github.com/ualmtorres/979268619a820a13e03c.js"></script>


Ahora, con un único `push` a `origin` se realizarán dos operaciones `push`, una al repo de BitBucket, y otra al repo de GitHub.

Podemos ver la configuración de lo que hemos realizado en este escenario usando `git config`

<script src="https://gist.github.com/ualmtorres/5d92af074d26e936c8df.js"></script>

Otra opción es ver directamente el arhivo `.git/config`

<script src="https://gist.github.com/ualmtorres/f10b3c8203427570c19d.js"></script>

## Actualización de repos remotos cuando el uso puede estar compartido

El planteamiento anterior es muy cómodo, ya que con una sola operación `push` se realiza tanto el `push` al repositorio *principal* como al que tenemos de *copia* (dos `push` en total). Sin embargo, está limitado a que si el repositorio remoto que actúa como copia es actualizado por otros usuarios, dichas modificaciones no serían vistas por nuestro repo local. Esto se debe a que la URL del `pull` está vinculada a un único repo. En nuestro caso el repo *principal*.

Para solventar esta limitación en lugar de tener dos URLs para hacer `push` en el `remote origin`, tendremos que tener dos `remote` independientes, cada uno con su repo para las operaciones de `pull` y `push`

Si hemos seguido los pasos del escenario anterior, nuestro archivo `.git/config` contendrá lo siguiente

<script src="https://gist.github.com/ualmtorres/f10b3c8203427570c19d.js"></script>

A continuación, tendremos que eliminar las dos URL a las que se hacía `push`. Esto lo podemos hacer editando el archivo `.git/config`, o con estos comandos

<script src="https://gist.github.com/ualmtorres/1a1fe88b5a28b30ace96.js"></script>

Así, nuestro repo ahora sólo está conectado al repo *principal*, como si no hubiésemos tenido el repo *copia*.

A continuación, modificaremos la configuración de nuestro repo local para que tenga los dos remotos. Haremos dos cosas:

* Renombrar el remoto `origin` con el nombre `bitbucket`
* Añadiremos un remoto denominado `github` para el repo GitHub.

Esto lo podemos hacer editando directamente el archivo `.git/config`, o con comandos

<script src="https://gist.github.com/ualmtorres/639e1f374510f0cb3d82.js"></script>

De una forma o de otra, el archivo `.git/config` deberá ser similar a este

<script src="https://gist.github.com/ualmtorres/aacf189ea3988a85e15b.js"></script>

Ahora, cuando queramos realizar un `push` y que se actualicen los dos repos remotos, tendremos que realizar dos operaciones `push`, una para cada remoto.

<script src="https://gist.github.com/ualmtorres/cc6cfca7eb18c2fb5d0a.js"></script>

La ventaja que obtenemos con este segundo enfoque es que los posibles cambios que pudieran introducir otros usuarios en los repos remotos no supondrán un problema para la sincronización de nuestros repos. Simplemente tendremos que asegurarnos de hacer previamiente un `pull`.

Así, un flujo de trabajo habitual podría ser

<script src="https://gist.github.com/ualmtorres/d4a968dfc8cfe2d6460d.js"></script>

Un caso de uso podría ser el siguinte:

* De forma local hemos creado un archivo `localAdded.md`
* En el repo GitHub se ha añadido un archivo `github.md`
* En el repo BitBucket se ha añadido un archivo `bitbucket.md`.

![]({{ site.url }}/images/postImages/threeBranches.jpg)

Para sincronizarlo todo deberíamos hacer los `pull` de los dos repos remotos y luego hacer los dos `push`.

<script src="https://gist.github.com/ualmtorres/495d42716745436e26f0.js"></script>

Finalmente, nuestros repos (el local y los dos remotos) quedarían sincronizados.

![]({{ site.url }}/images/postImages/threeBranchesMerged.jpg)

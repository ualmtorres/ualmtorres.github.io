---
layout: post
title: Plantilla Heat para la creación de la infraestructura básica de OpenStack
category: posts
---

Disponible la [Plantilla Heat para la creación de la infraestructura básica para la instalación de OpenStack](https://gist.github.com/ualmtorres/8f1e7720deaa3aefa77678372e37d69e). La plantilla asume la existencia de una red conectada a una red externa mediante un router. Dicha red proporciona conexión a Internet. La plantilla crea:

* Redes de mantenimiento y de túnel.
* Nodo de control, nodo de red y nodo de cómputo. Los tres nodos se conectan a las redes de mantenimiento y de túnel.
* Conexión de los nodos creados a la red con conexión a Internet.
* Dirección IP flotante para los nodos creados.
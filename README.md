# dockerr
Dockerizar desarrollo de datos. El objetivo de este repositorio es garantizar un environment de R común a un equipo de trabajo. Para ello, es necesario un servidor accesible por todos sus miembros. En este servidor, a través de docker, se levantará un contendor que implemente un servidor linux con varias aplicaciones utilizadas por el equipo.

* Rstudio Server 
  * Paquetes de tidyverse
  
  * Paquetes geospaciales
  
  * Otros paquetes necesarios

* Shiny Proxy

* ssh

El contenedor se gestiona a partir del fichero [docker-compose.yaml](./docker-compose.yaml). (Ir a capítulo [Docker-compose](#Docker-compose) para mas detalles)

Para más detalles sobre la dockerización de R ir a [https://github.com/rocker-org/rocker-versioned2](https://github.com/rocker-org/rocker-versioned2)

## Puesta en marcha del contendor

1. **Clonar el repositorio en el servidor**

```bash
git clone https://github.com/PabloRL/dockerr
```

2. **Modificar el fichero** [.env](./.env) en con el nombre y contraseña que tendrá el administrador del contendor. (Por de defecto: RSTUDIO y RSTUDIO)

3. **Crear claves shh** y guardarlas en [.ssh](./.ssh/)

4. **Añadir nombre y mail para identificarse en github** en [.gitconfig](./.config)

5. **Levantar el contenedor**

```bash
docker compose up -d --build
```

6. **Creación de usarios en el contendor** . Para ello, abrimos una terminal del contenedor (rdatos es el nombre del contenedor por defecto) y creamos tantos usuarios de linux como sean necesarios manualmente o por medio del script [/user_scripts/users.sh](./user_scripts/users.sh) y el fichero con los nombres de usuario [/user_scripts/users.txt](./user_scripts/users.txt) que estarán dentro del contenedor creado.

```bash
docker exec -ti rdatos bash
```

```bash
sudo /user_scripts/users.sh
```

## Actualización de versión de R

Este proyecto permite actualizar la versión base de R de manera sencilla. Es recomendable que esta no sea nunca la última versión disponible en R-Cran para asegurar la reproducibilidad de los analisis en el futuro. Para actualizar el contenedor únicamente hay que añadir un nuevo dockerfile igual que [dockerfiles/R4.0.5/Dockerfile](./dockerfiles/R4.0.5/Dockerfile) sustituyendo la versión de R al principio del archivo y modificar [docker-compose.yaml](./docker-compose.yaml) con las nuevas referencias a la nueva versión de R.

## Docker-compose

El fichero [docker-compose.yaml](./docker-compose.yaml) es el encargado de levantar y gestionar el contendedor generado. En principio consta de un solo servicio (en este caso el contenedor rdatos)

Al levantar por primera vez el contenedor o al modificar el dockerfile referenciando en build- > dockerfile se crea la imagen docker_datos:4.0.5 (4.0.5 es la etiqueta de la imagen que coincide con la version de R utilizada) 

Los puertos que se quieren conectar entre huésped y anfitrión se definen en **ports**. En este caso conectamos el 3838 propio del shinyproxy con el 20000 del servidor y el 8787 propio del Rstudio server cpn el 20001 del servidor.

Por último, la sincronización de carpetas entre anfitrión y huésped se realiza en el apartado **volumes**. 
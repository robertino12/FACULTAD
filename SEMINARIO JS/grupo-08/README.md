# Trabajo Final

## Juego de la oca

### Documentación

* El juego es para dos jugadores. Pudiendo crearse hasta 100 salas diferentes, alojando como máximo hasta 200 jugadores.

* Las preguntas se asignan aleatoriamente a los diferentes casilleros al crear la partida.

* Las respuestas sólo se muestran al jugador que debe responder. El adversario sólo verá la pregunta.

* Para el backend se partió desde el servidor de la cátedra y se personalizó según nuestras necesidades.

* Se utilizó socket.io para mantener una comunicación fluida entre el cliente y el servidor.

* Los jugadores no pueden manipular el dado ni las preguntas y respuestas.

* Las preguntas y respuestas son en su totalidad en formato texto.

* Las preguntas y respuestas se encuentran especificadas en un archivo JSON. No utilizamos ningún gestor de base de datos.

* Cuando un jugador se desconecta, se envía un mensaje de alerta al rival y luego se lo redirecciona al welcome.

******* 

### Comenzando una partida

* **Para iniciar el servidor se debe ejecutar el comando:**

    ```bash
        #Con Node.js
        npm run iniciar-oca
        
        #Con Docker
        docker compose up
    ```

* **Para comenzar a jugar:**

    Luego de levantar el servidor, el jugador 1 deberá ingresar su nombre y color, crear una nueva partida y pasarle el ID de la sala al jugador 2. Por su parte, el jugador 2, deberá elegir su nombre y color e ingresar a la partida con el ID proporcionado por el jugador 1. Ya estarán listos para comenzar a jugar.

******* 

### Integrantes del grupo:

```
    Battista Agustín
    Bordón Ladislao
    Lucentini Robertino
```

******* 

De aquí en adelante continúa el readme de la cátedra...

*******

# Seminario de Lenguajes JS

## Levantar el Proyecto con Docker

### Instalar docker

* **Windows**: [Link de descarga](https://hub.docker.com/editions/community/docker-ce-desktop-windows/)

* **macOS**: [Link de descarga](https://docs.docker.com/docker-for-mac/install/)

* **GNU/Linux**: [Link de Instalacion](https://docs.docker.com/engine/install/)
  
  * para linux es necesario tener en consideracion 2 pasos de [post-instalacion](https://docs.docker.com/engine/install/linux-postinstall/)

    ```bash
        # Configure Docker to start on boot
        # para iniciar el serivicio al arrancar la pc
        sudo systemctl enable docker.service
        sudo systemctl enable containerd.service
        
        # Manage Docker as a non-root user
        # para agregar al usuario con al grupo docker, de esta manera no pide el sudo 
        # para este paso necesitas salir y volver a entrar en la sesion o reiniciar el equipo
        sudo usermod -aG docker $USER
    ```

### Instalar dependencias del proyecto

```bash
    docker-compose build
```

### Correr la aplicación

```bash
    docker-compose up
```

## Levantar el Proyecto con NPM

### Instalar NVM ( gestor de versiones de node y npm )

* **Windows**: [Link de Instalacion](https://github.com/coreybutler/nvm-windows)
* **macOS | GNU/Linux**: [Link de Instalacion](https://github.com/nvm-sh/nvm)

### Intalar version de node y marcarla como la predefinida para su uso

```bash
   nvm install 19
   nvm use 19
```

### Instalar Dependencias

```bash
    npm install
```

### Correr la aplicación

```bash
    # para windows
    npm run windows

    # para linux/mac o para correrlo desde wls (el ubuntu nativo de windows)
    npm run linux
```

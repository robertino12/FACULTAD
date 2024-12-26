//Importamos express
import express from 'express';
//Importamos path para trabajar con rutas y directorios
import path from 'path';
//Importamos routeServer de routes.js
import routerServer from './routes.js';
//Importamos fileURLTOPath que sirve para convertir una URL en una ruta de archivo
import { fileURLToPath } from 'url';

//Socket IO
//Importamos la función createServer del módulo HTTP. Esta función se utiliza para crear un servidor HTTP que será utilizado para manejar las conexiones WebSocket mediante socket.io
import { createServer } from 'http';
//Importamos la clase server del módulo socket.io. La clase server es el componente central de socket.io y se utiliza para configurar y administrar conexiones de socket en el servidor.
import { Server } from 'socket.io';

//Importamos funciones de oca.js para poder utilizarlas
import findBy ,{ saveTablero,devolverTabla } from './controllers/juego-oca/oca.js';
import { TIMEOUT } from 'dns';

//Obtenemos la URL del archivo actual y se convierte a una ruta del sistema de archivos local
const __filename = fileURLToPath(import.meta.url);
//Retorna el nombre de directorio en el que se encuentra el archivo
const __dirname = path.dirname(__filename);

//Definimos el puerto en el que se escucharán las solicitudes entrantes
const PORT = 3000;
//Instanciamos express en una variable que podamos usar para configurar y manejar las rutas y funcionalidades
var app = express();

//io
//Creamos un servidor HTTP que se encargará de manejar las solicitudes entrantes y las respuestas para nuestra app web
const server = createServer(app);
//Creamos una instancia de Socket.IO utilizando el servidor HTTP que hemos creado
//(Socket.IO es una biblioteca que permite la comunicación en tiempo real bidireccional entre clientes y servidores a través de websockets)
//Al pasar el objeto server como argumento a new Server, estamos vinculando el servidor HTTP con Socket.IO, lo que nos permitirá utilizar websockets para enviar y recibir mensajes en tiempo real entre el cliente y el servidor.
const io = new Server(server);

// configuracion de gestor de vistas
app.set('view engine', 'ejs');
app.set('views',  path.resolve(__dirname, 'views'));

// configuro express para recibir data
app.use(express.json()); //configura express para poder recibir datos en formato JSON en las solicitudes. De esta manera express puede analizar el body de las solicituds entrantes y convertirlo en objetos js disponibles en req.body
app.use(express.urlencoded({ extended: false })); //configura Express para que pueda recibir datos codificados en formato application/x-www-form-urlencoded. Este es un formato comúnmente utilizado en formularios HTML.

// configuracion de path a exponer publicamente 
app.use('/s/', express.static(path.join(__dirname, 'public-static')));
app.use('/p/', express.static(path.join(__dirname, '../practicas')));
app.set('views', path.join(__dirname, 'views'));

/*
servimos publicamente los archivos que consumen las apis para la entrega de la práctica 4
ahora podemos accederlos en las urls:
localhost:3000/entrega/apis-personas/index.html
localhost:3000/entrega/apis-personas/by_age.html
localhost:3000/entrega/apis-personas/overweight.html
*/

//app.use('/entrega/apis-personas', express.static(path.join(__dirname, '../apis-personas')));


// importo rutas desde modulo en archivo aparte
app.use('/', routerServer);

//////////////////////////////////////////////////////////////////////////////////////////////////////

//Lógica de socket.io del lado del servidor
// numeroAleatorio = 0;

//Creamos un array para tener registro de los jugadores conectados
let jugadoresConectados = [];

//Dejamos la primera posición vacía
jugadoresConectados.push("vacio");

//Inicializamos el array de 1 a 100 (misma cantidad que salas) con arrays vacíos
for (let i=1; i<101; i++) {
  let array = [];
  jugadoresConectados.push(array);
}

io.on('connection', (socket) => { //Se activa cada vez que el cliente se conecta al servidor a través de socket.io
  //io.emit('numeroAleatorio', numeroAleatorio);

  console.log('Un cliente se ha conectado (accedió al index) con el socket id: ', socket.id);
  //console.log(jugadoresConectados);
  //Se activa cuando el cliente emite el evento actualizarNombre
  socket.on('actualizarNombre',(tablaId) => {
    let tabla = devolverTabla(tablaId); //Llamo a devolver tabla para que busque el tablero con el ID recibido
    console.log(tabla); //Imprime en la consola del servidor la tabla encontrada
    let nombresYColores={ //Crea el objeto nombres y colores para emitir un evento al cliente
      nombre1 : tabla.jugador1Nom,
      nombre2 : tabla.jugador2Nom,
      color1 : tabla.jugador1Color,
      color2 : tabla.jugador2Color
    };

    console.log("el jugador: ",socket.id,"está en la tabla: ",tablaId);

    //Agrego el jugador a la tabla de conectados
    jugadoresConectados[tablaId].push(socket.id);

    //Muestro en la consola la tabla de conectados
    console.log(jugadoresConectados);
    //console.log('posicion tabla:');
    //console.log(' ',jugadoresConectados[tablaId]);

    //Emite un evento a todos los clientes para que cambien los nombres y colores de los jugadores
    io.emit('cambiarNomCol',nombresYColores,tablaId);
  })


  // Evento para manejar el botón "dado" presionado por el cliente
  socket.on('botonDado', (tableroId,playerId) => { // Recibe el ID del tablero y el jugador
    console.log('Dado');
    //Si ID enviada coincide con la de la tabla doy bola a la petición. Sino no le emito
    let tabla = devolverTabla(tableroId); //se llama a la función devolverTabla con el tableroId recibido del cliente para obtener la tabla correspondiente desde el archivo JSON donde se almacenan las partidas
    //verifico q el jugador 2 ya este conectado antes de comenzar a responder preg
    if(tabla.jugador2Id!=0){
    //Verifico que el juego no haya terminado
    if (tabla.jugador1Pos == 21 || tabla.jugador2Pos == 21) {
      console.log('El juego ya ha finalizado, no hago caso al dado');
    } else { //El juego no finalizo. Sigo atendiendo el evento...
    
    //console.log(tabla);
    let turn = tabla.turn; //se obtiene el turno actual de la variable tabla
    let ok = false; //incializo ok
    if(turn == 1) { //si el turno es 1 verifico que quien emitió el evento haya sido el jugador 1
      ok = tabla.jugador1Id == playerId; //si es correcto ok es true
    } else if (turn == 2){ //si el turno es 2 verifico que quien emitió el evento haya sido el jugador 2
      ok = tabla.jugador2Id == playerId; //si es correcto ok es true
    }
    //muestra en consola lo verificado
    console.log(' tabla.id: '+ tabla.id)
    console.log(' tabla.jugador1ID: '+tabla.jugador1Id);
    console.log(' playerID: '+playerId);

    //Inicializacion de variable de casilla
    let numeroCasilla = 0;
    //let numeroCasillaAnt = 0;
    if (ok) { //Si la solicitud del jugador es válida (corresponde a su turno), se ejecuta el código dentro de este bloque.
      let numeroAleatorio;
      let bolean = true;
      //Genero un número aleatorio del 1 al 6 que permita al jugador avanzar sin chocar con el otro jugador en el tablero
      while (bolean) {
        numeroAleatorio = Math.floor(Math.random() * 6) + 1; //Genero un número
        if (turn == 1){ //Si el turno es 1..
          numeroCasilla = tabla.jugador1Pos + numeroAleatorio; //Núm de casilla es la pos del jug1 + el num generado
          if(numeroCasilla != tabla.jugador2Pos){ //Verifico que el núm obtenido no coincida con la pos del jugador 2
            bolean = false; //cambio el boolean para salir del while
            turn = -1; //cambio el valor del turno
          }
        } else if (turn == 2) { //Si el turno es 2..
            numeroCasilla = tabla.jugador2Pos + numeroAleatorio; //Núm de casilla es la pos del jug2 + el num generado
            if(numeroCasilla != tabla.jugador1Pos){ //Verifico que el núm obtenido no coincida con la pos del jugador 1
            bolean = false; //cambio el boolean para salir del while
            turn = -2; //cambio el valor del turno
            }
        }
      }
      tabla.turn = turn; //actualizo el valor del turno en la tabla
      saveTablero(tabla); //Guardo el tablero actualizado en el archivo

      
      //Debo verificar si el jugador ha ganado
      if (numeroCasilla > 20) { //Si esto se cumple ya no hay más preguntas que contestar, por lo tanto, el jugador ganó
        numeroCasilla = 21;
        io.emit('mostrarPreg',tableroId,numeroCasilla);
      //Si la casilla es <=20 todavía hay preguntas por responder
      } else {
        //Emito el evento mostrarPreg para los jugadores del tablero
        io.emit('mostrarPreg',tableroId,numeroCasilla);   
      }
      //Emito el evento numeroAleatorio a los jugadores del tablero
      io.emit('numeroAleatorio', numeroAleatorio,tableroId);
    }

    } //cierro el else que tiene el if (tabla.jugador1Pos == 21 || tabla.jugador2Pos == 21)
  }//cierro if de verificacion de dos jugadores
  else{
    console.log('Dado');
    console.log(' Jugador 2 no esta conectado');
  }
  });

  //Este evento se activa cuando un jugador responde una pregunta
  socket.on('respondio',(numeroCasilla,respuesta,playerId,tableroId) => {
    //numeroCasilla => núm de casilla en el que se respondió la pregunta
    //respuesta => rta seleccionada por el jugador (0,1,2)
    //playerId => ID del jugador que respondió
    //tableroId => ID del tablero en el que se está jugando
    console.log('Respondio'); //Muestra en consola el nombre del evento
    let tabla = devolverTabla(tableroId); //Se obtiene la tabla correspondiente según el id de tablero recibido
    let turn = tabla.turn; //Se obtiene el turno actual desde la tabla
    
    let numeroCasillaAnt;
    let color;
    //Verificamos que la respuesta sea correcta, esto es su value es true (ver formato de preguntas.json)
    if(tabla.tablero[numeroCasilla].Pregunta.respuestas[respuesta].value){
      if((turn == -1)&&(tabla.jugador1Id == playerId)){ //Verificamos si el turno es del jugador 1 y si coincide el jugador1 id con el id del jugador en cuestión
        numeroCasillaAnt = tabla.jugador1Pos; //Guardamos número de casilla anterior
        tabla.jugador1Pos = numeroCasilla; //Actualizamos la posición del jugador1 con la casilla en la que ha caído después de responder correctamente
        color = tabla.jugador1Color; //Guardamos el color del jugador 1
        console.log(" el jugador 1 respondío correctamente. Su color es: "+color);
        io.emit('pintarRespuestas',tableroId,playerId,respuesta,true);
        turn = 2; //Actualizamos el turno. Ahora le tocará al jugador 2
        //Emitimos movimiento a los clientes para que actualicen su tablero
        //El cliente corrobora que el tablero coincida con el de su sala
        //numPlayer sirve para poder eliminar del casillero inicial al jugador que se mueva e ingrese al tablero
        let numPlayer = -1;
        if (turn == 1) {
          numPlayer = 2;
        } else if (turn == 2) {
          numPlayer = 1;
        }
        //Esto se emite siempre porque es para actualizar el tablero de ambos jugadores (si no se movió ninguno simplemente no se actualiza, se escribe dos veces lo mismo)
        io.emit('movimiento',tableroId,numeroCasilla,numeroCasillaAnt,color,numPlayer);
        console.log("Ya se emitio movimiento");
        if (numeroCasilla == 21) { //Entonces el jugador ganó!
          console.log("Ganó el jugador: "+numPlayer);
          //Le aviso al jugador ganador
          io.emit('Ganaste',tableroId,playerId);
          //Le aviso al jugador perdedor
          socket.broadcast.emit('Perdiste',tableroId);
        }
      } else if((turn == -2)&&(tabla.jugador2Id == playerId)) { //Verificamos si el turno es del jugador 2 y si coincide el jugador2 id con el id del jugador en cuestión
        //Misma lógica que el if anterior
        numeroCasillaAnt = tabla.jugador2Pos;
        tabla.jugador2Pos = numeroCasilla;
        color = tabla.jugador2Color;
        console.log(" el jugador 2 respondío correctamente. Su color es: "+color);
        io.emit('pintarRespuestas',tableroId,playerId,respuesta,true);
        turn = 1;
        let numPlayer = -1;
        if (turn == 1) {
          numPlayer = 2;
        } else if (turn == 2) {
          numPlayer = 1;
        }
        io.emit('movimiento',tableroId,numeroCasilla,numeroCasillaAnt,color,numPlayer);
        console.log("Ya se emitio movimiento");
        if (numeroCasilla == 21) { 
          console.log("Ganó el jugador: "+numPlayer);
          io.emit('Ganaste',tableroId,playerId);
          socket.broadcast.emit('Perdiste',tableroId);
        }
      }
    //Si la respuesta es incorrecta...
    } else {
      if((turn == -1)&&(tabla.jugador1Id == playerId)){
        io.emit('pintarRespuestas',tableroId,playerId,respuesta,false);
      }
      else if((turn == -2)&&(tabla.jugador2Id == playerId)){
        io.emit('pintarRespuestas',tableroId,playerId,respuesta,false);
      }
      if(turn == -1){ //Si el turno era del jugador 1 se cambia a jugador 2
        turn = 2;
      } else if(turn == -2){ //Si el turno era del jugador 2 se cambia a jugador 1
        turn = 1;
      }
       // io.emit('leErro',tableroId);
      }
      tabla.turn = turn; //Actualizamos el turno en la tabla
      saveTablero(tabla); //Guardamos la tabla en el archivo
      //Emitimos un evento de cambio de turno
      io.emit('seCambio',turn,tableroId);
  });

    socket.on('QuieroAbandonar',(tableroId,playerId) => {
      //Leo la tabla
      let tabla = devolverTabla(tableroId);
      let numeroCasillaAnt;
      let color;
      let numPlayer;
      //Verifico que el juego no haya terminado
      if (tabla.jugador1Pos == 21 || tabla.jugador2Pos == 21) {
        console.log('El juego ya ha finalizado, no hago caso al botón de abandonar');
      } else { //El juego no finalizo. Sigo atendiendo el evento...
        //Verifico qué jugador es el que abandonó y asigno al otro como ganador
        if (playerId == tabla.jugador1Id) {
          numeroCasillaAnt = tabla.jugador2Pos;
          tabla.jugador2Pos = 21;
          color = tabla.jugador2Color;
          numPlayer = 2;
        } else if (playerId == tabla.jugador2Id) {
          numeroCasillaAnt = tabla.jugador1Pos;
          tabla.jugador1Pos = 21;
          color = tabla.jugador1Color;
          numPlayer = 1;
        }
        saveTablero(tabla); //Guardo la tabla en el archivo
        let numeroCasilla = 21; //Marco la casilla en 21 para saber que el juego está finalizado
        io.emit('movimiento',tableroId,numeroCasilla,numeroCasillaAnt,color,numPlayer); //Emito el movimiento para pintar el tablero
        //Mando los respectivos eventos de ganador y perdedor
        socket.broadcast.emit('GanastePorAbandono',tableroId);
        io.emit('PerdistePorAbandono',tableroId,playerId);
      }
    });

    // Evento de desconexión de Socket.IO
    socket.on('disconnect', () => { 
      console.log('Un cliente se ha desconectado (se fue del index) con el socket id: ',socket.id);
      
      //Declaro variables que usaré para buscar en qué sala se encontraba el jugador que se ha desconectado
      let i = 0;
      let j;
      let encontre = false;

      //Busco la sala en la que se encontraba el jugador desconectado
      while (!encontre && i < 100) { //Si encontré no busco más. Si es 99, al sumar 1 al i, busco en el 100 (última sala)
        i++; //arranco a buscar desde la posición 1 (sala 1)
        j = 0; //cada array interno arranca en 0 o es nulo
        while (!encontre && jugadoresConectados[i][j] != null) { //Si encontré no busco más, si es null se terminó el array interno
          if (socket.id == jugadoresConectados[i][j]) { //Hago la comparación con el id del jugador desconectado
            encontre = true; //cambio valor para que termine la búsqueda
          } else {
            j++; //sumo para seguir recorriendo el array interno
          }
        }
      }

      //La sala en la que se encontraba el jugador queda en la posición i
      console.log("El jugador: ",socket.id," estaba en la sala: ",i);

      //Mando un mensaje de jugador desconectado a cada uno de los que accedieron a la sala
      j = 0;
      let mensaje = "Un jugador se ha desconectado de la sala";
      while (jugadoresConectados[i][j] != null) { //Hasta que se termine el array
        console.log("Enviando mensaje a cliente..."); //Muestro msj en consola del servidor
        io.to(jugadoresConectados[i][j]).emit('JugadorDesconectado', mensaje); //Mando el msj privado al jugador
        j++; //sumo para seguir recorriendo el array
      }
    });
});

//////////////////////////////////////////////////////////////////////////////////////////////////////

// Inicio del servidor 
server.listen(PORT, () => {
    console.clear();
    console.log('\x1Bc'); //volví a dejar esta linea para que limpie la pantalla cuando se corre con docker
    //console.log('\x1b[7m%s\x1b[0m', ' El servidor de JS esta corriendo correctamente          '); 
    //console.log('\x1b[7m%s\x1b[0m', ' Ultima actualización a las: '+ new Date().toLocaleTimeString()+'                  \r\n');
    
    //Dejamos la consola personalizada para trabajar más cómodamente
    console.log('---------------------------------------------------------')
    console.log('\x1b[34m%s\x1b[0m', ' TP Final ==>','\x1b[32m\x1b[0m',` http://localhost:${PORT}/juego-oca/welcome \r`);
    console.log('---------------------------------------------------------')
    console.log('\x1b[31m%s\x1b[0m', ' Para salir presione en esta ventana [Ctrl + C ]        \r\n');    
});

export default app;
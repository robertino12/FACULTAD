//Importamos el módulo file system de node. Proporciona funciones para trabajar con archivos del SO
import fs from 'fs';

//Guardamos la ruta del tablero donde se almacenan los datos del juego en GAME_FILE
const GAME_FILE = 'src/data/juego-oca/tableros.json';

//Función que se ejecuta cuando se crea el juego por primera vez
function crearOca(){
  if (!fs.existsSync(GAME_FILE)) { //Si no existe el archivo del tablero
    fs.writeFileSync(GAME_FILE, JSON.stringify([])); //Se crea un nuevo archivo vacío
  }
  let preguntasJson = JSON.parse(fs.readFileSync('src/data/juego-oca/preguntas.json', 'utf8')); //Se leen las preguntas del JSON y se guardan en una variable
  //console.log("Las preguntas del JSON son...");
  //console.log(preguntasJson);
  let TableroInicial = []; //inicializo el tablero
  TableroInicial[0] = "Las preguntas van del 1 al 20 y en la pos 21 se encuentra la pregunta ganadora";

  // Verificamos que haya suficientes preguntas para llenar todas las casillas del tablero
  if (preguntasJson.length < 20) { //Si no hay preguntas suficientes mostramos un error
    throw new Error('No hay suficientes preguntas para llenar todas las casillas del tablero.');
  }

  for (let i = 1; i <= 21; i++) { // creo 21 casillas (la última es para ganar el juego)
    let indice = Math.floor(Math.random() * preguntasJson.length); // consigo un numero random del arreglo
    let casilla = {
      numero: i,
      ocupada: false,
      Pregunta : preguntasJson[indice] // agrego la pregunta de ese numero random
    };
    TableroInicial.push(casilla); //meto al arreglo la casilla generada
    preguntasJson.splice(indice, 1); //elimino del json la pregunta q meti
  }
  let pid = generatedId(); //genero id aleatorio para el jugador
  let tabla = {  //creo la tabla del juego
    tablero : TableroInicial, //agrego el array de preguntas al tablero
    turn : 1, //se define el turno inicial para el jugador 1
    numeroDado: 0,
    id : generatedId(), //genero id del tablero
    playerId : pid,
    jugador1Id : pid,
    jugador1Pos : 0,
    jugador1Nom : null,
    jugador1Color : null,
    jugador2Id : 0,
    jugador2Pos : 0,
    jugador2Nom : null,
    jugador2Color : null
  };
  console.log("El tablero inicial es...");
  console.log(TableroInicial);
  //console.log('La pos 20 del tablero inicial es...');
  //console.log(TableroInicial[20])
  //console.log("Si la pos 20 es distinta de undefined quiere decir que el tablero se creó bien");
  saveTablero(tabla); //guardo en memoria la tabla
  return tabla; //la función devuelve el objeto tabla, que representa el estado inicial del juego
  //tableroId : tabla.id,
  //playerId : tabla.jugador1Id
}

function generatedId(){ //genera un numero random del 1 al 100
  let randomInt = Math.floor(Math.random() * 100) + 1;
  return randomInt;
}

function joinOca(tablaid){ //función para unirse a una sala existente
  let  tabla =  findBy(t => t.id == tablaid); //Busca en el json de partidas la partida que tenga ese id, devuelve undefinded si no la encuentra
  tabla.jugador2Id = generatedId(); //genero la id del jugador 2
  tabla.jugador2pos = 0; //posiciono jugador 2 en el inicio
  saveTablero(tabla); //guardo la tabla
  return tabla; //retorno la tabla actualizada
}

function cambiarNum(tablaid,num){ //funcion que cambia el numero del dado de la tabla (no se usa aun)
  tabla = leerTabla(tablaid); //lee la tabla de juego utilizando la función leerTabla
  tabla.numeroDado = num; //asigna el número del dado proporcionado al atributo numeroDado de la tabla
  saveTablero(tabla.id); //guarda la tabla actualizada
}

function saveTablero(tabla){ //guarda la partida que recibe como parámetro
  let matches = JSON.parse(fs.readFileSync(GAME_FILE)); //leo el json y lo almaceno en la variable matches
  let i = matches.findIndex(t => t.id == tabla.id); //busca el tablero con la misma id
  if (i == -1) {
    matches.push(tabla); //si no lo encontro, lo agrega
  } else {
    matches[i] = tabla; //si lo encontro, lo actualiza
  }
  fs.writeFileSync(GAME_FILE, JSON.stringify(matches)); //convierto la variable matches a json y lo guardo en el archivo
}

function leerTabla(id){ //busca una tabla de juego específica en el archivo JSON de partidas y devuelve su índice
  let matches = JSON.parse(fs.readFileSync(GAME_FILE)); //lee el archivo JSON de partidas y convierte su contenido en un arreglo llamado matches 
  let i = matches.findIndex(t => t.id == id); //busca en el arreglo matches la posición (índice) de la tabla de juego que tenga el ID proporcionado y lo guarda en i
  if (i === -1) {  
    return undefined; //si no se encuentra la tabla de juego (el índice es -1), devuelve undefined  
  } else {
    return i; //si se encuentra la tabla de juego, devuelve su índice
  }
}

function devolverTabla(id){ //busca una tabla de juego específica en el archivo JSON de partidas y la devuelve
  let matches = JSON.parse(fs.readFileSync(GAME_FILE));; //lee el archivo JSON de partidas y convierte su contenido en un arreglo llamado matches 
  let i = matches.findIndex(t => t.id == id); //busca en el arreglo matches la posición (índice) de la tabla de juego que tenga el ID proporcionado y lo guarda en i
  if (i == -1) {
    return undefined; //si no se encuentra la tabla de juego (el índice es -1), devuelve undefined  
  } else {
    return matches[i]; //si se encuentra la tabla de juego, la devuelve
  }
}
  
function findBy(predicate) { //recibe un predicado que es una función utilizada para encontrar un elemento específico en el arreglo de partidas
  if (fs.existsSync(GAME_FILE)) { //verifica si el archivo existe
    return JSON.parse(fs.readFileSync(GAME_FILE)).find(predicate); //si existe, leo archivo, busco en él y devuelvo el elemento
  } else {
    return undefined; //si el archivo no existe, devuelvo undefined
  }
}

//Exportamos las funciones para poder utilizarlas en otros archivos
export {crearOca as default,joinOca,findBy,saveTablero,devolverTabla}; 
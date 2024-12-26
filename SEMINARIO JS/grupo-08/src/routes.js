import express, { application } from 'express';
import showDashboard, { helloWord } from './controllers/dashboard.js'
//importamos las funciones que creamos en el archivo oca.js
import crearOca,{joinOca,findBy, saveTablero,devolverTabla} from './controllers/juego-oca/oca.js';
import { setTimeout } from 'timers/promises';

import io from './app.js';
//importamos rutas del controlador
import overweight,{ by_age,imc_over_40,average_imc,youngest,by_height} from './controllers/Punto6.js';

//Usamos un enrutador para modularizar y despues usarlo en app.js
//(Un enrutador en Express es un módulo que permite definir y agrupar rutas y controladores para diferentes partes de una aplicación web.)
var routerServer = express.Router();

//Variables para la entrega final
let ids = {}; //objeto para agrupar ids de tablero y jugadores
let colorsandnames = {}; //objeto para agrupar colores y nombres de los jugadores

// ruta homepage 
routerServer.get('/', showDashboard);

//rutas de las apis
routerServer.get('/hello', helloWord);
routerServer.get('/peoples/overweight', overweight);
routerServer.get('/peoples/by_age', by_age);
routerServer.get('/peoples/imc_over_40',imc_over_40);
routerServer.get('/peoples/average_imc',average_imc);
routerServer.get('/peoples/youngest',youngest);
routerServer.get('/peoples/by_height',by_height);

//para renderizar los ejs en /entrega_tp4_index /by_age y /overweight (otra forma de entrega para la práctica 4)
routerServer.get('/by_age', (req,res)=>{
    res.render('by_age');
})
routerServer.get('/overweight', (req,res)=>{
    res.render('overweight');
})
routerServer.get('/entrega_tp4_index', (req,res)=>{
    res.render('entrega_tp4_index');
})

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//JUEGO ENTREGA FINAL

//Ruta de bienvenida del juego. Renderiza welcome.ejs
routerServer.get('/juego-oca/welcome', (req,res) => {
    res.render('juego-oca/welcome.ejs')
})

//Se recibe una solicitud post con los datos del formulario ingresados por el usuario, se guardan en una variable y se redirecciona a la siguiente página
routerServer.post('/juego-oca/welcome', (req,res) => {
    //console.log(req.body);
    //console.log(req.body.user_name);
    //console.log(req.body.selected_color)
    colorsandnames = req.body; //Guardamos los datos enviados en una variable
    console.log(colorsandnames); //Mostramos los datos en la consola del servidor para verificar que sean correctos
    //res.redirect('/juego-oca/welcome-join'); //Se redirije al usuario a la siguiente página
})

//Pantalla de selección entre crear juego e ingresar a uno existente
routerServer.get('/juego-oca/welcome-join', (req,res) => {
    res.render('juego-oca/welcome-join.ejs')
})

//Pantalla para ingresar a un juego existente
routerServer.get('/juego-oca/welcome-join/in', (req,res) => {
    res.render('juego-oca/welcome-join-in.ejs')
})

//Esta ruta procesa el id ingresado por el jugador 2 y lo redirecciona a la sala correspondiente
routerServer.post('/juego-oca/welcome-join/in', (req,res) => {
    console.log("El jugador 2 se unirá a la sala número:", req.body["idsala"]); //Mostramos en consola la sala  a la que el jugador 2 solicitó unirse
    let id = req.body["idsala"];
    let url = '/juego-oca/index/';
    url = url + id; //armamos la url 
    res.redirect(url); //redireccionamos
})

//Esta ruta se encarga de crear un nuevo juego, guardar los datos en el archivo y renderizar el tablero para mostrárselo al jugador
routerServer.get('/juego-oca/index', (req,res)=>{
    //Creamos una nueva tabla
    let tabla = crearOca(); //(hacerla asincronica) => intenté hacerlo y se rompía
    //Guardamos los ids en memoria
    ids.playerId = tabla.playerId;
    ids.tableroId = tabla.id;
    //Guardamos en la tabla generada el nombre y color elegido por el jugador 1
    tabla.jugador1Color = colorsandnames.selected_color;
    tabla.jugador1Nom = colorsandnames.user_name;
    saveTablero(tabla); //Guardamos la tabla en el archivo
    res.render('juego-oca/index.ejs') //Renderizamos el index para mostrárselo al jugador
})


routerServer.get('/juego-oca/index/getid', (req,res)=>{
    res.json(ids);
})

//Redirecciona al jugador 2 a la sala elegida según el ID de la petición get
routerServer.get('/juego-oca/index/:id', (req,res)=>{
    let tabla  = devolverTabla(req.params.id);
    console.log(colorsandnames.selected_color);
    console.log(colorsandnames.user_name);
    if (tabla.jugador1Color != colorsandnames.selected_color) {
        //Obtenemos el id del parámetro y lo utilizamos en joinOca como argumento para unir al jugador. Guardamos lo obtenido en tabla
        tabla = joinOca(req.params.id);
        //Guardamos los ids en una variable en memoria
        ids.playerId = tabla.jugador2Id;
        ids.tableroId = tabla.id;
        //Asignamos el nombre y color del jugador 2 a la tabla
        tabla.jugador2Color = colorsandnames.selected_color;
        tabla.jugador2Nom = colorsandnames.user_name;
        //console.log(tabla);
        //Guardamos los cambios en el archivo
        saveTablero(tabla);
        //Renderizamos el index para el jugador 2
        res.render('juego-oca/index.ejs');
    } else {
        console.log("Los colores son iguales");
        res.redirect('/juego-oca/welcome-alert');
    }
})

routerServer.get('/juego-oca/welcome-alert', (req,res) => {
    res.render('juego-oca/welcome-alert');
})

//Con esta petición se obtiene la pregunta correspondiente a una posición determinada del tablero
//Además, se maneja la lógica para mostrar o no las respuestas según sea el turno del jugador 1 o del jugador 2
routerServer.get('/juego-oca/index/getPregunta/:pos/:id/:playerId', (req,res)=>{ //La petición espera tres parámetros dinámicos en la URL (pos,id y playerID)
    let tabla=devolverTabla(req.params.id); //Obtenemos el ID del parámetro y lo utilizamos para buscar el tablero en el JSON
    let pregunta=tabla.tablero[req.params.pos].Pregunta; //Obtenemos POS del parámetro y lo utilizamos para traer la pregunta correspondiente a esa posición en el arreglo del tablero
    //Verificamos de quién es el turno para saber si debe o no ver las respuestas
    if((tabla.turn==-1)){ //Si es el turno del jugador 1
        if(tabla.jugador1Id==req.params.playerId){ //Verificamos que coincida el playerID enviado con el de la tabla
            for(let i=0; i<3;i++){
                pregunta.respuestas[i].value=null;
            }
            res.json(pregunta); //Si se cumple todo, devolvemos la pregunta con sus respuestas      
        } else { //Si no se cumple, se envía la pregunta con las respuestas a null, ya que el jugador 2 no debe ver las respuestas aún.
            pregunta.respuestas=null;
            res.json(pregunta);
        }
    }else if(tabla.turn == -2){ //Si es el turno del jugador 2
        if(tabla.jugador2Id==req.params.playerId){ //Verificamos que coincida el playerID enviado con el de la tabla
            for(let i=0; i<3;i++){
                pregunta.respuestas[i].value=null;
            }
            res.json(pregunta); //Si se cumple todo, devolvemos la pregunta con sus respuestas   
        } else { //Si no se cumple, se envía la pregunta con las respuestas a null, ya que el jugador 1 no debe ver las respuestas aún.
            pregunta.respuestas=null;
            res.json(pregunta);
        }
    }
})

export default routerServer;
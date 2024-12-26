let ids={};
let pregunta={};

//consigo el IDSALA
let url = "http://localhost:3000/juego-oca/index/getid" 
fetch(url)
  .then(response => response.json())
  .then(data => {
    console.log(data);
    ids = data;
    let idsala = document.getElementById("idsala");
    //agrego idsala al html
    idsala.innerHTML = ids.tableroId;
  })

  //crea una conexión de socket utilizando la URL actual del cliente (el navegador) y la ruta por defecto del servidor de Socket.IO
  //dispara el evento llamado connection
const socket = io();

setTimeout(() => {socket.emit('actualizarNombre',ids.tableroId)},2000); //Espera 2 segundos y emite un evento para actualizar los nombres con el ID del tablero

//al boton dado le ponemos un evento click para cuando se clikee se mande al servidor el id del tablero y el id del jugador que cliqueo
document.getElementById('dado').addEventListener('click', () => {
  socket.emit('botonDado',ids.tableroId,ids.playerId);
});

//obtenemos el numero aleatorio del dado sacado en el servidor para ponerlo en el elemento num 
  socket.on('numeroAleatorio', (numero,id) => {
    if(id == ids.tableroId)
      document.getElementById('num').textContent = numero;
  });
  
  socket.on('seCambio',(turno,id) => {
        //Cartel cambio de turno
        //habilito el boton
        if(id == ids.tableroId){
          document.getElementById('numTurn').textContent = turno;
        }
  });

//funciones para no poner tanto codigo
  function caseUno(color){
    switch(color){
      case 'blue':
        color='primary';
        break;
      case 'yellow':
        color='warning';
        break;
      case 'red':
        color='danger';
        break;
      case 'green':
        color='success';
        break;
    }
    return color;
  }
  function caseDos(color){
    switch(color){
      case 'primary':
        color='#cfe2ff';
        break;
      case 'warning':
        color='#fff3cd';
        break;
      case 'danger':
        color='#f8d7da';
        break;
      case 'success':
        color='#d1e7dd';
        break;
    }
    return color;
  }
  function caseTres(color){
    switch(color){
      case 'blue':
        color='#cfe2ff';
        break;
      case 'yellow':
        color='#fff3cd';
        break;
      case 'red':
        color='#f8d7da';
        break;
      case 'green':
        color='#d1e7dd';
        break;
    }
    return color;
  }

  //obtenemos el nombre y color del jugador actual, y el id de la tabla
  socket.on('cambiarNomCol',(nomCol,tablaId)=>{
    nomCol.color1=caseUno(nomCol.color1);//guardamos en nomCol.color1 el color pro con nombre adaptado a bootstrap
    console.log(nomCol.color1);
    let padre=document.querySelector(".list-group");//guardamos en padre la ul
    if(!padre.hasChildNodes()){//sino tiene hijos
      let nom1=document.createElement('li');//creamos en nom1 la li
      padre.appendChild(nom1);//ponemos la li como hijo de la ul
      nom1.innerHTML='Jugador 1: '+nomCol.nombre1;//le ponemos el nombre
      nom1.className="list-group-item list-group-item-"+nomCol.color1;//le ponemos el color
      let largada1 = document.getElementById('t0p1');//guardamos en la var el elemento t0p1
      nomCol.color1=caseDos(nomCol.color1);//guardamos el color en nomCol.color1
      largada1.style.backgroundColor = nomCol.color1;//le ponemos el color
    }//pongo este if xq sino el jugaor 1 se agrega dos veces
    if(nomCol.nombre2!=null && nomCol.color2!=null && tablaId == ids.tableroId){//hacemos este if, xq sino hay jugador 2, no deberia ponerse el jugador, entonces preguntamos si es dist de null
      nomCol.color2=caseUno(nomCol.color2);//hacemos lo mismo que con el jugador 1
      let nom2=document.createElement('li');
      padre.appendChild(nom2);
      nom2.innerHTML="Jugador 2: "+nomCol.nombre2;
      nom2.className="list-group-item list-group-item-"+nomCol.color2;
      let largada2 = document.getElementById('t0p2');
      nomCol.color2=caseDos(nomCol.color2);
      largada2.style.backgroundColor = nomCol.color2;
    }
  })

  socket.on('movimiento',(tablaID,numCasilla,numCasillaAnt,color,numPlayer) =>{
     if(ids.tableroId == tablaID){
      color=caseTres(color);
      if (numCasillaAnt == 0) {//si salio de la largada
        let cadena = "t0p" + numPlayer;//guardamos en cadena el elemento del jugador que tenga numPlayer
        let casillaAnt = document.getElementById(cadena);//guardamos el elemento en la var
        casillaAnt.style.backgroundColor = "white";//pintamos de blanco ya que se fue de la largada
      } else {//si numCasillaAnt no es 0 osea ya avanzo dos veces en el tablero
        let casillaAnt = document.getElementById('t'+numCasillaAnt);//guardamos en casillaAnt el elemento del tablero
        casillaAnt.style.backgroundColor = "white";//ponemos la casilla ant en blanco
      }
      
      let casilla = document.getElementById('t'+numCasilla);//guardamos en casilla el elemento t+numero de la casilla actual
      console.log(color);
      casilla.style.backgroundColor = color;//le ponemos el color del jugador
     }
  });

  let auxNumCasilla;
  socket.on('mostrarPreg',(tableroId,numCasilla)=> {
    if(ids.tableroId == tableroId){
    fetch("http://localhost:3000/juego-oca/index/getPregunta/"+numCasilla+"/"+ids.tableroId+"/"+ids.playerId)
    .then(response => response.json())
    .then(data => {
      console.log(data);
      pregunta = data;
      if(padre.hasChildNodes){
        while(padre.firstChild){//mientras la ul tenga li´s le sacamos los hijos asi no aparecen las repuestas de la preg anterior
          padre.removeChild(padre.firstChild);
        }
      }  
      auxNumCasilla = numCasilla;
      crearPreguntasYResp(padre);
    });
  }});
//obtenemos pos anteultima para pintarla en blanco
  socket.on('CambiarAnteUltima',(tableroId,posAnteultima) => {
    if (tableroId == ids.tableroId) {
      let casillaAnteUltima = document.getElementById('t'+posAnteultima);
      casillaAnteUltima.style.backgroundColor = "white";
    }
  });

  //si gano emitimos una alerta
  socket.on('Ganaste',(tablaID,playerId) =>{
        if(tablaID == ids.tableroId){
          if (playerId == ids.playerId) {
            setTimeout(() => Swal.fire({
              title: 'Ganaste!',
              text: 'Sos el ganador de nuestro juego. Felicitaciones!',
              imageUrl: 'https://cardochicureo.cl/wp-content/uploads/2016/03/ganador.jpg',
              imageWidth: 400,
              imageAlt: 'Ganador',
            }),1000);
          }
        }
      });
//si perdio emitimos una alerta
  socket.on('Perdiste',(tablaID) => {
    if(tablaID == ids.tableroId){
      setTimeout(() => Swal.fire({
        title: 'Perdiste!',
        text: 'No has podido ganar este juego. Suerte en la próxima!',
        imageUrl: 'https://www.pngmart.com/files/17/Game-Over-PNG-File.png',
        imageWidth: 400,
        imageAlt: 'Perdedor',
      }),1000);
    }
  });

  socket.on('GanastePorAbandono',(tablaID) =>{
    if(tablaID == ids.tableroId){
      setTimeout(() => Swal.fire({
        title: 'Ganaste!',
        text: 'El otro jugador abandonó!',
        imageUrl: 'https://cardochicureo.cl/wp-content/uploads/2016/03/ganador.jpg',
        imageWidth: 400,
        imageAlt: 'Ganador',
      }),1000);
    }
  });

socket.on('PerdistePorAbandono',(tablaID, playerId) => {
if(tablaID == ids.tableroId){
  if (playerId == ids.playerId) {
    setTimeout(() => Swal.fire({
      title: 'Perdiste!',
      text: 'Has abandonado el juego!',
      imageUrl: 'https://www.pngmart.com/files/17/Game-Over-PNG-File.png',
      imageWidth: 400,
      imageAlt: 'Perdedor',
    }),1000);
  }
}
});

//Mensaje que llega cuando un jugador se ha desconectado
socket.on('JugadorDesconectado', (mensaje) => {
  //Se muestra el mensaje en el navegador
  console.log(mensaje);
  Swal.fire({
    title: 'Un jugador se ha desconectado!',
    text: 'El jugador rival perdió la conexión. En diez segundos serás redireccionado al inicio...',
    imageUrl: 'https://www.pngall.com/wp-content/uploads/2017/05/Alert-Download-PNG.png',
    imageWidth: 400,
    imageAlt: 'Desconectado'
  })
  //Pasados 10 segundos se redirecciona al usuario para que pueda crear un juego nuevo
  setTimeout(() => { window.location.href = "/juego-oca/welcome" },10000);
});

//SECTOR APARECER PREGUNTAS
socket.on('pintarRespuestas',(tableroId,playerId,respuesta,bolean)=>{
  console.log('entro en pintar respuesta');
  console.log(respuesta);
  if(tableroId==ids.tableroId && playerId==ids.playerId){
    switch(respuesta){
    case 0:

      console.log('entro a la resp 0');
      if(bolean){
        let resp='resp'+respuesta;
        let correcta= document.getElementById(resp);
        correcta.style.backgroundColor = "#d1e7dd";//la pintamos de verde
      }
      else{
        let resp='resp'+respuesta;
        let correcta= document.getElementById(resp);
        correcta.style.backgroundColor = "#f8d7da";//sino de rojo
      }
      
      /*let incorrecta =document.getElementById('resp1');
      incorrecta.style.backgroundColor = "#f8d7da";//sino de rojo
      incorrecta =document.getElementById('resp2');
      incorrecta.style.backgroundColor = "#f8d7da";//sino de rojo*/
      break;
    case 1:
      console.log('entro a la resp 1');
      if(bolean){
        let resp='resp'+respuesta;
        let correcta= document.getElementById(resp);
        correcta.style.backgroundColor = "#d1e7dd";//la pintamos de verde
      }
      else{
        let resp='resp'+respuesta;
        let correcta= document.getElementById(resp);
        correcta.style.backgroundColor = "#f8d7da";//sino de rojo
      }
      /*let incorrecta1 =document.getElementById('resp0');
      incorrecta1.style.backgroundColor = "#f8d7da";//sino de rojo
      incorrecta1 =document.getElementById('resp2');
      incorrecta1.style.backgroundColor = "#f8d7da";//sino de rojo*/
      break;
    case 2:
      console.log('entro a la resp 2');
      if(bolean){
        let resp='resp'+respuesta;
        let correcta= document.getElementById(resp);
        correcta.style.backgroundColor = "#d1e7dd";//la pintamos de verde
      }
      else{
        let resp='resp'+respuesta;
        let correcta= document.getElementById(resp);
        correcta.style.backgroundColor = "#f8d7da";//sino de rojo
      }
      /*let incorrecta2 =document.getElementById('resp0');
      incorrecta2.style.backgroundColor = "#f8d7da";//sino de rojo
      incorrecta2 =document.getElementById('resp1');
      incorrecta2.style.backgroundColor = "#f8d7da";//sino de rojo*/
      break;
    }
  };
});

function crearPreguntasYResp (padre){
  let tocada=false;
  padre.innerHTML=pregunta.pregunta;//ponemos la pregunta en la ul
  console.log(pregunta.respuestas==null);
  if(pregunta.respuestas !=null){//si la respuesta es distinto de null
    let resp1=document.createElement('li');//creamos li y lo guardamos en resp1
    resp1.className += " list-group-item"//le ponemos una clase
    resp1.id="resp0";
    padre.appendChild(resp1);//la ponemos la li como hijo de la ul
    resp1.innerHTML=pregunta.respuestas[0].text;//ponemos la respuesta en la li
    resp1.addEventListener('click', () => {//le agregamos un evento a la li
      if(!tocada){//si ningun otra pregunta fue tocada, osea tocada=false
        socket.emit('respondio',auxNumCasilla,0,ids.playerId,ids.tableroId);//emitimos al servidor el num de la casilla de la pregunta, el numero de la respuesta, el id del jugador y de la tabla
        /*if(pregunta.respuestas[0].value===true){//si la respuesta es verdadera
          resp1.style.backgroundColor = "#d1e7dd";//la pintamos de verde
        }
        else{
          resp1.style.backgroundColor = "#f8d7da";//sino de rojo
        }
        tocada=true;//ponemos tocada en true asi no podemos tocar ningun otra resp*/
      };  
    });

    //hacemos lo mismo para las otras dos respuestas
    let resp2=document.createElement('li');
    resp2.className += " list-group-item"
    resp2.id="resp1";
    padre.appendChild(resp2);
    resp2.innerHTML=pregunta.respuestas[1].text;
    resp2.addEventListener('click', () => {
      if(!tocada){
        socket.emit('respondio',auxNumCasilla,1,ids.playerId,ids.tableroId);
        /*if(pregunta.respuestas[1].value===true){
        resp2.style.backgroundColor = "#d1e7dd";
      }
      else{
        resp2.style.backgroundColor = "#f8d7da";
      }
      tocada=true;*/
      };
    });
    
    let resp3=document.createElement('li');
    resp3.className += " list-group-item"
    resp3.id="resp2";
    padre.appendChild(resp3);
    resp3.innerHTML=pregunta.respuestas[2].text;
    resp3.addEventListener('click', () => {
      if(!tocada){
        socket.emit('respondio',auxNumCasilla,2,ids.playerId,ids.tableroId);
       /* if(pregunta.respuestas[2].value===true){
        resp3.style.backgroundColor = "#d1e7dd";
      }
      else{
        resp3.style.backgroundColor = "#f8d7da";
      }
      tocada=true;*/
      };
    });
  }
}
const padre=document.getElementById('preguntaPosta');//guardamos en padre la ul

//Botón de abandonar juego

//Obtenemos su ID
const salir_button = document.querySelector("#salir_button");

//Función del botón
const abandonarJuego = () => { 
  console.log("El botón de abandonar juego fue cliqueado");
  socket.emit('QuieroAbandonar',ids.tableroId,ids.playerId);
}

//Hacemos que cuando se cliquee el botón se dispare la función correspondiente
salir_button.addEventListener("click",abandonarJuego);
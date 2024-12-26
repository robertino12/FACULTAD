//Obtenemos los ids de los botones
const newGame_button = document.querySelector("#newGame_button");
const joinGame_button = document.querySelector("#joinGame_button");
let datos = {
    user_name: '',
    selected_color: ''
  };
  //Consigo desde el localStorage el nombre y el color q eligio el jugadore en la pag anterior
 
let url = '/juego-oca/welcome';
const newGame = () => { 
  datos.user_name = sessionStorage.getItem('nombre');
  datos.selected_color = sessionStorage.getItem('color');
  let opciones = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json' 
    },
    body: JSON.stringify(datos)
  };
  console.log(datos);
  fetch(url, opciones) //Hago un Post para guardar en el servidor el color y nombre elegido
    .catch(error => {
      console.error('Error en la solicitud:', error);
    });
  window.location.href = "/juego-oca/index"; //mando al crear una partida nueva
}

const joinGame = () => { window.location.href = "/juego-oca/welcome-join/in" } //mando a ingrear el id de la partida en la que se quiere meter el jugador

//Hacemos que cuando se cliquee un elemento se dispare su función correspondiente
newGame_button.addEventListener("click",newGame);
joinGame_button.addEventListener("click",joinGame);
/*

Versión vieja de anterior y siguiente para pasar de página
(reemplazada por nueva versión en base a las correcciones del profesor)

function siguiente(){
    num =localStorage.getItem("pagina");//guardamos en num lo q vale el local storage en ese momento
    if(num < 9){//si es menor a 9 quiere decir q no llego a la ult pag entonces podemos ir uno adelante
        num++;//x lo cual pasamos a la sig
        localStorage.setItem("pagina",num);//seteamos el local asi ya tenemos guardada el num d pag q estamos
        lista = document.getElementById("personajes");//guardamos en lista la ul
        while(lista.firstChild){//mientras la ul tenga li
            lista.removeChild(lista.firstChild);//removemos los li de la ant pag
        }
        pag = document.getElementById("pag");//obtenemos pag para luego cambiarle el num
        pag.innerHTML = "pag: " + num;
        cambiarPagina(num);//llamamos a la funcion para poner los nuevos pj en la pag actual
    }
}

function anterior(){
    num =localStorage.getItem("pagina");//guardamos en num lo q valga el local
    if(num > 1){//si es mayor a 1 quiere decir que podemos ir para atras
        num--;//le restamos uno para poder ir a la pag ant
        localStorage.setItem("pagina",num);//guardamos el num d la pag q cambiamos en el local
        lista = document.getElementById("personajes");//guardamos en lista la ul q aparece
        while(lista.firstChild){//mientras haya hijo 
            lista.removeChild(lista.firstChild);//eliminar el hijo q haya para desp poner nueva ul
        }
        pag = document.getElementById("pag");//guardamos pagina act en pag
        pag.innerHTML = "pag: " + num;//lo ponemos en el html
        cambiarPagina(num);//ponemos el ul d la pag actual
    }
}

*/

function cambiarPagina(url){
    fetch(url)
    .then(response => response.json())
    .then(data =>{ 
        //console.log(data);
        document.getElementById("siguiente").setAttribute('url',data.next); //seteamos atributo url de siguiente con lo que nos brinda el json
        document.getElementById("anterior").setAttribute('url',data.previous); //hacemos lo mismo para anterior
       
        pjs = data.results;//en pjs guardamos el vector de pjs de la pagina que tenga i
        lista = document.getElementById("personajes");//guardamos en lista ul
        for (let index = 0; index < pjs.length; index++) {//recorremos vector
          li = document.createElement("li");//en li guardamos el nodo de la lista a crear
          li.addEventListener("click",function(){
            mostrarInfoPj(pjs[index])
            });//agregamos un evento para cuando se clickee un li y a la funcion le pasamos el pj q se este recorriendo en el for
          li.innerHTML =  pjs[index].name;//ponemos el nombre respectivo en cada li
          lista.appendChild(li);//agregamos el li en la lista
        }
    });
}

function mostrarInfoPj(pj){
    //alert('anda el click');
    let titulo=document.getElementById("titulo");//guardamos el h3
    const padre=document.querySelector('.carac');//guardamos en padre la ul
    while(padre.firstChild){//mientras la ul tenga li´s le sacamos los hijos asi no aparecen las carac de los pjs anteriores
        padre.removeChild(padre.firstChild);
    }
    titulo.innerHTML='Personaje Seleccionado:<br>'+pj.name;//ponemos titulo en el h3 (br deja un enter)
    let li=document.createElement('li'); //creamos un li para cada dato del pj
    padre.appendChild(li); //lo agregamos a la ul
    li.innerHTML='Nombre: '+pj.name; //lo editamos con el dato
    let li2=document.createElement('li');
    padre.appendChild(li2);
    li2.innerHTML='Altura: '+pj.height+'cm';
    let li3=document.createElement('li');
    padre.appendChild(li3);
    li3.innerHTML='Peso: '+pj.mass+'kg';
    let li4=document.createElement('li');
    padre.appendChild(li4);
    li4.innerHTML='Color de piel: '+pj.skin_color;
    let li5=document.createElement('li');
    padre.appendChild(li5);
    li5.innerHTML='Sexo: '+pj.gender;
    //planeta
    let planetURL = pj.homeworld; //utilizamos la url que obtenemos de las propiedades del pj
    fetch(planetURL)
    .then(response => response.json())
    .then(data =>{
        let planeta=document.createElement('li');
        padre.appendChild(planeta);
        planeta.innerHTML = "Planeta: "+data.name;
    });
    //peliculas
    let peliculasURL = pj.films; //utilizamos la url que obtenemos de las propiedades del pj
    let listaPeliculas = document.createElement('ul'); //creamos un ul donde listar las películas
    listaPeliculas.innerHTML = "Peliculas donde aparece: ";
    listaPeliculas.setAttribute("id", "listapelis"); //creamos un id para poder trabajarlo en el css
    padre.appendChild(listaPeliculas); //agregamos la nueva ul a la que ya tenía el pj
    peliculasURL.forEach(element => { //obtenemos la información de cada película con un foreach
        fetch(element)
        .then(response => response.json())
        .then(data =>{
            let peli = document.createElement('li'); 
            peli.setAttribute("class","idspelis"); //agregamos una clase para trabajar con todas juntas en css
            peli.innerHTML = data.title;
            listaPeliculas.appendChild(peli); //agregamos la película al ul (nuevo) de películas
    });
    });
}

localStorage.setItem("pagina","1"); //seteamos el local storage para que tenga la primera pagina. Esto lo usamos para mostrar num de pag en el HTML

cambiarPagina("https://swapi.dev/api/people/"); //llamamos a la función para que consuma la API

let sig = document.getElementById('siguiente'); //obtenemos el botón siguiente y lo guardamos en una variable
sig.addEventListener('click', (e) => { //agregamos un evento para que cuando hagan clic en el botón se ejecute esta función
    num = localStorage.getItem("pagina"); //guardamos en num lo que vale la página cuando es llamada la función
    if (num < 9) { //corroboramos que exista una página siguiente
        num++; //existe una página siguiente, entonces incrementamos num
        localStorage.setItem("pagina",num); //seteamos el local con el nuevo número
        pag = document.getElementById("pag");
        pag.innerHTML = "pag: " + num; //actualizamos el número de página en el html
        let url = e.target.getAttribute('url'); //obtenemos la url que fue guardada previamente cuando se llamó a la función cambiar página
        cambiarPagina(url); //llamamos a cambiar página con la nueva url (la del botón siguiente)
        document.getElementById("personajes").innerHTML = ""; //borramos pjs anteriores
    }
})

let ant = document.getElementById('anterior'); //obtenemos el botón anterior y lo guardamos en una variable
ant.addEventListener('click', (e) => { //agregamos un evento para que cuando hagan clic en el botón se ejecute esta función
    num = localStorage.getItem("pagina"); //guardamos en num lo que vale la página cuando es llamada la función
    if (num > 1) { //corroboramos que exista una página anterior
        num--; //existe una página anterior, entonces decrementamos num
        localStorage.setItem("pagina",num); //seteamos el local con el nuevo número
        pag = document.getElementById("pag");
        pag.innerHTML = "pag: " + num; //actualizamos el número de página en el html
        let url = e.target.getAttribute('url'); //obtenemos la url que fue guardada previamente cuando se llamó a la función cambiar página
        cambiarPagina(url); //llamamos a cambiar página con la nueva url (la del botón anterior)
        document.getElementById("personajes").innerHTML = ""; //borramos pjs anteriores
    }
})

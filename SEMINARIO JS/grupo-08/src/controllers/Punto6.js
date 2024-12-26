import fs from 'fs';//importamos modulo file system q es una api para interactuar con los archivos
//desarrollamos la logica en el controlador para no tener un choclo de cosas en el routes q es donde definimos las rutas

//creando la logica de las apis que luego seran usadas mediante peticiones http en el routes
const people = JSON.parse(fs.readFileSync('src/data/people.json', 'utf8'));//con fs.readFileSync leemos el people json y con json parse lo parseamos d manera que podemos trabajar con el
const overweight = (req,res) => {
    let imcM25 = people.filter(p => p.weight / Math.pow(p.height/100,2) > 25).map(p => p.name);//filtramos del vector de personas los q tenga imc mayor a 25 y ese vector lo mapeamos para crear un vector con los nombres de las personas filtradas
    let response = {
        IMCMayorA25: imcM25
      };//lo ponemos como un objeto para desp poder mandar una resp como json
    res.json(response);
}
const by_ageFunction = () => {//creamos una funcion que devuelva un vector de edades indexado por nombre debido a q la vamos a usar seguido en dif modulos
  let response = {}
  let act = new Date();
  for (let index = 0; index < people.length; index++) {
    let d = new Date(people[index].dob);
    let age = 0;
    if (((d.getMonth() < act.getMonth())) || ((d.getMonth() == act.getMonth()) && (d.getDate() < act.getDate()))) {
      age = (d.getFullYear() - act.getFullYear()) * -1;
    } else {
      age = (d.getFullYear() - act.getFullYear() - 1) * -1;
    }
    response[people[index].name] = age;
  }
  return response;
}
const by_age = (req,res) => {//modulo usando la funcion, que rsponde un json con un vector de edades indexado por nombre
    let response = by_ageFunction();
    res.json(response);

}
const imc_over_40 = (req,res) => {
    let vectorAges = by_ageFunction(); 
    let response = [];
    let viejos = Object.entries(vectorAges).filter(([name, age]) => age > 40).map(([name, age]) => name);//object entries devuelve un vector, donde cada elem tiene un vector con dos claves, en este caso nombre y edad
    //filtramos los q tiene mas de 40, y con el map creamos nuevo vector de edades d los filtrados anteriormente
    for (let i = 0; i < people.length; i++) {
       if (viejos.includes(people[i].name)) {//si el nombre en el vector people en la pos i se encuentra en viejos, sacarle el imcy lo pusheamos a response, generando el vector de imc de los mayores de 40
         let bmi = people[i].weight / Math.pow(people[i].height / 100, 2); 
         response.push(bmi);
       }
     }
   
     res.json(response);
};
const average_imc = (req,res) => {
    let avg = {};
    let total = 0; 
    people.forEach(element => {
        total += element.weight / Math.pow(element.height / 100, 2);
    });//sacamos el imc d todas las personas
    avg['avg'] = total/people.length;// ponemos en el objeto avg el imc promedio
    res.json(avg);
}
const  youngest = (req,res) => {
  let array = by_ageFunction();//usamos funcion que devuelve vector de edades indexado por nombre
  let EdadMasJoven = 9999;
  let masJoven = '';
  for (const [name, age] of Object.entries(array)) {//pasamos por cada clave valor, osea name,age de response
    if (age < EdadMasJoven) {//usamos el valor age de la pos 1 del vector response para compararlo con la menor edad
      EdadMasJoven = age;//si es menor actualizamos youngest age y youngestperson
      masJoven = name;
    }
  }
    let joven = people.filter(p => p.name == masJoven);//creamos un nuevo vector que va a ser solo un elemento ya que uno solo va a ser el mas joven
    res.json(joven);
}
const  by_height = (req,res) => {
  let people = JSON.parse(fs.readFileSync('src/data/people.json', 'utf8'));
  let array = people.sort((a,b) => a.height - b.height);//el metodo sort sirve para devolver un vector ordenado de menor a mayor, en este caso entre alturas de las personas   
  res.json(array);
}
export { overweight as default, by_age, imc_over_40, average_imc, youngest, by_height };
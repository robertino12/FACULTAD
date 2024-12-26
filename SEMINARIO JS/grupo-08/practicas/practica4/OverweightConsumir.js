url = "http://localhost:3000/peoples/overweight"

fetch(url)
    .then(response => response.json())
    .then(data => {
        console.log(data.IMCMayorA25[0]);
        let arreglo = document.getElementById("arreglo");
        data.IMCMayorA25.forEach(element => {
          let li = document.createElement('li');
          li.className = "list-group-item";
          arreglo.appendChild(li);
          li.innerHTML = element;
        });
    })
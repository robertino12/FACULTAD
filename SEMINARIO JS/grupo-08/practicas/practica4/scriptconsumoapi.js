url = "http://localhost:3000/peoples/by_age"

fetch(url)
    .then(response => response.json())
    .then(data => {
        console.log(data);
        let nombres = Object.entries(data).map(([name,age]) => name)
        console.log(nombres);
        nombres.forEach(element => {
            let li = document.createElement('li');
            li.className = "list-group-item";
            arreglo.appendChild(li);
            li.innerHTML = element + ": " + data[element];
        });
    })
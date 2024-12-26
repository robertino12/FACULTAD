function showImg(){
    let x = document.getElementById('imagenAmostrar').value;
    let previousImage = document.getElementById(localStorage.getItem("act1"));
    if (previousImage) {
        previousImage.style.display = "none";
    }
    switch (x) {
        case "imagen 1":
            localStorage.setItem("act1","imagen-1");
            document.getElementById("imagen-1").style.display = "block";
            break;
        case "imagen 2":
            localStorage.setItem("act1","imagen-2");
            document.getElementById("imagen-2").style.display = "block";
            break;
        case "imagen 3":
            localStorage.setItem("act1","imagen-3");
            document.getElementById("imagen-3").style.display = "block";
            break;
        default:
            console.log("no es una imagen disponible");
            break;
    }         
}
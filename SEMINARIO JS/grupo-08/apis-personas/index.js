const byage_button = document.querySelector("#byage_button");
const overweight_button = document.querySelector("#overweight_button");

const byage = () => { window.location.href = "by_age.html" }
const overweight = () => { window.location.href = "overweight.html" }

byage_button.addEventListener("click",byage);
overweight_button.addEventListener("click",overweight);
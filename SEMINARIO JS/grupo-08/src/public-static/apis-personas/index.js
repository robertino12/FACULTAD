const byage_button = document.querySelector("#byage_button");
const overweight_button = document.querySelector("#overweight_button");

const byage = () => { window.location.href = "by_age" }
const overweight = () => { window.location.href = "overweight" }

byage_button.addEventListener("click",byage);
overweight_button.addEventListener("click",overweight);
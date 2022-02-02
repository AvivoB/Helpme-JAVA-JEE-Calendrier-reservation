/**
 * 
 */
let formToggle = document.querySelector("#form-toggle");
let forms = document.querySelectorAll(".card");
let service = document.querySelectorAll("#service");

formToggle.onchange = () => {
	for (let i = 0; i < forms.length; i++){
		forms[i].style.display = "none";	
	}
	
	let active =  formToggle.value;
	
	forms[active].style.display = "block";
	//service.setAttribute("name", active);
	
}
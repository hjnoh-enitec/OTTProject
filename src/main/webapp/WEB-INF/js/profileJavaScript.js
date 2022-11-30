/**
 * 
 */

 
 function setProfile(event){
	 let reader = new FileReader();
	 
	 reader.onload = function(event){
		 let img = document.createElement("img");
		 img.setAttribute("src",event.target.result);
		 document.querySelector("div#profile-image").appendChild(img);
	 };
	 
	 reader.readAsDataURL(event.target.files[0]);
 }
 
 
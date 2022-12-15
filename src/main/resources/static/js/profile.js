const modalAdd = document.getElementById("modal-add");
const modalModify = document.getElementById("modal-modify");
const modalTitle = document.getElementById("modalTitle");
const contentForm = document.getElementById("contentForm");
const buttonInForm = document.getElementById("buttonInForm");

function moveContent(frm) {
	frm.submit();
}
function openModalWithSetting() {
	modalModify.style.display = "flex";
	modalTitle.innerHTML = "<h2>Profile Setting</h2>";
}

function openModalWithAddProfile() {
	modalAdd.style.display = "flex";
	modalTitle.innerHTML = "<h2>Profile Add</h2>";
}

function closeModal() {
	modalAdd.style.display = "none";
	modalModify.style.display = "none";
}

function setProfile(event) {
	let reader = new FileReader();
	reader.onload = function(event) {
		let img = document.getElementById("fileUpload");
		img.setAttribute("src", event.target.result);
	};

	reader.readAsDataURL(event.target.files[0]);
}

function createProfile() {
	$('#createProfile').submit();
}
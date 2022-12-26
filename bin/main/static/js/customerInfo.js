let today = new Date();
let thisYear = today.getFullYear();

let phone = document.getElementById("phone");
if (phone.value.length == 11) {
	let phoneFirst = phone.value.substr(0, 3) + "-";
	let phoneSecond = phone.value.substr(3, 4) + "-";
	let phoneThird = phone.value.substr(7, 4);

	phone.value = phoneFirst + phoneSecond + phoneThird;
} else {
	phone.value = "ERROR!";
}

let birth = document.getElementById("birth");
if (birth.value.length == 8) {
	let year = birth.value.substr(0, 4);
	let month = "";
	let day = "";

	if (birth.value.charAt(4) == 0) {
		month = birth.value.substr(5, 1);
	} else {
		month = birth.value.substr(4, 2);
	}

	if (birth.value.charAt(6) == 0) {
		day = birth.value.substr(7, 1);
	} else {
		day = birth.value.substr(6, 2);
	}

	birth.value = year + "年" + month + "月" + day + "日";
} else {
	birth.value = "ERROR!";
}
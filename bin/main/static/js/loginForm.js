var findIdForm = document.getElementById("findIdForm");
var findPWForm = document.getElementById("findPWForm");

var c_name = document.getElementById("c_name");
var c_birth = document.getElementById("c_birth");
var c_phone = document.getElementById("c_phone");

var c_id = document.getElementById("c_id");

		function findID() {
			findIdForm.setAttribute("onsubmit", "return doAction()");
			findIdForm.setAttribute("method", "post");
		}
		
		function findPW() {
			findPWForm.setAttribute("action", "/find/sendCheckedMail")
			findPWForm.setAttribute("onsubmit", "return formCheck(this);");
			findPWForm.setAttribute("method", "post");
		}

		document.getElementById("modal_open_btn_findID").onclick = function() {
			document.getElementById("modal-findID").style.display = "flex";
			msg_id.innerHTML = "";
		}
		
		document.getElementById("modal_open_btn_findPW").onclick = function() {
			document.getElementById("modal-findPW").style.display = "flex";
			msg_pw.innerHTML = "";
		}

		var msg = document.getElementById("msg");

		function closeFindID() {
			document.getElementById("modal-findID").style.display = "none";
			c_name.value = "";
			c_birth.value = "";
			c_phone.value = "";
			msg_id.innerHTML = "";
		}
		function closeFindPW() {
			document.getElementById("modal-findPW").style.display = "none";
			c_id.value = "";
		}

		function doAction() {
			var nameVal = document.getElementById("c_name").value;
			var birthVal = document.getElementById("c_birth").value;
			var phoneVal = document.getElementById("c_phone").value;

			let birthRegex = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
			let phoneRegex = new RegExp('^(0[1|7|8|9][0])([0-9]{4})([0-9]{4})$');

			if (nameVal.length < 3) {
				msg_id.innerHTML = "check name";
				return false;
			}

			if (birthVal.length != 8 || birthRegex.test(birthVal) == false) {
				msg_id.innerHTML = "check birth";
				return false;
			}

			if (phoneRegex.test(phoneVal) == false) {
				msg_id.innerHTML = "check phone";
				return false;
			}

			$.ajax({
				type : 'post',
				url : "http://localhost:8000/find/id",
				async : false,
				data : {
					"c_name" : nameVal,
					"c_birth" : birthVal,
					"c_phone" : phoneVal
				},
				success : function(data) {
					msg_id.innerHTML = "";
					var str = "";
					if(data.length <= 0){
						str = "一致する情報がありません。\r\n入力情報をもう一度確認してください。";
					}else{
						str += "お客様のメールアドレスは\r\n";
						
						for(var i = 0; i < data.length; i++){
							str += data[i];
							if(data.length > 1){
								if(i <= data.length - 2){
								str += ", ";
								}
							}
						}
						str += "です。";
					}
					alert(str);
					
				},
				error : function(error) {

				}
			})

			return false;
		}
		
		function formCheck() {
			
			let mailRegex = new RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
			
			if(c_id.value == ""){
				msg_pw.innerHTML = 'メールを入力してください。';
				return false;
			}
			
			if(mailRegex.test(c_id.value) == false){
				msg_pw.innerHTML = 'メールの形式が正しくありません。';
				return false;
			}
			
			alert(c_id.value + "にメールを発送しました。");

			return true;
		}
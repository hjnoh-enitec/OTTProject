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
}

function openModalWithAddProfile() {
	modalAdd.style.display = "flex";
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
	let pf_name = document.getElementById("pf_name");
	if(pf_name == '' || pf_name === undefined || pf_name.value.length == 0){
		alert('使用するニックネームを入力してください。');
		return false;
	}
	$('#createProfile').submit();
	return true;
}

/////////////////////////////////////////////////////////////////

function enterkey(index,e) {
		let txt = document.getElementById("name" + index);
		let code = e.code;
		if(!txt.readOnly){
			if(code == 'Enter'){
				accept(index);
			}
		}
	}
		function returnProfile(){
			location.href='/profile/select';
		}
		function cancel(index){
			let updateBtn = document.getElementById("nameChange" + index);
			let acceptBtn = document.getElementById("changeAccept"+ index);
			let	showProfileName = document.getElementById("name"+index);
			let profileName = document.getElementById("pf_name" + index);
			let sendUpdateBtn = document.getElementById("profileUpdateBtn"+ index);
			let sendDeleteBtn = document.getElementById("profileDeleteBtn"+ index);
			let cancelBtn = document.getElementById("cancel"+index);
			updateBtn.style.display = 'block';
			acceptBtn.style.display = 'none';
			cancelBtn.style.display = 'none';
			showProfileName.readOnly = true;
			showProfileName.style.outline = 'none';
			showProfileName.style.border = '0';
			showProfileName.style.borderRadius = '0';
			showProfileName.value=profileName.value;
		}
		
		function accept(index) {
			let updateBtn = document.getElementById("nameChange" + index);
			let acceptBtn = document.getElementById("changeAccept"+ index);
			let	showProfileName = document.getElementById("name"+index);
			let profileName = document.getElementById("pf_name" + index);
			let sendUpdateBtn = document.getElementById("profileUpdateBtn"+ index);
			let sendDeleteBtn = document.getElementById("profileDeleteBtn"+ index);
			let cancelBtn = document.getElementById("cancel"+index);
			if(showProfileName.value.length < 1){
				alert('ニックネームを入力してください。');
				return false;	
			}
			updateBtn.style.display = 'block';
			acceptBtn.style.display = 'none';
			cancelBtn.style.display = 'none';
			showProfileName.readOnly = true;
			showProfileName.style.outline = 'none';
			showProfileName.style.border = '0';
			showProfileName.style.borderRadius = '0';
			profileName.value=showProfileName.value;
			if(sendUpdateBtn.style.display == ""){
				sendUpdateBtn.style.display = 'block';
				sendDeleteBtn.style.display = 'none';
			}
			return true;
		}
		function nameChange(index) {
			let updateBtn = document.getElementById("nameChange" + index);
			let acceptBtn = document.getElementById("changeAccept"+ index);
			let profileName = document.getElementById("name" + index);
			let cancelBtn = document.getElementById("cancel"+index);
			updateBtn.style.display = 'none';
			acceptBtn.style.display = 'block';
			cancelBtn.style.display = 'block';
			profileName.readOnly = false;
			profileName.style.outline = '1px solid';
			profileName.style.border = '1px solid';
			profileName.style.borderRadius = '1px';
			
		}
		function imgChange(index) {
			let file = document.getElementById("fileUpload"+index);
			file.click();
			
		}
		function changeProfileImg(event,index){
			 let reader = new FileReader();
			 let sendUpdateBtn = document.getElementById("profileUpdateBtn"+ index);
			 let sendDeleteBtn = document.getElementById("profileDeleteBtn"+ index);
			 reader.onload = function(event){
				 let img = document.getElementById("profileImg-card"+index);
				 img.setAttribute("src",event.target.result);
			 };
			 reader.readAsDataURL(event.target.files[0]);
			 if(sendUpdateBtn.style.display == ""){
					sendUpdateBtn.style.display = 'block';
					sendDeleteBtn.style.display = 'none';
			}
		}
		function updateProfile(index){
			let updatebtn = document.getElementById("profileUpdateBtn"+index);
			let deletebtn = document.getElementById("profileDeleteBtn"+index);
			if(window.confirm("変更事項を保存しますか？")){
				let form = document.getElementById("fileUploadform"+index);
				let data = new FormData(form);
				$.ajax({
					type:'POST',
					enctype:'multipart/form-data',
					url:'http://localhost:8000/update',
					//url:'http://18.183.223.7:8000/update',
					data:data,
					processData:false,
					contentType:false,
					cache:false,
					success:function(data){
						if(data == 0){
							
							window.location.reload();
						}
						else{
							alert('修正に失敗しました。');
						}
					},
					error : function(e){
						console.log('ERROR : ' + e);
					}
				});
			}updatebtn.style.display='none';
			deletebtn.style.display='block'
			
			}
			function deleteProfile(index) {
				if(window.confirm("本当に削除しますか？")){
					let pf_code = document.getElementById("pf_code" + index);
					$.ajax({
						type:'POST',
						url:'http://localhost:8000/delete',
						data:{"pf_code" : pf_code.value},
						success:function(data){
							if(data == 0){
								window.location.reload();
							}
							else if(data == 1){
								location.href='/profile/select';
							}
							else{
								alert('削除に失敗しました。');
							}
						},
						error : function(e){
							console.log('ERROR : ' + e);
						}
					})
				}
			}

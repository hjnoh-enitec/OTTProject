<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <style>
        * { box-sizing:border-box; }
        form {
            width:400px;
            height:600px;
            display : flex;
            flex-direction: column;
            align-items:center;
            position : absolute;
            top:50%;
            left:50%;
            transform: translate(-50%, -50%) ;
            border: 1px solid rgb(89,117,196);
            border-radius: 10px;
        }
        .input-field {
            width: 300px;
            height: 40px;
            border : 1px solid rgb(89,117,196);
            border-radius:5px;
            padding: 0 10px;
            margin-bottom: 10px;
        }
        
        label {
            width:300px;
            height:30px;
            margin-top :4px;
        }
        button {
            background-color: rgb(89,117,196);
            color : white;
            width:300px;
            height:50px;
            font-size: 17px;
            border : none;
            border-radius: 5px;
            margin : 20px 0 30px 0;
        }
        .title {
            font-size : 50px;
            margin: 40px 0 30px 0;
        }
        .msg {
            height: 30px;
            text-align:center;
            font-size:16px;
            color:red;
        }
        
        .sns-chk {
            margin-top : 5px; 
        }
    </style>
    <title>Register</title>
</head>
<body>
   <!-- form action="<c:url value="/register/save"/>" method="POST" onsubmit="return formCheck(this)"-->
   <form:form id="frm" action="/modify/save" method="post" onchange="pwCheck(this)">
    <div class="title">ユーザ情報修正</div>
    <div id="msg" class="msg"><form:errors path="pwd"/></div>  
    <label for="">ID</label>
    <input class="input-field" type="text" name="c_id" value="${customer.c_id}" readonly="readonly">
    <label for="">パスワード</label>
    <input class="input-field" type="password" name="c_pwd"  placeholder="パスワード">
    <label for="">パスワード再入力</label>
    <input class="input-field" type="password" name="c_pwd2" placeholder="再入力してください">
    <label for="">名前</label>
    <input class="input-field" type="text" name="c_name" value="${customer.c_name}" readonly="readonly">
    <label for="">生年月日</label>
    <input class="input-field" type="text" name="c_birth" value="${customer.c_birth}">
    <label for="">携帯</label>
    <input class="input-field" type="text" name="c_phone" value="${customer.c_phone}">
    <input type="hidden" name="c_mailcheck" value="${customer.c_mailcheck}">
    <button>修正</button>
   </form:form> 
   <script>
       function pwCheck(frm) {
            if(frm.c_pwd.value!==frm.c_pwd2.value) {　
                setMessage('pwdが一致しません', frm.c_pwd2);
            }else{
            	deleteMessage('', frm.pwd);
            }
       }
       function setMessage(msg, element){
            document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
            if(element) {
                element.select();
            }
       }
       function deleteMessage(msg,element){
    	   document.getElementById("msg").innerHTML = ``;
       }
       
   </script>
</body>
</html>
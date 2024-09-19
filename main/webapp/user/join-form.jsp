<%@page import="utils.Util"%>
<%@page import="utils.EmailAuth"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/common.jsp" %>
    <title>회원가입 폼</title>
</head>
<body>
    <%@ include file="/common/header.jsp" %>
    <div class="d-flex justify-content-center join">                                                             
        <form class="border bg-light card p-2 text-dark p-3 w-25" method="post" action="join.jsp" onsubmit="return checkForm()">
            <div class="mb-3">
                <label for="joinId" class="form-label">아이디</label>
                <input id="joinId" class="form-control" type="text" name="id" placeholder="최소 6자를 입력하세요." onkeyup="checkId()"/>
                <p id="idMsg"></p>
            </div>
            <div class="mb-3">
                <label for="joinPassword" class="form-label">비밀번호</label>
                <input id="joinPassword" class="form-control" type="password" name="password" placeholder="영어와 숫자를 조합하여 최소 6자를 입력하세요." onkeyup="checkPassword()"/>
                <p id="passwordMsg"></p>
            </div>
            <div class="mb-3">
                <label for="joinNickname" class="form-label">닉네임</label>
                <input id="joinNickname" class="form-control" type="text" name="nickname"/>
            </div>
            <div class="mb-3">
                <label for="joinAddress" class="form-label">주소</label>
                <input id="joinAddress" class="form-control" type="text" name="address"/>
            </div>
            <div class="mb-3">
                <label for="joinPhone" class="form-label">핸드폰 번호</label>
                <input id="joinPhone" class="form-control" type="text" name="phone" onkeyup="checkPhone()"/>
                <p id="phoneMsg"></p>
            </div>
            <div class="mb-3">
                <label for="joinEmail" class="form-label">이메일</label>
                <input id="joinEmail" class="form-control" type="text" name="email" onkeyup="checkEmail()"/>
                <p id="emailMsg"></p>
            </div>
            <div class="text-end mb-3">
                <button type="button" id="sendButton" class="btn btn-outline-primary btn-sm" onclick="sendAuthToken()">인증 번호 전송</button>
            </div>
            <div class="mb-3 mb-3">
                <label for="joinAuthToken" class="form-label">이메일 인증 번호</label>
                <input id="joinAuthToken" class="form-control" type="text" name="emailAuthToken" disabled/>
                <p id="emailAuthMsg"></p>
            </div>
            <div class="text-end mb-3">
                <button type="button" id="checkButton" class="btn btn-outline-primary btn-sm" onclick="checkAuthToken()" disabled>인증 번호 확인</button>
            </div>
            <div class="text-end mb-3">
                <button type="submit" id="joinButton" class="btn btn-primary" disabled>회원가입</button>
            </div>
            <p id="msg"></p>
        </form>
    </div>
    <script>
		// 정규식
		// 아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자
	    const REG_ID = /^[a-z]+[a-z0-9]{5,19}$/g;
		// 비밀번호는 최소 6글자와 최소 하나의 영문자나 숫자를 포함해야 한다.
	    const REG_PASSWORD = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$/;
	    const REG_EMAIL = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i;
	    const REG_PHONE = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	    
 		// 유효성 검사
		function checkForm() {
			let msg = document.getElementById("msg");
			let idValue = document.querySelector("[name=id]").value;
		    let passwordValue = document.querySelector("[name=password]").value;
		    let nicknameValue = document.querySelector("[name=nickname]").value;
		    let addressValue = document.querySelector("[name=address]").value;
		    let phoneValue = document.querySelector("[name=phone]").value;
		    let emailValue = document.querySelector("[name=email]").value;
		    let emailAuthTokenValue = document.querySelector("[name=emailAuthToken]").value;
 			
		    if (idValue.trim() === ""
		        || passwordValue.trim() === ""
		        || nicknameValue.trim() === ""
		        || addressValue.trim() === ""
		        || phoneValue.trim() === ""
		        || emailValue.trim() === ""
		        || emailAuthTokenValue.trim() === "") {
		        msg.textContent = "작성하지 않은 칸이 존재합니다.";
		        return false;
		    }
		    msg.textContent = "";
		    
		    if (!checkSameId()) {
				alert('중복된 아이디입니다.');
				return false;
		    }
		    
		    if (!REG_ID.test(idValue)) {
		    	alert('아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.');
		    	return false;
		    }
		    
		    if (!REG_PASSWORD.test(passwordValue)) {
		        alert('비밀번호 입력 칸을 다시 확인해주세요.');
		        return false;
		    }
		    
		    if(!REG_PHONE.test(phoneValue)) {
		        alert('핸드폰 번호 입력 칸을 다시 확인해주세요.');
		        return false;
		    }
		    
		    if(!REG_EMAIL.test(emailValue)) {
		        alert('이메일 입력 칸을 다시 확인해주세요.');
		        return false;
		    }
		
		    return true;
		}
        
 		// 키보드 입력마다 아이디 유효성 검사
        function checkId() {
        	let idValue = document.querySelector("[name=id]").value;
            let idMsg = document.getElementById("idMsg");

            if (idValue.length < 6) {
                idMsg.textContent = "6글자 이상 입력하세요.";
                return;
            }

            if (idValue.length > 20) {
                idMsg.textContent = "아이디가 너무 깁니다.";
                return;
            }

            // ajax
            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    let data = xhr.responseText.trim();
                    if (data === 'none') {
                        idMsg.textContent = "";
                    } else if (data === 'exist') {
                        idMsg.textContent = "중복된 아이디 입니다.";
                    }
                }
            };

            xhr.open("GET", "idCheck.jsp?id=" + idValue);
            xhr.send();
        }

 		// 회원가입 버튼 누를 시 아이디 유효성
 		function checkSameId() {
			let result = false;
 			let idValue = document.querySelector("[name=id]").value;
 			// ajax
            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    let data = xhr.responseText.trim();
                    if (data === 'none') {
                    	result = true;
                    } else if (data === 'exist') {
                    	result = false;
                    }
                }
            };
            
            xhr.open("GET", "idCheck.jsp?id=" + idValue, false);
            xhr.send();
            return result;
 		}
 		
 		// 비밀번호 유효성 검사
        function checkPassword() {
        	let passwordValue = document.querySelector("[name=password]").value;
            let passwordMsg = document.getElementById("passwordMsg");

            if (passwordValue.length < 6) {
                passwordMsg.textContent = "6글자 이상 입력하세요.";
                return ;
            }
            if (!REG_PASSWORD.test(passwordValue)) {
                passwordMsg.textContent = "영어와 숫자를 조합하세요.";
                return ;
            }
            if (passwordValue.length > 20) {
                passwordMsg.textContent = "비밀번호가 너무 깁니다.";
                return ;
            }
            
            // 아무것도 해당 안되면 빈칸
            passwordMsg.textContent = "";
        }

        function checkPhone() {
        	let phoneValue = document.querySelector("[name=phone]").value;
            let phoneMsg = document.getElementById("phoneMsg");

            if (!REG_PHONE.test(phoneValue)) {
                phoneMsg.textContent = "알맞은 핸드폰 번호 양식이 아닙니다.";
                return ;
            }
            
         // 아무것도 해당 안되면 빈칸
            phoneMsg.textContent = "";
        }
        
        function checkEmail() {
        	let emailValue = document.querySelector("[name=email]").value;
			let emailMsg = document.getElementById("emailMsg");
			
			if (!REG_EMAIL.test(emailValue)) {
				emailMsg.textContent = "알맞은 이메일 주소 양식이 아닙니다.";
				return ;
			}
			
			// 아무것도 해당 안되면 빈칸
			emailMsg.textContent = "";
        }

        function sendAuthToken() {
        	let emailValue = document.querySelector("[name=email]").value;
        	if (!REG_EMAIL.test(emailValue)) {
				alert('올바른 이메일을 작성해주세요');
				return ;
			} else {
				// ajax
	            let xhr = new XMLHttpRequest();
	            xhr.onreadystatechange = function () {
	                if (xhr.readyState === 4 && xhr.status === 200) {
	    	        	document.getElementById("joinAuthToken").disabled = false;
	    	        	document.getElementById("checkButton").disabled = false;
	    	        	document.getElementById("joinEmail").readonly = true;
	    	        	document.getElementById("sendButton").disabled = true;
	                }
	            };

				xhr.open("GET", "join-form.jsp?requestEmail=" + emailValue);
				xhr.send();
<%
				// 처음 인증번호를 요청한 이메일
				String requestEmail = request.getParameter("requestEmail");
				if (requestEmail != null) {
					EmailAuth.sendEmail(requestEmail);
				}
%>
			}
        }
        
        function checkAuthToken() {
        	let emailAuthTokenValue = document.querySelector("[name=emailAuthToken]").value;
        	if (emailAuthTokenValue.length !== 6) {
				alert("입력한 인증번호가 6글자가 아닙니다.");
				return ;
        	} else {
        		// ajax
	            let xhr = new XMLHttpRequest();
        		// onload는 onreadystatechange의 하나의 트랜잭션
        		// onreadystatechange사용 시 readyState가 4가 될 때 까지 계속 alert("인증이 실패하였습니다. 다시 시도해주세요."); 실행됨
	            xhr.onload = function () {
	                if (xhr.status === 200) {
	                	let msg = xhr.responseText.trim();
	                	if (msg === "인증이 완료되었습니다.") {
	    	        		document.getElementById("joinAuthToken").disabled = true;
		    	        	document.getElementById("checkButton").disabled = true;
		    	        	document.getElementById("joinButton").disabled = false;
		    	        	alert(msg);
	                	} else {
	                		alert(msg);
	                	}
	                } else {
	                	alert("인증이 실패하였습니다. 다시 시도해주세요.");
	                }
	            };
			xhr.open("GET", "emailAuth.jsp?inputToken=" + emailAuthTokenValue + "&responseEmail=" + document.querySelector("[name=email]").value);
			xhr.send();
        	}
        }
    </script>
    <%@ include file="/common/footer.jsp" %>
</body>
</html>
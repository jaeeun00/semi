<%@page import="domain.user.dao.UserDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지 수정 폼</title>
<%@ include file="../common/common.jsp"%>
<style>
.subContent {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>

	<div class="container mt-4">
		<form action="updateUser.jsp" method="post" onsubmit="return checkForm()">
			<table class="table table-bordered">
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
				</colgroup>
<%
	UserDao userDao = new UserDao();
	User user = userDao.getUserByUserNo(USERNO);
%>
				<tbody>
					<tr>
						<th class="table-light text-center align-middle">아이디</th>
						<td class="align-middle">
						<input type="text" class="form-control" name="id" value="<%=user.getId() +"("+ user.getType() %>)" readonly></td>
						<th class="table-light text-center align-middle">이메일</th>
						<td class="align-middle">
						<input type="email" class="form-control" name="email" value="<%=user.getEmail() %>" readonly></td>
					</tr>
					<tr>
						<th class="table-light text-center align-middle">닉네임</th>
						<td class="align-middle">
						<input type="text" class="form-control" name="nickname" value="<%=user.getNickname() %>"></td>
						<th class="table-light text-center align-middle">핸드폰 번호</th>
						<td class="align-middle">
						<input type="tel" class="form-control" name="phone" value="<%=user.getPhone() %>">
						<p id="phoneMsg"></p></td>
					</tr>
					<tr>
						<th class="table-light text-center align-middle">가입 날짜</th>
						<td class="align-middle">
						<input type="text" class="form-control" value="<%=user.getCreatedDate() %>" readonly></td>
						<th class="table-light text-center align-middle">내 정보 최근 수정
							날짜</th>
<%
	if (user.getUpdatedDate() != null) {
%>
						<td class="align-middle"><input type="text" class="form-control" value="<%=user.getUpdatedDate() %>" readonly></td>
<%
	} else {
%>
						<td class="align-middle"><input type="text" class="form-control" value="-" readonly></td>
<%
	}
%>
					</tr>
					<tr>
						<th class="table-light text-center align-middle">주소</th>
						<td colspan="3" class="align-middle">
						<input type="text" class="form-control" name="address" value="<%=user.getAddress() %>"></td>
					</tr>
				</tbody>
			</table>
			<div class="text-center mt-3 mb-5">
				<button type="submit" class="btn btn-primary">수정</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
    const REG_PHONE = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
    
    function checkForm(){
    	let nicknameValue = document.querySelector("[name=nickname]").value;
    	let phoneValue = document.querySelector("[name=phone]").value;
    	let address = document.querySelector("[name=address]").value;
		if (nicknameValue.trim() === ""
			|| phoneValue.trim() === ""
			|| address.trim() === "") {
			alert('작성하지 않은 칸이 존재합니다.');
			return false;
		}
		
		if (!REG_PHONE.test(phoneValue)) {
			alert('알맞은 핸드폰 번호 양식이 아닙니다.');
			return false;
		}
		return true;
    }
    </script>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>
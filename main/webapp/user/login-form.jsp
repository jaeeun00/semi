<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/common/common.jsp" %>
    <title>세미 로그인 페이지</title>
</head>
<body>
    <%@ include file="/common/header.jsp" %>
   	<%
   		String error = request.getParameter("error");
   		if ("admin".equals(error)) {
   	%>
   		<script>
   			alert("관리자 전용 페이지입니다. 관리자 계정으로 로그인 후 이용해주세요.");
   		</script>
   	<%
   		}
   	%>
    <div class="d-flex justify-content-center login">
        <form class="border bg-light card p-2 text-dark p-3 w-25" method="post" action="login.jsp">
            <div class="mb-3">
                <label class="form-label" for="loginId">아이디</label>
                <input id="loginId" class="form-control" type="text" name="id" value=""/>
            </div>
            <div class="mb-3">
                <label for="loginPwd" class="form-label">비밀번호</label>
                <input id="loginPwd" class="form-control" type="password" name="password" value=""/>
            </div>
            <div class="text-end">
                <button type="submit" class="btn btn-primary">로그인</button>
            </div>
        </form>
    </div>
    <%@ include file="/common/footer.jsp" %>
</body>
</html>

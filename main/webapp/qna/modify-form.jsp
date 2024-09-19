<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-09-11
  Time: 오전 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
	<%@ include file="../common/common.jsp" %>
</head>
<body>
	<div><%@ include file="../common/header.jsp" %></div>
	
    <div class="container mb-3">
    	<h1 class="mb-3">문의사항 입력폼</h1>
    	
		<form class="border bg-light p-3" action="insert.jsp" method="post" onsubmit="disabledBtn()"> 
	    	<div class="row mb-3">
	        	<label class="form-label">제목</label>
	          	<input type="text" class="form-control" name="title" />
			</div>	
			<div class="row mb-3">          
	          <input type="hidden" name="category" value="1"> 
          	  <span>문의 종류: 1대1문의</span> 
			</div>
			<div class="row mb-3">
	          	<label class="form-label">내용</label>
	          	<textarea rows="10" class="form-control" name="content"></textarea>
	        </div>
	        <div class="text-end mb-3">
	        	<button type="submit" class="btn btn-primary" >등록</button>
	        	<a href="list.jsp" class="btn btn-secondary">취소</a>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		function disabledBtn() {
			let el = document.querySelector("form button[type=submit]");
			el.disabled = true;
		}
	</script>
	<div><%@ include file="../common/footer.jsp" %></div>
</body>
</html>

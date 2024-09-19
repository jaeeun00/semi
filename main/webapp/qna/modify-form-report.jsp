<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-09-12
  Time: 오전 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/common.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<div><%@ include file="../common/header.jsp" %></div>
<body>
	<div class="container mb-3">
    	<h1 class="mb-3">문의사항 입력폼</h1>
    	
		<form class="border bg-light p-3" action="insert.jsp" method="post"> 
	    	<div class="row mb-3">
	        	<label class="form-label">제목</label>
	          	<input type="text" class="form-control" name="title" />
			</div>	
			<div class="row mb-3">          
	          	 <input type="hidden" name="category" value="2"> 
          		  <span>문의 종류: 1대1문의</span> 
			</div>

            <div class="row" style="margin-bottom: 0;">
                <div class="col-4 ">
                    <label class="form-label">신고유저</label>
                   <input type="text" class="form-control" name="baduser" placeholder="신고유저 닉네임을 정확히 입력해주세요">
                </div>
            </div>
            
			<div class="row mb-3">
	          	<label class="form-label">내용</label>
	          	<textarea rows="10" class="form-control" name="content"></textarea>
	        </div>
	        <div class="text-end mb-3">
	        	<button type="submit" class="btn btn-primary">등록</button>
	        	<a href="list-report.jsp" class="btn btn-secondary">취소</a>
			</div>
		</form>
	</div>
	
	

<div><%@ include file="../common/footer.jsp" %></div>
</body>
</html>


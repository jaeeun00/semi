Created by IntelliJ IDEA.
User: jhta
Date: 2024-09-11
Time: 오후 4:56
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>insert-form</title>
    <%@ include file="../common/common.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<%
	int bookNo = 1000;

	
%>

<div class="container mt-4 mb-5">
    <div class="row mb-3">
    	<div class="col-12">
		    <h1>게시글 작성폼</h1>
    	</div>
    </div>
	
	<div class="row mb-3">
    	<div class="col-12">
		   <div class="card">
		   	<div class="card-header">판매할 책정보</div>
		   	<div class="card-body">
				<table class="table">
					<colgroup>
						<col width="15%">
						<col width="35%">
						<col width="15%">
						<col width="35%">			
					</colgroup>
					<tr>
						<th>번호</th>
						<td></td>
						<th>제목</th>
						<td></td>
					</tr>
					<tr>
						<th>저자</th>
						<td></td>
						<th>출판사</th>
						<td></td>
					</tr>
				</table>
		   	</div>
		   </div>
    	</div>
    </div>

	<div class="row mb-3">
		<div class="col-12">
		    <p>제목, 내용을 입력하고 게시글을 등록해보세요.</p>
		    <form class="border bg-light p-3" method="post" action="insert.jsp">
		    	<input type="hidden" name="bookNo" value="<%=bookNo%>">
		        <div class="mb-3">
		            <label class="form-label">제목</label>
		            <input type="text" class="form-control" name="title">
		        </div>       
		        <div class="mb-3">
		            <label class="form-label">가격</label>
		            <input type="text" class="form-control" name="price">
		        </div>
		        <div class="mb-3">
		            <label class="form-label">내용</label>
		            <textarea rows="7" class="form-control" name="content"></textarea>
		        </div>
		        <div class="text-end">
		            <button type="submit" class="btn btn-primary">등록</button>
		        </div>
		    </form>
		
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>

<script>

</script>
</body>
</html>

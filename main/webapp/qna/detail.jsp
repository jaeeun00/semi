<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-09-11
  Time: 오전 9:04
  To change this template use File | Settings | File Templates.
--%>
<%@page import="utils.Util"%>
<%@page import="domain.book.vo.Category"%>
<%@page import="domain.qna.vo.Qna"%>
<%@page import="domain.qna.dao.QnaDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상세보기</title>
<%@include file="../common/common.jsp"%>
</head>
<body>
<div><%@ include file="../common/header.jsp" %></div>

<% int userNo = (Integer) session.getAttribute("USERNO"); 

	int qnaNo = Integer.parseInt(request.getParameter("no"));

	QnaDao qnaDao = new QnaDao();
	Qna qna	 = qnaDao.getQnabyNo(qnaNo);
%>

<div class="container" id="divContents">
    <div class="row">
       <div class="col-12">
           <table class="table">
               <colgroup>
                   <col width="15%">
                   <col width="35%">
                   <col width="15%">
                   <col width="35%">
               </colgroup>
               <tbody>
               <tr>
                   <th>번호</th>
                   <td><%=qna.getNo() %></td>
                   <th>작성자</th>
                   <td><%=qna.getUser().getNickname() %></td>
               </tr>
<%
	if (qna.getCategoryNo() == 1) {
%>
               <tr>
                   <th>제목</th>
                   <td colspan="3"><%=qna.getTitle() %></td>
               </tr>
<% 
	} else { 
%>
               <tr>
                   <th>제목</th>
                   <td><%=qna.getTitle() %></td>
                   <th>신고 유저</th>
                   <td><%=qna.getBadUser().getNickname()%></td>
               </tr>
<%
	}
%>
               <tr>
                   <th>등록일</th>
                   <td><%=Util.formatFullDateTime(qna.getCreatedDate()) %></td>
                   <th>수정일</th>
                   <td><%=Util.formatFullDateTime(qna.getUpdatedDate()) %></td>
               </tr>
               <tr>
                   <th>내용</th>
                   <td colspan="12"><%=qna.getContent() %></td>
               </tr>
               </tbody>
           </table>

           <div class="text-end">
               <a href="modify-form.jsp?no=" class="btn btn-light">수정</a>
               <a href="delete.jsp?no=<%=qnaNo %>" class="btn btn-danger">삭제</a>
           </div>

           <div class="mb-3">
               <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="추가문의 사항이 있으시면 댓글을 작성해주세요">
               <div class="text-end">
                   <button type="submit" class="btn btn-primary btn-sm">등록</button>
               </div>
           </div>

       </div>

    </div>

</div>




<div><%@ include file="../common/footer.jsp" %></div>
</body>
</html>

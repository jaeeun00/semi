<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-09-12
  Time: 오전 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@page import="domain.qna.vo.Qna"%>
<%@page import="java.util.List"%>
<%@page import="domain.qna.dao.QnaDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>문의 게시판</title>
<%@ include file="../common/common.jsp" %>
</head>
<body>
<div><%@ include file="../common/header.jsp" %></div>

<%
    int userNo = (Integer) session.getAttribute("USERNO");

	QnaDao qnaDao = new QnaDao();
	List<Qna> qnalist = qnaDao.getQnaByUserNo(userNo);
%>
<div class="container" id="divContents">
  <div class="row">
    <div class="col-12">
      <h6 class="title1">문의 게시판</h6>
      <h3>신고</h3>
    </div>
    <div class="col-2">
      <ul class="categoryNavBar">
        <li><a href="list.jsp" class="btn btn">1대1문의</a></li>
        <li><a href="list-report.jsp" class="btn btn">신고</a></li>
      </ul>
    </div>
    <div class="col-10">
      <table class="table">
        <thead>
        	<tr>
	          <th>문의번호</th>
	          <th>문의제목</th>
	          <th>신고유저닉네임</th>
	          <th>등록일</th>
       	 </tr>
        </thead>
        <tbody>
<% for (Qna qna : qnalist) {   %>
	<% if (qna.getCategoryNo()== 2) { %>
                    <tr>
                        <td><%=qna.getNo()%></td>
                        <td><a href="detail.jsp?no=<%=qna.getNo()%>"><%=qna.getTitle()%></a></td>
                        <td><%=qna.getBadUser().getNickname() %></td>
                        <td><%=qna.getCreatedDate()%></td>
                    </tr>
    <% } %>   
<% } %>
        </tbody>
      </table>
      <div class="text-end">
        <a href="form-report.jsp" class="btn btn-outline-primary">글쓰기</a>
      </div>
    </div>
  </div>
</div>

<div><%@ include file="../common/footer.jsp" %></div>
</body>
</html>


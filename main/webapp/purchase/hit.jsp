<%@ page import="utils.Util" %>
<%@ page import="domain.purchase.dao.BoardDao" %>
<%@ page import="domain.purchase.vo.Board" %><%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-09-12
  Time: 오전 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    // 요청파라미터 값 조회하기
    int no = Util.toInt(request.getParameter("no"));
    int pageNo = Util.toInt(request.getParameter("page"));

    BoardDao boardDao = new BoardDao();
    Board board = boardDao.getBoardByNo(no);

    board.setViewCount(board.getViewCount() + 1);

    boardDao.updateBoard(board);

    response.sendRedirect("detail.jsp?no=" + no + "&page=" + pageNo);

%>
</body>
</html>

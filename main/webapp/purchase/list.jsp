<%@ page import="domain.purchase.vo.Board" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.Util" %>
<%@ page import="domain.purchase.dao.BoardDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="utils.Pagination" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Purchase</title>
    <%@ include file="../common/common.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<%
    int pageNo = Util.toInt(request.getParameter("page"), 1);

    BoardDao boardDao = new BoardDao();
    int totalRows = 0;

    try {
        totalRows = boardDao.getTotalRows();
    } catch (SQLException e) {
        e.printStackTrace(); // 예외 발생 시 콘솔에 출력
        // 예외 처리에 따른 로직을 추가할 수 있습니다.
        // 예를 들어, 에러 메시지를 사용자에게 표시하거나 기본값을 설정할 수 있습니다.
    }

    // 페이징처리에 필요한 정보를 제공하는 Pagination 객체를 생성한다.
    Pagination pagination = new Pagination(pageNo, totalRows);

    // 요청한 페이지번호에 맞는 조회범위의 게시글 목록을 조회한다.
    List<Board> boards = boardDao.getBoards(pagination.getBegin(), pagination.getEnd());

    // 전체 게시글 수와 현재 페이지의 시작 항목 번호를 이용해 내림차순 rowNumber를 계산
    int rowNumber = totalRows - pagination.getBegin() + 1;
%>

<div id="divContents">
    <div class="center container">
        <div class="subContent">
            <h6 class="title1">책 구매합니다 게시판</h6>
            <table class="table">
                <colgroup>
                    <col width="10%">
                    <col width="*">
                    <col width="15%">
                    <col width="10%">
                    <col width="10%">
                    <col width="15%">
                </colgroup>
                <caption>List of users</caption>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">제목</th>
                    <th scope="col">닉네임</th>
                    <th scope="col">조회수</th>
                    <th scope="col">좋아요</th>
                    <th scope="col">날짜</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Board board : boards) {
                %>
                <tr>
                    <th scope="row"><%= rowNumber-- %></th> <!-- 내림차순 출력 -->
                    <td><a href="hit.jsp?no=<%= board.getNo() %>&page=<%= pageNo %>"><%= board.getTitle() %></a></td>
                    <td><%= board.getUser().getNickname() %></td>
                    <td><%= Util.toCurrency(board.getViewCount()) %></td>
                    <td><%= Util.toCurrency(board.getLikeCount()) %></td>
                    <td><%= Util.formatDate(board.getCreatedDate()) %></td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <%
                if(pagination.getTotalRows() > 0) {
                    int beginPage = pagination.getBeginPage();
                    int endPage = pagination.getEndPage();
            %>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <li class="page-item <%=pagination.isFirst() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?page=<%=pagination.getPrev() %>">Previous</a></li>
                    <%
                        for (int num = beginPage; num <= endPage; num++) {
                    %>
                        <li class="page-item">
                            <a href="list.jsp?page=<%=num %>" class="page-link <%=pageNo == num ? "active" : "" %>">
                                <%=num %>
                            </a>
                        </li>
                    <%
                        }
                    %>
                    <li class="page-item <%=pagination.isLast() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?page=<%=pagination.getNext() %>">Next</a></li>
                </ul>
            </nav>
        </div>
        <%
            }
        %>
        <div class="text-end">
            <a href="../book/list.jsp" class="btn btn-primary">새 글</a>
        </div>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>

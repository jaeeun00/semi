<%@page import="java.util.List"%>
<%@page import="utils.Util"%>
<%@page import="utils.Pagination"%>
<%@page import="domain.purchase.vo.Board"%>
<%@page import="domain.purchase.dao.BoardDao"%>
<%@page import="domain.user.vo.User"%>
<%@page import="domain.user.dao.UserDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<%@ include file="../common/common.jsp"%>
<style>
.subContent {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.button-container {
	padding-left: 1100px;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container mt-4">
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
					<td class="align-middle"><%=user.getId() +"("+ user.getType() %>)</td>
					<th class="table-light text-center align-middle">이메일</th>
					<td class="align-middle"><%=user.getEmail() %></td>
				</tr>
				<tr>
					<th class="table-light text-center align-middle">닉네임</th>
					<td class="align-middle"><%=user.getNickname() %></td>
					<th class="table-light text-center align-middle">핸드폰 번호</th>
					<td class="align-middle"><%=user.getPhone() %></td>
				</tr>
				<tr>
					<th class="table-light text-center align-middle">가입 날짜</th>
					<td class="align-middle"><%=user.getCreatedDate() %></td>
					<th class="table-light text-center align-middle">내 정보 최근 수정 날짜</th>
<%
	if (user.getUpdatedDate() == null) {
%>
				<td class="align-middle">-</td>
<%
	} else {
%>
					<td class="align-middle"><%=user.getUpdatedDate() %></td>
<%
	}
%>
				</tr>
				<tr>
					<th class="table-light text-center align-middle">주소</th>
					<td colspan="3" class="align-middle"><%=user.getAddress() %></td>
				</tr>
			</tbody>
		</table>
		<div class="text-center mt-3 button-container">
			<a href="myPage-updateForm.jsp"><button type="submit" class="btn btn-primary">내 정보 수정</button></a>
		</div>
	</div>
	<div id="divContents">
		<div class="container">
			<div class="row g-4">
				<div class="col-md-6">
					<div class="subContent p-4 mb-4">
						<h6 class="mb-3 fw-bold">내가 작성한 구매합니다.</h6>
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">글 번호</th>
									<th scope="col">글 제목</th>
									<th scope="col">책 제목</th>
									<th scope="col">구매하고 싶은 가격</th>
								</tr>
							</thead>
<%
	BoardDao boardDao = new BoardDao();
	
	// 구매합니다 게시판 페이징 세팅
	int purchasePageNo = Util.toInt(request.getParameter("purchasePage"), 1);
	int purchaseTotalRow = boardDao.getTotalRowsByUserNo(USERNO);
	Pagination purchasePagination = new Pagination(purchasePageNo, purchaseTotalRow, 5, 5);
	
	List<Board> purchaseBoards = boardDao.getBoardsByUserNo(USERNO, purchasePagination.getBegin(), purchasePagination.getEnd());
	
	int purchaseRowNumber = purchaseTotalRow - purchasePagination.getBegin() + 1;
%>
							<tbody>
<%
	if (purchaseBoards.isEmpty()) {
%>
		<tr>
			<td colspan="4" class="text-center">작성한 구매 글이 없습니다.</td>
		</tr>
<%
	} else {
		
		for (Board board : purchaseBoards) {
%>
									<tr>
										<th scope="row"><%=purchaseRowNumber-- %></th>
										<td><a href="../purchase/hit.jsp?no=<%=board.getNo() %>"><%=board.getTitle() %></a></td>
										<td><%=board.getBook().getTitle() %></td>
										<td><%=board.getPrice() %></td>
		
									</tr>
<%
		}
	}
%>
							</tbody>
						</table>					
<%
	if(purchasePagination.getTotalRows() > 0) {
	    int purchaseBeginPage = purchasePagination.getBeginPage();
	    int purchaseEndPage = purchasePagination.getEndPage();
%>
						<nav aria-label="Page navigation">
							<ul class="pagination justify-content-center mt-3">
								<li class="page-item <%=purchasePagination.isFirst() ? "disabled" : "" %>">
								<a class="page-link" href="myPage.jsp?purchasePage=<%=purchasePagination.getPrev() %>">Previous</a></li>
<%
	for (int num = purchaseBeginPage; num <= purchaseEndPage; num++) {
%>
								<li class="page-item">
		                            <a href="myPage.jsp?purchasePage=<%=num %>" class="page-link <%=purchasePageNo == num ? "active" : "" %>">
		                                <%=num %>
		                            </a>
		                        </li>
<%
	}
%>
								<li class="page-item <%=purchasePagination.isLast() ? "disabled" : "" %>"><a class="page-link" href="myPage.jsp?purchasePage=<%=purchasePagination.getNext() %>">Next</a></li>
							</ul>
						</nav>
<%
	}
%>
					</div>
				</div>
				<div class="col-md-6">
					<div class="subContent p-4 mb-4">
						<h6 class="mb-3 fw-bold">내가 작성한 판매합니다.</h6>
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">글 번호</th>
									<th scope="col">글 제목</th>
									<th scope="col">책 제목</th>
									<th scope="col">판매하고 싶은 가격</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">1</th>
									<td>Mark</td>
									<td>Otto</td>
									<td>@mdo</td>
								</tr>
							</tbody>
						</table>
						<nav aria-label="Page navigation">
							<ul class="pagination justify-content-center mt-3">
								<li class="page-item"><a class="page-link" href="#">Previous</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">Next</a></li>
							</ul>
						</nav>
					</div>
				</div>
				<div class="col-md-6">
					<div class="subContent p-4 mb-4">
						<h6 class="mb-3 fw-bold">내가 작성한 문의 글</h6>
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">글 번호</th>
									<th scope="col">글 제목</th>
									<th scope="col">Last</th>
									<th scope="col">Handle</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">1</th>
									<td>Mark</td>
									<td>Otto</td>
									<td>@mdo</td>
								</tr>
							</tbody>
						</table>
						<nav aria-label="Page navigation">
							<ul class="pagination justify-content-center mt-3">
								<li class="page-item"><a class="page-link" href="#">Previous</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">Next</a></li>
							</ul>
						</nav>
					</div>
				</div>
				<div class="col-md-6">
					<div class="subContent p-4 mb-4">
						<h6 class="mb-3 fw-bold">내가 작성한 신고 글</h6>
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">글 번호</th>
									<th scope="col">글 제목</th>
									<th scope="col">Last</th>
									<th scope="col">내가 신고한 유저</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">1</th>
									<td>Mark</td>
									<td>Otto</td>
									<td>@mdo</td>
								</tr>
							</tbody>
						</table>
						<nav aria-label="Page navigation">
							<ul class="pagination justify-content-center mt-3">
								<li class="page-item"><a class="page-link" href="#">Previous</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">Next</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>
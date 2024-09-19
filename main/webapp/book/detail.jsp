<%@page import="utils.Pagination"%>
<%@page import="utils.Util"%>
<%@ page import="domain.book.dao.BookDao" %>
<%@ page import="domain.book.vo.Book" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title>도서 디테일</title>
	<%@ include file="/common/common.jsp" %>
</head>
<body>
<%@ include file="/common/header.jsp" %>
<%
    // 요청 파라미터 값을 조회한다.
    int bookNo = Util.toInt(request.getParameter("bookNo"));
    
    List<Book> books = null;
    BookDao bookDao = new BookDao();
    Book book = bookDao.getBookByNo(bookNo);
	
%>
<div id="divContents">
    <div class="center container">
    	<div class="subContent">
             <section class="bookList bookDetail">
             	<p class="fs-3 title">책 상세정보</p>
	          	<div class="card mb-3 book">
	                <div class="card-body row g-0">
	                    <div class="col-md-2">
	                        <img src="<%=book.getCover() %>" class="img-thumbnail bookImg" alt="<%=book.getTitle() %>">
	                    </div>
	                    <div class="col-md-10">
                           	<p class="card-title fs-4 mt-2"><%=book.getTitle() %></p>
                           	<p class="card-text"><span class="detailTitle">저자</span> <%=book.getAuthor() %></p>
                            <p class="card-text"><span class="detailTitle">분류</span> <%=book.getCategory().getName() %></p>
                            <p class="card-text"><span class="detailTitle">출판사</span> <%=book.getPublisher() %></p>
                            <p class="card-text"><span class="detailTitle">가격</span> <%=book.getPrice() %> 원</p>
                            <p class="card-text"><span class="detailTitle">발행일</span> <%=book.getDate() %></p>
                            
	                    </div>
	                </div>
	                <div class="card-footer text-muted">
				    	<div class="btn-group btn-group-small" role="group" aria-label="Basic example">
							<a href="/book/list.jsp?" class="btn btn-secondary">검색결과 돌아가기</a>
<!-- 							<a href="#" class="btn btn-secondary disabled">버튼1</a> -->
						</div>
				  </div>
	            </div>
	            <!-- 글 조회 여부 statusDiv -->
	            <section class="statusDiv">
	            	<!-- 해당 책으로 거래하는 글이 없는 경우 -->
	            	<div class="card border-info mb-3">
	            		<div class="card-body text-center">	            		
			            	<p class="card-text mt-1 mb-3">거래할 수 있는 중고 책이 존재하지 않습니다.</p>
		                 	<a href="/purchase/insert-form.jsp?bookNo=<%=book.getNo() %>" class="btn btn-sm btn-info">글 쓰러 가기</a>	            		
	            		</div>
	            	</div>
                 	
                 	<!-- 해당 책으로 거래하는 글이 있는 경우 -->
                 	<div class="d-flex flex-row-reverse mt-4">
	                 	<div class="btn-group" role="group" aria-label="Basic mixed styles example">
							<a href="/purchase/insert-form.jsp?bookNo=<%=book.getNo() %>" class="btn btn-primary">purchase 글쓰기</a>
							<a href="/sell/insert-form.jsp?bookNo=<%=book.getNo() %>" class="btn btn-outline-primary">sell 글쓰기</a>
						</div>
					</div>
                 	<div class="cardW d-flex flex-wrap">
	                 	<div class="card bg-light mb-3">
							<div class="card-header">가격 넣기</div>
							<div class="card-body">
							  <h5 class="card-title">글제목 넣기</h5>
							  <p class="card-text">본문 말줄임표 넣어서 추가</p>
							  <a href="" class="d-block mt-4 link-body-emphasis link-offset-2 link-underline-opacity-25 link-underline-opacity-75-hover">보러가기
							  	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-right" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M14 2.5a.5.5 0 0 0-.5-.5h-6a.5.5 0 0 0 0 1h4.793L2.146 13.146a.5.5 0 0 0 .708.708L13 3.707V8.5a.5.5 0 0 0 1 0z"/>
</svg> 
							  </a>
							</div>
						</div>
                 	</div>
	            </section>
	        </section>
		</div>
    </div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
</html>
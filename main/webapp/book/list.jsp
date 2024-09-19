<%@page import="utils.Pagination"%>
<%@page import="domain.book.vo.Category"%>
<%@page import="domain.book.dao.CategoryDao"%>
<%@page import="utils.Util"%>
<%@ page import="domain.book.dao.BookDao" %>
<%@ page import="domain.book.vo.Book" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title>도서 검색</title>
	<%@ include file="/common/common.jsp" %>
	<script>
		function getCategoryNo(event)  {
			let ctgr = 0;
			let radioId = event.target.id;
			ctgr = document.getElementById(radioId).value;
			
			document.querySelector("input[name=ctgr]").value = ctgr;
			document.querySelector("input[name=page]").value = 1;
			document.getElementById("hiddenForm").submit();
		}
	</script>
</head>
<body>
<%@ include file="/common/header.jsp" %>
<%
    // 요청 파라미터 값을 조회한다.
    String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword") ;

    int ctgr = Util.toInt(request.getParameter("ctgr"), 0);
    int pageNo = Util.toInt(request.getParameter("page"), 1);
	
    List<Book> books = null;
    BookDao bookDao = new BookDao();
    
	int totalRows = 0;
	Pagination pagination = null;
	
    if (ctgr == 0) {
	    totalRows = bookDao.getTotalRows(keyword);
		pagination = new Pagination(pageNo, totalRows);
	    books = bookDao.getBooksByBookTitle(keyword, pagination.getBegin(), pagination.getEnd());
	    System.out.println("(ctrg 0) 전체 책 개수 :" + totalRows);
    } else {
    	totalRows = bookDao.getRowsByKeyword(keyword, ctgr);
    	pagination = new Pagination(pageNo, totalRows);
		books = bookDao.getBooksByCategoryNo(keyword, ctgr, pagination.getBegin(), pagination.getEnd());		
		System.out.println("(ctgr != 0) 책 개수 :" + totalRows);
		
    }
    
    CategoryDao categoryDao = new CategoryDao();
    List<Category> categories = categoryDao.getCategories();
%>
<div id="divContents">
	<form action="list.jsp" id="hiddenForm">
		<input type="hidden" name="keyword" value="<%=keyword %>">
		<input type="hidden" name="page" value="<%=pageNo %>">
		<input type="hidden" name="ctgr" value="<%=ctgr %>">
	</form>
    <div class="center container">
    	<div class="subContent">
             <section class="flex bookListW">
                 <article class="sideBar">
                 	<div id="facetList">
					    <h3>상세 검색</h3>
					    <ul class="facetList">
					        <li>
					            <dl>
					                <dt>
					                    <span>카테고리별 조회</span>
					                </dt>
					                <dd>
					                    <ul>
					                        <li>
					                        	<input type="radio" name="ctgr" class="bookCtgr" id="radioCtgr0" value="0" checked onClick="getCategoryNo(event);">
					                            <label for="radioCtgr0">전체</label>
					                        </li>
<%
for(Category category : categories) {

%>					                        <li>
					                        	<input type="radio" name="ctgr" class="bookCtgr" id="radioCtgr<%=category.getNo()%>" value="<%=category.getNo()%>" onClick="getCategoryNo(event);" <%=category.getNo() == ctgr ? "checked" : "" %>>
					                            <label for="radioCtgr<%=category.getNo()%>">
					                            	<%=category.getName() %>
				                            	</label>
					                        </li>
<%
	}
%>
					                    </ul>
					                </dd>
					            </dl>
					        </li>
					    </ul>
					</div>
                 </article>
                 <section class="bookList">
<%
if(!books.isEmpty()) {
	for(Book book : books) {

%>
                   	<div class="card mb-3 book">
                         <div class="row g-0">
                             <div class="col-md-2">
                                <img src="<%=book.getCover() %>" class="img-thumbnail bookImg" alt="<%=book.getTitle() %>">
                             </div>
                             <div class="col-md-10">
                                 <div class="card-body">
                                     <a href="/book/detail.jsp?bookNo=<%=book.getNo() %>" 
                                     class="card-title ellipsis">
                                     	<%=book.getTitle() %>
										<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">
										  <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8"/>
										</svg>
                                   	</a>
                                    <div class="card-text">
	                                    <p class="middleText"><%=book.getAuthor() %></p>
	                                    <p class="text-body-secondary"><%=book.getPublisher() %></p>
	                                    <p class="text-body-secondary"><%=book.getPrice() %> 원</p>
	                                    <p class="text-body-secondary"><%=book.getDate() %></p>
	                                    <div class="bookStatus">
	                                    	<!-- sell 게시판 X -->
	                                    	<div class="sellY d-none">
	                                    		<p class="card-text mt-1">거래할 수 있는 중고 책이 존재하지 않습니다.</p>
	                                    		<a href="/purchase/insert-form.jsp?bookNo=<%=book.getNo() %>" class="btn btn-sm border-dark">글 쓰러 가기</a>
	                                    	</div>
	                                    	<!-- sell 게시판 O -->
	                                    	<div class="sellN">
	                                    		<p class="">
	                                    			가격 비교하기 
	                                    			<span class="bold">N</span>건 
	                                    			<svg xmlns="http://www.w3.org/2000/svg" width="8" height="8" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
	                                    				<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
                                    				</svg>
	                                    		</p>
	                                    		<ul class="card-text mt-1">
	                                    			<li>
		                                    			<a href="/sell/detail.jsp?bookNo=<%=book.getNo() %>" class="">
		                                    				bookNo말고 거기 primary key도 받아와야 함
		                                    			</a>
	                                    			</li>
                                    			</ul>
	                                    		<!-- <a href="/sell/list.jsp" class="btn btn-sm border-dark">판매 게시판 글 전체 보기</a> -->
	                                    	</div>
	                                    </div>
                                  </div>
                              	</div>
                             </div>
                         </div>
                     </div>
<%
	
	} 
	
	
	if (totalRows > 0) { 
		int beginPage = pagination.getBeginPage();
		int endPage = pagination.getEndPage();

%>
					<div>
						<ul class="pagination justify-content-center">
								<li class="page-item <%=pagination.isFirst() ? "disabled" : "" %>">
									<a href="list.jsp?keyword=<%=keyword %>&page=<%=pagination.getPrev() %>&ctgr=<%=ctgr %>" class="page-link">이전</a>
								</li>
<%
		for (int num = beginPage; num <= endPage; num++) {
%>
								<li class="page-item">
									<a href="list.jsp?keyword=<%=keyword %>&page=<%=num %>&ctgr=<%=ctgr %>" 
									class="page-link <%=pageNo == num ? "active" : "" %>" >
										<%=num %>
									</a>
								</li>
<%
		}
%>				
								<li class="page-item <%=pagination.isLast() ? "disabled" : "" %>">
									<a href="list.jsp?keyword=<%=keyword %>&page=<%=pagination.getNext() %>&ctgr=<%=ctgr %>" class="page-link">다음</a>
								</li>
							</ul>
					</div>
<%
	}
} else {
%>
					<div class="card book noData border-dark rounded text-center p-5 mb-2 w-100 h-100 justify-content-center">
						<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-box-seam" viewBox="0 0 16 16" style="margin: 0 auto;"><path d="M8.186 1.113a.5.5 0 0 0-.372 0L1.846 3.5l2.404.961L10.404 2zm3.564 1.426L5.596 5 8 5.961 14.154 3.5zm3.25 1.7-6.5 2.6v7.922l6.5-2.6V4.24zM7.5 14.762V6.838L1 4.239v7.923zM7.443.184a1.5 1.5 0 0 1 1.114 0l7.129 2.852A.5.5 0 0 1 16 3.5v8.662a1 1 0 0 1-.629.928l-7.185 2.874a.5.5 0 0 1-.372 0L.63 13.09a1 1 0 0 1-.63-.928V3.5a.5.5 0 0 1 .314-.464z"/></svg>
						<p class="mt-3">해당 조건의 도서를 조회할 수 없습니다.</p>
					</div>
<%
}
%>
                 </section>
             </section>
		</div>
    </div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
</html>
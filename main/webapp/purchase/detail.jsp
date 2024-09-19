<%@page import="domain.purchase.vo.Reply"%>
<%@page import="java.util.List"%>
<%@page import="domain.purchase.dao.ReplyDao"%>
<%@page import="domain.purchase.vo.Like"%>
<%@page import="domain.purchase.vo.Board"%>
<%@page import="domain.purchase.dao.BoardDao"%>
<%@page import="utils.Util"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/common.jsp" %>
<html>
<head>
    <title>구매글</title>
    <style>
        header { margin-bottom: 50px; }
        #cover-image-box {
            text-align: center;
        }
        #cover-image-box img {
            max-width: 100%; /* 이미지 크기를 적절히 조정 */
            height: auto;
        }
        .center-buttons {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .center-buttons button {
            margin: 0 5px; /* 버튼 사이에 5px 간격 추가 */
        }
    </style>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<%
    if(request.getParameter("error") != null) {
%>
    <div class="alert alert-danger">
        수정/삭제는 게시글 작성자만 가능합니다.
    </div>
<%
    }
%>

<%
    // 요청 파라미터 값 조회
    int no = Util.toInt(request.getParameter("no"));
    int pageNo = Util.toInt(request.getParameter("page"), 1);

    // 게시글 정보 조회
    BoardDao boardDao = new BoardDao();
    Board board = boardDao.getBoardByNo(no);
%>

<div class="container">
    <div class="row">
        <div class="col-12">
            <p class="text-end">
                조회수 <%= Util.toCurrency(board.getViewCount()) %>
                추천수 <%= Util.toCurrency(board.getLikeCount()) %>
            </p>
        </div>
        <div class="row">
            <!-- 이미지 영역 -->
            <div class="col-md-4" id="cover-image-box">
                <img src="<%= board.getBook().getCover() %>" alt="책 이미지">
            </div>

            <!-- 데이터 영역 -->
            <div class="col-md-8">
                <table class="table">
                    <colgroup>
                        <col width="15%">
                        <col width="35%">
                        <col width="15%">
                        <col width="35%">
                    </colgroup>
                    <tbody>
                    	<tr>
                    		<th>도서 정보</th>
                    	</tr>
                        <tr>
                            <th>도서명</th>
                            <td><%=board.getBook().getTitle() %></td>
                            <th>저자</th>
                            <td><%=board.getBook().getAuthor() %></td>
                        </tr>
                        <tr>
                            <th>출판사</th>
                            <td><%=board.getBook().getPublisher() %></td>
                            <th>판매가격</th>
                            <td><%=Util.toCurrency(board.getBook().getPrice()) %> 원</td>
                        </tr>
                    </tbody>
                </table>

                <table class="table">
                    <colgroup>
                        <col width="15%">
                        <col width="35%">
                        <col width="15%">
                        <col width="35%">
                    </colgroup>
                    <tbody>
                    	<tr>
                    		<th>입력 정보</th>
                    	</tr>
                        <tr>
                            <th>제목</th>
                            <td><%=board.getTitle() %></td>
                            <th>구매가격</th>
                            <td><%=Util.toCurrency(board.getPrice()) %> 원</td>
                        </tr>
                        <tr>
                            <th>등록일</th>
                            <td><%=Util.formatFullDateTime(board.getCreatedDate()) %></td>
                            <th>수정일</th>
                            <td><%=Util.formatFullDateTime(board.getUpdatedDate()) %></td>
                        </tr>
                        <!-- 상세 내용 추가 -->
                        <tr>
                            <th>상세내용</th>
                            <td colspan="3"><%=board.getContent() %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%--
		추천
			+ 로그인 후 가능하다.
			+ 이 게시글을 이미 추천한 사용자는 추천을 취소한다.
		
		수정/삭제
			+ 로그인 후 가능하다.
			+ 이 게시글의 작성자만 가능하다.
 	--%>
 	<%
 	// 게시글에 대한 수정/삭제 가능여부를 판정한다.
 	// 로그인되어 있고, 로그인한 사용자번호와 게시글의 작성자번호가
 	// 같은 때 true로 판정한다.
 	boolean canLike = false;
 	boolean showMyLike = false;
 	boolean canModify = false;
 	if (USERID != null) {
 		canLike = true;
 		int loginedUserNo = (Integer) session.getAttribute("USERNO");
 		// 로그인한 사용자가 이 게시글에 좋아요를 했는지 조회
 		Like savedLike = boardDao.getLikeByBoardNoAndUserNo(no, loginedUserNo);
 		if (savedLike != null) {
 			showMyLike = true;	// 이 게시글에 좋아요를 했다.
 		}
 		if (loginedUserNo == board.getUser().getUserNo()) {
 			canModify = true;
 		}
 	}
 	%>
 	<div>
	 	<%
			if (canModify) {
		%>
			<div class="text-end mt-3">
		        <a href="update-form.jsp?no=<%=board.getNo() %>" class="btn btn-secondary btn-sm">수정</a>
		        <a href="delete.jsp?no=<%=board.getNo() %>" class="btn btn-danger btn-sm">삭제</a>
		        <a href="list.jsp" class="btn btn-primary btn-sm">목록</a>
	    	</div>
		<% 
			} else {
		%>
			<div class="text-end mt-3">
		        <a href="update-form.jsp?no=<%=board.getNo() %>" class="btn btn-secondary btn-sm">수정</a>
		        <a href="delete.jsp?no=<%=board.getNo() %>" class="btn btn-danger btn-sm">삭제</a>
		        <a href="list.jsp" class="btn btn-primary btn-sm">목록</a>
	    	</div>
		<%
			}
		%>
		<div class="text-center mb-3">
	    <%
	        if (canLike) {
	    %>
	        <a href="like.jsp?no=<%=no %>&page=<%=pageNo %>" 
	            class="btn btn-outline-success position-relative">
	            추천
	            <i class="bi <%=showMyLike ? "bi-heart-fill" : "bi-heart" %>"></i>
	            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
	                <%=board.getLikeCount() %>
	            </span>
	        </a>
	        <a href="../qna/list-report.jsp" class="btn btn-outline-danger ms-2">신고</a>
	    <%
	        } else {
	    %>
	        <a href="#" class="btn btn-outline-secondary position-relative disabled">
	            추천
	            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
	                <%=board.getLikeCount() %>
	            </span>
	        </a>
	        <a href="../qna/list-report.jsp" class="btn btn-outline-danger ms-2">신고</a>
	    <%
	        }
	    %>
		</div>
	</div>
	<div class="row">
		<div class="col-12">
		<%
			if (USERID != null) {
		%>
				<form class="border bg-light p-3 mt-3" method="post" action="insert-reply.jsp">
					<input type="hidden" name="bno" value="<%=board.getNo() %>" />
					<div class="mb-3">
						<textarea rows="3" class="form-control" name="content"></textarea>
					</div>
					<div class="text-end">
						<button type="submit" class="btn btn-primary btn-sm">등록</button>
					</div>
				</form>
		<%
			}
		%>
		<%
			// 게시글의 댓글 조회하기
			ReplyDao replyDao = new ReplyDao();
			List<Reply> replyList = replyDao.getReplyListByBoardNo(board.getNo());
		%>
			<div class="mt-3">
				<%
					int userNo = -1;	// 로그인하지 않았다면 userNo는 -1이다.
					if (session.getAttribute("USERNO") != null) {
						userNo = (Integer) session.getAttribute("USERNO");
					}
					
					for(Reply reply : replyList) {
						boolean canReplyModify = false;
						if (userNo == reply.getUser().getUserNo()) {
							canReplyModify = true;
						}
				%>
					<div class="border p-2 mb-2">
						<div class="small d-flex justify-content-between">
						   <div>
						      <span><%=reply.getUser().getNickname() %></span>
						      <span><%=Util.formatFullDateTime(reply.getCreatedDate()) %></span>
						   </div>
						   <div>
						   <%
						   	if (canReplyModify) {
						   %>
						       <a href="delete-reply.jsp?rno=<%=reply.getNo() %>&bno=<%=board.getNo() %>&page=<%=pageNo %>" class="btn btn-outline-dark btn-sm">삭제</a>
						   <%
						   	} else {
						   %>
						       <a class="btn btn-outline-dark btn-sm disabled">삭제</a>
						   <%
						   	}
						   %>
						    </div>
						</div>
						<p class="mb-0"><%=reply.getContent() %></p>
			      	</div>
			<%
				}
	   		%>  
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>

<%@page import="domain.purchase.vo.Board"%>
<%@page import="domain.purchase.dao.BoardDao"%>
<%@page import="domain.purchase.vo.Reply"%>
<%@page import="domain.purchase.dao.ReplyDao"%>
<%@page import="utils.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 여부 확인하기
	if (session.getAttribute("USERNO") == null) {
		response.sendRedirect("/user/login0.jsp?error=notLoggedIn");
		return;
	};
	
	// 로그인한 사용자번호 조회하기
	int userNo = (Integer) session.getAttribute("USERNO");
	
	// 요청처리에 필요한 값  수집하기
	int replyNo = Util.toInt(request.getParameter("rno"));
	int boardNo = Util.toInt(request.getParameter("bno"));
	int pageNo = Util.toInt(request.getParameter("page"));
	
	ReplyDao replyDao = new ReplyDao();
	Reply reply = replyDao.getReplyByNo(replyNo);
	
	// 댓글 작성자와 로그인한 사용자가 동일인이면 댓글을 삭제한다.
	if(reply.getUser().getUserNo() == userNo) {
		// 댓글을 삭제한다.
		replyDao.deleteReplyByNo(replyNo);
		
		BoardDao boardDao = new BoardDao();
		Board board = boardDao.getBoardByNo(boardNo);
		
		boardDao.updateBoard(board);
	}
	
	// 게시글 상세정보를 요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("detail.jsp?no=" + boardNo + "&page=" + page);
	
	
	
	
	
	
	
%>
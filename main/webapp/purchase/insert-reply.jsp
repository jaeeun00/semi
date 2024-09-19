<%@page import="domain.purchase.dao.BoardDao"%>
<%@page import="domain.purchase.dao.ReplyDao"%>
<%@page import="domain.user.vo.User"%>
<%@page import="domain.purchase.vo.Board"%>
<%@page import="domain.purchase.vo.Reply"%>
<%@page import="utils.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("USERNO") == null) {
		response.sendRedirect("/user/login-form.jsp?error=notLoggedIn");
		return;
	}
	
	int userNo = (Integer) session.getAttribute("USERNO");
	int boardNo = Util.toInt(request.getParameter("bno"));
	String content = request.getParameter("content");	

	Reply reply = new Reply();
	reply.setContent(content);
	
	int parentNo = Util.toInt(request.getParameter("parentNo"), 0);  // 0은 최상위 댓글을 의미함
	reply.setParent_no(parentNo);
	
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.getBoardByNo(boardNo);
	reply.setBoard(board);
	
	User user = new User();
	user.setUserNo(userNo);
	reply.setUser(user);
	
	ReplyDao replyDao = new ReplyDao();
	replyDao.insertReply(reply);
	
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?no=" + boardNo);
	
	
%>
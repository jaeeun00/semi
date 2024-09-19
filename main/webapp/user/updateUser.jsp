<%@page import="domain.user.vo.User"%>
<%@page import="domain.user.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int userNo = (Integer) session.getAttribute("USERNO");
	String nickname = request.getParameter("nickname");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	UserDao userDao = new UserDao();
	User user = new User();
	
	user.setUserNo(userNo);
	user.setNickname(nickname);
	user.setPhone(phone);
	user.setAddress(address);
	
	userDao.updateUser(user);
	
	response.sendRedirect("myPage.jsp");
%>
<%@ page import="domain.user.vo.User" %>
<%@ page import="domain.user.dao.UserDao" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // 회원가입 폼에서 입력한 값 받아오기
  String id = request.getParameter("id");
  String rawPassword = request.getParameter("password");
  String encodedPassword = DigestUtils.sha256Hex(rawPassword);
  String nickname = request.getParameter("nickname");
  String address = request.getParameter("address");
  String phone = request.getParameter("phone");
  String email = request.getParameter("email");

  // 받아온 값으로 user 생성
  User user = new User();
  user.setId(id);
  user.setPassword(encodedPassword);
  user.setNickname(nickname);
  user.setAddress(address);
  user.setPhone(phone);
  user.setEmail(email);

  UserDao userDao = new UserDao();

  // user객체로 회원가입
  userDao.join(user);

  // 회원가입이 완료되면 메인 페이지로
  response.sendRedirect("../index.jsp");
%>
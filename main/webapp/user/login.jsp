<%@ page import="domain.user.dao.UserDao" %>
<%@ page import="domain.user.vo.User" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 이미 로그인이 되어있는 상황일 때, 메인 페이지로 이동한다.
    String USERID = (String) session.getAttribute("USERID");
    if (USERID != null && !USERID.isEmpty()) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // 입력한 아이디와 비밀번호를 받는다.
    String id = request.getParameter("id");
    String rawPassword = request.getParameter("password");

    // 입력한 비밀번호를 암호화한다.
    String encodedPassword = DigestUtils.sha256Hex(rawPassword);

    // 입력한 아이디와 암호화된 비밀번호로 그 유저에 대한 모든 정보를 가져온다.
    UserDao userDao = new UserDao();
    User user = userDao.getUserByIdPassword(id, encodedPassword);

    // 입력한 아이디와 비밀번호와 일치하는 계정이 존재하지 않을 때, 로그인 폼 페이지로 이동한다.
    if (user == null) {
        response.sendRedirect("login-form.jsp");
        return;
    }

    // 가져온 유저 정보를 세션에 넣는다.
    session.setAttribute("USERNO", user.getUserNo());
    session.setAttribute("USERID", user.getId());
    session.setAttribute("USERNICKNAME", user.getNickname());
    session.setAttribute("USERTYPE", user.getType());

    // 관리자라면 관리자의 메인페이지로
   	if (user.getType().equals("ADMIN")){
   		response.sendRedirect("../admin/index.jsp");
   		return;
   	}
    
    // 정상적으로 로그인이 되면 메인페이지로
    response.sendRedirect("../index.jsp");
%>
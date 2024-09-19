<%@page import="domain.user.vo.User"%>
<%@page import="java.util.List"%>
<%@page import="domain.admin.dao.AdminDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 메인 페이지</title>
    <%@ include file="../common/common.jsp" %>
<style>
    .sidebar {
        background-color: #000; 
        color: white; 
        height: 100vh; 
    }
    .sidebar .nav-link {
        color: white; 
        padding: 10px 15px;
        text-decoration: none; 
        transition: background-color 0.3s;
    }
    .sidebar .nav-link:hover {
        background-color: #444; 
    }
    .btn-danger {
        background-color: #dc3545; 
        border-color: #dc3545; 
    }
    .card-text {
    	font-size: 20px;
    }
    table {
    	font-weight: bold;
    }
</style>
</head>
<body>
<%
	// user/login.jsp에서 세션에서 USERID, USERNICKNAME, USERTYPE를 가져온다.
	// 저장된 상태로 admin/index.jsp로 전달된다.
	String userId = (String)session.getAttribute("USERID");
	String userNickName = (String)session.getAttribute("USERNICKNAME");
	String userType = (String)session.getAttribute("USERTYPE");
	
	// 만약에 userType이 "null"이거나 ADMIN이 아니면 관리자로 로그인 된 것이 아니니 
	// 바로 ../user/login-form.jsp로 돌려보낸다.
	if (userType == null || !userType.equals("ADMIN")) {
		response.sendRedirect("../user/login-form.jsp?error=admin");
		return;
	}
%>
		
<!-- 
	관리자의 메인 페이지에서 필요한 데이터
	: 사이트의 총 회원수, 사이트의 총 도서수, 사이트의 총 조회수
	  , 사이트의 총 게시글 수
	  
	: 관리자의 이름, 이메일, 연락처
 -->
 
<%
	// DB 엑세스를 위해 AdminDao 객체를 생성한다.
	AdminDao adminDao = new AdminDao();
%>
<div class="d-flex">
    <div class="sidebar p-3" style="background-color: #808080; color:white;">
        <div class="d-flex align-items-center mb-4">
            <svg xmlns="http://www.w3.org/2000/svg" width="56" height="56" fill="currentColor" class="bi bi-person-gear" viewBox="0 0 16 16">
  <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4m.256 7a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1zm3.63-4.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382zM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0"></path>
</svg>
            <span>admin</span>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="/admin/qna-management/list.jsp">
                	 문의/신고 관리하기
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/member-management/list.jsp">
                	회원 관리하기
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/statistics-management/list.jsp">
                	사이트 통계 확인하기
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/index.jsp">
                	사이트 홈으로 이동하기
                </a>
            </li>
        </ul>
        <div class="mt-auto">
            <a class="btn btn-danger w-100" href="../user/logout.jsp" style="color: white;">로그아웃</a>
        </div>
    </div>
    
    <div class="main-content p-3 flex-grow-1 text-center">
		
		<h3 style="text-align: left;"><%=userNickName %> 관리자님 환영합니다.</h3>
		<br />
		<div class="row">
    		<div class="col-md-6">
        		<div class="card mb-3">
            		<div class="card-body">
                		<h5 class="card-title"><mark>사이트 총 회원수</mark></h5>
                			<h6 class="card-text"><strong><%=adminDao.countTotalMembersInBookstore() %> 명</strong></h6>
            		</div>
        		</div>
    		</div>
        		
        	<div class="col-md-6">
            	<div class="card mb-3">
                	<div class="card-body">
                    	<h5 class="card-title"><mark>사이트에 등록된 총 도서수</mark></h5>
                    		<h6 class="card-text"><strong><%=adminDao.countTotalBooksInBookstore() %> 권</strong></h6>
               		</div>
            	</div>
        	</div>
        		
        	<div class="col-md-6">
           		<div class="card mb-3">
                	<div class="card-body">
                    	<h5 class="card-title"><mark>사이트 게시글의 총 조회수</mark></h5>
                    		<h6 class="card-text"><strong><%=adminDao.countTotalViewsInPurchaseBoards()+adminDao.countTotalViewsInSellBoards() %> 회</strong></h6>
                	</div>
            	</div>
        	</div>
    		
    		<div class="col-md-6">
           		<div class="card mb-3">
                	<div class="card-body">
                    	<h5 class="card-title"><mark>사이트 총 게시글수</mark></h5>
                    		<h6 class="card-text"><strong><%=adminDao.countTotalPostsInPurchaseBoards()+adminDao.countTotalPostsInSellBoards() %> 개</strong></h6>
                	</div>
            	</div>
        	</div>
    	</div>
	
    <h2 style="text-align: left;">관리자 비상 연락망</h2>
    <br/>
    <table class="table table-info table-bordered" style="width: 70%;">
        <thead class="table-light">
            <tr>
                <th>아이디</th>
                <th>닉네임</th>
                <th>이메일</th>
                <th>연락처</th>
            </tr>
        </thead>
        <tbody class="table-group-divider">
<%
	// DB에서 모든 관리자를 조회한다.
	List<User> users = adminDao.getAllAdministrator();
%>
<%
	for (User user : users) {
%>
            <tr>
                <td><%=user.getId() %></td>
                <td><%=user.getNickname() %></td>
                <td><%=user.getEmail() %></td>
                <td><%=user.getPhone() %></td>
            </tr>
<%
	}
%>
        </tbody>
    </table>
    
	</div>
</div>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
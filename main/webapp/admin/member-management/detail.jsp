<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 관리 페이지</title>
    <%@ include file="../../common/common.jsp" %>
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
</style>
<body>
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
                	 1:1 문의 관리하기
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/report-management/list.jsp">
                 	신고 내역 관리하기
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/member-management/list.jsp">
                	회원 관리하기
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/statistics-management/list.jsp" style="display: none;">
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
    	<h1>회원 정보 상세보기</h1>
    	<br/>
    	
    	<table class="table table-bordered">
    			<tr>
    				<th scope="col" class="text-center">유저 번호</th>
    				<td>1</td>
					<th scope="col" class="text-center">유저 아이디</th>
					<td>홍길동</td>
				</tr>
				<tr>
					<th scope="col" class="text-center">유저 닉네임</th>
					<td>hong</td>
					<th scope="col" class="text-center">유저 이메일</th>
					<td>hong@naver.com</td>
				</tr>
				<tr>
					<th scope="col" class="text-center">유저 연락처</th>
					<td>010-1111-1111</td>
					<th scope="col" class="text-center">유저 주소</th>
					<td>경기도 하남시 아파트</td>
				</tr>
				<tr>
					<th scope="col" class="text-center">가입일자</th>
					<td>2024/01/11</td>
					<th scope="col" class="text-center">작성한 게시글 수</th>
					<td>117</td>
				</tr>
				<tr>
					<th scope="col" class="text-center">작성한 댓글 수</th>
					<td>21</td>
					<th scope="col" class="text-center">신고 누적 횟수</th>
					<td>3</td>
    			</tr>
    			<tr>
    				<th scope="col" class="text-center">활성화 여부</th>
    				<td>활성화</td>
    				<th scope="col" class="text-center">사용자 타입</th>
    				<td>사용자</td>
    			</tr>
    	</table>
    	
    <div class="float-end">
    <!-- 
    	활성화, 비활성화
    	관리자로 변경, 이용자로 변경은 조건부로 하나만 보이도록
     -->
    	<a href="update-form.jsp?id=xxx" class="btn btn-success text-white">활성화</a>
    	<a href="update-form.jsp?id=xxx" class="btn btn-danger text-white">비활성화</a>
		<a href="update-form.jsp?id=xxx" class="btn btn-info text-white">관리자로 변경</a>
		<a href="update-form.jsp?id=xxx" class="btn btn-info text-white">이용자로 변경</a>
		<a href="list.jsp" class="btn btn-primary text-white">목록</a>
	</div>
    </div>
    
</div>
<%@ include file="../../common/footer.jsp" %>
</body>
</html>
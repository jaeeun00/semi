<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
  <%@ include file="common/common.jsp" %>
</head>
<body>
<%@ include file="common/header.jsp" %>
<div id="divContents">
  <div class="center container">
    <section class="row g-2">
      <div class="content col-6">
        <table class="table table-hover">
        </table>

      </div>
      <div class="content col-6">
        <!-- table content-->
        <div class="subContent">
          <h6 class="title1">테이블 제목 작성란</h6>
          <table class="table">
            <caption>List of users</caption>
            <thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">First</th>
              <th scope="col">Last</th>
              <th scope="col">Handle</th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <th scope="row">1</th>
              <td>Mark</td>
              <td>Otto</td>
              <td>@mdo</td>
            </tr>
            <tr>
              <th scope="row">2</th>
              <td>Jacob</td>
              <td>Thornton</td>
              <td>@fat</td>
            </tr>
            <tr>
              <th scope="row">3</th>
              <td>Larry</td>
              <td>the Bird</td>
              <td>@twitter</td>
            </tr>
            </tbody>
          </table>
          <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
              <li class="page-item"><a class="page-link" href="#">Previous</a></li>
              <li class="page-item"><a class="page-link" href="#">1</a></li>
              <li class="page-item"><a class="page-link" href="#">2</a></li>
              <li class="page-item"><a class="page-link" href="#">3</a></li>
              <li class="page-item"><a class="page-link" href="#">Next</a></li>
            </ul>
          </nav>
        </div>
        <!-- // table -->
      </div>
      <div class="content col-6">
        <table class="table table-hover">
        </table>

      </div>
      <div class="content col-6">
        <!-- form -->
        <!-- https://getbootstrap.com/docs/5.3/forms/form-control/ -->
        <div class="subContent">
          <h6 class="title1">폼태그 제목 작성란</h6>
          <!-- each form -->
          <div class="row g-3 mb-3 align-items-center">
            <div class="col-auto">
              <label for="" class="col-form-label">Password</label>
            </div>
            <div class="col-auto">
              <input type="password" id="" class="form-control">
            </div>
            <div class="col-auto">
                  <span id="" class="form-text">
                    Must be 8-20 characters long.
                  </span>
            </div>
          </div>
          <!-- // each form -->
        </div>
        <!-- // form -->

      </div>
    </section>
  </div>
</div>
<%@ include file="common/footer.jsp" %>
</body>
</html>
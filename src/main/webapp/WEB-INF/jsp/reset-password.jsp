<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"></jsp:include>
<body>
<jsp:include page="banner.jsp"></jsp:include>
<%
	String message = (String)request.getAttribute("message");
	String method = (String)request.getAttribute("method");
	String contextPath = request.getContextPath();
	String pathInfo = (String)request.getAttribute("pathInfo");
%>
<div class="container">
	<c:if test="${requestScope.method == 'post' }">
		<div message="${requestScope.message }" id="checkValid"></div>
	</c:if>
	<c:if test="${requestScope.method == 'get' }">
<div class="col-md-4 col-md-offset-4 center">
	<h1>Reset Password</h1>
	<p>Please fill in this form to reset your password.</p>
	<hr>
  <form:form class="form-horizontal center" action="${pageContext.request.contextPath}/account/forgot-password/reset-password/${requestScope.pathInfo}" method="post" modelAttribute="account">
    <div class="form-group">
      <label class="control-label col-sm-5" for="pwd">New Password:</label>
      <div class="col-sm-10">          
        <form:input path="password" type="password" class="form-control" id="pwd" placeholder="Enter password" name="password" required="required"/>
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default">Submit</button>
      </div>
    </div>
  </form:form>
  </div>
  </c:if>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"></jsp:include>
<body>
<jsp:include page="banner.jsp"></jsp:include>
<div class="container">
<c:set var = "message" value="default" scope="page" ></c:set>
<c:if test="${not empty requestScope.message}">
	<c:set var = "message" value="${requestScope.message}" scope="page" ></c:set>	
</c:if>
<div message="${message}" id="checkValid">
<c:if test="${message == 'Your account wasn\\'t verified'}">
	<a href="${pageContext.request.contextPath}/account/register/get-verification">Click here to get a verified link!</a>
</c:if>
</div>
<div class="col-md-4 col-md-offset-4">
  <form:form class="form-horizontal center" action="${pageContext.request.contextPath}/doLogin" method="post" modelAttribute="account">
    <div class="form-group">
      <label class="control-label col-sm-2" for="email">Email:</label>
      <div class="col-sm-10">
        <form:input path="email" type="email" class="form-control" id="email" placeholder="Enter email" name="email" value="${email}" required="required"/>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd">Password:</label>
      <div class="col-sm-10">          
        <form:input path="password" type="password" class="form-control" id="pwd" placeholder="Enter password" name="password" required="required"/>
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <div class="checkbox">
          <label><input type="checkbox" name="remember"> Remember me</label>
        </div>
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default">Submit</button>
      </div>
    </div>
  </form:form>
  </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
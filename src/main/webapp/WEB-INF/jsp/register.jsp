<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"></jsp:include>
<body>
	<jsp:include page="banner.jsp"></jsp:include>
<c:set var="message" value="default"></c:set>
<c:if test="${not empty requestScope.message}">
	<c:set var="message" value="${requestScope.message}"></c:set>
</c:if>
	<div class="container">
		<div message="${message }" id="checkValid"></div>
		<div class="col-md-4 col-md-offset-4">
			<h1>Sign Up</h1>
			<p>Please fill in this form to create an account.</p>
			<hr>
			<form:form class="form-horizontal center" action="${pageContext.request.contextPath}/account/doRegister" method="post" modelAttribute="account" >
				<div class="form-group">
					<label class="control-label col-sm-6" for="name">Your Name:</label>
					<div class="col-sm-10">
						<form:input path="name" type="name" class="form-control" id="name"
							placeholder="Enter your name" name="name" required="required" value="${requestScope.account.name }" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="email">Email:</label>
					<div class="col-sm-10">
						<form:input path="email" type="email" class="form-control" id="email"
							placeholder="Enter email" name="email" value="${requestScope.account.email }" required="required"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd">Password:</label>
					<div class="col-sm-10">
						<form:input path="password" type="password" class="form-control" id="pwd"
							placeholder="Enter password" name="password" required="required"/>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<p>
							By creating an account you agree to our <a href="#"
								style="color: dodgerblue">Terms & Privacy</a>.
						</p>
						<a href="${pageContext.request.contextPath}/account/register/get-verification" style="color: dodgerblue">Don't Get Verification Link ?</a>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default">Register</button>
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
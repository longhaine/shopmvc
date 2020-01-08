<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"></jsp:include>
<body>
<c:set var="message" value="default" scope="page"></c:set>
<c:if test="${not empty requestScope.message }">
	<c:set var="message" value="${requestScope.message}" scope="page"></c:set>
</c:if>
<jsp:include page="banner.jsp"></jsp:include>
	<c:if test="${path == 'your-info' }">
	<div class="checkout_area section-padding-80">
		<div class="container">
			<div id="checkValid" message="${message}"></div>
			<div class="row">
				<div class="col-12 col-md-6">
					<div class="checkout_details_area mt-50 clearfix">
						<div class="cart-page-heading mb-30">
							<h5>Billing Address</h5>
						</div>
						<form:form name = "your-info" action="${pageContext.request.contextPath}/account/doYour-info" method="post" modelAttribute="account">
							<div class="row">
								<div class="col-12 mb-3">
									<label for="your_name">Your Name <span>*</span></label> <form:input path="name" 
										type="text" class="form-control" id="yourname" value="${account.name}" name="name"
										required="required" />
								</div>

								<div class="col-12 mb-3">
									<label for="address">Address<span>*</span></label> <form:input path="address"
										type="text" class="form-control" id="address" value="${account.address}"
										required="required" name="address"/>
								</div>

								<div class="col-12 mb-3">
									<label for="phone_number">Phone No <span>*</span></label> <form:input path ="phone"
										type="number" class="form-control" id="phone_number" min="0"
										value="${account.phone }" name="phone"/>
								</div>
							    <div class="form-group">        
							      <div class="col-sm-offset-2 col-sm-10">
							        <button type="submit" class="btn btn-default">Submit</button>
							      </div>
							    </div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>
	<c:if test="${path == 'change-pass' }">
	<div class="checkout_area section-padding-80">
		<div class="container">
			<div id="checkValid" message="${message }"></div>
			<div class="row">
				<div class="col-12 col-md-6">
					<div class="checkout_details_area mt-50 clearfix">
						<div class="cart-page-heading mb-30">
							<h5>Change Password</h5>
						</div>
						<form name ="change-pass" action="${pageContext.request.contextPath}/account/doChange-pass" method="post">
							<div class="row">
								<div class="col-12 mb-3">
									<label for="currentpassword">Current Password <span>*</span></label> <input
										type="password" class="form-control" id="currentpassword" value="" name="currentpassword"
										required/>
								</div>
								<div class="col-12 mb-3">
									<label for="newpassword">New Password <span>*</span></label> <input
										type="password" class="form-control" id="newpassword" value="" name="newpassword"
										required>
								</div>								
							    <div class="form-group">        
							      <div class="col-sm-offset-2 col-sm-10">
							        <button type="submit" class="btn btn-default">Submit</button>
							      </div>
							    </div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
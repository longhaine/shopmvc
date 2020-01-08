<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"></jsp:include>
<body>
<jsp:include page="banner.jsp"></jsp:include>
<c:set var="message" value="default"></c:set>
<c:if test="${not empty requestScope.message }">
	<c:set var="message" value="${requestScope.message }"></c:set>
</c:if>
<c:set var="readonly" value ="false"></c:set>
<c:if test="${requestScope.inCase == 'account' }">
	<c:set var="readonly" value ="true"></c:set>
</c:if>
<c:set var="totalPrice" value="0.0"></c:set>
   <!-- ##### Breadcumb Area Start ##### -->
    <div class="breadcumb_area bg-img" style="background-image: url(img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="page-title text-center">
                        <h2>Checkout</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Checkout Area Start ##### -->
    <div class="checkout_area section-padding-80">
        <div class="container">
            <div class="row">
                <div class="col-12 col-md-6">
                    <div class="checkout_details_area mt-50 clearfix">

                        <div class="cart-page-heading mb-30">
                            <h5>Billing Address</h5>
                        </div>

                        <form:form action="${pageContext.request.contextPath}/cart/doCheckout" method="post" modelAttribute="account">
                            <div class="row">
                                <div class="col-12 mb-3">
                                    <label for="yourname">Your Name <span>*</span></label>
                                    <form:input path="name" type="text" class="form-control" id="yourname" name="name" value="${account.name}" required="required" readonly="${readonly }"/>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="street_address">Address <span>*</span></label>
                                    <form:input path="address" type="text" class="form-control mb-3" id="street_address" name="address" value="${account.address}" required="required" readonly="${readonly }"/>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="phone_number">Phone No <span>*</span></label>
                                    <form:input path="phone" type="number" class="form-control" id="phone_number" min="0" name="phone" value="${account.phone}"  required="required" readonly="${readonly }"/>
                                </div>
                                <div class="col-12 mb-4">
								<c:if test="${requestScope.inCase == 'account' }">
                                    <span><a href="${pageContext.request.contextPath}/account/your-info">Edit your info here !</a></span>
                                </c:if>
                                	<input type="submit" class="btn essence-btn pull-right" value="Place Order">
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-5 ml-lg-auto">
                    <div class="order-details-confirmation">

                        <div class="cart-page-heading">
                            <h5>Your Order</h5>
                            <p>The Details</p>
                        </div>

                        <ul class="order-details-form mb-4">
                            <li><span>Product</span> <span>Total</span></li>
							<c:forEach var="cart" items="${sessionScope.cartList }">
                            <li id="checkoutc${cart.id }" price="${cart.price }"><span>${cart.name }</span> <span>$${cart.price }</span></li>
                            <c:set var="totalPrice" value="${totalPrice + cart.price}"></c:set>
                            </c:forEach>
                            <li><span>Subtotal</span> <span>$<fmt:formatNumber value="${totalPrice }" maxFractionDigits="2" /></span></li>
                            <li><span>Shipping</span> <span>Free</span></li>
                            <li><span>Total</span> <span>$<fmt:formatNumber value="${totalPrice }" maxFractionDigits="2" /></span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Checkout Area End ##### -->
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
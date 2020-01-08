<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"></jsp:include>
<body>
<jsp:include page="banner.jsp"></jsp:include>
<c:set var = "message" value="default" scope="page"></c:set>
<c:if test="${not empty requestScope.message }">
	<c:set var="message" value="${requestScope.message }" scope="page"></c:set>
</c:if>
<c:set var = "orderCount" value="0" scope="page"></c:set>
<c:if test="${not empty requestScope.orderList }">
	<c:set var="orderCount" value="${requestScope.orderList.size()}" scope="page"></c:set>
</c:if>
<c:set var = "pageParameter" value="${param.page }" scope="page"></c:set>
<c:if test="${empty param.page }">
	<c:set var="pageParameter" value="1" scope="page"></c:set>
</c:if>
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
				<div id="checkValid" message="${message }"></div>            
                <div class="col-12 col-md-6">
                    <div class="checkout_details_area mt-50 clearfix">

                        <div class="cart-page-heading mb-30" count="${orderCount }" page="${pageParameter }">
                            <h5>Order List</h5>
                        </div>
						<div class="order-list">
						<span class="page-order"></span>
						<ul class="ul-list">
							<c:forEach var="order" items="${requestScope.orderList }">
							<li href="#" id="${order.id }">
								<span class="id-order">id : ${order.id }</span>
								<span class="date-order">date : ${order.date }</span>
								<span>price : $${order.price }</span>
								<span class="pull-right">status : delivered</span>
							</li>
							</c:forEach>
						</ul>
						
                        <ul class="pagination pagination-order">
                            <li class="previous"><a href="#"><i class="fa fa-angle-left"></i></a></li>
                        </ul>
                        
						</div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-5 ml-lg-auto">
                    <div class="order-details-confirmation">

                        <div class="cart-page-heading" id="your-order">
                            <h5>Your Order</h5>
                            <p>The Details</p>
                        </div>

                        <ul class="order-details-form mb-4">
                            <li><span>Product</span> <span>Total</span></li>
                            <li><span>Subtotal</span> <span>$0</span></li>
                            <li><span>Shipping</span> <span>Free</span></li>
                            <li><span>Total</span> <span>$0</span></li>
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
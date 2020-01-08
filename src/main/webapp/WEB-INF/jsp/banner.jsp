<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- ##### Header Area Start ##### -->
    <header class="header_area">
        <div class="classy-nav-container breakpoint-off d-flex align-items-center justify-content-between">
            <!-- Classy Menu -->
            <nav class="classy-navbar" id="essenceNav">
                <!-- Logo -->
                <a class="nav-brand" href="${pageContext.request.contextPath}/"><img src="<c:url value='/img/logo/tlogovogue.png'/>" alt=""></a>
                <!-- Navbar Toggler -->
                <div class="classy-navbar-toggler">
                    <span class="navbarToggler"><span></span><span></span><span></span></span>
                </div>
                <!-- Menu -->
                <div class="classy-menu">
                    <!-- close btn -->
                    <div class="classycloseIcon">
                        <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                    </div>
                    <!-- Nav Start -->
                    <div class="classynav">
                        <ul>
                            <li><a href="#">Shop</a>
                                <div class="megamenu">
                                    <ul class="single-mega cn-col-4">
                                        <li class="title">Ladies's Collection</li>
											<c:forEach var="category" items="${categoryList}">
													<c:if test="${category.gender == 'women' || category.gender == 'both' }">
														<li><a href="${pageContext.request.contextPath}/shop/women/${category.name}">${category.name}</a></li>
													</c:if>
                                        	</c:forEach>
                                    </ul>
                                    <ul class="single-mega cn-col-4">
                                        <li class="title">Men's Collection</li>
											<c:forEach var="category" items="${categoryList}">
														<c:if test="${category.gender == 'men' || category.gender == 'both' }">
															<li><a href="${pageContext.request.contextPath}/shop/men/${category.name}">${category.name}</a></li>
														</c:if>
	                                        	</c:forEach>
                                    </ul>
                                    <ul class="single-mega cn-col-4">
                                        <li class="title">Brands</li>
                                        <c:forEach var="brand" items="${brandList }">
										<li><a href="#">${brand.name}</a></li>
										</c:forEach>
										
                                    </ul>
                                    <div class="single-mega cn-col-4">
                                        <img src="${pageContext.request.contextPath}/img/bg-img/bg-6.jpg" alt="">
                                    </div>
                                </div>
                            </li>
                            <li><a href="#">Pages</a>
                                <ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                                    <li><a href="${pageContext.request.contextPath}/cart/checkout">Checkout</a></li>
                                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                                </ul>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/blog">Blog</a></li>
                            <li><a href="contact">Contact</a></li>
                        </ul>
                    </div>
                    <!-- Nav End -->
                </div>
            </nav>
            <!-- Header Meta Data -->
            <div class="header-meta d-flex clearfix justify-content-end">
                <!-- Search Area -->
                <div class="search-area">
                    <form action="${pageContext.request.contextPath}/search" method="get">
                        <input type="search" name="q" id="headerSearch" placeholder="Type for search" pattern=".{3,}" required title="3 characters minimum"
                        value='<c:if test="${not empty param.q}">${param.q }</c:if>'>
                        <button type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>
                    </form>
                </div>
                <!-- Favourite Area -->
                <div class="favourite-area">
                    <a href="#"><img src="${pageContext.request.contextPath}/img/core-img/heart.svg" alt=""></a>
                </div>
                <!-- User Login Info -->
                <div class="user-login-info">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="caret"></span><img src="${pageContext.request.contextPath}/img/core-img/user.svg" alt="">
                    </a>
                      <ul class="dropdown-menu text-center">
						<c:if test="${empty sessionScope.account}">
	    					<li class="cursor-link" id="login">Login</li> <!-- Link in js -->
	    					<div class="dropdown-divider"></div>
	    					<li class="cursor-link" id="forgotPassword">Forgot Password?</li> <!-- Link in js -->
	    					<div class="dropdown-divider"></div>
	    					<li class="cursor-link" id="register">Register</li> <!-- Link in js -->
	    					<div class="dropdown-divider"></div>
	    					<li class="cursor-link" id="history">History</li> <!-- Link in js -->
    					</c:if>
 						<c:if test="${not empty sessionScope.account }">	
							<li class="cursor-default">Hi ${sessionScope.account.name }!</li> <!-- Link in js -->
	    					<div class="dropdown-divider"></div>
	    					<li class="cursor-link" id="yourinfo">Your info</li> <!-- Link in js -->
	    					<div class="dropdown-divider"></div>
	    					<li class="cursor-link" id="changepassword">Change Password</li> <!-- Link in js -->
	    					<div class="dropdown-divider"></div>
	    					<li class="cursor-link" id="history">History</li> <!-- Link in js -->
	    					<div class="dropdown-divider"></div>
							<c:if test="${sessionScope.account.role == 1 }">
		    					<li class="cursor-link" id="admin">Admin page</li> <!-- Link in js -->
		    					<div class="dropdown-divider"></div>
	    					</c:if>
    					<li class="cursor-link" id="logout">Logout</li> <!-- Link in js -->
    					</c:if>
  					</ul>
                </div>
                <!-- Cart Area -->
                <div class="cart-area">
                    <a href="#" id="essenceCartBtn"><img src="${pageContext.request.contextPath}/img/core-img/bag.svg" alt=""> <span></span></a>
                </div>
            </div>

        </div>
    </header>
    <!-- ##### Header Area End ##### -->

    <!-- ##### Right Side Cart Area ##### -->
    <div class="cart-bg-overlay"></div>

    <div class="right-side-cart-area">

        <!-- Cart Button -->
        <div class="cart-button">
            <a href="#" id="rightSideCart"><img src="${pageContext.request.contextPath}/img/core-img/bag.svg" alt=""> <span></span></a>
        </div>

        <div class="cart-content d-flex">

            <!-- Cart List Area -->
            <div class="cart-list">
            	<c:if test="${not empty sessionScope.cartList }">
				<c:forEach var="cart" items="${sessionScope.cartList}">
                <!-- Single Cart Item -->
                <div class="single-cart-item" id="c${cart.id}">
                    <a href="#" class="product-image">
                        <img src="${pageContext.request.contextPath}/${cart.image}1.jpg" class="cart-thumb" alt="">
                        <!-- Cart Item Desc -->
                        <div class="cart-item-desc">
                          <span class="product-remove" cid="c${cart.id }"><i class="fa fa-close" aria-hidden="true"></i></span>
                            <span class="badge">${cart.brand.name }</span>
                            <h6>${cart.name }</h6>
                            <p class="size">Size: S</p>
                            <p class="color">Color: Red</p>
                            <p class="price">$${cart.price }></p>
                        </div>
                    </a>
                </div>
                </c:forEach>
                </c:if>
            </div>
			
            <!-- Cart Summary -->
            <div class="cart-amount-summary">

                <h2>Summary</h2>
                <ul class="summary-table">
                    <li><span>subtotal:</span> <span></span></li>
                    <li><span>delivery:</span> <span>Free</span></li>
                    <li><span>discount:</span> <span>0%</span></li>
                    <li><span>total:</span> <span></span></li>
                </ul>
                <form action="${pageContext.request.contextPath}/cart/checkout" method="get">
                <div class="checkout-btn mt-100">
                    <input type="submit"class="btn essence-btn" value="CHECKOUT">
                </div>
                </form>
            </div>
            
        </div>
    </div>
    <!-- ##### Right Side Cart End ##### -->
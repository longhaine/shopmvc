<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${not empty requestScope.detailList }">
	<c:set var="totalPrice" value="0"></c:set>
	<c:forEach var="detail" items="${requestScope.detailList }">
		<li><span>${detail.product.name}</span> <span>$${detail.product.price }</span></li>
		<c:set var="totalPrice" value="${totalPrice + detail.product.price }"></c:set>
	</c:forEach>
	<li><span>Subtotal</span> <span>$<fmt:formatNumber value="${totalPrice }" maxFractionDigits="2" /></span></li>
	<li><span>Shipping</span> <span>Free</span></li>
	<li><span>Total</span> <span>$<fmt:formatNumber value="${totalPrice }" maxFractionDigits="2" /></span></li>
</c:if>
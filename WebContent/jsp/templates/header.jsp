<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sb-admin.css" media="screen" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css" media="screen" type="text/css"/>

<div>
	<nav class="navbar navbar-inverse navbar-fixed-top">
	
		<div class="navbar-header">
			<a class="navbar-brand" href='<c:url value="/calendar.htm" />' ><fmt:message
				key="label.calendar" /> <i class="glyphicon glyphicon-calendar"></i> </a>
		</div>
		<!-- Top Menu Items -->
		<c:if test="${sessionScope.user != null}">
			<ul class="nav navbar-right top-nav">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">${sessionScope.user.user}<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href='<c:url value="/logout.htm"/>'><i class="glyphicon glyphicon-off"></i> <fmt:message
						key="label.exit" /></a></li>
					</ul>
				</li>
			</ul>
		</c:if>
	</nav>
</div>
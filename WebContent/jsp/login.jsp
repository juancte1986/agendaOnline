<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/form-signin.css" media="screen" type="text/css">
   		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sb-admin.css" media="screen" type="text/css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css" media="screen" type="text/css"/>
		<title><fmt:message key="label.login"/></title>
	</head>
	<body>
		<div id="wrapper">
			<jsp:include page="/jsp/templates/header.jsp" />
			 <div class="container-fluid">
				<div class="card card-container">
					<img id="profile-img" class="profile-img-card"
						src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
					<p id="profile-name" class="profile-name-card"></p>
					<form:form commandName="formLogin" action='${pageContext.request.contextPath}/login/processFormLogin.htm' method="POST" class="form-signin">
						<div class="form-group">
							<form:label path="user">
								<fmt:message key="label.user" />
							</form:label>
							<form:input class="form-control" path="user"/>
							<form:errors class="label label-danger" path="user"/>
						</div>
						<div class="form-group">
							<form:label path="password">
								<fmt:message key="label.password" />
							</form:label>
							<form:password class="form-control" path="password"/>
							<form:errors  class="label label-danger" path="password" />
						</div>
						<div class="form-group">
							<form:label path="remember">
								<fmt:message key="label.remember" />
							</form:label>
							<form:checkbox path="remember"/>
							<form:button class="btn btn-lg btn-primary btn-block btn-signin" ><fmt:message key="label.start"/></form:button>
						</div>
					</form:form>
					<c:if test="${error}">
						<span class="label label-danger"><fmt:message key="errors.login.start" /></span>
					</c:if>
				</div>
			</div>
		</div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><fmt:message key="label.privateEvent" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery-ui.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/form.css" media="screen"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/sb-admin.css"
	media="screen" type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/font-awesome.min.css"
	media="screen" type="text/css" />
<!-- js -->
<script src="${pageContext.request.contextPath}/js/lib/jquery-1.11.3.js"></script>
<script src="${pageContext.request.contextPath}/js/lib/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/lib/jquery-ui.js"></script>
<script
	src="${pageContext.request.contextPath}/js/widgets/jquery.privateEvent.js"></script>
<script>
	$(function() {
		$("#content").applyPrivateEvent({
			urlContext : '${pageContext.request.contextPath}'

		});
	});
</script>
</head>
<body>
	<jsp:include page="/jsp/templates/header.jsp" />
	<div id="content">
		<div class="card card-container">
			<div style="width: 350px" class="panel panel-primary">
				<div class="panel-heading">
					<fmt:message key="label.privateEvent" />
				</div>
				<div class="panel-body">
					<form:form commandName="formPrivateEvent"
						action='${pageContext.request.contextPath}/updatePrivateEvent.htm'
						method="POST">
						<!--id evento -->
						<form:hidden path="id" />
						<div class="form-group">
							<form:label path="name">
								<fmt:message key="label.name" />
							</form:label>
							<form:input class="form-control" path="name" />
							<form:errors class="label label-danger" path="name"/>
						</div>
						<div class="form-group">
							<form:label path="date">
								<fmt:message key="label.date" />
							</form:label>
							<form:input class="form-control" id="datepicker" path="date" />
							<form:errors class="label label-danger" path="date"/>
						</div>
						<!--hora de inicio-->
						<div class="row">
							<div class="col-xs-6 col-sm-6 col-md-6">
								<div class="form-group">
									<form:label path="startTime">
										<fmt:message key="label.startTime" />
									</form:label>
									<form:select class="form-control" id="startTimepicker"
										path="startTime">
										<form:options items="${hours}" />
									</form:select>
								</div>
							</div>
							<div class="col-xs-6 col-sm-6 col-md-6">
								<div class="form-group">
									<form:label path="endTime">
										<fmt:message key="label.endTime" />
									</form:label>
									<form:select class="form-control" id="endTimepicker"
										path="endTime">
										<form:options items="${hours}" />
									</form:select>
									<br />
								</div>
							</div>
						</div>
						<div class="form-group">
								<form:errors class="label label-danger" path="endTime" />
							</div>
						<div class="form-group">
							<form:label path="description">
								<fmt:message key="label.description" />
							</form:label>
							<form:input class="form-control" path="description" />
						</div>
						<div class="form-group">
							<form:label path="address">
								<fmt:message key="label.address" />
							</form:label>
							<form:input class="form-control" path="address" />
						</div>
						<div align="center">
							<form:button class="btn btn-primary">
								<fmt:message key="label.edit" />
							</form:button>
							<c:url value="/deleteEvent.htm" var="url">
								<c:param name="id" value='${formPrivateEvent.id}' />
							</c:url>
							<a class="btn btn-primary" href='${url}'><fmt:message
									key="label.delete" /></a> <a class="btn btn-primary"
								href='<c:url value="/calendar.htm" />'><fmt:message
									key="label.cancel" /></a>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
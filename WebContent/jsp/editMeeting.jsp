<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title><fmt:message key="label.meeting" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<!-- css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css" media="screen" type="text/css">
   		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sb-admin.css" media="screen" type="text/css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css" media="screen" type="text/css"/>
        <!-- js -->
		<script src="${pageContext.request.contextPath}/js/lib/jquery-1.11.3.js"></script>
		<script src="${pageContext.request.contextPath}/js/lib/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/lib/jquery-ui.js"></script>
		<script src="${pageContext.request.contextPath}/js/widgets/jquery.meeting.js"></script>
        <script>
				$(function() {
					$("#content").applyMeeting({
						urlContext : '${pageContext.request.contextPath}',
						guestsNames: ${formMeeting.guestsNames},
						isOwner:${formMeeting.isOwner},
						isGuest:${formMeeting.isGuest},
						state:${formMeeting.state}
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
						<fmt:message key="label.meeting" />
					</div>
					<div class="panel-body">
						<c:url value="${url}" var="urlAction" />
						<form:form commandName="formMeeting" action='${urlAction}'
							method="POST">
							<!--isGuest -->
							<form:hidden path="isGuest" />
							<!--isOwner -->
							<form:hidden path="isOwner" />
							<!--guestNames -->
							<form:hidden path="guestsNames" />
							<!--id evento -->
							<form:hidden path="id" />
							<!--nombre -->
							<div class="form-group">
								<form:label path="name">
									<fmt:message key="label.name" />
								</form:label>
								<form:input class="form-control owner" path="name" />
								<form:errors class="label label-danger" path="name" />
							</div>
							<!--tema -->
							<div class="form-group">
								<form:label path="theme">
									<fmt:message key="label.theme" />
								</form:label>
								<form:input class="form-control owner" path="theme" />
							</div>
							<!--fecha del evento -->
							<div class="form-group">
								<form:label path="date">
									<fmt:message key="label.date" />
								</form:label>
								<form:input class="form-control owner" id="datepicker"
									path="date" />
								<form:errors class="label label-danger" path="date"/>
							</div>
							<!--hora de inicio-->
							<div class="row">
								<div class="col-xs-6 col-sm-6 col-md-6">
									<div class="form-group">
										<form:label path="startTime">
											<fmt:message key="label.startTime" />
										</form:label>
										<form:select class="form-control owner"
											id="startTimepicker" path="startTime">
											<form:options items="${hours}" />
										</form:select>
									</div>
								</div>
								<div class="col-xs-6 col-sm-6 col-md-6">
									<div class="form-group">
										<form:label path="endTime">
											<fmt:message key="label.endTime" />
										</form:label>
										<form:select class="form-control owner"
											id="endTimepicker" path="endTime">
											<form:options items="${hours}" />
										</form:select>
									</div>
								</div>
							</div>
							<div class="form-group">
								<form:errors class="label label-danger" path="endTime" />
							</div>
							<!--salas-->
							<div class="form-group">
								<form:label path="hallId">
									<fmt:message key="label.hall" />
								</form:label>
								<form:select class="form-control owner" path="hallId">
									<form:options items="${halls}" itemLabel="description"
										itemValue="id" />
								</form:select>
							</div>
							<!--Solo si sos invitado, si se pone en true, no se modifica mas-->
	
							<label class="guest"><fmt:message key="label.confirm" /></label>
							<label class="guest" for="yes"> <fmt:message key="label.yes" /></label>
							<form:radiobutton class="guest" id="yes" path="state" value="1" />
							<label class="guest" for="not"> <fmt:message key="label.not" /></label>
							<form:radiobutton class="guest" id="not" path="state" value="2" />
	
							<br />
							<!--invitados-->
							<div class="form-group">
								<label><fmt:message key="label.guests" /></label>
								<!-- se ingrea el user para el autocompletar -->
								<div class="input-group">
									<input class="owner form-control" id="inputGuest" />
									<span class="input-group-addon" id="basic-addon2"><a class="linkDelete" id="btn-addUser" href="#"><span class="glyphicon glyphicon-plus-sign"></span></a></span>
								</div>
							</div>
							<!-- va almacenar los ids de los user nuevos -->
							<form:hidden id="guestsIds" path="guestsIds" />
							<form:errors class="label label-danger" path="guestsIds" />
							<!-- va almacenar los ids de los user nuevos -->
							<input type="hidden" id="hiddenGuestId" />
							<div id="scroll" class="form-control" style="width:100%;height:100px;overflow:scroll;">
								<ul class="list-group" id="ulGuests">
								</ul>
							</div>
							<br/>
							<div align="center">
								<form:button class="btn btn-primary" id="btn-edit">
									<fmt:message key="label.edit" />
								</form:button>
								<c:url value="/deleteEvent.htm" var="urlDelete">
									<c:param name="id" value='${formMeeting.id}' />
								</c:url>
								<a class="linkDelete btn btn-primary" href='${urlDelete}'><fmt:message
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
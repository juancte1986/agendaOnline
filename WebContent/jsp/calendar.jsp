<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title><fmt:message key="label.calendar"/></title>
		<!-- css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tooltipster.css" type="text/css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/calendar.css" type="text/css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sb-admin.css" media="screen" type="text/css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css" media="screen" type="text/css"/>
		<script src="${pageContext.request.contextPath}/js/lib/jquery-1.11.3.js"></script>
		<script src="${pageContext.request.contextPath}/js/lib/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/lib/jquery-ui.js"></script>
		<script src="${pageContext.request.contextPath}/js/widgets/jquery.calendar.js"></script>
		<script src="${pageContext.request.contextPath}/js/lib/jquery.tooltipster.js"></script>
		<script>
			$(function() {
				$("#content").applyCalendar({
					urlContext : '${pageContext.request.contextPath}'
				});
			});
		</script>
	</head>
	<body>
		<jsp:include page="/jsp/templates/header.jsp" />
		<br />
	    <div class="container">
			<div id="content">
				<nav>
				  <ul class="pager">
				 	<li><a id="btn-previous" href="#"><fmt:message key="label.previous" /></a></li>
				    <li><a id="btn-next" href="#"><fmt:message key="label.next" /></a></li>
				  </ul>
				</nav>
				<div style="width:1140px;">
					<table class="table table-bordered" id="table">
						<thead>
							<tr>
								<th colspan="8">
									<div style="float: center;">
										<div class="dropdown">
										  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
										   	<i class="glyphicon glyphicon-wrench"></i>
										    <span class="caret"></span>
										  </button>
										  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
										    <li><a href='<c:url value="/newMeeting.htm" />'><fmt:message key="label.create.meeting" /></a></li>
										    <li><a href='<c:url value="/newPrivateEvent.htm" />'> <fmt:message key="label.create.privateEvent" /></a></li>
										  </ul>
										</div>
									</div>
								</th>
							</tr>
							<tr>
								<th style="width:50px;"><fmt:message key="label.hours" /></th>
								<th><fmt:message key="label.sunday" />
									<div id="sundayId"></div></th>
								<th><fmt:message key="label.monday" />
									<div id="mondayId"></div></th>
								<th><fmt:message key="label.tuesday" />
									<div id="tuesdayId"></div></th>
								<th><fmt:message key="label.wednesday" />
									<div id="wednesdayId"></div></th>
								<th><fmt:message key="label.thursday" />
									<div id="thursdayId"></div></th>
								<th><fmt:message key="label.friday" />
									<div id="fridayId"></div></th>
								<th><fmt:message key="label.saturday" />
									<div id="saturdayId"></div></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th style="border-top-width: 0px;padding-top: 20px; padding-left: 0px; padding-right: 0px; text-align: right;">
									<div  class="columnHours">	
										<div style="top: 0px; position: absolute;border-top: 1px solid #fff; width: 50px">00:00</div>
										<div style="top: 20px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 40px;position: absolute;border-top: 1px solid #fff; width: 50px">01:00</div>
										<div style="top: 60px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 80px;position: absolute;border-top: 1px solid #fff; width: 50px">02:00</div>
										<div style="top: 100px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 120px;position: absolute;border-top: 1px solid #fff; width: 50px">03:00</div>
										<div style="top: 140px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 160px;position: absolute;border-top: 1px solid #fff; width: 50px">04:00</div>
										<div style="top: 180px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 200px;position: absolute;border-top: 1px solid #fff; width: 50px">05:00</div>
										<div style="top: 220px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 240px;position: absolute;border-top: 1px solid #fff; width: 50px">06:00</div>
										<div style="top: 260px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 280px;position: absolute;border-top: 1px solid #fff; width: 50px">07:00</div>
										<div style="top: 300px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 320px;position: absolute;border-top: 1px solid #fff; width: 50px">08:00</div>
										<div style="top: 340px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 360px;position: absolute;border-top: 1px solid #fff; width: 50px">09:00</div>
										<div style="top: 380px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 400px;position: absolute;border-top: 1px solid #fff; width: 50px">10:00</div>
										<div style="top: 420px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 440px;position: absolute;border-top: 1px solid #fff; width: 50px">11:00</div>
										<div style="top: 460px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 480px;position: absolute;border-top: 1px solid #fff; width: 50px">12:00</div>
										<div style="top: 500px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 520px;position: absolute;border-top: 1px solid #fff; width: 50px">13:00</div>
										<div style="top: 540px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 560px;position: absolute;border-top: 1px solid #fff; width: 50px">14:00</div>
										<div style="top: 580px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 600px;position: absolute;border-top: 1px solid #fff; width: 50px">15:00</div>
										<div style="top: 620px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 640px;position: absolute;border-top: 1px solid #fff; width: 50px">16:00</div>
										<div style="top: 660px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 680px;position: absolute;border-top: 1px solid #fff; width: 50px">17:00</div>
										<div style="top: 700px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 720px;position: absolute;border-top: 1px solid #fff; width: 50px">18:00</div>
										<div style="top: 740px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 760px;position: absolute;border-top: 1px solid #fff; width: 50px">19:00</div>
										<div style="top: 780px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 800px;position: absolute;border-top: 1px solid #fff; width: 50px">20:00</div>
										<div style="top: 820px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 840px;position: absolute;border-top: 1px solid #fff; width: 50px">21:00</div>
										<div style="top: 860px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 880px;position: absolute;border-top: 1px solid #fff; width: 50px">22:00</div>
										<div style="top: 900px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
										<div style="top: 920px;position: absolute;border-top: 1px solid #fff; width: 50px">23:00</div>
										<div style="top: 940px;position: absolute;border-top: 1px solid #fff; width: 50px"></div>
									</div>
								</th>
								<td style="padding-top: 20px;">
									<div class="columnSunday"></div>
								</td>
								<td style="padding-top: 20px;">
									<div class="columnMonday"></div>
								</td>
								<td style="padding-top: 20px;">
									<div class="columnTuesday"></div>
								</td>
								<td style="padding-top: 20px;">
									<div class="columnWednesday">
									</div>
								</td>
								<td style="padding-top: 20px;">
									<div class="columnThursday"></div>
								</td>
								<td style="padding-top: 20px;">
									<div class="columnFriday"></div>
								</td>
								<td style="padding-top: 20px;">
									<div class="columnSaturday"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</body>
</html>
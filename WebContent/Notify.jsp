<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IBeacon - Registration Success!</title>
</head>

<!-- BOOTSTRAP STYLES-->
<link href="css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="css/custom.css" rel="stylesheet" />
<link rel="icon" type="image/png" href="images/favicon.png">



<!--  Including Scripts and CSS -->

<link rel="icon" type="image/png" href="images/favicon.png">

<!-- Custom Theme files -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />

<!-- Custom Theme files -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" href="css/formValidation.css" />



<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery-1.11.3.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/formValidation.js"></script>
<script src="js/framework/bootstrap.js"></script>
<script src="js/menu_jquery.js"></script>
<!--  End of Scripts and CSS -->


<body>

	<div class="container">

		<%
			if (request.getAttribute("Notification") != null && "uuid".equals(request.getAttribute("Notification"))) {
		%>
		<div class="alert alert-danger fade in">
			<strong>Failed!</strong> Beacon UUID not configured. Please configure
			UUID first.
		</div>
		<%
			}
		%>
		<%
			if (request.getAttribute("Notification") != null
					&& "success".equals(request.getAttribute("Notification"))) {
		%>
		<div class="alert alert-success fade in">
			<strong>Success!</strong> Notification created successfully.<br>
		</div>
		<%
			}
		%>
		<%
			if (request.getAttribute("Notification") != null && "failed".equals(request.getAttribute("Notification"))) {
		%>
		<div class="alert alert-danger fade in">
			<strong>Failed!</strong> Notification could not be created.
		</div>
		<%
			}
		%>
		<%
			if (request.getAttribute("Notification") != null && "config".equals(request.getAttribute("Notification"))) {
		%>
		<div class="alert alert-danger fade in">
			<strong>Failed!</strong> Beacon ID does not exists.
		</div>
		<%
			}
		%>
		<%
			if (request.getAttribute("count1") != null) {
		%>
		<div class="alert alert-danger fade in">
			<%
				if (request.getAttribute("count1") != null) {
						String count = request.getAttribute("count1").toString();
			%>
			<strong><%=count%></strong> Parameters missing!<br> <br>

			<%
				}
					if (request.getAttribute("msg1") != null) {
			%>
			<strong><%=request.getAttribute("msg1")%></strong><br>
			<%
				}
					if (request.getAttribute("msg2") != null) {
			%>
			<strong><%=request.getAttribute("msg2")%></strong><br>
			<%
				}
			%>
		</div>
		<%
			}
		%>





		<%
			if (request.getAttribute("count") != null) {
		%>
		<div class="alert alert-danger fade in">
			<%
				if (request.getAttribute("count") != null) {
						String count = request.getAttribute("count").toString();
			%>
			<strong><%=count%></strong> Parameters missing!<br> <br>

			<%
				}
					if (request.getAttribute("msg1") != null) {
			%>
			<strong><%=request.getAttribute("msg1")%></strong><br>
			<%
				}
					if (request.getAttribute("msg2") != null) {
			%>
			<strong><%=request.getAttribute("msg2")%></strong><br>
			<%
				}
			%>
		</div>
		<%
			}
			if (request.getAttribute("msg3") != null) {
		%>
		<strong><%=request.getAttribute("msg3")%></strong><br>
		<%
			}
		%>
	</div>
</body>
</html>
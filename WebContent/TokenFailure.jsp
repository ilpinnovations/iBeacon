<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IBeacon - Registration Failure!</title>
</head>

<!-- BOOTSTRAP STYLES-->
<link href="css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="css/custom.css" rel="stylesheet" />
<link rel="icon" type="image/png" href="images/Icon11.png">


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

		<div class='panel-heading'>
			<div class="alert alert-danger">
				<strong>Sorry!</strong> Token could not be created!<br><br>
				<%
				if(request.getAttribute("count")!=null){
				String count=request.getAttribute("count").toString();
				%>
				<strong><%=count %></strong> Parameters missing!<br><br>
				
				<%
				}
				if(request.getAttribute("msg1")!=null){
				%>
				<strong><%=request.getAttribute("msg1") %></strong><br>
				<%
				}
				if(request.getAttribute("msg2")!=null){
				%>
				<strong><%=request.getAttribute("msg2") %></strong><br>
				<%
				}
				if(request.getAttribute("msg3")!=null){
				%>
				<strong><%=request.getAttribute("msg3") %></strong><br>
				<%
				}
				if(request.getAttribute("msg4")!=null){
				%>
				<strong><%=request.getAttribute("msg4") %></strong><br>
				<%
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>
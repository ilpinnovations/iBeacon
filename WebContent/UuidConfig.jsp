<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>IBeacon - User Registration</title>

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
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script src="js/menu_jquery.js"></script>
<!--  End of Scripts and CSS -->

</head>
<body>

	<div class="container">

		<div class=' panel-heading'>
			<i class="fa fa-user-plus fa-1x"></i> &nbsp; Beacon UUID Configuration
		</div>
		<form action='UuidConfig' method="post" name="userRegForm"
			id="userRegForm" class="form-horizontal">
			<div class="form-group">
				<label class="col-lg-3 control-label">Token ID</label>
				<div class="col-lg-5">
					<input type="text" class="form-control" name="tokenID"
						placeholder="Your tokenID here" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-lg-3 control-label">UUID</label>
				<div class="col-lg-5">
					<input type="text" class="form-control" name="uuid"
						placeholder="Beacon UUID here" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-9 col-lg-offset-3">
					<button type="submit" class="btn btn-primary">Configure</button>
				</div>
			</div>
		</form>
	</div>
	</div>

</body>

</html>
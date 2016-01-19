<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Geofence - Forgot Password ?</title>

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
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script src="js/menu_jquery.js"></script>
<!--  End of Scripts and CSS -->
<script>
	$(document)
			.ready(
					function() {
						// Generate a simple captcha
						function randomNumber(min, max) {
							return Math.floor(Math.random() * (max - min + 1)
									+ min);
						}
						;
						$('#captchaOperation').html(
								[ randomNumber(1, 100), '+',
										randomNumber(1, 200), '=' ].join(' '));

						$('#userRegForm')
								.bootstrapValidator({
											message : 'This value is not valid',
									        feedbackIcons: {
									            valid: 'glyphicon glyphicon-ok',
									            invalid: 'glyphicon glyphicon-remove',
									            validating: 'glyphicon glyphicon-refresh'
									        },
											message : 'This value is not valid',
											fields : {
												firstName : {
													message : 'The entered first name is not valid',
													validators : {
														notEmpty : {
															message : 'The first name is required and can\'t be empty'
														},
														stringLength : {
															min : 3,
															max : 30,
															message : 'The first name must be more than 2 and less than 30 characters long'
														},
														regexp : {
															regexp : /^[a-zA-Z]+$/,
															message : 'The first name can only consist of alphabetical characters'
														},
														different : {
															field : 'lastName',
															message : 'The first name and last name can\'t be the same'
														}
													}
												},
												lastName : {
													message : 'The entered last name is not valid',
													validators : {
														notEmpty : {
															message : 'The last name is required and can\'t be empty'
														},
														stringLength : {
															min : 3,
															max : 30,
															message : 'The last name must be more than 2 and less than 30 characters long'
														},
														regexp : {
															regexp : /^[a-zA-Z]+$/,
															message : 'The last name can only consist of alphabetical characters'
														},
														different : {
															field : 'firstName',
															message : 'The last name and first name can\'t be the same'
														}
													}
												},
												userName : {
													message : 'The username is not valid',
													validators : {
														notEmpty : {
															message : 'The username is required and can\'t be empty'
														},
														stringLength : {
															min : 6,
															max : 30,
															message : 'The username must be more than 6 and less than 30 characters long'
														},
														regexp : {
															regexp : /^[a-zA-Z0-9_\.]+$/,
															message : 'The username can only consist of alphabetical, number, dot and underscore'
														},
														different : {
															field : 'password',
															message : 'The username and password can\'t be the same as each other'
														}
													}
												},
												email : {
													validators : {
														notEmpty : {
															message : 'The email address is required and can\'t be empty'
														},
														emailAddress : {
															message : 'The input is not a valid email address'
														}
													}
												},
												password : {
													validators : {
														notEmpty : {
															message : 'The password is required and can\'t be empty'
														},
														identical : {
															field : 'confirmPassword',
															message : 'The password and its confirm are not the same'
														},
														different : {
															field : 'username',
															message : 'The password can\'t be the same as username'
														}
													}
												},
												confirmPassword : {
													validators : {
														notEmpty : {
															message : 'The confirm password is required and can\'t be empty'
														},
														identical : {
															field : 'password',
															message : 'The password and its confirm are not the same'
														},
														different : {
															field : 'username',
															message : 'The password can\'t be the same as username'
														}
													}
												},
												captcha : {
													validators : {
														callback : {
															message : 'Wrong answer',
															callback : function(
																	value,
																	validator) {
																var items = $(
																		'#captchaOperation')
																		.html()
																		.split(
																				' '), sum = parseInt(items[0])
																		+ parseInt(items[2]);
																return value == sum;
															}
														}
													}
												},
												acceptTerms : {
													validators : {
														notEmpty : {
															message : 'You must accept the terms and agreements'
														}
													}
												}
											}
										});
					});
</script>

</head>
<body>



	<div class="container">

		<div class=' panel-heading'>
			<i class="fa fa-user-plus fa-1x"></i> &nbsp; Password Reset Request
		</div>

		<div id="page-wrapper">
			<div id="page-inner">

				<div class="row">
					<div class="col-md-12">
						<!-- Form Elements -->
						<%
							if (request.getAttribute("msg") != null
									&& request.getAttribute("msg").equals("Success")) {
								request.removeAttribute("msg");
						%>

						<div class="alert alert-info">
							<strong>Password Sent !</strong> <br />Your password has been sent to
							registered mail address! <br /> <br /> <input type='button'
								class='btn btn-success' id='btnClose' value='Close'/>
						</div>
						<%
							} else if (request.getAttribute("msg") != null
									&& request.getAttribute("msg").equals("Failed")) {
								request.removeAttribute("msg");
						%>
						<div class="alert alert-danger">
							<strong>No user found !</strong> <br />No user found for given mail
							address!
							<br /><input type='button' class='btn btn-danger' id='btn'
								value='Try Again!' onclick='window.history.back(-1);' />
						</div>
						<%
							} else {
						%>

						<form action='ResetPasswordRequest' method="post"
							name="forgotPasswordForm" id="userRegForm"
							class="form-horizontal">

							<!-- 							<div class="form-group"> -->
							<!-- 								<label class="col-lg-3 control-label">Username</label> -->
							<!-- 								<div class="col-lg-5"> -->
							<!-- 									<input type="text" class="form-control" name="userName" -->
							<!-- 										value="kuntaldarji" /> -->
							<!-- 								</div> -->
							<!-- 							</div> -->
							<!-- 							<div class="form-group"> -->
							<!-- 								<label class="col-lg-3 control-label">Date of Birth</label> -->
							<!-- 								<div class="col-lg-5"> -->
							<!-- 									<input type="date" class="form-control" name="dob" -->
							<!-- 										value='1990-01-30' /> -->
							<!-- 								</div> -->
							<!-- 							</div> -->
							<div class="form-group">
								<label class="col-lg-3 control-label">Email address</label>
								<div class="col-lg-5">
									<input type="text" class="form-control" name="email"
										value="kuntal.darji@tcs.com" />
								</div>
							</div>

							<div class="form-group">
								<div class="col-lg-9 col-lg-offset-3">
									<button type="submit" class="btn btn-primary">Request
										New Password</button>
								</div>
							</div>
						</form>
						<%
							}
						%>
					</div>
				</div>



<script type="text/javascript">
		$(document).ready(function() {
			$('#btnClose').click(function() {
				window.opener.location.reload(true);
				window.close();
			});
		});
	</script>
	
	</body>
</html>
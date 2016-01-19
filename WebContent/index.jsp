<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<%
	if (session.getAttribute("userName") != null) {
		//request.getRequestDispatcher("index.jsp").forward(request, response);
		response.sendRedirect("dashboard.jsp");
	}
%>



<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>IBeacons</title>
<link rel="stylesheet" href="css/normalize.css">

<link rel="icon" type="image/png" href="img/Icon11.png">
<link rel='stylesheet prefetch'
	href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

<link rel="stylesheet" href="css/style.css">

<!-- Bootstrap Core CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">

<!-- Custom Fonts -->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css"
	type="text/css">

<!-- Plugin CSS -->
<link rel="stylesheet" href="css/animate.min.css" type="text/css">

<!-- Custom CSS -->
<link rel="stylesheet" href="css/creative.css" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

<script src="js/index.js"></script>



</head>

<body id="page-top">



	<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand page-scroll" href="#page-top">IBeacons</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a class="page-scroll" href="#about">About</a></li>
					<li><a class="page-scroll" href="#services">Services</a></li>
					<li><a class="page-scroll" href="#contact">Contact</a></li>
					<li><a class="page-scroll" href="#signin">SignIn</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>

	<header>

		<div class="header-content">
			<div style="margin-left: 33%; width: 500px">
				<%
					if (session.getAttribute("msg") != null && "sameUser".equals(session.getAttribute("msg"))) {
						session.removeAttribute("msg");
				%>
				<button id='btn' style='display: none;'
					class="trigger error-trigger">Error</button>
				<div class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Registration Failed!</strong> Email Address already
					registered.
				</div>

				<%
					}
					if (session.getAttribute("msg") != null && "Failed".equals(session.getAttribute("msg"))) {
						session.removeAttribute("msg");
				%>
				<button id='btn' style='display: none;'
					class="trigger error-trigger">Error</button>
				<div class="alert alert-danger fade in">
					<a href="#signin" class="close" data-dismiss="alert"
						aria-label="close">&times;</a> <strong>Registration
						Failed!</strong> Invalid Email or Password.
				</div>
				<%
					}
				%>
			</div>
			<div class="header-content-inner" style="margin-top: 150px">
				<h1 style="font-family: cursive; font-variant: normal;">The
					Ultimate solution for iBeacon Notifications!</h1>
				<hr>
				<a href="#signin" class="btn btn-primary btn-xl page-scroll">Create
					Free Account</a>
			</div>
		</div>
	</header>

	<section class="bg-primary" id="about">
		<div class="container">
			<div class="row">
				<div class="col-lg-12  text-center">
					<h2 class="section-heading" style="margin-top: -50px">What are
						iBeacons?</h2>
					<hr class="light">
					<p class="text-faded col-md-6"
						style="text-align: left; margin-left: -100px">
						iBeacons are small bluetooth transmitters that trigger close-by
						devices to perform actions. This means that iBeacons can trigger
						notifications on approaching users devices having a radius of 1-30
						meters. iBeacons are a better fit for micro-locations and can for
						instance be placed next to a painting in a museum, next to a
						billboard or in a specific aisles of a store.<br>
						<br>iBeacon Notifications are a powerful tool to enhance the
						interaction with your customers by providing them with
						highly-relevant information delivered at the right place and the
						right time.

					</p>
					<img src="img/beac.png" height="300px" width="350px"
						style="margin-right: -150px; margin-top: -50px">
						
				</div>
			</div>
		</div>
	</section>

	<section id="services" style="height: 250px">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading">Getting Started</h2>
					<hr class="primary">
				</div>
			</div>
		</div>
		<div class="container" >
			<div class="row" >
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<img src="img/1.png" height="100px">
						<h3>Create an account and log into the Plot Dashboard</h3>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<img src="img/2.png" height="100px">
						<h3>Buy iBeacons and place them in your store OR turn your iPhone/iPad into an iBeacon</h3>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<img src="img/3.png" height="100px">
						<h3>Add your iBeacons in the dashboard and create accompanying notifications</h3>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<img src="img/4.png" height="100px">
						<h3>Implement the iBeacon plugin your app</h3>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="signin">
		<div class="container-fluid">
			<div class="logmod">
				<div class="logmod__wrapper">
					<div class="logmod__container">
						<ul class="logmod__tabs">
							<li data-tabtar="lgm-2"><a href="#">Login</a></li>
							<li data-tabtar="lgm-1"><a href="#">Sign Up</a></li>
						</ul>
						<div class="logmod__tab-wrapper">
							<div class="logmod__tab lgm-1">
								<div class="logmod__heading">
									<span class="logmod__heading-subtitle">Enter your
										personal details <strong>to create an account</strong>
									</span>
								</div>
								<div class="logmod__form">
									<form action="ProcessRegistration" class="simform">
										<div class="sminputs">
											<div class="input full">
												<label class="string optional" for="user-name">Email*</label>
												<input class="string optional" maxlength="200"
													id="user-email" placeholder="Email" type="email"
													name="email" size="50" />
											</div>
										</div>
										<div class="sminputs">
											<div class="input full">
												<label class="string optional" for="user-name">User
													Name*</label> <input class="string optional" maxlength="200"
													id="user-email" placeholder="User Name" type="text"
													name="userName" size="50" />
											</div>
										</div>
										<div class="sminputs">
											<div class="input string optional">
												<label class="string optional" for="user-pw">Password*</label>
												<input class="string optional" maxlength="255" id="user-pw"
													placeholder="Password" name="password" required="required"
													type="text" size="50" />
											</div>
											<div class="input string optional">
												<label class="string optional" for="user-pw-repeat">Repeat
													password *</label> <input class="string optional" maxlength="255"
													id="user-pw-repeat" placeholder="Repeat password"
													required="required" name="confirmPassword" type="text"
													size="50" onkeyup="validatePassword()" />
											</div>
										</div>
										<div class="simform__actions">
											<input class="sumbit" name="commit" type="submit"
												style="background-color: #f44336" value="Create Account" />
											<span class="simform__actions-sidetext">By creating an
												account you agree to our <a class="special" href="#"
												target="_blank" role="link">Terms & Privacy</a>
											</span>
										</div>
									</form>
								</div>
							</div>
							<div class="logmod__tab lgm-2">
								<div class="logmod__heading">
									<span class="logmod__heading-subtitle">Enter your email
										and password <strong>to sign in</strong>
									</span>
								</div>
								<div class="logmod__form">
									<form action="AuthUser" method="post" class="simform">
										<div class="sminputs">
											<div class="input full">
												<label class="string optional" for="user-name">Email*</label>
												<input class="string optional" maxlength="200" name="email"
													id="user-email" placeholder="Email" type="email" size="50" />
											</div>
										</div>
										<div class="sminputs">
											<div class="input full">
												<label class="string optional" for="user-pw">Password
													*</label> <input class="string optional" name="password"
													maxlength="200" id="user-pw" required="required"
													title="Password is mandatory" placeholder="Password"
													type="password" size="50">
											</div>
										</div>
										<div class="simform__actions">
											<input class="sumbit" style="background-color: #f44336"
												name="commit" type="submit" value="Log In" /> <span
												class="simform__actions-sidetext"><a class="special"
												onclick='forgotPassword()' role="link">Forgot your
													password?<br>Click here
											</a></span>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<section id="contact">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2 text-center">
					<h2 class="section-heading">Let's Get In Touch!</h2>
					<hr class="primary">
					<p>Ready to start your next project with us? That's great! Send us an email and we will get back to you as soon
						as possible!</p>
				</div>
				<div class="col-lg-12 text-center">
					<i class="fa fa-envelope-o fa-3x wow bounceIn" data-wow-delay=".1s"></i>
					<p>
						<a href="mailto:ILPInnovations@tcs.com">ILPInnovations@tcs.com</a>
					</p>
				</div>
			</div>
		</div>
	</section>

	<!-- jQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="js/jquery.easing.min.js"></script>
	<script src="js/jquery.fittext.js"></script>
	<script src="js/wow.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="js/creative.js"></script>
	<script type="text/javascript">
		function forgotPassword() {
			window.open('forgotPassword.jsp', '_blank',
					'height=500, width=500, resizable=no, top=150, left= 500');
		}
	</script>
	<script>
		function validatePassword() {
			var password = document.getElementById("user-pw");
			var confirmPassword = document.getElementById("user-pw-repeat");
			if (password.value != confirmPassword.value) {
				confirmPassword.setCustomValidity("Passwords Don't Match");
			} else {
				confirmPassword.setCustomValidity('');
			}
		}
	</script>

</body>

</html>

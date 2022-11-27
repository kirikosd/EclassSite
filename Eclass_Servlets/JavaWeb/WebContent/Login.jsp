<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link rel="stylesheet"	href="login_register.css" type="text/css"/>
<script src="./javascript/index.js"  type="text/javascript" ></script>
<script src="./javascript/error.js"  type="text/javascript" ></script>
</head>
<body>
	<div class = "form">
		<h1>Login Form</h1>		
		<!-- the data the user enters in this form are send to the LoginServlet.java file, particularly calling its doPost method -->
		<form action="<%=request.getContextPath()%>/LoginServlet" method="post">

			<input type="text" name="username" placeholder="username" /> 
			<input type="password" name="password" placeholder="password" />
			<button>login</button>
			<h4>Not registered yet? <a style = "color: #e38283" href = "registrationOptions.html">Register now!</a></h4>
			
		</form>
	</div>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel = stylesheet
      href = "login_register.css"
      type = "text/css">
<head>
<meta charset="ISO-8859-1">
<title>Secretary Registration</title>
</head>
<body>
	<div class="form">
		<h1>Secretary Registration</h1>
		<!-- the data the user enters in this form are send to the SecretaryRegister.java file, particularly calling its doPost method -->
		<form action="<%=request.getContextPath()%>/SecretaryRegister" method="post">
			<input type="text" name="username" placeholder="username" required/> 
			<input type="password" name="password" placeholder="password" />
			<input type="text" name="name" placeholder="name" />
			<input type="text" name="surname" placeholder="surname" />
			<input type="text" name="email" placeholder="email" />
			<input type="text" name="phone" placeholder="phone number" />
			<input type="text" name="afm" placeholder="afm" required/>
			<button onclick = "Login.jsp">register</button>
		</form>
	</div>	
</body>
</html>
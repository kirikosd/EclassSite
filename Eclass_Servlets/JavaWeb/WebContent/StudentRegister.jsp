<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel = stylesheet
      href = "login_register.css"
      type = "text/css">
<head>
<meta charset="ISO-8859-1">
<title>Student Registration</title>
</head>
<body>
	<div class="form">
		<h1>Student Registration</h1>
		<!-- the data the user enters in this form are send to the 	StudentRegister.java file, particularly calling its doPost method -->
		<form action="<%=request.getContextPath()%>/StudentRegister" method="post">
			<input type="text" name="username" placeholder="username" required/> 
			<input type="password" name="password" placeholder="password" />
			<input type="text" name="name" placeholder="name" />
			<input type="text" name="surname" placeholder="surname" />
			<input type="text" name="email" placeholder="email" />
			<input type="text" name="department" placeholder="department" />
			<input type="text" name="registrationNumber" placeholder="registration number" required/>
			<button onclick = "Login.jsp">register</button>
		</form>
	</div>	
</body>
</html>
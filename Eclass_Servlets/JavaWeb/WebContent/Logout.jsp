<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Log Out!</title>
</head>
<body>
<%
	// delete the session if the user chooses to log out
	session.removeAttribute("username");
	session.invalidate();
	
	// redirect to the initial login page after the user logs out
	response.sendRedirect("Login.jsp");
%>
</body>
</html>

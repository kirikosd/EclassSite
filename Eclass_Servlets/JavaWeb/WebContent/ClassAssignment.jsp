<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.dao.CoursesDao"%>
<!DOCTYPE html>
<html>
<head>
<link REL=STYLESHEET
      HREF="tables.css"
      TYPE="text/css">
<meta charset="US-ASCII">
<title>Class Assignment to Professor</title>
<style type="text/css">
button {
	font-family: "Roboto", sans-serif;
	text-transform: uppercase;
	outline: 0;
	background: #ea9fa0;
	width: 20%;
	padding: 15px;
	color: #443c44;
	font-size: 20px;
	transition: all 0.3 ease;
	cursor: pointer;
	border: 2px solid black;
	box-shadow: 3px 3px #ea9fa0;
	letter-spacing: 2px;
}
button:hover
{
	background-color:#4eb6f7;
}
body {
	background: #68b599;
}
div {
	text-align: center;
	margin-top: 150px;
}
h1 {
	font-family: "Roboto", sans-serif;
	font-size: 40px;
	font-weight: lighter;
	color: #000000;
}
h4{	
    -webkit-text-stroke: 1px black;
	font-size: 25px;
	font-weight: bold;
	color: #e38283;
	font-family: sans-serif;
}
a:link {
	background-color: transparent;
	text-decoration: none;
}
a:hover {
	color: #006652;
	text-decoration: underline;
}
</style>
</head>
<body style="background-color:  #68b599">
	 <table style = "margin-left: auto; margin-right: auto" class = "styled-table">
        <thead>
            <tr style = "background-color: #e38283">
                <th>Course ID</th>
                <th>Title</th>
                <th>Assigned Professor</th>
                <th>Assign to Professor</th>
                <th></th>
            </tr>
        </thead>
<%		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/coursegrades?allowPublicKeyRetrieval=true&useSSL=false", "root", "test123");
			Statement statement = connection.createStatement();
			
			HttpSession temp = request.getSession();
			String username = temp.getAttribute("username").toString();
			
			int courseID = 0;
			String title = "";
			String professors_afm ="";
			
			String courses = "select * from courses";
			ResultSet res = statement.executeQuery(courses);

			while (res.next()) {
		%>
			<tr class = "active-row">
				<td><%=res.getInt("courseID")%></td>
				<td><%=res.getString("title")%></td>
				<td><%=res.getString("professors_afm")%></td>
				<td><input type="text" name="professors_afm" placeholder="Professors AFM" /></td>
				<td>
				    <a href="ClassAssignment2.jsp?courseID=<%=res.getInt("courseID")%>&professors_afm=<%=request.getParameter("professors_afm")%>">
      					<button class = "delete" type="button" onclick = "alert('Assignment Succesfull!')">Assign</button>
      				</a>
				</td>
			</tr>
		<%
		}
		connection.close();
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
	</table>
</body>
</html>
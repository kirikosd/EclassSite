<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<%@page import="java.sql.*"%>    
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
<title>Insert Grades</title>
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
<form method="post" name="myfrom">
 <table style = "margin-left: auto; margin-right: auto" class = "styled-table">
        <thead>
            <tr style = "background-color: #e38283">
                <th>Course ID</th>
                <th>Course Title</th>
                <th>RegNumber</th>
                <th>Assign Grade</th>
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
			
			String sql1 = "select afm from professors where username = '" + username + "'";
			PreparedStatement preparedStatement1 = connection.prepareStatement(sql1);
			ResultSet resultSet1 = statement.executeQuery(sql1);
			
			String professors_afm = "";
			
			while (resultSet1.next()){
				professors_afm = resultSet1.getString("afm");
			}
			out.println(username);
			out.println(professors_afm);
			
			String sql2 = "select courseID,title from courses where professors_afm ='" + professors_afm + "'";
			PreparedStatement preparedStatement2 = connection.prepareStatement(sql2);
			ResultSet resultSet2 = statement.executeQuery(sql2);
			

			int course_courseID= 0;
			String title = "";
			
			while(resultSet2.next()){
				course_courseID = resultSet2.getInt("courseID");
				title = resultSet2.getString("title");
				
				String sql3 = "SELECT * FROM grades WHERE courseID ='" + course_courseID + "'";
				PreparedStatement preparedStatement3 = connection.prepareStatement(sql2);
				ResultSet resultSet3 = statement.executeQuery(sql3);

				while (resultSet3.next()) {
				%>
					<tr class = "active-row">
						<td><%=resultSet3.getInt("courseID")%></td>
						<td><%=title%></td>
						<td><%=resultSet3.getString("registrationNumber")%></td>
						<td><input type="text" name="grade" placeholder="grade"  /></td>
						<td>
				    	<a href="InsertGrades2.jsp?courseID=<%=resultSet3.getInt("courseID")%>&registrationNumber=<%=resultSet3.getString("registrationNumber")%>&grade=<%=request.getParameter("grade")%>">
      						<button class = "delete" type="button" onclick = "alert('Grade Inserted!')">Assign Grade</button>
      					</a>
						</td>
					</tr>
		<%
		}}
		connection.close();
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
   </table>
  </form>
</body>
</html>
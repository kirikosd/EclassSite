<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.dao.CoursesDao"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link REL=STYLESHEET
      HREF="tables.css"
      TYPE="text/css">
<title>Grades Per Semester</title>
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
</style>
</head><body style="background-color:  #68b599">
 <table id="sem1" style = "margin-left: auto; margin-right: auto" class = "styled-table">
        <thead>
            <tr style = "background-color: #e38283">
                <th>Course ID</th>
                <th>Title</th>
                <th>Grade</th>
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
			String username= temp.getAttribute("username").toString();
			
			String sql1 = "select registrationNumber from students where username = '" + username + "'";
			PreparedStatement preparedStatement1 = connection.prepareStatement(sql1);
			ResultSet resultSet1 = statement.executeQuery(sql1);
			
			String registrationNumber = "";
			
			while (resultSet1.next()){
				registrationNumber = resultSet1.getString("registrationNumber");
			}
			out.println(username);
			out.println(registrationNumber);
		
			String sql2 = "select courseID,title from courses where semester = 1";
			PreparedStatement preparedStatement2 = connection.prepareStatement(sql2);
			ResultSet resultSet2 = statement.executeQuery(sql2);
			
			int courses_courseID= 0;
			String title = "";
			int grade = 0;
			
			while (resultSet2.next()){
				courses_courseID = resultSet2.getInt("courseID");
				title = resultSet2.getString("title");
			
				String sql3 = "select grade from grades where courseID = '" + courses_courseID + "' and registrationNumber = '" + registrationNumber + "'";
				PreparedStatement preparedStatement3 = connection.prepareStatement(sql3);
				ResultSet resultSet3 = statement.executeQuery(sql3);
				
				while (resultSet3.next()){
					grade = resultSet3.getInt("grade");
				}
				%>
				<tr class = "active-row">
					<td><%= courses_courseID %></td>
					<td><%= title %></td>
					<td><%= grade %></td>
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
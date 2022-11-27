<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.dao.CoursesDao"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link REL=STYLESHEET
      HREF="tables.css"
      TYPE="text/css">
<title>Show All Courses</title>
</head>
<body style="background-color:  #68b599">
    <table style = "margin-left: auto; margin-right: auto" class = "styled-table">
        <thead>
            <tr style = "background-color: #e38283">
                <th>Course ID</th>
                <th>Title</th>
                <th>Professor's AFM</th>
                <th>Department</th>
                <th>Semester</th>
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
			
			int courseID= 0;
			String title = "";
			String professors_afm = "";
			String department = "";
			int semester = 0;
			
			String courses = "select * from courses";
			ResultSet res = statement.executeQuery(courses);

			while (res.next()) {
		%>
			<tr class = "active-row">
				<td><%=res.getInt("courseID")%></td>
				<td><%=res.getString("title")%></td>
				<td><%=res.getString("professors_afm")%></td>
				<td><%=res.getString("department")%></td>
				<td><%=res.getInt("semester")%></td>
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
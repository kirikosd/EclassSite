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
<title>Total Grade</title>
</head><body style="background-color:  #68b599">
    <table style = "margin-left: auto; margin-right: auto" class = "styled-table">
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
			String registrationNumber = temp.getAttribute("registrationNumber").toString();
			
			int courseID= 0;
			String title = "";
			int grades = 0;
			
			String grade = "select courseID,grade from grades";
			PreparedStatement preparedStatement = connection.prepareStatement(grade);
			//preparedStatement.setString(1, "12345");
			ResultSet res = statement.executeQuery(grade);

			while (res.next()) {
				courseID = res.getInt("courseID");
				grades = res.getInt("grades");
		%>
			<tr class = "active-row">
				<td><%=res.getInt("courseID")%></td>
				<td><%=res.getInt("grade")%></td>
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
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
<link REL=STYLESHEET
      HREF="tables.css"
      TYPE="text/css">
<meta charset="US-ASCII">
<title>List Grades</title>
</head>
<body style="background-color:  #68b599">
 <table style = "margin-left: auto; margin-right: auto" class = "styled-table">
        <thead>
            <tr style = "background-color: #e38283">
                <th>Course ID</th>
                <th>Title</th>
                <th>RegNumber</th>
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
			String username = temp.getAttribute("username").toString();
			
			String sql1 = "select afm from professors where username = '" + username + "'";
			PreparedStatement preparedStatement1 = connection.prepareStatement(sql1);
			ResultSet resultSet1 = statement.executeQuery(sql1);
			
			String professors_afm = "";
			String registrationNumber = "";
			
			while(resultSet1.next()){
				professors_afm = resultSet1.getString("afm");
			}
			out.println(username);
			out.println(professors_afm);
			
			String sql2 = "select courseID,title from courses where professors_afm = '" + professors_afm + "'";
			PreparedStatement preparedStatement2 = connection.prepareStatement(sql2);
			ResultSet resultSet2 = statement.executeQuery(sql2);
			
			int courses_courseID = 0;
			String title= "";
			
			while (resultSet2.next()){
				courses_courseID = resultSet2.getInt("courseID");
				title = resultSet2.getString("title");
				
				String sql3 = "select * from grades where courseID = '" + courses_courseID + "'";
				PreparedStatement preparedStatement3 = connection.prepareStatement(sql3);
				ResultSet resultSet3 = statement.executeQuery(sql3);
				
				while (resultSet3.next()){
		%>
					<tr class = "active-row">
						<td><%=courses_courseID%></td>
						<td><%=title %></td>
						<td><%=resultSet3.getInt("registrationNumber")%></td>
						<td><%=resultSet3.getInt("grade")%></td>
					</tr>
		<%
				}
			}
		connection.close();
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
   </table>
</body>
</html>
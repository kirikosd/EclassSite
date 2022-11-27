<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>

<%@page import="java.sql.*,java.util.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
response.sendRedirect("ClassAssignment.jsp");

int courseID = Integer.parseInt(request.getParameter("courseID"));
String professors_afm = request.getParameter("professors_afm");

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/coursegrades?allowPublicKeyRetrieval=true&useSSL=false", "root", "test123");	
		
	String updateQuery = "UPDATE courses SET professors_afm = ? WHERE courseID = ?";
	
	PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
	preparedStatement.setString(1, professors_afm);
	preparedStatement.setInt(2, courseID);
	preparedStatement.executeUpdate();	
	
	out.println("Assignment Succesfull!");
} catch (Exception e) {
	System.out.print(e);
	e.printStackTrace();
}
%>

package com.dao;

import com.model.Students;
import com.model.Secretaries;
import com.model.Professors;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Dao stands for database access object
// this class is responsible for the connections with the database
public class Dao {
				
	// function that validates whether the data given in the login form are correct 
	public boolean validate(Students student) throws ClassNotFoundException {
		
		boolean status = false;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		try (
			// establish the connection with the database javacom.models giving the url and the database's username and password
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/coursegrades?allowPublicKeyRetrieval=true&useSSL=false", "root", "test123");	
			PreparedStatement preparedStatement = connection.prepareStatement("select * from students where username = ? and password = ?")
			)
		{
			// the prepared statement gets its values from the student object given as a parameter to the validate function
			preparedStatement.setString(1, student.getUsername());
			preparedStatement.setString(2, student.getPassword());
			
			// execute the prepared statement 
			ResultSet rs = preparedStatement.executeQuery();
			status = rs.next();		
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		// if the prepared statement gets executed, the boolean status is set to true and thus the validation is successful
		return status;		
	}	
	
	// function that validates whether the data given in the login form are correct 
	public boolean validate(Professors professor) throws ClassNotFoundException {
		
		boolean status = false;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		try (
			// establish the connection with the database javacom.models giving the url and the database's username and password
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/coursegrades?allowPublicKeyRetrieval=true&useSSL=false", "root", "test123");	
			PreparedStatement preparedStatement = connection.prepareStatement("select * from professors where username = ? and password = ?")
			)
		{
			// the prepared statement gets its values from the professor object given as a parameter to the validate function
			preparedStatement.setString(1, professor.getUsername());
			preparedStatement.setString(2, professor.getPassword());
			
			// execute the prepared statement 
			ResultSet rs = preparedStatement.executeQuery();
			status = rs.next();		
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		// if the prepared statement gets executed, the boolean status is set to true and thus the validation is successful
		return status;		
	}
	
	// function that validates whether the data given in the login form are correct 
	public boolean validate(Secretaries secretary) throws ClassNotFoundException {
		
		boolean status = false;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		try (
			// establish the connection with the database javacom.models giving the url and the database's username and password
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/coursegrades?allowPublicKeyRetrieval=true&useSSL=false", "root", "test123");	
			PreparedStatement preparedStatement = connection.prepareStatement("select * from secretaries where username = ? and password = ?")
			)
		{
			// the prepared statement gets its values from the secretary object given as a parameter to the validate function
			preparedStatement.setString(1, secretary.getUsername());
			preparedStatement.setString(2, secretary.getPassword());
			
			// execute the prepared statement 
			ResultSet rs = preparedStatement.executeQuery();
			status = rs.next();		
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		// if the prepared statement gets executed, the boolean status is set to true and thus the validation is successful
		return status;		
	}	
}

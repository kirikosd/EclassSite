package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.model.Courses;

public class CoursesDao {

    public List<Courses> getAllCourses() throws ClassNotFoundException {
    	
    	Class.forName("com.mysql.cj.jdbc.Driver");
    	
        List<Courses> Courses = new ArrayList<Courses>();
        try (
        	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/coursegrades?allowPublicKeyRetrieval=true&useSSL=false", "root", "test123");	
    		PreparedStatement preparedStatement = connection.prepareStatement("select * from courses");
    		){
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from courses");
            while (rs.next()) {
                Courses Course = new Courses();
                ((com.model.Courses) Courses).setCourseID(rs.getInt("courseID"));
                ((com.model.Courses) Courses).setTitle(rs.getString("title"));
                ((com.model.Courses) Courses).setProfessors_afm(rs.getString("professors_afm"));
                ((com.model.Courses) Courses).setDepartment(rs.getString("department"));
                ((com.model.Courses) Courses).setSemester(rs.getInt("semester"));
          
                Courses.add(Course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return Courses;
    }
}
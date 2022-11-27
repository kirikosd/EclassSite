package com.model;

public class Grades {
	String courseID;
	int grade;
	static String registrationNumber ;
	
	public String getCourseID() {
		return courseID;
	}
	public void setCourseID(String courseID) {
		this.courseID = courseID;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public static String getRegistrationNumber() {
		return registrationNumber;
	}
	public static void setRegistrationNumber(String registrationNumber) {
		Grades.registrationNumber = registrationNumber;
	}
	
}

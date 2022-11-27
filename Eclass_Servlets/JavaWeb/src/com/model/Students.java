package com.model;

public class Students extends Users {
	private String department,registrationNumber;
	int usersCounter = 0;
	
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public int getUsersCounter() {
		return usersCounter;
	}
	public void setUsersCounter(int usersCounter) {
		this.usersCounter = usersCounter;
	}
	public String getRegistrationNumber() {
		return registrationNumber;
	}
	public void setRegistrationNumber(String registrationNumber) {
		this.registrationNumber = registrationNumber;
	}
	
}

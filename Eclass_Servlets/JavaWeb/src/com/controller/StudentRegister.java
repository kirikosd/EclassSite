package com.controller;

import java.io.IOException;
import java.security.SecureRandom;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.model.Encryption;
import com.model.Students;
import com.model.Users;
import com.dao.StudentDao;

@WebServlet("/StudentRegister")
public class StudentRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// create an object of the Dao class in order to manage the connection with the database
	private StudentDao STdao;
	
	// when this servlet gets initialized, the STdao object gets instantiated
	public void init() {
		STdao = new StudentDao();
	}
       
    public StudentRegister() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WebContent/StudentRegister.jsp");
		dispatcher.forward(request, response);
		
	}
	
	// doPost method used to retrieve the user input from the register.jsp form and then store the user's data in the database
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// request and store the user input from the register.jsp form
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String surname = request.getParameter("surname");
		String email = request.getParameter("email");
		String department = request.getParameter("department");
		String registrationNumber = request.getParameter("registrationNumber");
		
		// hash the password
		SecureRandom random = new SecureRandom();
		byte bytes[] = new byte[20];
		random.nextBytes(bytes);		
		String hashed_password = Encryption.getHashMD5(password, random.toString());
		
		// create a new student using the user input from the register.jsp form
		Students student = new Students();
		student.setUsername(username);
		student.setPassword(hashed_password);
		student.setName(name);
		student.setSurname(surname);
		student.setEmail(email);
		student.setDepartment(department);
		student.setRegistrationNumber(registrationNumber);
		
		// create a new user using the user input from the register.jsp form
		Users user = new Users();
		user.setUsername(username);
		user.setPassword(hashed_password);
		user.setName(name);
		user.setSurname(surname);
		user.setEmail(email);
		
		try {
			/*
			 * insert the user in the database by using the Dao.insert() function
			 * the user has to be inserted before the student because the student's 'username' field 
			 * is foreign key to the user's primary key 'username'  
			 */
			
			int result3 = STdao.insert(user);
			int result2 = STdao.insert(student);
			
			if (result2 != 0 && result3 != 0) {
				
				// wait 2 seconds before redirecting to next page
				try {
				    Thread.sleep(5 * 1000);
				} catch (InterruptedException ie) {
				    Thread.currentThread().interrupt();
				}
				response.sendRedirect("Login.jsp");
			} else {
				response.sendRedirect("registrationFailed.html");
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
	}

}
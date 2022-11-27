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
import com.model.Users;
import com.dao.ProfessorDao;
import com.model.Professors;

/**
 * Servlet implementation class AdminRegistration
 */
@WebServlet("/ProfessorRegister")
public class ProfessorRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// create an object of the Dao class in order to manage the connection with the database
	private ProfessorDao PRdao;
	
	// when this servlet gets initialized, the dao object gets instantiated
	public void init() {
		PRdao = new ProfessorDao();
	}

    public ProfessorRegister() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WebContent/ProfessorRegister.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// request and store the user input from the register.jsp form
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String surname = request.getParameter("surname");
		String email = request.getParameter("email");
		String department = request.getParameter("department");
		String afm = request.getParameter("afm");
		
		// hash the password
		SecureRandom random = new SecureRandom();
		byte bytes[] = new byte[20];
		random.nextBytes(bytes);		
		String hashed_password = Encryption.getHashMD5(password, random.toString());
						
		Professors professor = new Professors();
		professor.setUsername(username);
		professor.setPassword(hashed_password);
		professor.setName(name);
		professor.setSurname(surname);
		professor.setEmail(email);
		professor.setDepartment(department);
		professor.setAfm(afm);
		
		Users user = new Users();
		user.setUsername(username);
		user.setPassword(hashed_password);
		user.setName(name);
		user.setSurname(surname);
		user.setEmail(email);
		
		try {
			/*
			 * insert the user in the database by using the Dao.insert() function
			 * the user has to be inserted before the patient because the patient's 'username' field 
			 * is foreign key to the user's primary key 'username'  
			 */

			int result3 = PRdao.insert(user);
			int result2 = PRdao.insert(professor);
			
			if (result2 != 0 && result3 != 0) {
				
				// wait 2 seconds before redirecting to next page
				try {
				    Thread.sleep(5 * 1000);
				} catch (InterruptedException ie) {
				    Thread.currentThread().interrupt();
				}
				response.sendRedirect("Login.jsp");
			}else {
				response.sendRedirect("registrationFailed.html");
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		
	}

}

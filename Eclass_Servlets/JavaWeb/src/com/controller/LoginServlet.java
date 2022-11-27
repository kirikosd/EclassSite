package com.controller;

import java.io.IOException;
import java.security.SecureRandom;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.model.Secretaries;
import com.model.Professors;
import com.model.Encryption;
import com.model.Students;
import com.dao.Dao;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// create an object of the Dao class in order to manage the connection with the database
	private Dao dao;
	
	// when this servlet gets initialized, the dao object gets instantiated
	public void init() {
		dao = new Dao();
	}
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WebContent/Login.jsp");
		dispatcher.forward(request, response);
	}
	
	// doPost method used in order to manage the login data of the user from the login.jsp form
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// request and store the user input from the login.jsp form
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		// hash the password
		SecureRandom random = new SecureRandom();
		byte bytes[] = new byte[20];
		random.nextBytes(bytes);		
		String hashed_password = Encryption.getHashMD5(password, random.toString());
						
		Students student = new Students();
		student.setUsername(username);
		student.setPassword(hashed_password);
		
		Professors professor = new Professors();
		professor.setUsername(username);
		professor.setPassword(hashed_password);
		
		Secretaries secretary = new Secretaries();
		secretary.setUsername(username);
		secretary.setPassword(hashed_password);
		
		// check if the user is a student, professor or secretary and redirect him to the corresponding page
		try {

			if (dao.validate(student)) {
				
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				
				response.sendRedirect("StudentMenu.jsp");
			}
			else if (dao.validate(professor)) {
				
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				
				response.sendRedirect("ProfessorMenu.jsp");				
			}
			else if (dao.validate(secretary)) {
				
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				
				response.sendRedirect("SecretaryMenu.jsp");				
			}	
			else {
				
				// if the validation wasn't successful, redirect to error 401 page
				response.sendRedirect("loginFailed.html");
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
}
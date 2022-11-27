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
import com.dao.SecretaryDao;
import com.model.Secretaries;

/**
 * Servlet implementation class AdminRegistration
 */
@WebServlet("/SecretaryRegister")
public class SecretaryRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// create an object of the Dao class in order to manage the connection with the database
	private SecretaryDao SECdao;
	
	// when this servlet gets initialized, the dao object gets instantiated
	public void init() {
		SECdao = new SecretaryDao();
	}

    public SecretaryRegister() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WebContent/SecretaryRegister.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// request and store the user input from the register.jsp form
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String surname = request.getParameter("surname");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String afm = request.getParameter("afm");
		
		// hash the password
		SecureRandom random = new SecureRandom();
		byte bytes[] = new byte[20];
		random.nextBytes(bytes);		
		String hashed_password = Encryption.getHashMD5(password, random.toString());
						
		Secretaries secretary = new Secretaries();
		secretary.setUsername(username);
		secretary.setPassword(hashed_password);
		secretary.setName(name);
		secretary.setSurname(surname);
		secretary.setEmail(email);
		secretary.setPhone(phone);
		secretary.setAfm(afm);
		
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

			int result3 = SECdao.insert(user);
			int result2 = SECdao.insert(secretary);
			
			if (result2 != 0 && result3 != 0){
				
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
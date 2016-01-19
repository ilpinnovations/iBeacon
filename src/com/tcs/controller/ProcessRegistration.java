package com.tcs.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tcs.util.DatabaseUtil;

/**
 * Servlet implementation class ProcessRegistration
 */
public class ProcessRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		//prevents direct access to the servlet
		String referer = request.getHeader("referer");
		
		String userName = request.getParameter("userName");
		String email = request.getParameter("email");
		
		if(referer==null){
			response.sendRedirect("unauthorisedAccess.jsp");
			return ;
		}
		try {
			Connection cnn = DatabaseUtil.getConnection();
			
			PreparedStatement st3 = cnn.prepareStatement("select * from geo_user where email=?");
			st3.setString(1,email);
			
			ResultSet rs3 = st3.executeQuery();
			if(DatabaseUtil.getRowCount(rs3)>0){
				HttpSession session=request.getSession();
				session.setAttribute("msg","sameUser");
				response.sendRedirect("index.jsp");
			}else{
		
		
		
		GregorianCalendar calendar = new GregorianCalendar();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String lastVisit = format.format(new Date(calendar.getTime().getTime()));
		String tokenID = request.getSession().getId();
		
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		
		

		
		
		
		try {
			
			PreparedStatement st = cnn.prepareStatement("INSERT INTO geo_user (USER_NAME,EMAIL,LAST_VISIT,TOKEN_ID,PASSWORD) VALUES(?,?,?,?,?)");

			st.setString(1,userName );
			st.setString(2, email);
			st.setString(3, lastVisit);
			st.setString(4, tokenID);
			st.setString(5, password);
 
			int count = st.executeUpdate();
			
			if(count!=0){
				System.out.println("User Registered Successfully!");
				request.setAttribute("source", "regPage");
				System.out.println();
				request.getRequestDispatcher("AuthUser").forward(request, response);
			}else{
				System.out.println("User Registration Failed!");
				HttpSession session = request.getSession();
				session.setAttribute("msg", "Failed");
				request.getRequestDispatcher("index.jsp").forward(request, response);				
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("User Registration Failed!");
			HttpSession session = request.getSession();
			session.setAttribute("msg", "Failed");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}	
			}
	}catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
}
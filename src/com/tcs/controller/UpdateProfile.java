package com.tcs.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tcs.util.DatabaseUtil;

/**
 * Servlet implementation class UpdateProfile
 */
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
 	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		session.removeAttribute("msg");
		String referer = request.getHeader("referer");
		if(referer==null){
			response.sendRedirect("unauthorisedAccess.jsp");
			return ;
		}
		String val = session.getAttribute("userID").toString();
		int userID = Integer.valueOf(val);
		
		String userName = request.getParameter("userName");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String dob = request.getParameter("dob");
		String email = request.getParameter("email");
		String oldpassword = request.getParameter("oldpassword");
		String newpassword = request.getParameter("newpassword");
		
		try {
			Connection cnn = DatabaseUtil.getConnection();
			PreparedStatement st1 = cnn.prepareStatement("select * from geo_user where user_id=? and password=?");
			st1.setInt(1,userID);
			st1.setString(2,oldpassword); 
			ResultSet rs1=st1.executeQuery();
			if(DatabaseUtil.getRowCount(rs1)==0){
				session.setAttribute("msg", "password");
				request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
				
			
			}else{
			
			
			
			
			
			PreparedStatement st = cnn.prepareStatement("UPDATE geo_user SET USER_NAME = ?, EMAIL =?,password=? WHERE email = ?");

			st.setString(1, userName);
			st.setString(2, email);
			st.setString(3, newpassword);
			st.setString(4,email);
			
			int count = st.executeUpdate();
			
			if(count!=0){
				System.out.println("User Details Updated Successfully!");
				
				cnn = DatabaseUtil.getConnection();
				
				st = cnn.prepareStatement("SELECT password,USER_ID,USER_NAME,EMAIL,LAST_VISIT,TOKEN_ID FROM geo_user WHERE email = ?");
			
				
				st.setString(1, request.getParameter("email"));
				
				ResultSet rSet = st.executeQuery();
				
				if(rSet.next()){
					
					session.setAttribute("userID", rSet.getInt("USER_ID"));
					session.setAttribute("userName", rSet.getString("USER_NAME"));
					session.setAttribute("email", rSet.getString("EMAIL"));
					session.setAttribute("password", rSet.getString("password"));
					session.setAttribute("tokenID", rSet.getString("TOKEN_ID"));
				}
				session.setAttribute("msg", "success");
				request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
			}else{
				session.setAttribute("msg", "failed");
				request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
				
			}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		
		
	}
	
	
}

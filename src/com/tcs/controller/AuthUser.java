package com.tcs.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tcs.bean.AppUtil;
import com.tcs.util.DatabaseUtil;

/**
 * Servlet implementation class AuthUser
 */
public class AuthUser extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAuthenticate(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doAuthenticate(request, response);
	}

	protected void doAuthenticate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// prevents direct access to the servlet
		Connection cnn = null;
		try {
			cnn = DatabaseUtil.getConnection();

			PreparedStatement st = cnn.prepareStatement(
					"SELECT USER_ID,USER_NAME,EMAIL,LAST_VISIT,TOKEN_ID,password FROM geo_user WHERE Email = ? AND PASSWORD = ?");

			st.setString(1, request.getParameter("email"));
			st.setString(2, request.getParameter("password"));

			ResultSet rSet = st.executeQuery();

			if (rSet.next()) {
				HttpSession session = request.getSession();

				session.setAttribute("userID", rSet.getInt("USER_ID"));
				session.setAttribute("userName", rSet.getString("USER_NAME"));
				session.setAttribute("email", rSet.getString("EMAIL"));
				session.setAttribute("tokenID", rSet.getString("TOKEN_ID"));
				session.setAttribute("password", rSet.getString("password"));
				String lastVisit = rSet.getString("LAST_VISIT");

				Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(lastVisit);
				lastVisit = new SimpleDateFormat("EEE, d MMM yyyy hh:mm:ss aaa").format(date);
				System.out.println(lastVisit);
				System.out.println(date.getTime());
				st = cnn.prepareStatement("UPDATE geo_user SET LAST_VISIT = ? WHERE USER_ID = ?");

				GregorianCalendar calendar = new GregorianCalendar();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				String updatedLastVisit = format.format(new Date(calendar.getTime().getTime()));
				session.setAttribute("lastVisit",
						lastVisit + " (" + AppUtil.toDuration(calendar.getTime().getTime() - date.getTime()) + ")");

				System.out.println("Calender " + updatedLastVisit);

				st.setString(1, updatedLastVisit);
				st.setInt(2, rSet.getInt("USER_ID"));

				st.executeUpdate();

				session.setAttribute("msg", "Success");
				response.sendRedirect("dashboard.jsp");
			} else {
				System.out.println("login failed");
				HttpSession session = request.getSession();
				session.setAttribute("msg", "Failed");
				response.sendRedirect("index.jsp");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

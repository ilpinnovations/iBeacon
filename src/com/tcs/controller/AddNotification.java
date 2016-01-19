package com.tcs.controller;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthScrollBarUI;

import org.apache.http.client.ClientProtocolException;
import org.json.JSONException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tcs.util.DatabaseUtil;

/**
 * Servlet implementation class ProcessTrigger
 */
public class AddNotification extends HttpServlet {
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

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String referer = request.getHeader("referer");
		if (referer == null) {
			response.sendRedirect("unauthorisedAccess.jsp");
			return;
		}

		HttpSession session = request.getSession();

		try {

			// parameters from session
			String val = session.getAttribute("userID").toString();

			int userID = Integer.valueOf(val);
			String tokenID = (String) session.getAttribute("tokenID");

			// parameters from request
			int radius = Integer.parseInt(request.getParameter("radius"));	

			String bName = request.getParameter("bName");
			String notification = request.getParameter("notification");
			int beacon_id = 0;
			Connection cnn = DatabaseUtil.getConnection();
			PreparedStatement st2 = cnn.prepareStatement("select uuid from geo_user where user_id=?");
			st2.setInt(1, userID);
			ResultSet rs2 = st2.executeQuery();
			while (rs2.next()) {
				String uuid = rs2.getString("uuid").toString().trim();
				if (uuid.equals("") || uuid == null) {
					request.getRequestDispatcher("addNotification.jsp").forward(request, response);
				} else {
					PreparedStatement st1 = cnn
							.prepareStatement("select beacon_id from add_beacon where beacon_name=? and token_id=?");
					st1.setString(1, bName);
					st1.setString(2, tokenID);
					ResultSet rs = st1.executeQuery();
					while (rs.next()) {
						beacon_id = rs.getInt("beacon_id");
					}
					PreparedStatement st = cnn.prepareStatement("INSERT INTO b_notify(beacon_id,notification,radius,token_id,status) values(?,?,?,?,?)");
					st.setInt(1, beacon_id);
					st.setString(2, notification);
					st.setInt(3,radius);
					st.setString(4, tokenID);
					st.setString(5, "Enabled");
					int count = st.executeUpdate();

					if (count != 0) {
						System.out.println("Insertion successful!");
						session.setAttribute("notify", "success");
					} else {
						session.setAttribute("notify", "failed");
					}
					request.getRequestDispatcher("addNotification.jsp").forward(request, response);
				}

			}
		} catch (

		Exception e)

		{
			e.printStackTrace();
			session.setAttribute("notify", "failed");
			request.getRequestDispatcher("addNotification.jsp").forward(request, response);

		}

	}
}

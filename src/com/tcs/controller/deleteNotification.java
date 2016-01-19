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
public class deleteNotification extends HttpServlet {
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

			int notifyID = Integer.parseInt(request.getParameter("notify_id"));
			Connection cnn = DatabaseUtil.getConnection();
			PreparedStatement st2 = cnn.prepareStatement("delete from b_notify where notify_id=?");
			st2.setInt(1, notifyID);
			int count = st2.executeUpdate();
			if (count > 0) {
				session.setAttribute("delete", "success");
				request.getRequestDispatcher("viewNotification.jsp").forward(request, response);
			} else {
				session.setAttribute("delete", "failed");
				request.getRequestDispatcher("viewNotification.jsp").forward(request, response);

			}
		} catch (

		Exception e)

		{
			e.printStackTrace();
			session.setAttribute("delete", "failed");
			request.getRequestDispatcher("viewNotification.jsp").forward(request, response);

		}

	}
}

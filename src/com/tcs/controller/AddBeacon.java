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

import org.apache.http.client.ClientProtocolException;
import org.json.JSONException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tcs.util.DatabaseUtil;

/**
 * Servlet implementation class ProcessTrigger
 */
public class AddBeacon extends HttpServlet {
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
		
		String referer = request.getHeader("referer");
		if(referer==null){
			response.sendRedirect("unauthorisedAccess.jsp");
			return ;
		}
		
		HttpSession session = request.getSession();

		try{
			
			
			// parameters from session
			String val = session.getAttribute("userID").toString();
			
			int userID = Integer.valueOf(val);
			String tokenID = (String)session.getAttribute("tokenID");

			
			String bName=request.getParameter("bName");
			int major=Integer.parseInt(request.getParameter("major"));
			int minor=0;
			if(request.getParameter("minor")==null||request.getParameter("minor").equals("")){
			minor=0;
			}else{
			minor=Integer.parseInt(request.getParameter("minor"));		
			}
			Connection cnn = DatabaseUtil.getConnection();
			
			PreparedStatement st2 = cnn
					.prepareStatement("select uuid from geo_user where user_id=?");
			st2.setInt(1,userID);
			ResultSet rs2 = st2.executeQuery();
				while(rs2.next()){
					String uuid=rs2.getString("uuid").toString().trim();
					if(uuid.equals("")||uuid==null){
						request.getRequestDispatcher("addBeacon.jsp").forward(request, response);
					}else{
			PreparedStatement st1 = cnn
					.prepareStatement("select * from add_beacon where beacon_name=? and token_id=?");
			st1.setString(1, bName);
			st1.setString(2, tokenID);
			ResultSet rs = st1.executeQuery();
			if(DatabaseUtil.getRowCount(rs)>0){
				session.setAttribute("add", "failedName");
				request.getRequestDispatcher("addBeacon.jsp").forward(request,response);
				
			}else{
			PreparedStatement st = cnn.prepareStatement("INSERT INTO add_beacon(token_id,beacon_name,major,minor,user_id) values(?,?,?,?,?)");
			st.setString(1, tokenID);
			st.setString(2, bName);
			st.setInt(3, major);
			st.setInt(4, minor);
			st.setInt(5,userID);
			int count = st.executeUpdate();

			if(count!=0){
				System.out.println("Insertion successful!");
				session.setAttribute("add", "success");
			}
			
			request.getRequestDispatcher("addBeacon.jsp").forward(request,response);
		}
		}
				}
		}
		catch(Exception e){
			e.printStackTrace();
			session.setAttribute("add", "failed");
			request.getRequestDispatcher("addBeacon.jsp").forward(request,response);
			
		}

	}
}

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
public class CreateBeacon extends HttpServlet {
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

		HttpSession session = request.getSession();

		try {
			String tokenID = request.getParameter("tokenID");

			String bName = request.getParameter("beaconName");
			String m = request.getParameter("major");
			int count = 0;
			if (bName == null || bName == "" || tokenID == null || m == null || tokenID == ""
					|| m == "") {

				if (bName == "" || bName == null) {
					String msg1 = "Beacon name Parameter missing. Please fill all the parameters";
					request.setAttribute("msg1", msg1);
					count++;
				}
				if (tokenID == "" || tokenID == null) {
					String msg2 = "TokenID Parameter missing. Please fill all the parameters";
					request.setAttribute("msg2", msg2);
					count++;
				}
				if (m == "" || m == null) {
					String msg3 = "Major ID Parameter missing. Please fill all the parameters";
					request.setAttribute("msg3", msg3);
					count++;
				}
				request.setAttribute("count1", count);
				request.getRequestDispatcher("Config.jsp").forward(request, response);

			} else {


				int major = Integer.parseInt(request.getParameter("major"));
				int minor = 0;
				if (request.getParameter("minor") == null || request.getParameter("minor").equals("")) {
					minor = 0;
				} else {
					minor = Integer.parseInt(request.getParameter("minor"));
				}
				Connection cnn = DatabaseUtil.getConnection();

				PreparedStatement st2 = cnn.prepareStatement("select uuid,user_id from geo_user where token_id=?");
				st2.setString(1, tokenID);
				ResultSet rs2 = st2.executeQuery();
				int userID = 0;
				if (DatabaseUtil.getRowCount(rs2) > 0) {
					while (rs2.next()) {
						String uuid = rs2.getString("uuid").toString().trim();
						userID = rs2.getInt("user_id");
						if (uuid.equals("") || uuid == null || uuid.equals("NULL")) {
							request.setAttribute("beacon", "uuid");
							request.getRequestDispatcher("Config.jsp").forward(request, response);
						} else {
							PreparedStatement st1 = cnn
									.prepareStatement("select * from add_beacon where beacon_name=? and token_id=?");
							st1.setString(1, bName);
							st1.setString(2, tokenID);
							ResultSet rs = st1.executeQuery();
							if (DatabaseUtil.getRowCount(rs) > 0) {
								request.setAttribute("beacon", "beaconName");
								request.getRequestDispatcher("Config.jsp").forward(request, response);

							} else {
								PreparedStatement st = cnn.prepareStatement(
										"INSERT INTO add_beacon(token_id,beacon_name,major,minor,user_id) values(?,?,?,?,?)");
								st.setString(1, tokenID);
								st.setString(2, bName);
								st.setInt(3, major);
								st.setInt(4, minor);
								st.setInt(5, userID);
								int count2 = st.executeUpdate();
								
								int beaconID=0;
								if (count2 != 0) {
									PreparedStatement st3 = cnn.prepareStatement(
											"select beacon_id from add_beacon where beacon_name=? and token_id=?");
									st3.setString(1, bName);
									st3.setString(2, tokenID);
									ResultSet rs3=st3.executeQuery();
									if(DatabaseUtil.getRowCount(rs3)>0){
									while(rs3.next()){
										beaconID=rs3.getInt("beacon_id");
									}
									}
									System.out.println("Insertion successful!");
									request.setAttribute("beaconID", beaconID);
									request.setAttribute("beacon", "success");
								}

								request.getRequestDispatcher("Config.jsp").forward(request, response);
							}
						}
					}
				} else {
					System.out.println("token id does not exixts");
					request.setAttribute("beacon", "token");
					request.getRequestDispatcher("Config.jsp").forward(request, response);

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("beacon", "failed");
			request.getRequestDispatcher("Config.jsp").forward(request, response);

		}

	}
}

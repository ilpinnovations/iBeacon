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
public class CreateNotification extends HttpServlet {
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
		try {
			String notification = request.getParameter("notify");
			String r = request.getParameter("radius");
			String b = request.getParameter("beacon_id");
			int count = 0;
			if (notification == null || notification == "" ||r==null||r==""|| b == null || b == "") {
				if (notification == "" || notification == null) {
					String msg1 = "Notification Parameter missing. Please fill all the parameters";
					request.setAttribute("msg1", msg1);
					count++;
				}
				
				if (b == "" || b == null) {
					String msg2 = "Beacon ID Parameter missing. Please fill all the parameters";
					request.setAttribute("msg2", msg2);
					count++;
				}
				if (r == "" || r == null) {
					String msg3 = "Radius Parameter missing. Please fill all the parameters";
					request.setAttribute("msg3", msg3);
					count++;
				}
				request.setAttribute("count1", count);
				request.getRequestDispatcher("Config.jsp").forward(request, response);

			} else {
				int radius = Integer.parseInt(request.getParameter("radius"));

				int beaconID = Integer.parseInt(b);
				Connection cnn = DatabaseUtil.getConnection();
				PreparedStatement st3 = cnn.prepareStatement("select * from add_beacon where beacon_id=?");
				st3.setInt(1, beaconID);
				ResultSet rs3 = st3.executeQuery();
				String tokenID = "";
				if (DatabaseUtil.getRowCount(rs3) > 0) {
					while (rs3.next()) {
						tokenID = rs3.getString("token_id");
					}

					PreparedStatement st2 = cnn.prepareStatement(
							"select uuid from geo_user where token_id in(select token_id from add_beacon where beacon_id=?)");
					st2.setInt(1, beaconID);
					ResultSet rs2 = st2.executeQuery();
					while (rs2.next()) {
						String uuid = rs2.getString("uuid").toString().trim();
						if (uuid.equals("") || uuid == null || uuid.equals("NULL")) {
							request.setAttribute("Notification", "uuid");
							request.getRequestDispatcher("Notify.jsp").forward(request, response);
						} else {
							PreparedStatement st = cnn.prepareStatement(
									"INSERT INTO b_notify(beacon_id,notification,radius,token_id,status) values(?,?,?,?,?)");
							st.setInt(1, beaconID);
							st.setString(2, notification);
							st.setInt(3, radius);
							st.setString(4, tokenID);
							st.setString(5, "Enabled");
							int count2 = st.executeUpdate();

							if (count2 != 0) {
								System.out.println("Insertion successful!");
								request.setAttribute("Notification", "success");
							} else {
								request.setAttribute("Notification", "failed");
							}
							request.getRequestDispatcher("Notify.jsp").forward(request, response);
						}

					}
				} else {
					request.setAttribute("Notification", "config");
					request.getRequestDispatcher("Notify.jsp").forward(request, response);
				}
			}
		} catch (

		Exception e)

		{
			e.printStackTrace();
			request.setAttribute("Notification", "failed");
			request.getRequestDispatcher("addNotification.jsp").forward(request, response);

		}

	}
}

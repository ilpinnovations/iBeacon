
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.tcs.util.DatabaseUtil;

public class Beacon extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String tokenID = request.getParameter("token_id");
			response.setContentType("text/html");
			JSONObject triggerInfo = null;
			JSONObject mainObject = new JSONObject();
			JSONArray triggerArray = new JSONArray();
			String uuid = null;

			Connection cnn = DatabaseUtil.getConnection();

			PreparedStatement st2 = cnn.prepareStatement("SELECT uuid FROM geo_user WHERE TOKEN_ID = ?");
			st2.setString(1, tokenID);
			ResultSet rSet2 = st2.executeQuery();
			while (rSet2.next()) {
				uuid = rSet2.getString("uuid");
				System.out.println(uuid);
			}

			PreparedStatement st = cnn.prepareStatement("SELECT * FROM add_beacon WHERE TOKEN_ID = ?");

			st.setString(1, tokenID);
			int radius = 0;

			ResultSet rSet = st.executeQuery();

			if (DatabaseUtil.getRowCount(rSet) > 0) {
				int beacon_id = 0;
				String beaconName = null;
				String major = null;
				String minor = null;
				
				while (rSet.next()) {

					beacon_id = rSet.getInt("beacon_id");
					beaconName = rSet.getString("beacon_name");
					major = rSet.getString("major");
					minor = rSet.getString("minor");

					PreparedStatement st1 = cnn.prepareStatement("SELECT * FROM b_notify WHERE beacon_ID = ?");

					st1.setInt(1, beacon_id);

					ResultSet rSet1 = st1.executeQuery();
					String notificationText = "";
					int r=0;
					while (rSet1.next()) {
						notificationText = rSet1.getString("notification");
						r = rSet1.getInt("radius");
						
					}

					System.out.println("notification");
					triggerInfo = new JSONObject();
					triggerInfo.put("tokenID", tokenID);
					triggerInfo.put("beaconName", beaconName);
					triggerInfo.put("uuid", uuid);
					triggerInfo.put("major", major);
					triggerInfo.put("minor", minor);
					triggerInfo.put("radius", r);
					triggerInfo.put("notificationText", notificationText);

					triggerArray.put(triggerInfo);

					mainObject.put("triggerData", triggerArray);

				} // end of while
				System.out.println(mainObject.toString());
				response.getWriter().write(mainObject.toString());
			} // end of if

			else {
				JSONObject triggerInfo2 = new JSONObject();
				triggerArray.put(triggerInfo2);
				mainObject.put("nullTrigger", triggerArray);
				response.getWriter().write(mainObject.toString());
			}
		} catch (

		Exception e)

		{
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

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
public class UuidConfig extends HttpServlet {
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
			// parameters from session
			int count=0;
			String tokenID = request.getParameter("tokenID");
			String uuid = request.getParameter("uuid");
			if (uuid == null || uuid == "" || tokenID == null || tokenID == "") {
				if (tokenID == "" || tokenID == null) {
					String msg1 = "TokenID Parameter missing. Please fill all the parameters";
					request.setAttribute("msg1", msg1);
					count++;
				}
				if (uuid == "" || uuid == null) {
					String msg2 = "UUID Parameter missing. Please fill all the parameters";
					request.setAttribute("msg2", msg2);
					count++;
				}
				request.setAttribute("count", count);
				request.getRequestDispatcher("Config.jsp").forward(request,
						response);
				
			} else {

				Connection cnn = DatabaseUtil.getConnection();
				PreparedStatement st2 = cnn.prepareStatement("select * from geo_user  where token_id=?");
				st2.setString(1, tokenID);
				ResultSet rs2 = st2.executeQuery();
				if (DatabaseUtil.getRowCount(rs2) > 0) {

					PreparedStatement st1 = cnn.prepareStatement("update geo_user set uuid=? where token_id=?");
					st1.setString(1, uuid);
					st1.setString(2, tokenID);
					int count1 = st1.executeUpdate();
					if (count1 > 0) {
						System.out.println("updated");
						session.setAttribute("config", "success");
						request.getRequestDispatcher("Config.jsp").forward(request, response);

					} else {
						session.setAttribute("config", "failed");
						request.getRequestDispatcher("Config.jsp").forward(request, response);

					}
				} else {
					session.setAttribute("token", "failed");
					request.getRequestDispatcher("Config.jsp").forward(request, response);

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("config", "failed");
			request.getRequestDispatcher("Config.jsp").forward(request, response);

		}

	}
}

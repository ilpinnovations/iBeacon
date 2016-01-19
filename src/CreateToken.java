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
public class CreateToken extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public int count = 0;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}

	protected void doProcess(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("userName");
		String email = request.getParameter("email");
		GregorianCalendar calendar = new GregorianCalendar();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String lastVisit = format
				.format(new Date(calendar.getTime().getTime()));
		String tokenID = request.getSession().getId();
		System.out.println("tokenId:" + tokenID);
		int count=0;
		String password = request.getParameter("password");
		if (userName == null || userName == ""|| email == null
				|| tokenID == null || password == null
				|| email == "" ||tokenID == ""
				|| password == "") {

			if (userName == "" || userName == null) {
				String msg1 = "User name Parameter missing. Please fill all the parameters";
				request.setAttribute("msg1", msg1);
				count++;
			}
			if (email == "" || email == null) {
				String msg2 = "Email Parameter missing. Please fill all the parameters";
				request.setAttribute("msg2", msg2);
				count++;
			}
			if (password == "" || password == null) {
				String msg3 = "Password Parameter missing. Please fill all the parameters";
				request.setAttribute("msg3", msg3);
				count++;
			}
			request.setAttribute("count", count);
			request.getRequestDispatcher("TokenFailure.jsp").forward(request,
					response);
			
		}
		try {
			Connection cnn = DatabaseUtil.getConnection();
			
			PreparedStatement st3 = cnn.prepareStatement("select * from geo_user where email=?");
			st3.setString(1,email);
			System.out.println(email);
			
			ResultSet rs3 = st3.executeQuery();
			if(DatabaseUtil.getRowCount(rs3)>0){
				request.setAttribute("msg4","Email id already registered.");
				request.getRequestDispatcher("TokenFailure.jsp").forward(request, response);;
			}else{
			PreparedStatement st = cnn
					.prepareStatement("INSERT INTO geo_user(USER_NAME,EMAIL,LAST_VISIT,TOKEN_ID,PASSWORD) VALUES(?,?,?,?,?)");

			st.setString(1, userName);
			st.setString(2, email);
			st.setString(3, lastVisit);
			st.setString(4, tokenID);
			st.setString(5, password);

			int c = st.executeUpdate();

			if (c != 0) {
				System.out.println("User Registered Successfully!");
				request.setAttribute("tokenID", tokenID);
				request.setAttribute("source", "regPage");
				request.getRequestDispatcher("TokenSuccess.jsp").forward(
						request, response);
			} else {
				System.out.println("User Registration Failed!");
				request.getRequestDispatcher("TokenFailure.jsp").forward(
						request, response);

			}
			}

		} catch (Exception e) {
			String msg = e.getMessage();
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("TokenFailure.jsp").forward(request,
					response);
			e.printStackTrace();
		}

	}
}
package hbg.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hbg.dao.UserDAO;

public class RegisterEmailCheckAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Connection conn = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		int result = 0;
		
		String email = request.getParameter("user_id");
		UserDAO dao = UserDAO.getInstance();
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			result = dao.emailCheck(conn , email);
		}catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				conn.close();
			}
			catch (Exception e) {
			}
		}
		PrintWriter out = response.getWriter();
		out.print(result);
		
		return null;
		
	}
}

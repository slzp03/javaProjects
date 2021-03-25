package hbg.action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hbg.dao.UserDAO;

public class PwdScAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		
		String user_name = request.getParameter("user_name");
		String user_email = request.getParameter("user_email");
		
		UserDAO dao = UserDAO.getInstance();
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(jdbcDriver);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e) {

			}
		}
		
		int pwdSc =0;
		pwdSc=dao.NameChk(user_name, user_email);
		
		if (pwdSc == 1) {
			session.setAttribute("pwdSc", pwdSc);
			session.setAttribute("user_email", user_email);
			forward.setRedirect(true);
			forward.setNextPath("hbg?command=change.go");
		}
		else {
			session.setAttribute("pwdSc", pwdSc);
			forward.setRedirect(false);
			forward.setNextPath("hbg?command=pwdSc.go");
		}
		return forward;
	}

}

package hbg.action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Decoder.BASE64Encoder;
import KISA.SHA256;
import hbg.dao.UserDAO;

public class ChangeAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		String user_email = request.getParameter("user_email");
		String user_pass = request.getParameter("user_pass");
		String user_passok = request.getParameter("user_passok");
		
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
		
		SHA256 sha = new SHA256(user_pass.getBytes()); 
		BASE64Encoder base64Encoder = new BASE64Encoder(); 
		String tmpPw= base64Encoder.encode(sha.GetHashCode());
		sha = new SHA256(user_passok.getBytes()); 
		base64Encoder = new BASE64Encoder();
		String tmpPwOk = base64Encoder.encode(sha.GetHashCode());
		
		int change = 0;
		if(tmpPw.equals(tmpPwOk)) {
				
				change = dao.Modify(user_email,tmpPw);
		}
		
		if (change == 1) {
			session.setAttribute("change", change);
			forward.setRedirect(true);
			forward.setNextPath("hbg?command=login.go");
		}
		else {
			session.setAttribute("change", change);
			forward.setRedirect(false);
			forward.setNextPath("hbg?command=change.go");
		}
		return forward;
	}
	
	

}

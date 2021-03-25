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
import hbg.vo.UserVO;

public class LoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		
		String user_email = request.getParameter("user_email");
		String user_pass = request.getParameter("user_pass");

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
		int row = dao.UserLogin(user_email, tmpPw);
		HttpSession session = request.getSession();
		if (row == 1) {
			UserVO user = dao.GetUser(user_email);
			String user_image=user.getUser_image();
			if(user.getUser_status().equals("1")) {
			
			session.setAttribute("user", user);
			session.setAttribute("user_email", user_email);
			session.setAttribute("user_image", user_image);
			session.setMaxInactiveInterval(1800);
			forward.setRedirect(true);
			forward.setNextPath("/hbg?command=service.go");			
			}else {
				forward.setRedirect(false);
				forward.setNextPath("/hbg?command=registerok.go");	
			}
		} else {
			session.setAttribute("row", row);
			forward.setRedirect(false);
			forward.setNextPath("/hbg?command=login.go");
		}
		
		return forward;

	}

}

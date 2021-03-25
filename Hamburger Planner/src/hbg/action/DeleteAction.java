package hbg.action;

import java.io.File;
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


public class DeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		
		HttpSession session = request.getSession();
		String user_email = session.getAttribute("user_email").toString();
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
		  	
	        @SuppressWarnings("deprecation")
			String uploadFileName = request.getRealPath("/upload") +"/";
		  	
	        File uploadfile = new File (uploadFileName);
	       
		int del = 0;
		del = dao.Delete(user_email, tmpPw);
		
		if (del == 1) {
			 if ( uploadfile.exists()&& uploadfile.isFile() )
		        {
		             uploadfile.delete();    
		        }
			 session.setAttribute("del", del);
			forward.setRedirect(true);
			forward.setNextPath("hbg?command=index.go");
		}
		
		else {
			session.setAttribute("del", del);
			forward.setRedirect(false);
			forward.setNextPath("hbg?command=mypage.go");
		}
		return forward;
	}

}

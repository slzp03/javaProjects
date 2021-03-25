package hbg.action;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import KISA.SHA256;
import hbg.dao.UserDAO;
import Decoder.BASE64Encoder;

public class ModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		String savePath = request.getServletContext().getRealPath("upload");
		int sizeLimit = 1024 * 1024 * 15;
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8",
				new DefaultFileRenamePolicy());
		
		String user_name = multi.getParameter("user_name");
		String user_pass = multi.getParameter("user_pass");
		String user_passok = multi.getParameter("user_passok");
		String old_user_image = session.getAttribute("user_image").toString();
		
		String user_image = multi.getFilesystemName("user_image");
		//String m_fileFullPath = savePath + "/" + user_image;
		
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
		
		if(user_image==null) {
			user_image=old_user_image;
		}else {

	            File f = new File(savePath + "\\" + old_user_image);  

	            if(f.exists()){
	               f.delete();
	            }else{
	            }
	         }
		int modi = 0;
		if(tmpPw.equals(tmpPwOk)) {
				modi = dao.Modify(user_name, tmpPw, user_image);
		}
		

		if (modi == 1) {
			session.setAttribute("modi", modi);
			forward.setRedirect(true);
			forward.setNextPath("hbg?command=mypage.go");
		}
		else {
			session.setAttribute("modi", modi);
			forward.setRedirect(false);
			forward.setNextPath("hbg?command=mypage.go");
		}
		return forward;
	}

}

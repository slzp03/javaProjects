package hbg.action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import Decoder.BASE64Encoder;
import KISA.SHA256;
import hbg.dao.UserDAO;
import hbg.util.EmailConfirm;
import hbg.vo.UserVO;

public class RegisterInsertAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		
		MultipartRequest multi = null;
		UserDAO dao = UserDAO.getInstance();
		UserVO vo = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		Connection conn = null;
		
		String savePath = request.getServletContext().getRealPath("upload");
		String encType="UTF-8";
		int sizeLimit=2*1024*1024;
		
		ActionForward forward = new ActionForward();
		
		try {
			multi = new MultipartRequest(request, savePath, sizeLimit, encType, new DefaultFileRenamePolicy());
			vo = new UserVO();
			conn = DriverManager.getConnection(jdbcDriver);
			String passwd = multi.getParameter("user_pass");
			SHA256 sha = new SHA256(passwd.getBytes());
			BASE64Encoder base64Encoder = new BASE64Encoder();

			String uuid = UUID.randomUUID().toString().substring(0, 8);
			SHA256 sha2 = new SHA256(uuid.getBytes());
			BASE64Encoder base64Encoder2 = new BASE64Encoder();
			EmailConfirm emailCon = new EmailConfirm();
			
			String user_name = multi.getParameter("user_name");
			String email = multi.getParameter("user_email");
			
			String user_image = multi.getFilesystemName("user_image_file");
			String key = base64Encoder2.encode(sha2.GetHashCode());
			String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
			key = key.replaceAll(match, "X");
			
			vo.setUser_name(user_name);
			if(user_image==null) {
				vo.setUser_image("0");
			}else {
			vo.setUser_image(user_image);
			}
			vo.setUser_email(email);
			vo.setUser_pass(base64Encoder.encode(sha.GetHashCode()));
			vo.setUser_activation_key(key);
			emailCon.connectEmail(email, key);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int result = dao.insertUser(conn, vo);

		if (result == 1) {
			forward.setRedirect(true);
			forward.setNextPath("hbg?command=registerok.go");
			return forward;
		} else {
			request.setAttribute("result", result);
			forward.setRedirect(false);
			forward.setNextPath("hbg?command=register.go");
			return forward;
		}

	}

}
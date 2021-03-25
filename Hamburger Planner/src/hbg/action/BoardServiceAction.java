package hbg.action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hbg.dao.BoardDAO;

public class BoardServiceAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		String user = request.getParameter("user");
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		BoardDAO dao = BoardDAO.getInstance();
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			int userno = dao.userNo(user);
			dao.BoardServiceAdd(conn, userno, boardno);
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

		return null;
	}

}

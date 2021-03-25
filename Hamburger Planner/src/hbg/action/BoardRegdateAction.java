package hbg.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hbg.dao.BoardDAO;

public class BoardRegdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		String regdate = "";
		int board_no = Integer.parseInt(request.getParameter("boardno"));
		BoardDAO dao = BoardDAO.getInstance();
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			regdate = dao.BoardRegdate(conn, board_no);
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
		out.print(regdate.substring(0,10));
		
		return null;
	}

}

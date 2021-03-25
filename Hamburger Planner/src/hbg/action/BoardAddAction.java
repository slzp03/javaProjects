package hbg.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hbg.dao.BoardDAO;

public class BoardAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		int result = 0;
		String add_type = request.getParameter("boardtype");
		BoardDAO dao = BoardDAO.getInstance();
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			result = dao.BoardAdd(conn, add_type);
			dao.BoardTypeAdd(conn, result, add_type);
			
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

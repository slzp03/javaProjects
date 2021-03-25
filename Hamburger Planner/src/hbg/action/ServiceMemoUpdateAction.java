package hbg.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hbg.dao.BoardDAO;

public class ServiceMemoUpdateAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		
		BoardDAO dao = BoardDAO.getInstance();
		
		HttpSession session = request.getSession();		
		String user = (String) session.getAttribute("user_email");

		int user_no = dao.userNo(user);
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		String memo_content = request.getParameter("memo_content");
		
		try {
			dao.setUpdateMemo(user_no, board_no, memo_content);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		PrintWriter out = response.getWriter();
		out.print(1);
		
		return null;

	}

}
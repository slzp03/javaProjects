package hbg.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hbg.dao.BoardDAO;
import hbg.vo.BoardVO;

public class ServiceAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		
		ActionForward forward = new ActionForward();
		
		BoardDAO dao = BoardDAO.getInstance();
		ArrayList<BoardVO> service = null;
		
		HttpSession session = request.getSession();		
		String user = (String) session.getAttribute("user_email");

		int user_no = dao.userNo(user);
		
		try {
			service = dao.getService(user_no);
			request.setAttribute("service", service);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		forward.setRedirect(false);
		forward.setNextPath("/HBG/hbg-service.jsp");
		return forward;

	}

}
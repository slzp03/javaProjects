package hbg.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginTestAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		ActionForward forward = new ActionForward();

		String user_email = request.getParameter("user_email");
		String user_pass = request.getParameter("user_pass");
		
		int row = 0;
		
		if (user_email.equals("test") && user_pass.equals("1234")) {
			row = 1;
		}

		if (row == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("user", "TESTER");
			session.setAttribute("user_email", user_email);
			session.setMaxInactiveInterval(1800);
			forward.setRedirect(true);
			forward.setNextPath("/hbg?command=service.go");
		} else {
			request.setAttribute("row", row);
			forward.setRedirect(false);
			forward.setNextPath("/hbg?command=login.go");
		}

		return forward;

	}

}

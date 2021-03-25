package hbg.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 ActionForward forward = new ActionForward();
	        
	        // ?��그??��?��??��?��??��?�� ??��?��??��?��??��?��?��?��?? ?��?�� ??��?��??��?��??��?��??��?��.
	        request.getSession().invalidate();
	        
	        // ?��그??��?��??��?�� ??��?�� ?��그??��?��?��?��?��? ??��?��??��?��?�?��.
	        forward.setRedirect(true);
	        forward.setNextPath("hbg?command=login.go");
	        
	        return forward;
	}

}

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
	        
	        // ?°úÍ∑∏??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ?≥¥?øΩ?? ?™®?ëê ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ.
	        request.getSession().invalidate();
	        
	        // ?°úÍ∑∏??øΩ?øΩ??øΩ?øΩ ??øΩ?øΩ ?°úÍ∑∏??øΩ?øΩ?∞Ω?úº?øΩ? ??øΩ?øΩ??øΩ?øΩ?∞?ã§.
	        forward.setRedirect(true);
	        forward.setNextPath("hbg?command=login.go");
	        
	        return forward;
	}

}

package hbg.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hbg.action.Action;
import hbg.action.ActionForward;
import hbg.action.BoardAddAction;
import hbg.action.BoardDeleteAction;
import hbg.action.BoardRegdateAction;
import hbg.action.BoardServiceAction;
import hbg.action.ChangeAction;
import hbg.action.DeleteAction;
import hbg.action.LoginAction;
import hbg.action.LogoutAction;
import hbg.action.ModifyAction;
import hbg.action.PwdScAction;
import hbg.action.RegisterEmailCheckAction;
import hbg.action.RegisterInsertAction;
import hbg.action.ServiceAction;
import hbg.action.ServiceBoardOrderAction;
import hbg.action.ServiceCheckTextUpdateAction;
import hbg.action.ServiceCheckboxUpdateAction;
import hbg.action.ServiceMemoUpdateAction;
import hbg.action.ServiceTitleUpdateAction;

@WebServlet("/hbg")
public class HbgController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	public HbgController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doProcess(request, response);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String command = request.getParameter("command");
//		System.out.println("Command Value : " + command);

		ActionForward forward = null;
		Action action = null;
		
		if (command.equals("index.go")) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setNextPath("/");
		} else if (command.equals("login.go")) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setNextPath("/HBG/hbg-login.jsp");
		}else if (command.equals("change.go")) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setNextPath("/HBG/hbg-pwdChg.jsp");
		}else if (command.equals("pwdSc.go")) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setNextPath("/HBG/hbg-pwdSc.jsp");
		}else if (command.equals("mypage.go")) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setNextPath("/HBG/hbg-mypage.jsp");
		} else if (command.equals("pwfind.go")) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setNextPath("/HBG/hbg-pwfind.jsp");
		} else if (command.equals("register.go")) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setNextPath("/HBG/hbg-register.jsp");
		} else if (command.equals("registerok.go")) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setNextPath("/HBG/hbg-register-email.jsp");
		} else if (command.equals("service.go")) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setNextPath("/hbg?command=service.do");
		}
		
		/* REGISTER */
		
		else if (command.equals("RegisterEmailCheck.do")) {
			action = new RegisterEmailCheckAction();
			forward = action.execute(request, response);
		}
		else if (command.equals("RegisterInsert.do")) {
			action = new RegisterInsertAction();
			forward = action.execute(request, response);
		}
		
		/* LOGIN */
		
		else if (command.equals("change.do")) {
			action = new ChangeAction();
			forward = action.execute(request, response);
		}
		
		else if (command.equals("pwdSc.do")) {
			action = new PwdScAction();
			forward = action.execute(request, response);
		}
		
		else if (command.equals("login.do")) {
			action = new LoginAction();
			forward = action.execute(request, response);
	    }
		else if (command.equals("logout.do")) {
			action = new LogoutAction();
			forward = action.execute(request, response);
		}
		else if (command.equals("modify.do")) {
			action = new ModifyAction();
			forward = action.execute(request, response);
		}
		else if (command.equals("delete.do")) {
			action = new DeleteAction();
			forward = action.execute(request, response);
			
		}
		
		/* SERVICE */
		else if (command.equals("service.do")) {
			action = new ServiceAction();
			forward = action.execute(request, response);
		} else if (command.equals("boardadd.do")) {
			action = new BoardAddAction();
			forward = action.execute(request, response);
		} else if (command.equals("boardregdate.do")) {
			action = new BoardRegdateAction();
			forward = action.execute(request, response);
		} else if (command.equals("userno.do")) {
			action = new BoardServiceAction();
			forward = action.execute(request, response);
		} else if (command.equals("boarddelete.do")) {
			action = new BoardDeleteAction();
			forward = action.execute(request, response);
		} else if (command.equals("boardorder.do")) {
			action = new ServiceBoardOrderAction();
			forward = action.execute(request, response);
		} else if (command.equals("titleupdate.do")) {
			action = new ServiceTitleUpdateAction();
			forward = action.execute(request, response);
		} else if (command.equals("memoupdate.do")) {
			action = new ServiceMemoUpdateAction();
			forward = action.execute(request, response);
		} else if (command.equals("checkboxupdate.do")) {
			action = new ServiceCheckboxUpdateAction();
			forward = action.execute(request, response);
		} else if (command.equals("checktextupdate.do")) {
			action = new ServiceCheckTextUpdateAction();
			forward = action.execute(request, response);
		}		
		
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getNextPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getNextPath());
				dispatcher.forward(request, response);
			}
		}

	}

}

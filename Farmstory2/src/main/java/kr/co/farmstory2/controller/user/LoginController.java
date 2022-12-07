package kr.co.farmstory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.farmstory2.dao.UserDAO;
import kr.co.farmstory2.vo.UserVO;

@WebServlet("/user/login.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/login.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		String auto = req.getParameter("auto");
		
		UserDAO dao = UserDAO.getInstance();
		UserVO vo = dao.selectUser(uid, pass);
		
		if(vo != null) {
			HttpSession session = req.getSession();
			session.setAttribute("sessUser", vo);
			
			if(auto != null) {
				String sessId = session.getId();
				
				// 쿠키생성
				Cookie cookie = new Cookie("SESSID", sessId);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*3);
				resp.addCookie(cookie);
				
				// 세션정보 데이터베이스 저장
				dao.updateUserForSession(uid, sessId);
			}
			resp.sendRedirect("/Farmstory2/index.do");
			
		}else {
			// 회원 아님
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
		    out.println("<script>alert('일치하는 회원이 없습니다.\\n아이디, 비밀번호를 다시 확인 하시기 바랍니다.'); location.href='/Farmstory2/user/login.do?success=100' </script>");
		    out.flush();
		}
	}
}

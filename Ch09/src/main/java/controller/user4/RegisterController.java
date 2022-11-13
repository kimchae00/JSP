package controller.user4;

import java.io.IOException;



import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.User4Dao;
import vo.User4Vo;

@WebServlet("/user4/register.do")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// forward
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user4/register.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		// POST 요청
		String seq = req.getParameter("seq");
		String name = req.getParameter("name");
		String gender = req.getParameter("gender");
		String age = req.getParameter("age");
		String addr = req.getParameter("addr");
		
		User4Vo vo = new User4Vo();
		vo.setSeq(seq);
		vo.setName(name);
		vo.setGender(gender);
		vo.setAge(age);
		vo.setAddr(addr);
		
		User4Dao.getInstance().insertUser(vo);

		// 리다이렉트
		resp.sendRedirect("/Ch09/user4/list.do");
	}
}

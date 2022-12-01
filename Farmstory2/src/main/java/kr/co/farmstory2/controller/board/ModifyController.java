package kr.co.farmstory2.controller.board;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/modify.do")
public class ModifyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String no = req.getParameter("no");
		String pg = req.getParameter("pg");

		ArticleVO vo = ArticleDAO.getInstance().selectArticle(no);
		req.setAttribute("vo", vo);
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		req.setAttribute("no", no);
		req.setAttribute("pg", pg);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/modify.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String pg = req.getParameter("pg");
		String no = req.getParameter("no");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		ArticleDAO.getInstance().updateArticle(no, title, content);
		 
		resp.sendRedirect("/Farmstory2/board/view.do?group="+group+"&cate="+cate+"&no="+no+"&pg="+pg);
	}
}

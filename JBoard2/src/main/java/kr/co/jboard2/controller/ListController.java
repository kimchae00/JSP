package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/list.do")
public class ListController extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/list.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String pg = req.getParameter("pg");
		
		int start = 0;
		int total = 0;
		int lastPageNum = 0;
		int currentPage = 1;
		int currentpageGroup = 1;
		int pageGroupStart = 0;
		int pageGroupEnd = 0;
		int pageStartNum = 0;
		
		if(pg != null) {
			currentPage = Integer.parseInt(pg);
		}
		
		start = (currentPage - 1) * 10;
		currentpageGroup = (int)Math.ceil(currentPage / 10.0);
		pageGroupStart = (currentpageGroup - 1) * 10 + 1;
		pageGroupEnd = currentpageGroup * 10;
		
		ArticleDAO dao = ArticleDAO.getInstance();
		
		// 전체 게시물 갯수
		total = dao.selectCountTotal();
		
		// 마지막 페이지 번호
		if(total % 10 == 0) {
			lastPageNum = total / 10;
			
		}else {
			lastPageNum = total / 10 + 1;
		}
		
		if(pageGroupEnd > lastPageNum){
			pageGroupEnd = lastPageNum;
		}
		
		pageStartNum = total - start;
		
		List<ArticleVO> article = dao.selectArticles(start);
		
		String no = req.getParameter("no");
		String title = req.getParameter("title");
		String comment = req.getParameter("comment");
		String nick = req.getParameter("nick");
		String rdate = req.getParameter("rdate");
		String hit = req.getParameter("hit");
		
		ArticleVO vo = new ArticleVO();
		vo.setNo(no);
		vo.setTitle(title);
		vo.setComment(comment);
		vo.setNick(nick);
		vo.setRdate(rdate);
		vo.setHit(hit);
		
		req.setAttribute("vo", vo);
		
	}
}

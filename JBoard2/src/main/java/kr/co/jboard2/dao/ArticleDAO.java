package kr.co.jboard2.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.FileVO;

public class ArticleDAO extends DBHelper {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	public int insertArticle(ArticleVO vo) {
		
		int parent = 0;
		
		try {
			logger.info("insertArticle");
			conn = getConnection();
			
			conn.setAutoCommit(false);
			
			stmt = conn.createStatement();
			psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			
			psmt.setString(1, vo.getTitle());
			psmt.setString(2, vo.getContent());
			psmt.setInt(3, vo.getFname() == null ? 0 : 1);
			psmt.setString(4, vo.getUid());
			psmt.setString(5, vo.getRegip());
			
			psmt.executeUpdate();
			rs = stmt.executeQuery(Sql.SELECT_MAX_NO);
			
			conn.commit();
			
			if(rs.next()) {
				parent = rs.getInt(1);
			}
			close();
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return parent;
	}
	
	public void insertFile(int parent, String newName, String fname) {
		try {
			logger.info("insertfile");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public ArticleVO insertComment(ArticleVO comment) {
		
		ArticleVO vo = null;
		
		try{
			logger.info("insertComment start...");
			conn = getConnection();
			
			// 트랜잭션 시작
			conn.setAutoCommit(false);
			
			psmt = conn.prepareStatement(Sql.INSERT_COMMENT);
			stmt = conn.createStatement();
			
			psmt.setInt(1, comment.getParent());
			psmt.setString(2, comment.getContent());
			psmt.setString(3, comment.getUid());
			psmt.setString(4, comment.getRegip());
			psmt.executeUpdate();
			rs = stmt.executeQuery(Sql.SELECT_COMMENT_LATEST);
			
			// 작업 확정
			conn.commit();
			
			if(rs.next()) {
				vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setContent(rs.getString(6));
				vo.setRdate(rs.getString(11).substring(2, 10));
				vo.setNick(rs.getString(12));
			}
			close();
			
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		
		return vo;
	}
	
	public ArticleVO selectArticle(String no) {
		
		ArticleVO vo = null;
		
		try {
			logger.info("selectArticle");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, no);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11));
				vo.setFno(rs.getInt(12));
				vo.setOriName(rs.getString(13));
				vo.setDownload(rs.getInt(14));
			}
			close();
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	public List<ArticleVO> selectArticles(int start) {
		
		List<ArticleVO> articles = new ArrayList<>();
		
		try {
			logger.info("selectArticles");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setInt(1, start);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11).substring(2, 10));
				vo.setNick(rs.getString(12));
				
				articles.add(vo);
			}
			close();
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return articles;
	}
	
	public int selectCountTotal() {
		
		int total = 0;
		
		try {
			logger.info("selectCountTotal");
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_COUNT_TOTAL);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			close();
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return total;
	}
	
	public FileVO selectfile(String fno) {
		FileVO fv = null;
		try{
			logger.info("selectFile start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_FILE);
			psmt.setString(1, fno);
			
			rs = psmt.executeQuery();
			if(rs.next()){
				fv = new FileVO();
				fv.setFno(rs.getInt(1));
				fv.setParent(rs.getInt(2));
				fv.setNewName(rs.getString(3));
				fv.setOriName(rs.getString(4));
				fv.setDownload(rs.getInt(5));
				fv.setRdate(rs.getString(6));
			}
			close();
			
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return fv;
	}
	
	public List<ArticleVO> selectComments(String parent) {
		
		List<ArticleVO> comments = new ArrayList<>();
		
		try {
			logger.info("selectComments start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO comment = new ArticleVO();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setComment(rs.getInt(3));
				comment.setCate(rs.getString(4));
				comment.setTitle(rs.getString(5));
				comment.setContent(rs.getString(6));
				comment.setFile(rs.getInt(7));
				comment.setHit(rs.getInt(8));
				comment.setUid(rs.getString(9));
				comment.setRegip(rs.getString(10));
				comment.setRdate(rs.getString(11).substring(2, 10));
				comment.setNick(rs.getString(12));
				
				comments.add(comment);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return comments;
	}
	
	public void updateArticle(String title, String content, String no) {
		try {
			logger.info("updateArticle");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void updateArticleHit(String no) {
		
		try {
			logger.info("updateArticleHit");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	public void updateFileDownload(String fno) {
		try{
			logger.info("updateFileDownload start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_FILE_DOWNLOAD);
			psmt.setString(1, fno);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e){
			logger.error(e.getMessage());
		}
	}
	
	public int updateComment(String no, String content) {
		
		int result = 0;
		
		try{
			logger.info("updateComment start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			
			result = psmt.executeUpdate();
			close();
			
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return result;
	}
	
	public int removeComment(String no) {
		
		int result = 0;
		
		try {
			logger.info("removeComment start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.REMOVE_COMMENT);
			psmt.setString(1, no);
			
			result = psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	public void deleteArticle(String no) {
		try {
			logger.info("deleteArticle start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	public String deleteFile(String parent) {
		
		String newName = null;
		
		try {
			logger.info("deleteFile start...");
			conn = getConnection();
			
			conn.setAutoCommit(false);
			
			PreparedStatement psmt1 = conn.prepareStatement(Sql.SELECT_FILE_WITH_PARENT); 
			PreparedStatement psmt2 = conn.prepareStatement(Sql.DELETE_FILE);
			psmt1.setString(1, parent);
			psmt2.setString(1, parent);
			
			rs = psmt1.executeQuery();
			psmt2.executeUpdate();
			
			conn.commit();
			
			if(rs.next()) {
				newName = rs.getString(3);
			}
			
			psmt1.close();
			psmt2.close();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return newName;
	}

}

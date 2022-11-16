<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	dao.updateArticleHit(no);
	
	ArticleBean ab = dao.selectArticle(no);
	
	
	
	
	pageContext.include("./_"+group+".jsp");
%>
<main id="board" class="view">
    <table>
        <caption>글보기</caption>
        <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="<%= ab.getTitle() %>" readonly></td>
        </tr>
        <% if(ab.getFile() > 0){ %>
        <tr>
            <th>파일</th>
            <td><a href="./proc/download.jsp?fno=<%= ab.getFno() %>"><%= ab.getOriName() %></a>&nbsp;<span><%= ab.getDownload() %></span>회 다운로드</td>
        </tr>
        <% } %>
        <tr>
            <th>내용</th>
            <td><textarea name="content" readonly><%= ab.getContent() %></textarea></td>
        </tr>
    </table>
    <div>
    	<% if(sessUser.getUid().equals(ab.getUid())){ %>
        <a href="./proc/deleteProc.jsp?group=<%= group %>&cate=<%= cate %>&no=<%= ab.getNo() %>&pg=<%= pg %>" class="btn btnRemove">삭제</a>
        <a href="./modify.jsp?group=<%= group %>&cate=<%= cate %>&no=<%= ab.getNo() %>&pg=<%= pg %>" class="btn btnModify">수정</a>
        <% } %>
        <a href="./list.jsp?group=<%= group %>&cate=<%= cate %>" class="btn btnList">목록</a>
    </div>
    <!-- 댓글 목록 -->
    <section class="commentList">
        <h3>댓글목록</h3>
        <article>
            <span class="nick">길동이</span>
            <span class="date">20-05-13</span>
            <p class="content">댓글 샘플입니다.</p>
            <div>
                <a href="#" class="Remove">삭제</a>
                <a href="#" class="Modify">수정</a>
            </div>
        </article>
        <p class="empty">등록된 댓글이 없습니다.</p>
    </section>
    <!-- 댓글 쓰기 -->
    <section class="commentForm">
        <h3>댓글쓰기</h3>
        <form action="#">
            <textarea name="content" placeholder="댓글내용 입력"></textarea>
            <div>
                <a href="#" class="btn btnCancel">취소</a>
                <input type="submit" class="btn btnComplete" value="작성완료"/>
            </div>
        </form>
    </section>
</main>    
<%@ include file="../_footer.jsp" %>
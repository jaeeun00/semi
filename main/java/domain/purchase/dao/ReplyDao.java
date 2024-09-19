package domain.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import domain.purchase.vo.Board;
import domain.purchase.vo.Reply;
import domain.user.vo.User;
import utils.DaoHelper;

public class ReplyDao {
	
	public void deleteReplyByNo(int replyNo) throws SQLException {
		String sql = """
			delete from book_purchase_replies
			where purchase_reply_no = ?	
		""";
		
		DaoHelper.delete(sql, replyNo);
	}
	
	public Reply getReplyByNo(int replyNo) throws SQLException {
		String sql = """
			select *
			from book_purchase_replies
			where purchase_reply_no = ?
		""";
		
		return DaoHelper.selectOne(sql, rs -> {
			Reply reply = new Reply();
			reply.setNo(rs.getInt("purchase_reply_no"));
			reply.setContent(rs.getString("purchase_reply_content"));
			reply.setCreatedDate(rs.getDate("created_date"));
			
			Board board = new Board();
			board.setNo(rs.getInt("purchase_no"));
			reply.setBoard(board);
			
			User user = new User();
			user.setUserNo(rs.getInt("user_no"));
			reply.setUser(user);
			
			return reply;
		}, replyNo);
	}
	
	public List<Reply> getReplyListByBoardNo(int boardNo) throws SQLException {
		String sql = """
			select A.purchase_reply_no
				, A.purchase_reply_content
				, A.created_date
				, B.user_no
				, B.user_nickname
			from book_purchase_replies A, users B
			where A.purchase_no = ?
			and A.user_no = B.user_no
			order by A.purchase_reply_no asc				
		""";
		
		return DaoHelper.selectList(sql, rs -> {
			Reply reply = new Reply();
			reply.setNo(rs.getInt("purchase_reply_no"));
			reply.setContent(rs.getString("purchase_reply_content"));
			reply.setCreatedDate(rs.getDate("created_date"));
 			
			User user = new User();
			user.setUserNo(rs.getInt("user_no"));
			user.setNickname(rs.getString("user_nickname"));
			reply.setUser(user);
			
			return reply;
			
		}, boardNo);
	}
	
	public void insertReply(Reply reply) throws SQLException {
	    String sql = """
	        insert into book_purchase_replies
	        (purchase_reply_no, purchase_reply_content, purchase_no, user_no, parent_purchase_reply_no)
	        values
	        (BOOK_PURCHASE_REPLYNO_SEQ.nextval, ?, ?, ?, ?)
	    """;

	    Integer parentNo = reply.getParent_no() == 0 ? null : reply.getParent_no();  // 최상위 댓글이면 null 처리
	    
	    DaoHelper.insert(sql
	            , reply.getContent()
	            , reply.getBoard().getNo()
	            , reply.getUser().getUserNo()
	            , parentNo);
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

package domain.qna.dao;

import domain.qna.vo.Qna;
import domain.user.vo.User;
import utils.DaoHelper;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QnaDao {
	
	// 카테고리번호를 받아서 게시글을 가져온다 
	public List<Qna> getQnaByCategoryNo(int categoryNo) {
		String sql="""
			SELECT Q.QNA_NO, 
					   Q.QNA_TITLE,
					   Q.QNA_CONTENT,
					   Q.QNA_CATEGORY_NO,
					   Q.CREATED_DATE,
					   Q.UPDATED_DATE,
					   Q.QNA_STATUS,
					   U.USER_NO,
					   U.USER_NICKNAME,
					   Q.ISDELETED,
					   BU.user_no bad_user_no,
				       BU.user_nickName bad_user_nickname
				FROM BOOK_QNA_BOARDS Q
				JOIN USERS U ON Q.USER_NO = U.USER_NO
				left join users BU on q.bad_user_no = BU.user_no
				WHERE Q.CATEGORY_NO=? 	
		""";
		 return DaoHelper.selectList(sql, rs -> {
	            Qna qna = new Qna();
	            qna.setNo(rs.getInt("QNA_NO"));
	            qna.setTitle(rs.getString("QNA_TITLE"));
	            qna.setContent(rs.getString("QNA_CONTENT"));
	            qna.setCategoryNo(rs.getInt("QNA_CATEGORY_NO"));
	            qna.setCreatedDate(rs.getDate("CREATED_DATE"));
	            qna.setUpdatedDate(rs.getDate("UPDATED_DATE"));
	            qna.setStatus(rs.getString("QNA_STATUS"));
	            qna.setIsDeleted(rs.getString("ISDELETED"));

	            User user = new User();
	            user.setUserNo(rs.getInt("USER_NO"));
	            user.setNickname(rs.getString("user_nickname"));
	            qna.setUser(user);

	            User badUser = new User();
	            badUser.setUserNo(rs.getInt("bad_user_no"));
	            badUser.setNickname(rs.getString("bad_user_nickname"));
	            qna.setBadUser(badUser);
	            
	            return qna;
	        }, categoryNo);
	    }
	
	// 변경할 정보가 반영된 게시글정보를 전달받아서 테이블에 반영시킨다.
	public void updateQna(Qna qna) throws SQLException{
		String sql="""
		update book_qna_boards
		set 
		qna_title = ?
		,qna_content = ?
		,qna_category_no = ?
		,created_date = ?
		,updated_date = sysdate
		,qna_status = ? 
		,user_no = ?
		,bad_user_no = ?
		,isdeleted = ?
		where qna_no = ?
		""";
		
		DaoHelper.update(sql,
				qna.getTitle()
			   ,qna.getContent()
			   ,qna.getCategoryNo()
			   ,qna.getCreatedDate()
			   ,qna.getStatus()
			   ,qna.getUser().getUserNo()
			   ,qna.getBadUser().getUserNo()
			   ,qna.getIsDeleted()
			   ,qna.getNo()
				);
	}
	
	// 유저닉네임으로 유저번호를 가져온다.
	public int getUserNoByUserNickName(String nickName) throws SQLException{
		String sql = """
				SELECT USER_NO
				FROM USERS
				WHERE USER_NICKNAME = ?
				""";
		return DaoHelper.selectOneInt(sql,nickName);
	}
	
	
	// 게시글 상세보기 
	public Qna getQnabyNo(int qnaNo) throws SQLException{
		String sql="""
				SELECT Q.QNA_NO, 
					   Q.QNA_TITLE,
					   Q.QNA_CONTENT,
					   Q.QNA_CATEGORY_NO,
					   Q.CREATED_DATE,
					   Q.UPDATED_DATE,
					   Q.QNA_STATUS,
					   U.USER_NO,
					   U.USER_NICKNAME,
					   Q.ISDELETED,
					   BU.user_no bad_user_no,
				       BU.user_nickName bad_user_nickname
				FROM BOOK_QNA_BOARDS Q
				JOIN USERS U ON Q.USER_NO = U.USER_NO
				left join users BU on q.bad_user_no = BU.user_no
				WHERE Q.QNA_NO=?
		""";
		return DaoHelper.selectOne(sql, rs->{
			Qna qna = new Qna();
			qna.setNo(rs.getInt("QNA_NO"));
			qna.setTitle(rs.getString("QNA_TITLE"));
			qna.setContent(rs.getString("QNA_CONTENT"));
			qna.setCategoryNo(rs.getInt("QNA_CATEGORY_NO"));
			qna.setCreatedDate(rs.getDate("CREATED_DATE"));
			qna.setUpdatedDate(rs.getDate("UPDATED_DATE"));
			qna.setStatus(rs.getString("QNA_STATUS"));
			qna.setIsDeleted(rs.getString("ISDELETED"));
			
			User user = new User();
			user.setUserNo(rs.getInt("USER_NO"));
			user.setNickname(rs.getString("user_nickname"));
			qna.setUser(user);
			
			User badUser = new User();
            badUser.setUserNo(rs.getInt("bad_user_no"));
            badUser.setNickname(rs.getString("bad_user_nickname"));
            qna.setBadUser(badUser);
			
			return qna;
			
		},qnaNo);
	}
	
	
	// 유저닉네임으로 숫자세서 존재여부 확인
    public boolean checkUserNickname(String nickname) {
        String sql = """
        		SELECT COUNT(*)
        		FROM USERS 
        		WHERE USER_NICKNAME = ?
        		"""; 
        int count = DaoHelper.selectOneInt(sql, nickname); // DaoHelper를 사용하여 닉네임 카운트 조회
        return count > 0; // 0보다 크면 존재함
    }

    
	// 유저번호를 받아서 글 목록을 가져온다.
    public List<Qna> getQnaByUserNo(int userNo) {
        String sql = """
           SELECT Q.QNA_NO,
                  Q.QNA_TITLE,
                  Q.QNA_CONTENT,
                  Q.QNA_CATEGORY_NO,
                  Q.CREATED_DATE,
                  Q.UPDATED_DATE,
                  Q.QNA_STATUS,
        		  Q.ISDELETED,
                  U.USER_NO,
                  U.USER_NICKNAME,
                  BU.user_no bad_user_no,
                  BU.user_nickName bad_user_nickname
                  
           FROM BOOK_QNA_BOARDS Q
           JOIN USERS U ON Q.USER_NO = U.USER_NO
           left join users BU on q.bad_user_no = BU.user_no
           WHERE U.USER_NO = ?
           AND Q.ISDELETED = 'NO'
        """;

        return DaoHelper.selectList(sql, rs -> {
            Qna qna = new Qna();
            qna.setNo(rs.getInt("QNA_NO"));
            qna.setTitle(rs.getString("QNA_TITLE"));
            qna.setContent(rs.getString("QNA_CONTENT"));
            qna.setCategoryNo(rs.getInt("QNA_CATEGORY_NO"));
            qna.setCreatedDate(rs.getDate("CREATED_DATE"));
            qna.setUpdatedDate(rs.getDate("UPDATED_DATE"));
            qna.setStatus(rs.getString("QNA_STATUS"));
            qna.setIsDeleted(rs.getString("ISDELETED"));

            User user = new User();
            user.setUserNo(rs.getInt("USER_NO"));
            user.setNickname(rs.getString("user_nickname"));
            qna.setUser(user);

            User badUser = new User();
            badUser.setUserNo(rs.getInt("bad_user_no"));
            badUser.setNickname(rs.getString("bad_user_nickname"));
            qna.setBadUser(badUser);
            
            return qna;
        }, userNo);
    }

    
    // Qna 객체에 내용저장
    public void insertBoard(Qna qna) {
        String sql = """
            INSERT INTO book_qna_boards
            (QNA_NO,
             QNA_TITLE,
             QNA_CONTENT,
             QNA_CATEGORY_NO,
             UPDATED_DATE,
             QNA_STATUS,
             USER_NO,
             BAD_USER_NO,
             ISDELETED)
            VALUES
            (book_qna_no_seq.nextval, ?, ?, ?, ?, ?, ?, ?, 'NO')
        """;

        DaoHelper.insert(sql,
            qna.getTitle(),
            qna.getContent(),
            qna.getCategoryNo(),
            qna.getUpdatedDate(),
            qna.getStatus(),
            qna.getUser().getUserNo(),
            qna.getBadUser() != null ? qna.getBadUser().getUserNo() : null);
    }

    
}

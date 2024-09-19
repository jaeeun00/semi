package domain.purchase.dao;

import domain.book.vo.Book;
import domain.user.vo.User;
import utils.DaoHelper;
import utils.RowMapper;
import domain.purchase.vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class BoardDao {

	/**
	 * 전체 게시글 개수를 조회해서 반환한다.
	 *
	 * @return 게시글 개수, 삭제된 게시글은 제외한다.
	 * @throws SQLException
	 */
	public int getTotalRows() throws SQLException {
		String sql = """
					select count(*) cnt
					from book_purchase_boards
					where isdeleted = 'NO'
				""";
		Integer result = DaoHelper.selectOne(sql, (rs) -> rs.getInt("cnt"));

		return result != null ? result : 0;
	}

	/**
	 * 새 게시글 정보를 전달받아서 테이블에 저장시킨다.
	 *
	 * @param board 새 게시글 정보
	 * @throws SQLException
	 */
	public void insertBoard(Board board) throws SQLException {
		String sql = """
					insert into book_purchase_boards
					(purchase_no
					 , purchase_title
					 , purchase_content
					 , purchase_price
					 , book_no
					 , user_no)
					values
					(book_purchase_no_seq.nextval, ?, ?, ?, ?, ?)
				""";

		DaoHelper.insert(sql, board.getTitle(), board.getContent(), board.getPrice(), board.getBook().getNo(), board.getUser().getUserNo());

	}

	/**
	 * 조회 범위에 맞는 게시글 목록을 조회해서 반환한다.
	 * @param begin 시작 일련번호
	 * @param end   끝 일련번호
	 * @return 게시글 목록
	 * @throws SQLException
	 */
	public List<Board> getBoards(int begin, int end) throws SQLException {
		String sql = """
				    select *
				    from (
				        select row_number() over (order by B.purchase_no desc) row_num
				             , B.purchase_no
				             , B.purchase_title
				             , B.purchase_content
				             , B.purchase_price
				             , B.created_date
				             , B.updated_date
				             , B.purchase_view_count
				             , B.purchase_like_count
				             , B.isdeleted
				             , U.user_no
				             , U.user_nickname
				        from book_purchase_boards B
				        join users U on B.user_no = U.user_no
				        where B.isdeleted = 'NO'
				    )
				    where row_num between ? and ?
				""";

		return DaoHelper.selectList(sql, rs -> {
			Board board = new Board();
			board.setNo(rs.getInt("purchase_no"));
			board.setTitle(rs.getString("purchase_title"));
			board.setContent(rs.getString("purchase_content"));
			board.setPrice(rs.getInt("purchase_price"));
			board.setCreatedDate(rs.getDate("created_date"));
			board.setUpdatedDate(rs.getDate("updated_date"));
			board.setViewCount(rs.getInt("purchase_view_count"));
			board.setLikeCount(rs.getInt("purchase_like_count"));
			board.setIsDeleted(rs.getString("isdeleted"));

			User user = new User();
			user.setUserNo(rs.getInt("user_no"));
			user.setNickname(rs.getString("user_nickname"));
			board.setUser(user);

			return board;
		}, begin, end);
	}

	/**
	 * 전달받은 게시글 번호에 대한 게시글정보를 조회해서 반환한다.
	 * @param no 조회할 게시글 번호
	 * @return 게시글 정보
	 * @throws SQLException
	 */
	public Board getBoardByNo(int no) throws SQLException {
		String sql = """
					select
						B.purchase_no,
						B.purchase_title,
						B.purchase_content,
						B.created_date,
						B.updated_date,
						B.purchase_price,
						B.purchase_view_count,
						B.purchase_like_count,
						B.isdeleted,
						U.user_no,
						U.user_nickname,
						l.book_no,
						l.book_title,
						l.book_author,
						l.book_publisher,
						l.book_price,
						l.book_date,
						l.book_stock,
						l.book_status,
						l.book_cover,
						c.book_category_no,
						c.book_category_name
					from
						book_purchase_boards B
					join
						users U on B.user_no = U.user_no
					join
						book_list l on B.book_no = l.book_no
					join
						book_categories c on l.book_category_no = c.book_category_no
					where
						B.purchase_no = ?
				""";

		return DaoHelper.selectOne(sql, rs -> {
			Board board = new Board();
			board.setNo(rs.getInt("purchase_no"));
			board.setTitle(rs.getString("purchase_title"));
			board.setContent(rs.getString("purchase_content"));
			board.setCreatedDate(rs.getDate("created_date"));
			board.setUpdatedDate(rs.getDate("updated_date"));
			board.setPrice(rs.getInt("purchase_price"));
			board.setViewCount(rs.getInt("purchase_view_count"));
			board.setLikeCount(rs.getInt("purchase_like_count"));
			board.setIsDeleted(rs.getString("isdeleted"));

			User user = new User();
			user.setUserNo(rs.getInt("user_no"));
			user.setNickname(rs.getString("user_nickname"));
			board.setUser(user);

			Book book = new Book();
			book.setNo(rs.getInt("book_no"));
			book.setTitle(rs.getString("book_title"));
			book.setAuthor(rs.getString("book_author"));
			book.setPublisher(rs.getString("book_publisher"));
			book.setPrice(rs.getInt("book_price"));
			book.setDate(rs.getString("book_date"));
			book.setStock(rs.getInt("book_stock"));
			book.setStatus(rs.getString("book_status"));
			book.setCover(rs.getString("book_cover"));
			book.setCategoryNo(rs.getInt("book_category_no"));

			board.setBook(book);

			return board;
		}, no);
	}

	/**
	 * 변경된 정보가 반영된 게시글 정보를 전달받아서 테이블에 반영시킨다.
	 * @param board 변경할 정보가 반영된 게시글 정보
	 * @throws SQLException
	 */
	public void updateBoard(Board board) throws SQLException {
		String sql = """
					update book_purchase_boards
					set purchase_title = ?
						, purchase_content = ?
						, created_date = ?
						, updated_date = sysdate
						, purchase_price = ?
						, purchase_view_count = ?
						, purchase_like_count = ?
						, user_no = ?
						, book_no = ?
						, isdeleted = ?
					where purchase_no = ?
				""";

		DaoHelper.update(sql,
				board.getTitle(),
				board.getContent(),
				board.getCreatedDate(),
				board.getPrice(),
				board.getViewCount(),
				board.getLikeCount(),
				board.getUser().getUserNo(),
				board.getBook().getNo(),
				board.getIsDeleted(),
				board.getNo()
		);
	}
	
	
	public Like getLikeByBoardNoAndUserNo(int boardNo, int userNo) {
	    String sql = """
	        select *
	        from book_purchase_likes
	        where purchase_no = ? and user_no = ?    
	    """;
	    
	    return DaoHelper.selectOne(sql, rs -> {
            Like like = new Like();
            like.setBoardNo(rs.getInt("purchase_no"));
            like.setUserNo(rs.getInt("user_no"));
            return like;
	        
	    }, boardNo, userNo);
	}
	
	/**
	 * 게시글번호, 사용자번호를 전달받아서 "좋아요 테이블"에 추가한다.
	 * @param boardNo 게시글번호
	 * @param userNo 사용자번호
	 * @throws SQLException
	 */
	public void insertLike(int boardNo, int userNo) throws SQLException {
		String sql = """
			insert into book_purchase_likes
			(purchase_no, user_no)
			values
			(?, ?)
		""";
		
		DaoHelper.insert(sql, boardNo, userNo);
	}
	
	/**
	 * 게시글번호, 사용자번호를 전달받아서 "좋아요 테이블"에서 행을 삭제한다.
	 * @param boardNo 게시글번호
	 * @param userNo 사용자번호
	 * @throws SQLException
	 */
	public void deleteLike(int boardNo, int userNo) throws SQLException {
		String sql = """
				delete from book_purchase_likes
				where purchase_no = ? and user_no = ?
		""";
			
		DaoHelper.insert(sql, boardNo, userNo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	/* 마이페이지에 필요한 메서드 */
	
	/**
	 * 마이페이지에 보여줄 구매합니다. 글 페이징 설정
	 * @param userNo
	 * @return 총 게시글 갯수
	 */
	public int getTotalRowsByUserNo(int userNo) {
		String sql = """
					select count(*) cnt
					from book_purchase_boards
					where isdeleted = 'NO'
					and user_no = ?
				""";
		
		return DaoHelper.selectOneInt(sql, userNo);
	}
	
	/**
	 * 마이페이지에 보여줄 구매합니다. 글 페이징
	 * @param begin
	 * @param end
	 * @param userNo
	 * @return 게시판 리스트
	 */
	public List<Board> getBoardsByUserNo(int userNo, int begin, int end) {
		String sql = """
				    select *
				    from (
				        select row_number() over (order by P.purchase_no desc) row_num
				             , P.purchase_no
				             , P.purchase_title
				             , P.purchase_price
				             , P.isdeleted
				             , B.book_title
				        from book_purchase_boards P
				        inner join book_list B
				        on B.book_no = P.book_no
				        where P.isdeleted = 'NO'
				        and P.user_no = ?
				    )
				    where row_num between ? and ?
				""";

		return DaoHelper.selectList(sql, rs -> {
			Board board = new Board();
			board.setNo(rs.getInt("purchase_no"));
			board.setTitle(rs.getString("purchase_title"));
			board.setPrice(rs.getInt("purchase_price"));
			board.setIsDeleted(rs.getString("isdeleted"));

			Book book = new Book();
			book.setTitle(rs.getString("book_title"));
			board.setBook(book);

			return board;
		}, userNo, begin, end);
	}
	
	/* 마이페이지에 필요한 메서드 끝 */
}
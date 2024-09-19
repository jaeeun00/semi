package domain.admin.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.user.vo.User;
import utils.DaoHelper;

public class AdminDao {
	
	/**
	 * 해당 유저가 관리자이면 true 반환, 관리자가 아니면 false를 반환한다.
	 * @param user 유저
	 * @return 관리자이면 true, 관리자가 아니면 false
	 * @throws SQLException
	 */
	public boolean isAdminUserByUser(User user) throws SQLException {
		if (user.getType().equals("ADMIN")) {
			return true;
		}
		return false;
	}
	
	/**
	 * Bookstore 사이트의 총 회원수를 집계해서 반환하는 메서드
	 * @return 사이트의 총 회원수
	 * @throws SQLException
	 */
	public int countTotalMembersInBookstore() throws SQLException {
		int totalMembers = 0;
		String sql = """
				SELECT COUNT(*)
				FROM USERS
				WHERE USER_TYPE = 'USER'
				""";
		totalMembers = DaoHelper.selectOneInt(sql);
		return totalMembers;
	}

	/**
	 * Bookstore 사이트에 등록되어 있는 책 정보의 개수를 집계해서 반환하는 메서드
	 * @return 사이트에 등록된 총 책수
	 * @throws SQLException
	 */
	public int countTotalBooksInBookstore() throws SQLException {
		int totalBooks = 0;
		String sql = """
				SELECT COUNT(*)
				FROM BOOK_LIST
				""";
		totalBooks = DaoHelper.selectOneInt(sql);
		return totalBooks;
	}
	
	/**
	 * Bookstore 사이트의 구매 게시판에 등록되어 있는 게시글의 총 조회수를 집계해서 반환하는 메서드
	 * @return 구매 게시판 게시글의 총 조회수
	 * @throws SQLException
	 */
	public int countTotalViewsInPurchaseBoards() throws SQLException {
		int totalViews = 0;
		String sql = """
				SELECT SUM(PURCHASE_VIEW_COUNT)
				FROM BOOK_PURCHASE_BOARDS
				WHERE ISDELETED = 'NO'
				""";
		totalViews = DaoHelper.selectOneInt(sql);
		return totalViews;
	}
	
	/**
	 * Bookstore 사이트의 판매 게시판에 등록되어 있는 게시글의 총 조회수를 집계해서 반환하는 메서드
	 * @return 판매 게시판 게시글의 총 조회수
	 * @throws SQLException
	 */
	public int countTotalViewsInSellBoards() throws SQLException {
		int totalViews = 0;
		String sql = """
				SELECT SUM(SELL_VIEW_COUNT)
				FROM BOOK_SELL_BOARDS
				WHERE ISDELETED = 'NO'
				""";
		totalViews = DaoHelper.selectOneInt(sql);
		return totalViews;
	}
	
	/**
	 * Bookstore 사이트의 구매 게시판에 등록되어 있는 게시글의 총 개수를 집계해서 반환하는 메서드
	 * @return 구매 게시판의 게시글의 총 개수
	 * @throws SQLException
	 */
	public int countTotalPostsInPurchaseBoards() throws SQLException {
		int totalPosts = 0;
		String sql = """
				SELECT COUNT(*)
				FROM BOOK_PURCHASE_BOARDS
				WHERE ISDELETED = 'NO'
				""";
		totalPosts = DaoHelper.selectOneInt(sql);
		return totalPosts;
	}
	
	/**
	 * Bookstore 사이트의 판매 게시판에 등록되어 있는 게시글의 총 개수를 집계해서 반환하는 메서드
	 * @return 판매 게시판의 게시글의 총 개수
	 * @throws SQLException
	 */
	public int countTotalPostsInSellBoards() throws SQLException {
		int totalPosts = 0;
		String sql = """
				SELECT COUNT(*)
				FROM BOOK_SELL_BOARDS
				WHERE ISDELETED = 'NO'
				""";
		totalPosts = DaoHelper.selectOneInt(sql);
		return totalPosts;
	}

	/**
	 * 사이트의 모든 관리자를 조회하는 메소드
	 * @return 사이트의 관리자 목록
	 * @throws SQLException
	 */
	public List<User> getAllAdministrator() throws SQLException {
		String sql = """
				SELECT *
				FROM USERS
				WHERE USER_TYPE = 'ADMIN'
				""";
		return DaoHelper.selectList(sql, rs -> {
			User user = new User();
			user.setUserNo(rs.getInt("USER_NO"));
			user.setId(rs.getString("USER_ID"));
			user.setPassword(rs.getString("USER_PASSWORD"));
			user.setNickname(rs.getString("USER_NICKNAME"));
			user.setEmail(rs.getString("USER_EMAIL"));
			user.setPhone(rs.getString("USER_PHONE"));
			user.setAddress(rs.getString("USER_ADDRESS"));
			user.setCreatedDate(rs.getDate("CREATED_DATE"));
			user.setUpdatedDate(rs.getDate("UPDATED_DATE"));
			user.setStatus(rs.getString("USER_STATUS"));
			user.setType(rs.getString("USER_TYPE"));
			return user;
		});
	}
}

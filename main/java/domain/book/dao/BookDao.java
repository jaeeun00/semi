package domain.book.dao;

import domain.book.vo.Book;
import domain.book.vo.Category;
import utils.DaoHelper;

import java.sql.SQLException;
import java.util.List;

public class BookDao {
    /**
     * 책제목을 키워드로 검색해서 조건에 맞는 도서들을 조회
     * @param keyword 책 제목 키워드
     * @return 책 제목에 검색 키워드가 있는 도서 목록
     * @throws SQLException
     */
    public List<Book> getBooksByBookTitle(String keyword, int begin, int end) throws Exception {
        String sql = """
    		select * 
    		from (select row_number() over (order by book_no desc) row_num
        		, book_no
    			, book_title
    			, book_author
    			, book_publisher
    			, book_price
    			, book_date
    			, book_stock
    			, book_status
    			, book_cover
    			, book_category_no
    			from book_list 
    			where book_title like '%' || ? || '%')
        	where row_num between ? and ?
		""";

        return DaoHelper.selectList(sql, rs -> 
        	Book.builder()
        		.no(rs.getInt("BOOK_NO"))
        		.title(rs.getString("BOOK_TITLE"))
        		.author(rs.getString("BOOK_AUTHOR"))
        		.publisher(rs.getString("BOOK_PUBLISHER"))
        		.price(rs.getInt("BOOK_PRICE"))
        		.date(rs.getString("BOOK_DATE"))
        		.stock(rs.getInt("BOOK_STOCK"))
        		.status(rs.getString("BOOK_STATUS"))
        		.cover(rs.getString("BOOK_COVER"))
        		.categoryNo(rs.getInt("BOOK_CATEGORY_NO"))
        		.build()
        , keyword, begin, end);
    }
    
    
    /**
     * 카테고리 번호로 조회해서 조건에 맞는 도서들을 조회
     * @param category 카테고리번호
     * @return 카테고리 번호로 조회한 도서들
     * @throws SQLException
     */
    public List<Book> getBooksByCategoryNo(String keyword, int ctgr, int begin, int end) throws Exception {
		String sql = """ 
			select * 
			from (select row_number() over (order by book_no desc) row_num
        		, book_no
    			, book_title
    			, book_author
    			, book_publisher
    			, book_price
    			, book_date
    			, book_stock
    			, book_status
    			, book_cover
    			, book_category_no
				from book_list 
				where book_title like '%' || ? || '%'
				and book_category_no = ? 
			) where row_num between ? and ?
		""";

        return DaoHelper.selectList(sql, rs -> Book.builder()
        		.no(rs.getInt("BOOK_NO"))
        		.title(rs.getString("BOOK_TITLE"))
        		.author(rs.getString("BOOK_AUTHOR"))
        		.publisher(rs.getString("BOOK_PUBLISHER"))
        		.price(rs.getInt("BOOK_PRICE"))
        		.date(rs.getString("BOOK_DATE"))
        		.stock(rs.getInt("BOOK_STOCK"))
        		.status(rs.getString("BOOK_STATUS"))
        		.cover(rs.getString("BOOK_COVER"))
        		.categoryNo(rs.getInt("BOOK_CATEGORY_NO"))
        		.build()
        	, keyword, ctgr, begin, end);
    }
    
    /**
     * 검색 결과로 나오는 책 개수를 조회
     * @return 검색 조회 결과 개수
     * @throws Exception
     */
    public int getRowsByKeyword(String keyword, int ctgr) throws Exception {
    	String sql = """ 
			select count(*) as cnt
			from book_list
			where book_title like '%' || ? || '%'
			and book_category_no = ? 
		""";
    	return DaoHelper.selectOne(sql, (rs) -> rs.getInt("CNT"), keyword, ctgr);
    }
    
    /**
     * 책 전체 개수를 조회
     * @return 책 전체 개수
     * @throws Exception
     */
    public int getTotalRows(String keyword) throws Exception {
    	String sql = """ 
			select count(*) as cnt
			from book_list
			where book_title like '%' || ? || '%'
		""";
    	return DaoHelper.selectOne(sql, (rs) -> rs.getInt("CNT"), keyword);
    }
    
    /**
     * 책 번호로 책 상세 정보를 조회. book/list/detail, 구매 게시글 작성용
     * @param bookNo 책 번호
     * @return 책 상세 정보
     * @throws SQLException
     */
    public Book getBookByNo(int bookNo) throws SQLException {
    	String sql = """
    		select B.book_no
    			, B.book_title
    			, B.book_author
    			, B.book_publisher
    			, B.book_price
    			, B.book_date
    			, B.book_stock
    			, B.book_status
    			, B.book_cover
    			, C.book_category_no
    			, C.book_category_name
    		from book_list B, book_categories C
    		where B.book_no = ?
    		and B.book_category_no = C.book_category_no
    	""";
    	
    	return DaoHelper.selectOne(sql, rs -> {
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
    		
    		Category category = new Category();
    		category.setNo(rs.getInt("book_category_no"));
    		category.setName(rs.getString("book_category_name"));
    		book.setCategory(category);
    		
    		
    		return book;
    	}, bookNo);
    	
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

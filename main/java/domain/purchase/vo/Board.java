package domain.purchase.vo;

import domain.book.vo.Book;
import domain.user.vo.User;
import lombok.*;

import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Board {
    private int no;
    private String title;
    private String content;
    private Date createdDate;
    private Date updatedDate;
    private int price;
    private int viewCount;
    private int likeCount;
    private String isDeleted;
    private User user;
    private Book book;

}


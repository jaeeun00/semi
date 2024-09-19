package domain.book.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {
    private int no;
    private String title;
    private String author;
    private String publisher;
    private int price;
    private String date;
    private int stock;
    private String status;
    private String cover;
    private int categoryNo;
    private Category category;
}
import java.util.ArrayList;
import java.util.List;

class Book {
    private String title;
    private int year;
    private String genre;
    private double price;
    private int soldCopies;

    public Book() {}

    public Book(String title, int year, String genre, double price, int soldCopies) {
        this.title = title; 
        this.year = year; 
        this.genre = genre; 
        this.price = price; 
        this.soldCopies = soldCopies; 
    }

    public String getGenre() { return genre; }
    public int getYear() { return year; }
    public double getPrice() { return price; }
    public int getSoldCopies() { return soldCopies; }
}

class Author{
    private String name;
    private int age;
    private String address;
    private List<Book> books;

    public Author() {
        this.books = new ArrayList<>();
    }

    public Author(String name, int age, String address) {
        this.name = name;
        this.age = age;
        this.address = address;
        this.books = new ArrayList<>();
    }

    public void addBook(Book book) {
        this.books.add(book);
    }

    public double calculateTotalRevenue() {
        double total = 0;
        for (Book b : books) {
            total += b.getPrice() * b.getSoldCopies();
        }
        return total;
    }

    public double calculateRevenueByGenre(String genre) {
        double total = 0;
        for (Book b : books) {
            if (b.getGenre().equalsIgnoreCase(genre)) {
                total += b.getPrice() * b.getSoldCopies();
            }
        }
        return total;
    }

    public double calculateRevenueByYear(int year) {
        double total = 0;
        for (Book b : books) {
            if (b.getYear() == year) {
                total += b.getPrice() * b.getSoldCopies();
            }
        }
        return total;
    }
}
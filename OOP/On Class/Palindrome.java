import java.util.Scanner;

public class Palindrome {
    public static void main(String[] args) {
        Scanner myObj = new Scanner(System.in);
        System.out.print("Enter a string: ");

        String inputString = myObj.nextLine();
        String reversedString = new StringBuilder(inputString).reverse().toString();
        if (inputString.equals(reversedString)) {
            System.out.println("The string is a palindrome.");
        } else {
            System.out.println("The string is not a palindrome.");
        }
        myObj.close();
    }
}

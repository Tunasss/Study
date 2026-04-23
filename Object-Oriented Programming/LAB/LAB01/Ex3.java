import java.util.Scanner;

public class Ex3 {
    public static void main(String[] args) {
        Scanner myObj = new Scanner(System.in);

        System.out.print("Enter a number: ");
        String number = myObj.nextLine();

        int res = 0;

        for (int i = 0; i < number.length(); i++) {
            res += number.charAt(i) - '0';
        }

        System.out.println("Sum of digits: " + res);

        myObj.close();
    }
}
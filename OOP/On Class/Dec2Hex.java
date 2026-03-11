import java.util.Scanner;

public class Dec2Hex {
    public static void main(String[] args) {
        Scanner myObj = new Scanner(System.in);

        System.out.print("Enter a decimal number: ");
        int decimalNumber = myObj.nextInt();

        String hex = "";
        while (decimalNumber > 0) {
            int hexValue = decimalNumber % 16;

            char hexDigit = (hexValue < 10) ? (char) ('0' + hexValue) : (char) ('A' + hexValue - 10);

            hex = hexDigit + hex;
            decimalNumber /= 16;
        }

        System.out.println("The hex number is: " + hex);

        myObj.close();
    }

}

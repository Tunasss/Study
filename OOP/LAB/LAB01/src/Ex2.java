import java.util.Scanner;

public class Ex2 {
    public static void main (String[] args){
        Scanner myObj = new Scanner(System.in);

        System.out.print("Enter first number: ");
        int s1 = myObj.nextInt();

        System.out.print("Enter second number: ");
        int s2 = myObj.nextInt();

        System.out.print("Enter third number: ");
        int s3 = myObj.nextInt();

        int res = Math.max(s1, Math.max(s2,s3));

        System.out.print("The largest number: ");
        System.out.print(res);
    }
}

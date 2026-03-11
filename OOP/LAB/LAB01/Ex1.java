import java.util.Scanner;

public class Ex1 {
    public static void main (String[] args){
        Scanner myObj = new Scanner(System.in);
        int n = myObj.nextInt();
        for (int i = 1; i <= n; i++){
            System.out.print(i);
            System.out.print(" - ");
            if (i % 2 != 0){
                System.out.println("Odd");
            }
            else {
                System.out.println("Even");
            }
        }
        myObj.close();
    }
}

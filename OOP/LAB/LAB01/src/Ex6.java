import java.util.Scanner;

public class Ex6 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter number of elements: ");
        int n = scanner.nextInt();

        int[] arr = new int[n];

        System.out.println("Enter " + n + " integers:");
        for (int i = 0; i < n; i++) {
            arr[i] = scanner.nextInt();
        }

        System.out.print("Enter number to search: ");
        int x = scanner.nextInt();

        int index = -1;

        for (int i = 0; i < n; i++) {
            if (arr[i] == x) {
                index = i;
                break;
            }
        }

        System.out.println(index);

        scanner.close();
    }
}
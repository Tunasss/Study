import java.util.Scanner;
import java.util.Arrays;

public class Ex7 {
    public static void main(String[] args) {
        Scanner myObj = new Scanner(System.in);

        int n = myObj.nextInt();
        int[] arr1 = new int[n];

        for (int i = 0; i < n; i++) {
            arr1[i] = myObj.nextInt();
        }

        int m = myObj.nextInt();
        int[] arr2 = new int[m];

        for (int i = 0; i < m; i++) {
            arr2[i] = myObj.nextInt();
        }

        int[] merged = new int[n + m];
        System.arraycopy(arr1, 0, merged, 0, n);
        System.arraycopy(arr2, 0, merged, n, m);

        Arrays.sort(merged);

        System.out.println("Merged array:");
        for (int num : merged) {
            System.out.print(num + " ");
        }

        myObj.close();
    }
}
import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Singer> singers = new ArrayList<>();

        System.out.print("Enter number of singers: ");
        int n = Integer.parseInt(sc.nextLine());

        for (int i = 0; i < n; i++) {
            System.out.println("\n--- Singer " + (i + 1) + " ---");
            System.out.print("Type (1 = Regular, 2 = Famous): ");
            int type = Integer.parseInt(sc.nextLine());

            System.out.print("Full name: ");
            String name = sc.nextLine();
            System.out.print("Years of experience: ");
            int years = Integer.parseInt(sc.nextLine());
            System.out.print("Number of albums sold: ");
            int albums = Integer.parseInt(sc.nextLine());
            System.out.print("Number of performances: ");
            int perf = Integer.parseInt(sc.nextLine());

            if (type == 1) {
                singers.add(new Singer(name, years, albums, perf));
            } else {
                System.out.print("Number of game shows: ");
                int shows = Integer.parseInt(sc.nextLine());
                singers.add(new FamousSinger(name, years, albums, perf, shows));
            }
        }

        // Display all singers
        System.out.println("\n=== All Singers ===");
        for (Singer s : singers) {
            System.out.println(s);
        }

        // Find highest-paid singer
        if (!singers.isEmpty()) {
            Singer highestPaid = singers.get(0);
            for (Singer s : singers) {
                if (s.calculateSalary() > highestPaid.calculateSalary()) {
                    highestPaid = s;
                }
            }
            System.out.println("\n=== Highest-Paid Singer ===");
            System.out.println(highestPaid);
        }

        sc.close();
    }
}

import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Ticket> tickets = new ArrayList<>();

        System.out.print("Enter number of tickets: ");
        int n = Integer.parseInt(sc.nextLine());

        for (int i = 0; i < n; i++) {
            System.out.println("\n--- Ticket " + (i + 1) + " ---");
            System.out.print("Type (1 = Full Package, 2 = Partial): ");
            int type = Integer.parseInt(sc.nextLine());

            System.out.print("Ticket ID: ");
            String id = sc.nextLine();
            System.out.print("Holder's full name: ");
            String name = sc.nextLine();
            System.out.print("Year of birth: ");
            int yob = Integer.parseInt(sc.nextLine());
            System.out.print("Number of games played: ");
            int games = Integer.parseInt(sc.nextLine());

            if (type == 1) {
                tickets.add(new FullPackageTicket(id, name, yob, games));
            } else {
                tickets.add(new PartialTicket(id, name, yob, games));
            }
        }

        // Calculate total revenue
        double totalRevenue = 0;
        int partialCount = 0;
        for (Ticket t : tickets) {
            totalRevenue += t.getPrice();
            if (t instanceof PartialTicket) {
                partialCount++;
            }
        }

        System.out.println("\n--- Ticket List ---");
        for (Ticket t : tickets) {
            System.out.println(t);
        }
        System.out.println("\nTotal revenue: " + totalRevenue + " VND");
        System.out.println("Number of Partial Tickets: " + partialCount);

        sc.close();
    }
}

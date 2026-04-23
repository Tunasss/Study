import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // Input staff info
        System.out.println("=== Enter Staff Information ===");
        System.out.print("Staff full name: ");
        String staffName = sc.nextLine();
        System.out.print("Staff age: ");
        int staffAge = Integer.parseInt(sc.nextLine());
        System.out.print("License ID: ");
        String licenseId = sc.nextLine();
        System.out.print("Employee ID: ");
        String employeeId = sc.nextLine();
        Staff staff = new Staff(staffName, staffAge, licenseId, employeeId);

        // Input room
        System.out.print("\nRoom type (VIP1, VIP2, VIP3): ");
        String roomType = sc.nextLine();
        Room room = new Room(roomType, staff);

        // Menu
        boolean running = true;
        while (running) {
            System.out.println("\n=== Menu ===");
            System.out.println("1. Add guest");
            System.out.println("2. Remove guest");
            System.out.println("3. Calculate rental cost");
            System.out.println("4. Display room info");
            System.out.println("5. Exit");
            System.out.print("Choose: ");
            int choice = Integer.parseInt(sc.nextLine());

            switch (choice) {
                case 1:
                    System.out.print("Guest full name: ");
                    String gName = sc.nextLine();
                    System.out.print("Guest age: ");
                    int gAge = Integer.parseInt(sc.nextLine());
                    System.out.print("Guest CCCD: ");
                    String gId = sc.nextLine();
                    room.addGuest(new Guest(gName, gAge, gId));
                    break;
                case 2:
                    System.out.print("Enter CCCD of guest to remove: ");
                    String removeId = sc.nextLine();
                    room.removeGuest(removeId);
                    break;
                case 3:
                    System.out.print("Number of days: ");
                    int days = Integer.parseInt(sc.nextLine());
                    System.out.println("Total cost: " + room.calculateCost(days) + " VND");
                    break;
                case 4:
                    System.out.println("\n" + room);
                    break;
                case 5:
                    running = false;
                    break;
                default:
                    System.out.println("Invalid choice.");
            }
        }

        sc.close();
    }
}

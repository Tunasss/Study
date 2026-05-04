import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Gate> gates = new ArrayList<>();

        System.out.print("Enter number of gates: ");
        int n = Integer.parseInt(sc.nextLine());

        for (int i = 0; i < n; i++) {
            System.out.println("\n--- Gate " + (i + 1) + " ---");
            System.out.print("Gate type (1 = Business, 2 = Academic, 3 = Power): ");
            int type = Integer.parseInt(sc.nextLine());
            System.out.print("Gate name: ");
            String name = sc.nextLine();

            switch (type) {
                case 1:
                    System.out.print("Unit price: ");
                    double price = Double.parseDouble(sc.nextLine());
                    System.out.print("Quantity of goods: ");
                    int qty = Integer.parseInt(sc.nextLine());
                    gates.add(new BusinessGate(name, price, qty));
                    break;
                case 2:
                    System.out.print("Required intelligence: ");
                    int intel = Integer.parseInt(sc.nextLine());
                    gates.add(new AcademicGate(name, intel));
                    break;
                case 3:
                    System.out.print("Warrior power: ");
                    int power = Integer.parseInt(sc.nextLine());
                    gates.add(new PowerGate(name, power));
                    break;
                default:
                    System.out.println("Invalid gate type.");
                    i--;
            }
        }

        // Input Prince stats
        System.out.println("\n=== Enter Prince's Stats ===");
        System.out.print("Money: ");
        double money = Double.parseDouble(sc.nextLine());
        System.out.print("Intelligence: ");
        int intelligence = Integer.parseInt(sc.nextLine());
        System.out.print("Power: ");
        int power = Integer.parseInt(sc.nextLine());
        Prince prince = new Prince(money, intelligence, power);

        // Attempt to pass all gates
        System.out.println("\n=== The Prince begins his journey ===");
        System.out.println(prince);
        boolean rescued = true;
        for (int i = 0; i < gates.size(); i++) {
            System.out.println("\nGate " + (i + 1) + ": " + gates.get(i));
            if (!gates.get(i).canPass(prince)) {
                rescued = false;
                break;
            }
        }

        System.out.println("\n=== Result ===");
        if (rescued) {
            System.out.println("The Prince has passed all gates and rescued the Princess!");
        } else {
            System.out.println("The Prince failed to rescue the Princess.");
        }
        System.out.println("Final stats: " + prince);

        sc.close();
    }
}

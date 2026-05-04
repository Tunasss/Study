import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<PersonProfile> people = new ArrayList<>();

        // (1) Input assessment for one person
        System.out.println("=== Input One Person's Assessment ===");
        System.out.print("Name: ");
        String name = sc.nextLine();
        System.out.print("Assessment result (e.g. O70-C30-E60-A96-N10): ");
        String result = sc.nextLine();
        PersonProfile single = new PersonProfile(name);
        single.parseTraits(result);
        single.displayDescription();

        // (2) Input for n people
        System.out.print("\nEnter number of people for the list: ");
        int n = Integer.parseInt(sc.nextLine());
        for (int i = 0; i < n; i++) {
            System.out.println("\n--- Person " + (i + 1) + " ---");
            System.out.print("Name: ");
            String pName = sc.nextLine();
            System.out.print("Assessment result: ");
            String pResult = sc.nextLine();
            PersonProfile pp = new PersonProfile(pName);
            pp.parseTraits(pResult);
            people.add(pp);
        }

        // Display list
        System.out.println("\n=== All People ===");
        for (int i = 0; i < people.size(); i++) {
            System.out.println((i + 1) + ". " + people.get(i));
        }

        // (3) Select a person and display description
        System.out.print("\nChoose a person to view description (1-" + people.size() + "): ");
        int choice = Integer.parseInt(sc.nextLine()) - 1;
        people.get(choice).displayDescription();

        // (4) Identify high-risk people
        System.out.println("\n=== High-Risk People ===");
        boolean foundRisk = false;
        for (PersonProfile p : people) {
            if (p.isHighRisk()) {
                System.out.println(p.getName() + " [" + p.getTraitString() + "] - RISK:");
                System.out.print(p.getRiskReasons());
                foundRisk = true;
            }
        }
        if (!foundRisk) {
            System.out.println("No high-risk people found.");
        }

        sc.close();
    }
}

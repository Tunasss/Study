import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static BloodType createBloodType(String aboType, boolean rhPositive) {
        switch (aboType.toUpperCase()) {
            case "O":  return new BloodTypeO(rhPositive);
            case "A":  return new BloodTypeA(rhPositive);
            case "B":  return new BloodTypeB(rhPositive);
            case "AB": return new BloodTypeAB(rhPositive);
            default:   return null;
        }
    }

    public static BloodType inputBloodType(Scanner sc, String label) {
        System.out.print(label + " - ABO type (O/A/B/AB): ");
        String abo = sc.nextLine().toUpperCase();
        System.out.print(label + " - Rh (+ or -): ");
        String rh = sc.nextLine();
        boolean rhPositive = rh.equals("+");
        return createBloodType(abo, rhPositive);
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Person> people = new ArrayList<>();

        // (a) Input list of people
        System.out.print("Enter number of people: ");
        int n = Integer.parseInt(sc.nextLine());
        for (int i = 0; i < n; i++) {
            System.out.println("\n--- Person " + (i + 1) + " ---");
            System.out.print("Name: ");
            String name = sc.nextLine();
            BloodType bt = inputBloodType(sc, "Blood type");
            people.add(new Person(name, bt));
        }

        // Display all people
        System.out.println("\n=== All People ===");
        for (int i = 0; i < people.size(); i++) {
            System.out.println((i + 1) + ". " + people.get(i));
        }

        // (b) Check if child's blood type is valid
        System.out.println("\n=== Check Child Blood Type Validity ===");
        System.out.println("Enter father's blood type:");
        BloodType fatherBT = inputBloodType(sc, "Father");
        System.out.println("Enter mother's blood type:");
        BloodType motherBT = inputBloodType(sc, "Mother");
        System.out.println("Enter child's blood type:");
        BloodType childBT = inputBloodType(sc, "Child");

        if (BloodType.isChildValid(fatherBT, motherBT, childBT)) {
            System.out.println("Result: The child's blood type " + childBT.getFullType() +
                               " IS genetically valid from father (" + fatherBT.getFullType() +
                               ") and mother (" + motherBT.getFullType() + ").");
        } else {
            System.out.println("Result: The child's blood type " + childBT.getFullType() +
                               " is NOT genetically valid from father (" + fatherBT.getFullType() +
                               ") and mother (" + motherBT.getFullType() + ").");
        }

        // (c) Choose person X and find donors
        System.out.println("\n=== Find Blood Donors ===");
        System.out.print("Choose person X (1-" + people.size() + "): ");
        int xIndex = Integer.parseInt(sc.nextLine()) - 1;
        Person personX = people.get(xIndex);
        System.out.println("Person X: " + personX);

        System.out.println("People who can donate blood to " + personX.getName() + ":");
        boolean found = false;
        for (int i = 0; i < people.size(); i++) {
            if (i == xIndex) continue;
            if (people.get(i).getBloodType().canDonateTo(personX.getBloodType())) {
                System.out.println("  - " + people.get(i));
                found = true;
            }
        }
        if (!found) {
            System.out.println("  No compatible donors found in the list.");
        }

        sc.close();
    }
}

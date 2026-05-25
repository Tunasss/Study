import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Vehicle> vehicles = new ArrayList<>();

        // Initialize at least 4 vehicles of different types
        vehicles.add(new Car("C001", "Toyota", 2020, 50000, 1000));
        vehicles.add(new Truck("T001", "Hino", 2018, 120000, 2000, 8.5));
        vehicles.add(new Motorbike("M001", "Honda", 2022, 30000, 500));
        vehicles.add(new Bus("B001", "Mercedes", 2019, 80000, 3000, 45));

        // --- Task 1: Display all vehicles ---
        System.out.println("=== VEHICLE LIST ===");
        for (Vehicle v : vehicles) {
            System.out.println(v);
        }
           
        // --- Task 2: Calculate and display total maintenance cost ---
        double totalCost = 0;
        for (Vehicle v : vehicles) {
            totalCost += v.calculateCost();
        }
        System.out.printf("Total Maintenance Cost (including base cost): %.2f%n", totalCost);

        // --- Task 3: Compare costs without base cost ---
        double motorbikeBusCost = 0;
        double carCost = 0;

        for (Vehicle v : vehicles) {
            if (v instanceof Motorbike || v instanceof Bus) {
                motorbikeBusCost += v.calculateCostWithoutBase();
            } else if (v instanceof Car) {
                carCost += v.calculateCostWithoutBase();
            }
        }
        System.out.printf("Motorbikes + Buses total cost : %.2f%n", motorbikeBusCost);
        System.out.printf("Cars total cost               : %.2f%n", carCost);

        if (motorbikeBusCost > carCost) {
            System.out.println("Motorbikes + Buses have HIGHER cost than Cars.");
        } 
        else if (carCost > motorbikeBusCost) {
            System.out.println("Cars have HIGHER cost than Motorbikes + Buses.");
        } 
        else {
            System.out.println("Both have EQUAL cost.");
        }
    }
}

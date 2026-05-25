public class Main {
    public static void main(String[] args) {
        // Create a Product using the constructor
        Product p = new Product("P001", "Wireless Mouse", 25.99, 10, 5);

        // Display initial product info
        System.out.println("=== Product Info ===");
        p.display();

        // Test sell() - sufficient stock
        System.out.println("\n--- Selling 3 units ---");
        p.sell(3);

        // Test sell() - insufficient stock
        System.out.println("\n--- Selling 20 units ---");
        p.sell(20);

        // Test needReorder() - stock is still above reorder level
        System.out.println("\n--- Need Reorder? " + p.needReorder());

        // Sell more to bring stock below reorder level
        System.out.println("\n--- Selling 5 units ---");
        p.sell(5);

        // Test needReorder() - stock is now below reorder level
        System.out.println("\n--- Need Reorder? " + p.needReorder());

        // Test restock()
        System.out.println("\n--- Restocking 20 units ---");
        p.restock(20);

        // Check reorder status after restocking
        System.out.println("\n--- Need Reorder? " + p.needReorder());

        // Final product info
        System.out.println("\n=== Final Product Info ===");
        p.display();
    }
}

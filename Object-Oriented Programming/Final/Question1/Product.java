public class Product {
    private String productCode;
    private String name;
    private double unitPrice;
    private int quantityOnHand;
    private int reorderLevel;

    // Constructor
    public Product(String productCode, String name, double unitPrice, int quantityOnHand, int reorderLevel) {
        this.productCode = productCode;
        this.name = name;
        this.unitPrice = unitPrice;
        this.quantityOnHand = quantityOnHand;
        this.reorderLevel = reorderLevel;
    }

    // Reduce inventory if sufficient stock exists
    public void sell(int quantity) {
        if (quantity <= 0) {
            System.out.println("Sell quantity must be positive.");
            return;
        }
        if (quantity > quantityOnHand) {
            System.out.println("Insufficient stock! Available: " + quantityOnHand + ", Requested: " + quantity);
        } else {
            quantityOnHand -= quantity;
            System.out.println("Sold " + quantity + " unit(s) of " + name + ". Remaining stock: " + quantityOnHand);
        }
    }

    // Add to inventory
    public void restock(int quantity) {
        if (quantity <= 0) {
            System.out.println("Restock quantity must be positive.");
            return;
        }
        quantityOnHand += quantity;
        System.out.println("Restocked " + quantity + " unit(s) of " + name + ". New stock: " + quantityOnHand);
    }

    // Return true if quantity falls below reorder level
    public boolean needReorder() {
        return quantityOnHand < reorderLevel;
    }

    // Display product information
    public void display() {
        System.out.println("Product Code : " + productCode);
        System.out.println("Name         : " + name);
        System.out.println("Unit Price   : " + unitPrice);
        System.out.println("Qty On Hand  : " + quantityOnHand);
        System.out.println("Reorder Level: " + reorderLevel);
    }
}

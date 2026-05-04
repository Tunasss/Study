public class BusinessGate extends Gate {
    private double unitPrice;
    private int quantity;

    public BusinessGate() {}

    public BusinessGate(String gateName, double unitPrice, int quantity) {
        super(gateName);
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getMoneyCost() {
        return unitPrice * quantity;
    }

    @Override
    public boolean canPass(Prince prince) {
        double cost = getMoneyCost();
        if (prince.getMoney() >= cost) {
            prince.setMoney(prince.getMoney() - cost);
            System.out.println("  -> Passed " + getGateName() + "! Paid " + cost + " VND. Money left: " + prince.getMoney());
            return true;
        }
        System.out.println("  -> FAILED at " + getGateName() + "! Need " + cost + " but only have " + prince.getMoney());
        return false;
    }

    @Override
    public String toString() {
        return "[Business Gate] " + getGateName() + ", Unit Price: " + unitPrice + ", Quantity: " + quantity;
    }
}

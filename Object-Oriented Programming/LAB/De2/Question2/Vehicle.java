abstract class Vehicle {
    protected String vehicleID;
    protected String brand;
    protected int yearOfManufacture;
    protected double mileage;
    protected double baseCost;

    public Vehicle(String vehicleID, String brand, int yearOfManufacture, double mileage, double baseCost) {
        this.vehicleID = vehicleID;
        this.brand = brand;
        this.yearOfManufacture = yearOfManufacture;
        this.mileage = mileage;
        this.baseCost = baseCost;
    }

    // Calculate total maintenance cost (including base cost)
    public abstract double calculateCost();

    // Calculate cost WITHOUT base cost
    public double calculateCostWithoutBase() {
        return calculateCost() - baseCost;
    }

    public String getType() {
        return this.getClass().getSimpleName();
    }

    @Override
    public String toString() {
        return String.format("%-10s | %-10s | %-10s | Year: %d | Mileage: %.0f | Base Cost: %.0f",
                getType(), vehicleID, brand, yearOfManufacture, mileage, baseCost);
    }
}
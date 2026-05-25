class Motorbike extends Vehicle {
    public Motorbike(String vehicleID, String brand, int yearOfManufacture, double mileage, double baseCost) {
        super(vehicleID, brand, yearOfManufacture, mileage, baseCost);
    }

    @Override
    public double calculateCost() {
        return baseCost + (mileage / 10.0) * 50;
    }
}

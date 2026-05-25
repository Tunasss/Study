class Car extends Vehicle {
    public Car(String vehicleID, String brand, int yearOfManufacture, double mileage, double baseCost) {
        super(vehicleID, brand, yearOfManufacture, mileage, baseCost);
    }

    @Override
    public double calculateCost() {
        return baseCost + mileage * 1.2;
    }
}
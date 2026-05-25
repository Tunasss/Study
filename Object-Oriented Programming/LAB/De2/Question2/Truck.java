class Truck extends Vehicle {
    private double loadWeight;

    public Truck(String vehicleID, String brand, int yearOfManufacture, double mileage, double baseCost, double loadWeight) {
        super(vehicleID, brand, yearOfManufacture, mileage, baseCost);
        this.loadWeight = loadWeight;
    }

    public double getLoadWeight() {
        return loadWeight;
    }

    @Override
    public double calculateCost() {
        return baseCost + loadWeight * 500;
    }
}
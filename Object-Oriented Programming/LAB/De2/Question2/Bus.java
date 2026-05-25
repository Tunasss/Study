class Bus extends Vehicle {
    private int numberOfSeats;

    public Bus(String vehicleID, String brand, int yearOfManufacture, double mileage, double baseCost, int numberOfSeats) {
        super(vehicleID, brand, yearOfManufacture, mileage, baseCost);
        this.numberOfSeats = numberOfSeats;
    }

    public int getNumberOfSeats() {
        return numberOfSeats;
    }

    @Override
    public double calculateCost() {
        return baseCost + numberOfSeats * 200;
    }
}
public class HeavyTruckDriver extends Driver {
    private double tonsDelivered;

    public HeavyTruckDriver() {}

    public HeavyTruckDriver(String driverID, String fullName, String licenseType,
                            String employmentDate, double baseCompensation,
                            double tonsDelivered) {
        super(driverID, fullName, licenseType, employmentDate, baseCompensation);
        this.tonsDelivered = tonsDelivered;
    }

    @Override
    public double calculatePay() {
        // Pay = Base Compensation + Tons Delivered x 250,000
        return baseCompensation + tonsDelivered * 250000;
    }

    @Override
    public String getDriverType() {
        return "Heavy Truck";
    }

    public double getTonsDelivered() { return tonsDelivered; }

    @Override
    public String toString() {
        return super.toString() + " | Tons: " + tonsDelivered;
    }
}

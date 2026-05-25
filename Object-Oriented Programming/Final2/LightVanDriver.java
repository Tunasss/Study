public class LightVanDriver extends Driver {
    private int deliveriesCompleted;

    public LightVanDriver() {}

    public LightVanDriver(String driverID, String fullName, String licenseType,
                          String employmentDate, double baseCompensation,
                          int deliveriesCompleted) {
        super(driverID, fullName, licenseType, employmentDate, baseCompensation);
        this.deliveriesCompleted = deliveriesCompleted;
    }

    @Override
    public double calculatePay() {
        // Pay = Base Compensation + Deliveries Completed x 50,000
        return baseCompensation + deliveriesCompleted * 50000;
    }

    @Override
    public String getDriverType() {
        return "Light Van";
    }

    public int getDeliveriesCompleted() { return deliveriesCompleted; }

    @Override
    public String toString() {
        return super.toString() + " | Deliveries: " + deliveriesCompleted;
    }
}

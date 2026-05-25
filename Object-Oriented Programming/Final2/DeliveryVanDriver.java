public class DeliveryVanDriver extends Driver {
    private int daysWorked;

    public DeliveryVanDriver() {}

    public DeliveryVanDriver(String driverID, String fullName, String licenseType,
                             String employmentDate, double baseCompensation,
                             int daysWorked) {
        super(driverID, fullName, licenseType, employmentDate, baseCompensation);
        this.daysWorked = daysWorked;
    }

    @Override
    public double calculatePay() {
        // Pay = Base Compensation + Days Worked x 300,000
        return baseCompensation + daysWorked * 300000;
    }

    @Override
    public String getDriverType() {
        return "Delivery Van";
    }

    public int getDaysWorked() { return daysWorked; }

    @Override
    public String toString() {
        return super.toString() + " | Days Worked: " + daysWorked;
    }
}

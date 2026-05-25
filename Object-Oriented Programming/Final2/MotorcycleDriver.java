public class MotorcycleDriver extends Driver {
    private double distanceCoveredKm;

    public MotorcycleDriver() {}

    public MotorcycleDriver(String driverID, String fullName, String licenseType,
                            String employmentDate, double baseCompensation,
                            double distanceCoveredKm) {
        super(driverID, fullName, licenseType, employmentDate, baseCompensation);
        this.distanceCoveredKm = distanceCoveredKm;
    }

    @Override
    public double calculatePay() {
        // Pay = Base Compensation + Distance Covered (km) x 5,000
        return baseCompensation + distanceCoveredKm * 5000;
    }

    @Override
    public String getDriverType() {
        return "Motorcycle";
    }

    public double getDistanceCoveredKm() { return distanceCoveredKm; }

    @Override
    public String toString() {
        return super.toString() + " | Distance: " + distanceCoveredKm + " km";
    }
}

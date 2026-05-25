public abstract class Driver {
    protected String driverID;
    protected String fullName;
    protected String licenseType;
    protected String employmentDate;
    protected double baseCompensation;

    public Driver() {}

    public Driver(String driverID, String fullName, String licenseType,
                  String employmentDate, double baseCompensation) {
        this.driverID = driverID;
        this.fullName = fullName;
        this.licenseType = licenseType;
        this.employmentDate = employmentDate;
        this.baseCompensation = baseCompensation;
    }

    // Abstract method — each subclass calculates pay differently
    public abstract double calculatePay();

    // Returns the driver type name for display
    public abstract String getDriverType();

    public String getDriverID() { return driverID; }
    public String getFullName() { return fullName; }
    public String getLicenseType() { return licenseType; }
    public String getEmploymentDate() { return employmentDate; }
    public double getBaseCompensation() { return baseCompensation; }

    @Override
    public String toString() {
        return getDriverType() + " | " + driverID + " | " + fullName + " | " + licenseType + " | " + employmentDate + " | " + baseCompensation;
    }
}

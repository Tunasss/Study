public class Staff extends Person {
    private String licenseId;
    private String employeeId;

    public Staff() {}

    public Staff(String fullName, int age, String licenseId, String employeeId) {
        super(fullName, age);
        this.licenseId = licenseId;
        this.employeeId = employeeId;
    }

    public String getLicenseId() { return licenseId; }
    public void setLicenseId(String licenseId) { this.licenseId = licenseId; }

    public String getEmployeeId() { return employeeId; }
    public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }

    @Override
    public String toString() {
        return "[Staff] " + super.toString() + ", License: " + licenseId + ", Employee ID: " + employeeId;
    }
}

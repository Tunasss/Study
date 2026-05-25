abstract class Staff {
    protected String staffID;
    protected String fullName;
    protected String dateOfBirth;
    protected String address;
    protected double baseSalary;
    protected String dateOfJoining;

    public Staff(String staffID, String fullName, String dateOfBirth,
                 String address, double baseSalary, String dateOfJoining) {
        this.staffID = staffID;
        this.fullName = fullName;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.baseSalary = baseSalary;
        this.dateOfJoining = dateOfJoining;
    }

    public abstract double calculateSalary();

    public double calculateSalaryWithoutBase() {
        return calculateSalary() - baseSalary;
    }

    public String getType() {
        return this.getClass().getSimpleName();
    }

    @Override
    public String toString() {
        return String.format("%-15s | %-5s | %-20s | Base: %.0f",
                getType(), staffID, fullName, baseSalary);
    }
}

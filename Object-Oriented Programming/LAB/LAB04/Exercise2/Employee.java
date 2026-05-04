public abstract class Employee {
    private String employeeId;
    private String fullName;
    private String dateOfBirth;
    private String address;
    private double salaryCoefficient;
    private String startDate;

    public static final double BASE_SALARY = 1800000; // Base salary in VND

    public Employee() {}

    public Employee(String employeeId, String fullName, String dateOfBirth,
                    String address, double salaryCoefficient, String startDate) {
        this.employeeId = employeeId;
        this.fullName = fullName;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.salaryCoefficient = salaryCoefficient;
        this.startDate = startDate;
    }

    public String getEmployeeId() { return employeeId; }
    public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(String dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public double getSalaryCoefficient() { return salaryCoefficient; }
    public void setSalaryCoefficient(double salaryCoefficient) { this.salaryCoefficient = salaryCoefficient; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public abstract double calculateSalary();

    @Override
    public String toString() {
        return "ID: " + employeeId + ", Name: " + fullName + ", DOB: " + dateOfBirth +
               ", Address: " + address + ", Coefficient: " + salaryCoefficient +
               ", Start: " + startDate + ", Salary: " + calculateSalary() + " VND";
    }
}

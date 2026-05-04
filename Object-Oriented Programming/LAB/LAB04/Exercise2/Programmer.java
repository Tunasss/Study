public class Programmer extends Employee {
    private double overtimePay;

    public Programmer() {}

    public Programmer(String employeeId, String fullName, String dateOfBirth,
                      String address, double salaryCoefficient, String startDate,
                      double overtimePay) {
        super(employeeId, fullName, dateOfBirth, address, salaryCoefficient, startDate);
        this.overtimePay = overtimePay;
    }

    public double getOvertimePay() { return overtimePay; }
    public void setOvertimePay(double overtimePay) { this.overtimePay = overtimePay; }

    @Override
    public double calculateSalary() {
        return BASE_SALARY * getSalaryCoefficient() + overtimePay;
    }

    @Override
    public String toString() {
        return "[Programmer] " + super.toString() + ", Overtime: " + overtimePay;
    }
}

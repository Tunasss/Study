public class Manager extends Employee {

    public Manager() {}

    public Manager(String employeeId, String fullName, String dateOfBirth,
                   String address, double salaryCoefficient, String startDate) {
        super(employeeId, fullName, dateOfBirth, address, salaryCoefficient, startDate);
    }

    @Override
    public double calculateSalary() {
        return BASE_SALARY * getSalaryCoefficient();
    }

    @Override
    public String toString() {
        return "[Manager] " + super.toString();
    }
}

public class Designer extends Employee {
    private double bonus;

    public Designer() {}

    public Designer(String employeeId, String fullName, String dateOfBirth,
                    String address, double salaryCoefficient, String startDate,
                    double bonus) {
        super(employeeId, fullName, dateOfBirth, address, salaryCoefficient, startDate);
        this.bonus = bonus;
    }

    public double getBonus() { return bonus; }
    public void setBonus(double bonus) { this.bonus = bonus; }

    @Override
    public double calculateSalary() {
        return BASE_SALARY * getSalaryCoefficient() + bonus;
    }

    @Override
    public String toString() {
        return "[Designer] " + super.toString() + ", Bonus: " + bonus;
    }
}

public class Tester extends Employee {
    private int bugsFound;

    public Tester() {}

    public Tester(String employeeId, String fullName, String dateOfBirth,
                  String address, double salaryCoefficient, String startDate,
                  int bugsFound) {
        super(employeeId, fullName, dateOfBirth, address, salaryCoefficient, startDate);
        this.bugsFound = bugsFound;
    }

    public int getBugsFound() { return bugsFound; }
    public void setBugsFound(int bugsFound) { this.bugsFound = bugsFound; }

    @Override
    public double calculateSalary() {
        return BASE_SALARY * getSalaryCoefficient() + bugsFound * 200000.0;
    }

    @Override
    public String toString() {
        return "[Tester] " + super.toString() + ", Bugs Found: " + bugsFound;
    }
}

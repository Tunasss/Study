class Janitor extends Staff {
    private int nightShiftDays;

    public Janitor(String staffID, String fullName, String dateOfBirth,
                   String address, double baseSalary, String dateOfJoining,
                   int nightShiftDays) {
        super(staffID, fullName, dateOfBirth, address, baseSalary, dateOfJoining);
        this.nightShiftDays = nightShiftDays;
    }

    @Override
    public double calculateSalary() {
        return baseSalary + nightShiftDays * 50000;
    }
}

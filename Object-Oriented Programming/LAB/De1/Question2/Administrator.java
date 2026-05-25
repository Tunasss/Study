class Administrator extends Staff {
    private double bonus;

    public Administrator(String staffID, String fullName, String dateOfBirth,
                         String address, double baseSalary, String dateOfJoining,
                         double bonus) {
        super(staffID, fullName, dateOfBirth, address, baseSalary, dateOfJoining);
        this.bonus = bonus;
    }

    @Override
    public double calculateSalary() {
        return baseSalary + bonus;
    }
}

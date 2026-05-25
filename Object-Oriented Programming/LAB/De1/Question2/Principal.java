class Principal extends Staff {
    private double coefficient;

    public Principal(String staffID, String fullName, String dateOfBirth,
                     String address, double baseSalary, String dateOfJoining,
                     double coefficient) {
        super(staffID, fullName, dateOfBirth, address, baseSalary, dateOfJoining);
        this.coefficient = coefficient;
    }

    @Override
    public double calculateSalary() {
        return baseSalary * coefficient;
    }
}

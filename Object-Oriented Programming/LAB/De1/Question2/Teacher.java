class Teacher extends Staff {
    private int teachingHours;

    public Teacher(String staffID, String fullName, String dateOfBirth,
                   String address, double baseSalary, String dateOfJoining,
                   int teachingHours) {
        super(staffID, fullName, dateOfBirth, address, baseSalary, dateOfJoining);
        this.teachingHours = teachingHours;
    }

    @Override
    public double calculateSalary() {
        return baseSalary + teachingHours * 100000;
    }
}

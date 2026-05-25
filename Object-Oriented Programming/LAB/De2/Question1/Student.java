class Student {
    private String name;
    private double mark1;
    private double mark2;
    private double mark3;

    public Student(String name, double mark1, double mark2, double mark3) {
        this.name = name;
        this.mark1 = mark1;
        this.mark2 = mark2;
        this.mark3 = mark3;
    }

    // Return total of 3 marks
    public double total() {
        return mark1 + mark2 + mark3;
    }

    // Return average mark
    public double average() {
        return total() / 3.0;
    }

    // Return true if average >= 50
    public boolean isPass() {
        return average() >= 50;
    }

    @Override
    public String toString() {
        return "Student = " + name + ", mark1 = " + mark1 + ", mark2 = " + mark2 + ", mark3 = " + mark3;
    }
}
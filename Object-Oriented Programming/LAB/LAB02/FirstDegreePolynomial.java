class FirstDegreePolynomial {
    private double a;
    private double b;

    public FirstDegreePolynomial(double a, double b) {
        if (a == 0) {
            System.err.println("Invalid input: Coefficient 'a' cannot be zero.");
        }
        this.a = a;
        this.b = b;
    }

    public double evaluate(double x0) {
        return a * x0 + b;
    }

    public double findRoot() {
        return -b / a;
    }

    public FirstDegreePolynomial add(FirstDegreePolynomial other) {
        double newA = this.a + other.a;
        if (newA == 0) {
            System.err.println("Resulting polynomial is no longer first-degree (a = 0).");
        }
        return new FirstDegreePolynomial(newA, this.b + other.b);
    }
}
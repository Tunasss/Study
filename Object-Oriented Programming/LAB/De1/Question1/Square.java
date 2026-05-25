class Square {
    private double x1, y1;
    private double x2, y2;
    private double x3, y3;
    private double x4, y4;

    public Square(double x1, double y1, double x2, double y2,
                  double x3, double y3, double x4, double y4) {
        this.x1 = x1; this.y1 = y1;
        this.x2 = x2; this.y2 = y2;
        this.x3 = x3; this.y3 = y3;
        this.x4 = x4; this.y4 = y4;
    }

    private double distance(double xa, double ya, double xb, double yb) {
        return Math.sqrt(Math.pow(xb - xa, 2) + Math.pow(yb - ya, 2));
    }

    private double sideAB() { return distance(x1, y1, x2, y2); }
    private double sideBC() { return distance(x2, y2, x3, y3); }
    private double sideCD() { return distance(x3, y3, x4, y4); }
    private double sideDA() { return distance(x4, y4, x1, y1); }

    public double area() {
        double side = sideAB();
        return side * side;
    }

    public double perimeter() {
        return sideAB() + sideBC() + sideCD() + sideDA();
    }

    public boolean checkEqualSides() {
        double ab = sideAB();
        double bc = sideBC();
        double cd = sideCD();
        double da = sideDA();
        double epsilon = 1e-9;
        return Math.abs(ab - bc) < epsilon
            && Math.abs(bc - cd) < epsilon
            && Math.abs(cd - da) < epsilon;
    }

    @Override
    public String toString() {
        return "Square: A(" + x1 + ", " + y1 + "), B(" + x2 + ", " + y2
             + "), C(" + x3 + ", " + y3 + "), D(" + x4 + ", " + y4 + ")";
    }
}

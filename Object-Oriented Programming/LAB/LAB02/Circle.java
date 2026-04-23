//3. Circle Class
class Circle {
    private double a;
    private double b;
    private double r;

    public Circle(double a, double b, double r) {
        this.a = a;
        this.b = b;
        this.r = r;
    }

    public double area() {
        return Math.PI * r * r;
    }

    public double perimeter() {
        return 2 * Math.PI * r;
    }

    public boolean testBelongs(double x, double y) {
        double distanceSquared = Math.pow(x - a, 2) + Math.pow(y - b, 2);
        return distanceSquared <= Math.pow(r, 2);
    }
}
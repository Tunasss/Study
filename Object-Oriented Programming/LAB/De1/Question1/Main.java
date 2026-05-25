import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the first point (x1, y1): ");
        double x1 = scanner.nextDouble();
        double y1 = scanner.nextDouble();

        System.out.print("Enter the second point (x2, y2): ");
        double x2 = scanner.nextDouble();
        double y2 = scanner.nextDouble();

        System.out.print("Enter the third point (x3, y3): ");
        double x3 = scanner.nextDouble();
        double y3 = scanner.nextDouble();

        System.out.print("Enter the fourth point (x4, y4): ");
        double x4 = scanner.nextDouble();
        double y4 = scanner.nextDouble();

        Square s = new Square(x1, y1, x2, y2, x3, y3, x4, y4);

        System.out.println(s);
        System.out.printf("Area      : %.2f%n", s.area());
        System.out.printf("Perimeter : %.2f%n", s.perimeter());
        System.out.println("Equal sides: " + s.checkEqualSides());
    }
}

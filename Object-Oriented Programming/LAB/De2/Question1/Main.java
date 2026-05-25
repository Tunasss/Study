import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter student name: ");
        String name = sc.nextLine();

        System.out.print("Enter mark 1: ");
        double mark1 = sc.nextDouble();

        System.out.print("Enter mark 2: ");
        double mark2 = sc.nextDouble();

        System.out.print("Enter mark 3: ");
        double mark3 = sc.nextDouble();

        Student student = new Student(name, mark1, mark2, mark3);

        System.out.println("\n===== Student Information =====");
        System.out.println(student);
        System.out.printf("Total marks : %.2f%n", student.total());
        System.out.printf("Average mark: %.2f%n", student.average());
        System.out.println("Pass status : " + (student.isPass() ? "PASSED" : "FAILED"));

        sc.close();
    }
}

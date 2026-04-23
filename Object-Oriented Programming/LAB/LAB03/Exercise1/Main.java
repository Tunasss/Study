import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Student> students = new ArrayList<>();

        System.out.print("Enter number of students: ");
        int n = Integer.parseInt(sc.nextLine());

        for (int i = 0; i < n; i++) {
            System.out.println("\n--- Student " + (i + 1) + " ---");
            System.out.print("Type (1 = College, 2 = University): ");
            int type = Integer.parseInt(sc.nextLine());

            System.out.print("Student ID: ");
            String id = sc.nextLine();
            System.out.print("Full name: ");
            String name = sc.nextLine();
            System.out.print("Address: ");
            String address = sc.nextLine();
            System.out.print("Total credits: ");
            int credits = Integer.parseInt(sc.nextLine());
            System.out.print("GPA: ");
            double gpa = Double.parseDouble(sc.nextLine());

            if (type == 1) {
                System.out.print("Graduation exam score: ");
                double examScore = Double.parseDouble(sc.nextLine());
                students.add(new CollegeStudent(id, name, address, credits, gpa, examScore));
            } else {
                System.out.print("Thesis title: ");
                String thesis = sc.nextLine();
                System.out.print("Thesis score: ");
                double thesisScore = Double.parseDouble(sc.nextLine());
                students.add(new UniversityStudent(id, name, address, credits, gpa, thesis, thesisScore));
            }
        }
        // Print out all students
        System.out.println("\n--- Students List ---");
        for (Student t : students) {
            System.out.println(t);
        }

        // Count graduated students
        int graduatedCount = 0;
        for (Student s : students) {
            if (s instanceof CollegeStudent && ((CollegeStudent) s).isGraduated()) {
                graduatedCount++;
            } else if (s instanceof UniversityStudent && ((UniversityStudent) s).isGraduated()) {
                graduatedCount++;
            }
        }
        System.out.println("\nNumber of graduated students: " + graduatedCount);

        sc.close();
    }
}

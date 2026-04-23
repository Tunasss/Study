import java.util.*;
import java.time.LocalDate;
import java.time.Month;

public class UITStudent {
    private String studentId;
    private String fullName;
    private int birthYear;
    private String citizenId;
    private double gpa;
    private String ctdt;

    public UITStudent() {}

    public UITStudent(String studentId, String fullName, int birthYear, String citizenId, double gpa, String ctdt) {
        this.studentId = studentId;
        this.fullName = fullName;
        this.birthYear = birthYear;
        this.citizenId = citizenId;
        this.gpa = gpa;
        this.ctdt = ctdt;
    }

    public void inputDetails() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter Student ID: ");
        this.studentId = sc.nextLine();
        System.out.print("Enter Full Name: ");
        this.fullName = sc.nextLine();
        System.out.print("Enter Birth Year: ");
        this.birthYear = sc.nextInt();
        sc.nextLine(); 
        System.out.print("Enter Citizen ID: ");
        this.citizenId = sc.nextLine();
        System.out.print("Enter GPA: ");
        this.gpa = sc.nextDouble();
        sc.nextLine();
        System.out.print("Enter CTDT (CQ/BCU/CTTT): ");
        this.ctdt = sc.nextLine().toUpperCase();
    }

    public void displayInfo() {
        System.out.printf("ID: %s | Name: %-15s | CitizenID: %s | GPA: %.2f | Program: %s\n", 
                          studentId, fullName, citizenId, gpa, ctdt);
    }

    public int calculateAge() {
        return LocalDate.now().getYear() - birthYear;
    }

    public LocalDate calculateGraduationDate() {
        double duration;
        switch (ctdt) {
            case "BCU": duration = 3.5; break;
            case "CTTT": duration = 4.5; break;
            case "CQ": default: duration = 4.0; break;
        }

        int startYear = birthYear + 18;
        int gradYear = startYear + (int) duration;
        Month gradMonth = (duration % 1 == 0) ? Month.SEPTEMBER : Month.MARCH;
        
        return LocalDate.of(gradYear, gradMonth, 1);
    }

    public double getGpa() { return gpa; }
    public String getFullName() { return fullName; }
}
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Staff> staffList = new ArrayList<>();

        // Task 1: Initialize at least 4 staff members of different types
        staffList.add(new Principal("P001", "Nguyen Van A", "1970-05-10", "HCM", 10000000, "2000-09-01", 3.5));
        staffList.add(new Teacher("T001", "Tran Thi B", "1985-03-15", "HCM", 8000000, "2010-08-01", 120));
        staffList.add(new Administrator("A001", "Le Van C", "1990-07-20", "HCM", 7000000, "2015-06-01", 2000000));
        staffList.add(new Janitor("J001", "Pham Thi D", "1988-12-01", "HCM", 5000000, "2018-01-15", 10));

        // Display all staff
        System.out.println("=== STAFF LIST ===");
        for (Staff s : staffList) {
            System.out.printf("%s => Salary: %,.0f%n", s, s.calculateSalary());
        }

        // Task 2: Total salary
        double totalSalary = 0;
        for (Staff s : staffList) {
            totalSalary += s.calculateSalary();
        }
        System.out.printf("%nTotal salary for the month: %,.0f%n", totalSalary);

        // Task 3: Compare the average salary difference (without a base) between Teachers and Administrators
        double teacherTotal = 0;
        int teacherCount = 0;
        double adminTotal = 0;
        int adminCount = 0;

        for (Staff s : staffList) {
            if (s instanceof Teacher) {
                teacherTotal += s.calculateSalaryWithoutBase();
                teacherCount++;
            } else if (s instanceof Administrator) {
                adminTotal += s.calculateSalaryWithoutBase();
                adminCount++;
            }
        }

        double teacherAvg = teacherCount > 0 ? teacherTotal / teacherCount : 0;
        double adminAvg = adminCount > 0 ? adminTotal / adminCount : 0;

        System.out.printf("%n=== COMPARISON (without Base Salary) ===%n");
        System.out.printf("Teacher average salary     : %,.0f%n", teacherAvg);
        System.out.printf("Administrator average salary: %,.0f%n", adminAvg);

        if (teacherAvg > adminAvg) {
            System.out.println("=> Teachers have HIGHER average salary.");
        } 
        else if (adminAvg > teacherAvg) {
            System.out.println("=> Administrators have HIGHER average salary.");
        } 
        else {
            System.out.println("=> Both have EQUAL average salary.");
        }
    }
}

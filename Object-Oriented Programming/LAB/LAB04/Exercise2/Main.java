import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Employee> employees = new ArrayList<>();

        System.out.print("Enter number of employees: ");
        int n = Integer.parseInt(sc.nextLine());

        for (int i = 0; i < n; i++) {
            System.out.println("\n--- Employee " + (i + 1) + " ---");
            System.out.print("Type (1=Manager, 2=Programmer, 3=Designer, 4=Tester): ");
            int type = Integer.parseInt(sc.nextLine());

            System.out.print("Employee ID: ");
            String id = sc.nextLine();
            System.out.print("Full name: ");
            String name = sc.nextLine();
            System.out.print("Date of birth: ");
            String dob = sc.nextLine();
            System.out.print("Address: ");
            String addr = sc.nextLine();
            System.out.print("Salary coefficient: ");
            double coeff = Double.parseDouble(sc.nextLine());
            System.out.print("Start date: ");
            String startDate = sc.nextLine();

            switch (type) {
                case 1:
                    employees.add(new Manager(id, name, dob, addr, coeff, startDate));
                    break;
                case 2:
                    System.out.print("Overtime pay: ");
                    double overtime = Double.parseDouble(sc.nextLine());
                    employees.add(new Programmer(id, name, dob, addr, coeff, startDate, overtime));
                    break;
                case 3:
                    System.out.print("Bonus: ");
                    double bonus = Double.parseDouble(sc.nextLine());
                    employees.add(new Designer(id, name, dob, addr, coeff, startDate, bonus));
                    break;
                case 4:
                    System.out.print("Number of critical bugs found: ");
                    int bugs = Integer.parseInt(sc.nextLine());
                    employees.add(new Tester(id, name, dob, addr, coeff, startDate, bugs));
                    break;
                default:
                    System.out.println("Invalid type.");
                    i--;
            }
        }

        // Display all employees
        System.out.println("\n=== All Employees ===");
        for (Employee e : employees) {
            System.out.println(e);
        }

        // Calculate total salary
        double totalSalary = 0;
        for (Employee e : employees) {
            totalSalary += e.calculateSalary();
        }
        System.out.println("\nTotal salary the company needs to pay: " + totalSalary + " VND");

        sc.close();
    }
}

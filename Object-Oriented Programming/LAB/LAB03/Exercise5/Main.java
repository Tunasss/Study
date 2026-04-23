import java.util.ArrayList;
import java.util.Scanner;
import java.io.FileWriter;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Order> orders = new ArrayList<>();

        System.out.print("Enter number of orders: ");
        int n = Integer.parseInt(sc.nextLine());

        for (int i = 0; i < n; i++) {
            System.out.println("\n=== Order " + (i + 1) + " ===");

            System.out.print("Order ID: ");
            String orderId = sc.nextLine();
            System.out.print("Invoice date (dd/MM/yyyy): ");
            String invoiceDate = sc.nextLine();

            // Customer info
            System.out.println("-- Customer Info --");
            System.out.print("Customer ID: ");
            String custId = sc.nextLine();
            System.out.print("Full name: ");
            String custName = sc.nextLine();
            System.out.print("Address: ");
            String custAddr = sc.nextLine();
            System.out.print("Phone number: ");
            String custPhone = sc.nextLine();
            Customer customer = new Customer(custId, custName, custAddr, custPhone);

            // Package type
            System.out.print("Package type (1 = Romantic, 2 = Fresh-Air): ");
            int pkgType = Integer.parseInt(sc.nextLine());

            ProductPackage pkg;
            if (pkgType == 1) {
                // Romantic Package: always Rose Perfume
                System.out.println("-- Rose Perfume (required) --");
                System.out.print("Perfume ID: ");
                String pId = sc.nextLine();
                System.out.print("Volume (ml): ");
                double pVol = Double.parseDouble(sc.nextLine());
                Perfume rosePerfume = new Perfume(pId, "Rose", pVol);

                Shampoo shampoo = null;
                System.out.print("Include Shampoo? (y/n): ");
                if (sc.nextLine().equalsIgnoreCase("y")) {
                    System.out.print("Shampoo ID: ");
                    String sId = sc.nextLine();
                    System.out.print("Type (Dry Hair / Oily Hair): ");
                    String sType = sc.nextLine();
                    System.out.print("Volume (ml): ");
                    double sVol = Double.parseDouble(sc.nextLine());
                    if (sType.equalsIgnoreCase("Oily Hair")) {
                        System.out.print("Standard (1 or 2): ");
                        int std = Integer.parseInt(sc.nextLine());
                        shampoo = new Shampoo(sId, sType, sVol, std);
                    } else {
                        shampoo = new Shampoo(sId, sType, sVol);
                    }
                }

                ShowerGel showerGel = null;
                System.out.print("Include Shower Gel? (y/n): ");
                if (sc.nextLine().equalsIgnoreCase("y")) {
                    System.out.print("Shower Gel ID: ");
                    String gId = sc.nextLine();
                    System.out.print("Type (Dry Skin / Oily Skin): ");
                    String gType = sc.nextLine();
                    System.out.print("Volume (ml): ");
                    double gVol = Double.parseDouble(sc.nextLine());
                    showerGel = new ShowerGel(gId, gType, gVol);
                }

                pkg = new RomanticPackage(rosePerfume, shampoo, showerGel);
            } else {
                // Fresh-Air Package: always Oily Hair Shampoo
                System.out.println("-- Oily Hair Shampoo (required) --");
                System.out.print("Shampoo ID: ");
                String sId = sc.nextLine();
                System.out.print("Volume (ml): ");
                double sVol = Double.parseDouble(sc.nextLine());
                System.out.print("Standard (1 or 2): ");
                int std = Integer.parseInt(sc.nextLine());
                Shampoo oilyShampoo = new Shampoo(sId, "Oily Hair", sVol, std);

                Perfume perfume = null;
                System.out.print("Include Perfume? (y/n): ");
                if (sc.nextLine().equalsIgnoreCase("y")) {
                    System.out.print("Perfume ID: ");
                    String pId = sc.nextLine();
                    System.out.print("Type (Rose / Chamomile): ");
                    String pType = sc.nextLine();
                    System.out.print("Volume (ml): ");
                    double pVol = Double.parseDouble(sc.nextLine());
                    perfume = new Perfume(pId, pType, pVol);
                }

                ShowerGel showerGel = null;
                System.out.print("Include Shower Gel? (y/n): ");
                if (sc.nextLine().equalsIgnoreCase("y")) {
                    System.out.print("Shower Gel ID: ");
                    String gId = sc.nextLine();
                    System.out.print("Type (Dry Skin / Oily Skin): ");
                    String gType = sc.nextLine();
                    System.out.print("Volume (ml): ");
                    double gVol = Double.parseDouble(sc.nextLine());
                    showerGel = new ShowerGel(gId, gType, gVol);
                }

                pkg = new FreshAirPackage(oilyShampoo, perfume, showerGel);
            }

            orders.add(new Order(orderId, customer, invoiceDate, pkg));
        }

        // Display all orders
        System.out.println("\n========== ALL ORDERS ==========");
        for (Order order : orders) {
            System.out.println(order);
            System.out.println("--------------------------------");
        }

        // Save to file
        try {
            FileWriter writer = new FileWriter("order_list.txt");
            for (Order order : orders) {
                writer.write(order.toString() + "\n--------------------------------\n");
            }
            writer.close();
            System.out.println("\nOrders saved to order_list.txt");
        } catch (IOException e) {
            System.out.println("Error saving to file: " + e.getMessage());
        }

        sc.close();
    }
}

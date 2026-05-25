import java.util.ArrayList;
import java.util.List;

public class Main {
        public static void main(String[] args) {
                // ===== TASK 1: Initialize a list of N drivers (at least 4, all different
                // types) =====
                List<Driver> drivers = new ArrayList<>();

                drivers.add(new HeavyTruckDriver(
                                "HT001", "Nguyen Van An", "C",
                                "2020/3/15", 5000000, 12.5));

                drivers.add(new LightVanDriver(
                                "LV001", "Tran Thi Binh", "B2",
                                "2021/7/1", 4000000, 85));

                drivers.add(new MotorcycleDriver(
                                "MC001", "Le Hoang Cuong", "A2",
                                "2022/1/10", 3000000, 620.0));

                drivers.add(new DeliveryVanDriver(
                                "DV001", "Pham Minh Duc", "B2",
                                "2019/11/20", 4500000, 22));

                // Additional drivers for richer data
                drivers.add(new HeavyTruckDriver(
                                "HT002", "Vo Thanh Em", "C",
                                "2018/5/5", 5500000, 18.0));

                drivers.add(new LightVanDriver(
                                "LV002", "Hoang Thi Phuong", "B2",
                                "2023/2/14", 4000000, 110));

                drivers.add(new MotorcycleDriver(
                                "MC002", "Dang Quoc Gia", "A2",
                                "2022/8/30", 3200000, 750.0));

                // ===== TASK 2: Calculate and display total driver payments for the month =====
                System.out.println("                          MONTHLY DRIVER PAYMENT REPORT");

                double totalPayments = 0;
                for (Driver d : drivers) {
                        double pay = d.calculatePay();
                        totalPayments += pay;
                        System.out.println(d.getDriverType() + " | " + d.getFullName() + " | Pay: " + (long) pay + " VND");
                }

                System.out.println("-".repeat(130));
                System.out.println("TOTAL PAYMENTS FOR THE MONTH: " + (long) totalPayments + " VND");

                // ===== TASK 3: Compare average payment (excluding base) between categories
                // =====
                // - Motorcycle Couriers vs Light Van Drivers vs Heavy Truck Drivers
                // "Excluding base compensation" means we only look at the variable/bonus part
                System.out.println();
                System.out.println("         AVERAGE PAYMENT COMPARISON (Excluding Base Compensation)");

                // Collect variable pay (pay - base) for each category
                double sumMotorcycle = 0, sumLightVan = 0, sumHeavyTruck = 0;
                int countMotorcycle = 0, countLightVan = 0, countHeavyTruck = 0;

                for (Driver d : drivers) {
                        double variablePay = d.calculatePay() - d.getBaseCompensation();
                        if (d instanceof MotorcycleDriver) {
                                sumMotorcycle += variablePay;
                                countMotorcycle++;
                        } else if (d instanceof LightVanDriver) {
                                sumLightVan += variablePay;
                                countLightVan++;
                        } else if (d instanceof HeavyTruckDriver) {
                                sumHeavyTruck += variablePay;
                                countHeavyTruck++;
                        }
                }

                double avgMotorcycle = countMotorcycle > 0 ? sumMotorcycle / countMotorcycle : 0;
                double avgLightVan = countLightVan > 0 ? sumLightVan / countLightVan : 0;
                double avgHeavyTruck = countHeavyTruck > 0 ? sumHeavyTruck / countHeavyTruck : 0;

                System.out.println("  Motorcycle Couriers   - Average Variable Pay: " + (long) avgMotorcycle + " VND  ("
                                + countMotorcycle + " drivers)");
                System.out.println("  Light Van Drivers     - Average Variable Pay: " + (long) avgLightVan + " VND  ("
                                + countLightVan + " drivers)");
                System.out.println("  Heavy Truck Drivers   - Average Variable Pay: " + (long) avgHeavyTruck + " VND  ("
                                + countHeavyTruck + " drivers)");

                System.out.println("-".repeat(130));

                // Compare Motorcycle vs Light Van
                double diffMcLv = avgMotorcycle - avgLightVan;
                System.out.println("  Motorcycle vs Light Van difference   : " + (long) diffMcLv + " VND  ("
                                + (diffMcLv >= 0 ? "Motorcycle" : "Light Van") + " earns more)");

                // Compare Motorcycle vs Heavy Truck
                double diffMcHt = avgMotorcycle - avgHeavyTruck;
                System.out.println("  Motorcycle vs Heavy Truck difference : " + (long) diffMcHt + " VND  ("
                                + (diffMcHt >= 0 ? "Motorcycle" : "Heavy Truck") + " earns more)");

                // Compare Light Van vs Heavy Truck
                double diffLvHt = avgLightVan - avgHeavyTruck;
                System.out.println("  Light Van  vs Heavy Truck difference : " + (long) diffLvHt + " VND  ("
                                + (diffLvHt >= 0 ? "Light Van" : "Heavy Truck") + " earns more)");

        }
}

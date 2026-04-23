import java.util.Scanner;
import java.util.Random;

class Dice {
    private int num;

    public int roll() {
        Random rand = new Random();
        this.num = rand.nextInt(6) + 1;
        return this.num;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Dice dice = new Dice();

        System.out.print("Enter the number of rolls (n): ");
        int n = scanner.nextInt();

        int[] frequency = new int[7];

        for (int i = 0; i < n; i++) {
            int result = dice.roll();
            frequency[result]++;
        }

        System.out.println("\nFace\tFrequency\tProbability");
        for (int i = 1; i <= 6; i++) {
            double probability = (double) frequency[i] / n;
            System.out.printf("%d\t%d\t\t%.4f\n", i, frequency[i], probability);
        }

        scanner.close();
    }
}
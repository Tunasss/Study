public class FutureTution {
    public static final double TUITION_INITIAL = 10000;
    public static final double TUITION_DOUBLE = TUITION_INITIAL * 2;
    public static final double RATE = 0.07;
    
    public static void main(String[] args) {
        double tuition = TUITION_INITIAL;
        int year = 0;

        while (tuition < TUITION_DOUBLE) {
            tuition *= (1 + RATE);
            year++;
        }

        System.out.println("The tuition will double in " + year + " years.");
        System.out.println("The tuition will be $" + String.format("%.2f", tuition) + " in " + year + " years.");
    }
}
public class MonteCarlo {
    public static final int NUMBER_OF_TRIALS = 200000000;
    public static void main(String[] args) {
        // Number of random points to generate
        int numberOfHits = 0;

        for (int i = 0; i < NUMBER_OF_TRIALS; i++) {
            // Generate a random x and y coordinate between -1.0 and 1.0
            double x = Math.random() * 2.0 - 1.0;
            double y = Math.random() * 2.0 - 1.0;

            // Check if the point is inside the circle
            // A point is inside the unit circle if x^2 + y^2 <= 1^2
            if (x * x + y * y <= 1) {
                numberOfHits++;
            }
        }

        // Apply the formula from the slide: 
        // pi = 4 * (numberOfHits / numberOfTrials)
        double pi = 4.0 * numberOfHits / NUMBER_OF_TRIALS;

        System.out.println("With " + NUMBER_OF_TRIALS + " trials, PI is estimated as: " + pi);
        System.out.println("Actual value of PI is: " + Math.PI);
    }
}

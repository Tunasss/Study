public class Openness extends PersonalityTrait {
    public Openness(int score) {
        super("Openness to Experience", "O", score);
    }

    @Override
    public String getHighDescription() {
        return "Enjoys new ideas, curious, independent, creative, embraces change and novelty.";
    }

    @Override
    public String getLowDescription() {
        return "Conservative, resistant to new ideas, prefers stability and routine.";
    }
}

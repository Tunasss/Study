public class Agreeableness extends PersonalityTrait {
    public Agreeableness(int score) {
        super("Agreeableness", "A", score);
    }

    @Override
    public String getHighDescription() {
        return "Friendly, empathetic, cooperative, altruistic, modest.";
    }

    @Override
    public String getLowDescription() {
        return "Competitive, self-centered, less empathetic and cooperative.";
    }
}

public class Neuroticism extends PersonalityTrait {
    public Neuroticism(int score) {
        super("Neuroticism", "N", score);
    }

    @Override
    public String getHighDescription() {
        return "Emotionally unstable, anxious, moody, vulnerable to stress.";
    }

    @Override
    public String getLowDescription() {
        return "Emotionally stable, calm, resilient, unaffected by stress.";
    }
}

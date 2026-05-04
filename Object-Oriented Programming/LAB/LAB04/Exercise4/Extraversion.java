public class Extraversion extends PersonalityTrait {
    public Extraversion(int score) {
        super("Extraversion", "E", score);
    }

    @Override
    public String getHighDescription() {
        return "Outgoing, energetic, sociable, enthusiastic, enjoys being around people.";
    }

    @Override
    public String getLowDescription() {
        return "Shy, reserved, prefers to work alone, avoids social interaction.";
    }
}

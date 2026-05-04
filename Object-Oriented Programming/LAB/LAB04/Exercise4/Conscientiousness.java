public class Conscientiousness extends PersonalityTrait {
    public Conscientiousness(int score) {
        super("Conscientiousness", "C", score);
    }

    @Override
    public String getHighDescription() {
        return "Hardworking, disciplined, responsible, persistent, loyal to organizations.";
    }

    @Override
    public String getLowDescription() {
        return "Disorganized, easily gives up, lacks responsibility and self-discipline.";
    }
}

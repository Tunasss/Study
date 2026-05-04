public abstract class PersonalityTrait {
    private String traitName;
    private String abbreviation;
    private int score;

    public PersonalityTrait() {}

    public PersonalityTrait(String traitName, String abbreviation, int score) {
        this.traitName = traitName;
        this.abbreviation = abbreviation;
        this.score = score;
    }

    public String getTraitName() { return traitName; }
    public void setTraitName(String traitName) { this.traitName = traitName; }

    public String getAbbreviation() { return abbreviation; }
    public void setAbbreviation(String abbreviation) { this.abbreviation = abbreviation; }

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }

    public String getLevel() {
        if (score >= 70) return "High";
        if (score <= 30) return "Low";
        return "No specific conclusion";
    }

    public abstract String getHighDescription();
    public abstract String getLowDescription();

    public String getDescription() {
        String level = getLevel();
        if (level.equals("High")) {
            return score + " " + traitName + " (" + abbreviation + "): High - " + getHighDescription();
        } else if (level.equals("Low")) {
            return score + " " + traitName + " (" + abbreviation + "): Low - " + getLowDescription();
        } else {
            return score + " " + traitName + " (" + abbreviation + "): No specific conclusion";
        }
    }

    @Override
    public String toString() {
        return abbreviation + score;
    }
}

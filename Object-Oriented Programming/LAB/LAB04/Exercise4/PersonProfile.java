import java.util.ArrayList;

public class PersonProfile {
    private String name;
    private ArrayList<PersonalityTrait> traits;

    public PersonProfile() {
        this.traits = new ArrayList<>();
    }

    public PersonProfile(String name) {
        this.name = name;
        this.traits = new ArrayList<>();
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public ArrayList<PersonalityTrait> getTraits() { return traits; }

    public void addTrait(PersonalityTrait trait) {
        traits.add(trait);
    }

    // Parse input like "O70-C30-E60-A96-N10"
    public void parseTraits(String input) {
        traits.clear();
        String[] parts = input.split("-");
        for (String part : parts) {
            char code = part.charAt(0);
            int score;
            if (part.startsWith("AB")) {
                // not applicable here, but safety
                score = Integer.parseInt(part.substring(2));
            } else {
                score = Integer.parseInt(part.substring(1));
            }
            switch (code) {
                case 'O': addTrait(new Openness(score)); break;
                case 'C': addTrait(new Conscientiousness(score)); break;
                case 'E': addTrait(new Extraversion(score)); break;
                case 'A': addTrait(new Agreeableness(score)); break;
                case 'N': addTrait(new Neuroticism(score)); break;
            }
        }
    }

    public PersonalityTrait getTraitByAbbreviation(String abbr) {
        for (PersonalityTrait t : traits) {
            if (t.getAbbreviation().equals(abbr)) return t;
        }
        return null;
    }

    public void displayDescription() {
        System.out.println("=== " + name + " ===");
        for (PersonalityTrait t : traits) {
            System.out.println(t.getDescription());
        }
    }

    // Risk patterns:
    // (b) Low C -> risk
    // (c) High N -> risk
    // (d) Low E + High N -> risk
    public boolean isHighRisk() {
        PersonalityTrait c = getTraitByAbbreviation("C");
        PersonalityTrait n = getTraitByAbbreviation("N");
        PersonalityTrait e = getTraitByAbbreviation("E");

        // (b) Low C
        if (c != null && c.getScore() <= 30) return true;
        // (c) High N
        if (n != null && n.getScore() >= 70) return true;
        // (d) Low E + High N
        if (e != null && n != null && e.getScore() <= 30 && n.getScore() >= 70) return true;

        return false;
    }

    public String getRiskReasons() {
        StringBuilder reasons = new StringBuilder();
        PersonalityTrait c = getTraitByAbbreviation("C");
        PersonalityTrait n = getTraitByAbbreviation("N");
        PersonalityTrait e = getTraitByAbbreviation("E");

        if (c != null && c.getScore() <= 30) {
            reasons.append("  - Low C: Disorganized, irresponsible, careless, impulsive.\n");
        }
        if (n != null && n.getScore() >= 70) {
            reasons.append("  - High N: Emotionally unstable, high stress, low commitment.\n");
        }
        if (e != null && n != null && e.getScore() <= 30 && n.getScore() >= 70) {
            reasons.append("  - Low E + High N: Difficulty seeking information, lacks career skills.\n");
        }
        return reasons.toString();
    }

    public String getTraitString() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < traits.size(); i++) {
            if (i > 0) sb.append("-");
            sb.append(traits.get(i).toString());
        }
        return sb.toString();
    }

    @Override
    public String toString() {
        return name + " [" + getTraitString() + "]";
    }
}

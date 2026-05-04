public abstract class BloodType {
    private String aboType; // O, A, B, AB
    private boolean rhPositive; // true = Rh+, false = Rh-

    public BloodType() {}

    public BloodType(String aboType, boolean rhPositive) {
        this.aboType = aboType;
        this.rhPositive = rhPositive;
    }

    public String getAboType() { return aboType; }
    public void setAboType(String aboType) { this.aboType = aboType; }

    public boolean isRhPositive() { return rhPositive; }
    public void setRhPositive(boolean rhPositive) { this.rhPositive = rhPositive; }

    public String getRhSign() { return rhPositive ? "+" : "-"; }

    public String getFullType() { return aboType + getRhSign(); }

    // Check if this blood type can donate to recipient
    public boolean canDonateTo(BloodType recipient) {
        // Rh rules: Rh- can donate to both, Rh+ can only donate to Rh+
        if (this.rhPositive && !recipient.rhPositive) {
            return false;
        }

        // ABO compatibility rules
        switch (this.aboType) {
            case "O":
                return true; // O can donate to all ABO types
            case "A":
                return recipient.aboType.equals("A") || recipient.aboType.equals("AB");
            case "B":
                return recipient.aboType.equals("B") || recipient.aboType.equals("AB");
            case "AB":
                return recipient.aboType.equals("AB");
            default:
                return false;
        }
    }

    // Get possible child blood types from two parents
    public static String[] getPossibleChildAboTypes(String parent1, String parent2) {
        String key = parent1.compareTo(parent2) <= 0 ? parent1 + "+" + parent2 : parent2 + "+" + parent1;
        switch (key) {
            case "O+O":   return new String[]{"O"};
            case "A+O":   return new String[]{"A", "O"};
            case "A+A":   return new String[]{"A", "O"};
            case "B+O":   return new String[]{"B", "O"};
            case "A+B":   return new String[]{"A", "B", "AB", "O"};
            case "B+B":   return new String[]{"B", "O"};
            case "AB+O":  return new String[]{"A", "B"};
            case "A+AB":  return new String[]{"A", "B", "AB"};
            case "AB+B":  return new String[]{"A", "B", "AB"};
            case "AB+AB": return new String[]{"A", "B", "AB"};
            default:      return new String[]{};
        }
    }

    public static boolean isChildValid(BloodType father, BloodType mother, BloodType child) {
        // Check ABO compatibility
        String[] possibleTypes = getPossibleChildAboTypes(father.getAboType(), mother.getAboType());
        boolean aboValid = false;
        for (String type : possibleTypes) {
            if (type.equals(child.getAboType())) {
                aboValid = true;
                break;
            }
        }
        if (!aboValid) return false;

        // Check Rh compatibility
        // If both parents are Rh-, child must be Rh-
        // If at least one parent is Rh+, child can be Rh+ or Rh-
        if (!father.isRhPositive() && !mother.isRhPositive()) {
            return !child.isRhPositive(); // child must be Rh-
        }
        return true; // child can be Rh+ or Rh-
    }

    @Override
    public String toString() {
        return getFullType();
    }
}

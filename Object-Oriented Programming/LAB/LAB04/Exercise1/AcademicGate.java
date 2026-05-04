public class AcademicGate extends Gate {
    private int requiredIntelligence;

    public AcademicGate() {}

    public AcademicGate(String gateName, int requiredIntelligence) {
        super(gateName);
        this.requiredIntelligence = requiredIntelligence;
    }

    public int getRequiredIntelligence() { return requiredIntelligence; }
    public void setRequiredIntelligence(int requiredIntelligence) { this.requiredIntelligence = requiredIntelligence; }

    @Override
    public boolean canPass(Prince prince) {
        if (prince.getIntelligence() >= requiredIntelligence) {
            System.out.println("  -> Passed " + getGateName() + "! Intelligence " + prince.getIntelligence() + " >= " + requiredIntelligence);
            return true;
        }
        System.out.println("  -> FAILED at " + getGateName() + "! Intelligence " + prince.getIntelligence() + " < " + requiredIntelligence);
        return false;
    }

    @Override
    public String toString() {
        return "[Academic Gate] " + getGateName() + ", Required Intelligence: " + requiredIntelligence;
    }
}

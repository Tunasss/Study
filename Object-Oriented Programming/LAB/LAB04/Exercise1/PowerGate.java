public class PowerGate extends Gate {
    private int warriorPower;

    public PowerGate() {}

    public PowerGate(String gateName, int warriorPower) {
        super(gateName);
        this.warriorPower = warriorPower;
    }

    public int getWarriorPower() { return warriorPower; }
    public void setWarriorPower(int warriorPower) { this.warriorPower = warriorPower; }

    @Override
    public boolean canPass(Prince prince) {
        if (prince.getPower() >= warriorPower) {
            prince.setPower(prince.getPower() - warriorPower);
            System.out.println("  -> Passed " + getGateName() + "! Power left: " + prince.getPower());
            return true;
        }
        System.out.println("  -> FAILED at " + getGateName() + "! Power " + prince.getPower() + " < " + warriorPower);
        return false;
    }

    @Override
    public String toString() {
        return "[Power Gate] " + getGateName() + ", Warrior Power: " + warriorPower;
    }
}

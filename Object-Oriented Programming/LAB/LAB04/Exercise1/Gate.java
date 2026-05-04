public abstract class Gate {
    private String gateName;

    public Gate() {}

    public Gate(String gateName) {
        this.gateName = gateName;
    }

    public String getGateName() { return gateName; }
    public void setGateName(String gateName) { this.gateName = gateName; }

    public abstract boolean canPass(Prince prince);

    @Override
    public String toString() {
        return "Gate: " + gateName;
    }
}

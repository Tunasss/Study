public class Guest extends Person {
    private String idCard; // CCCD

    public Guest() {}

    public Guest(String fullName, int age, String idCard) {
        super(fullName, age);
        this.idCard = idCard;
    }

    public String getIdCard() { return idCard; }
    public void setIdCard(String idCard) { this.idCard = idCard; }

    @Override
    public String toString() {
        return "[Guest] " + super.toString() + ", CCCD: " + idCard;
    }
}

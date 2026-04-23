public abstract class Ticket {
    private String ticketId;
    private String holderName;
    private int yearOfBirth;
    private int numberOfGames;

    public Ticket() {}

    public Ticket(String ticketId, String holderName, int yearOfBirth, int numberOfGames) {
        this.ticketId = ticketId;
        this.holderName = holderName;
        this.yearOfBirth = yearOfBirth;
        this.numberOfGames = numberOfGames;
    }

    public String getTicketId() { return ticketId; }
    public void setTicketId(String ticketId) { this.ticketId = ticketId; }

    public String getHolderName() { return holderName; }
    public void setHolderName(String holderName) { this.holderName = holderName; }

    public int getYearOfBirth() { return yearOfBirth; }
    public void setYearOfBirth(int yearOfBirth) { this.yearOfBirth = yearOfBirth; }

    public int getNumberOfGames() { return numberOfGames; }
    public void setNumberOfGames(int numberOfGames) { this.numberOfGames = numberOfGames; }

    public abstract double getPrice();

    @Override
    public String toString() {
        return "Ticket ID: " + ticketId + ", Holder: " + holderName +
               ", Year of Birth: " + yearOfBirth + ", Games: " + numberOfGames +
               ", Price: " + getPrice() + " VND";
    }
}

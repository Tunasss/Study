public class PartialTicket extends Ticket {

    public PartialTicket() {}

    public PartialTicket(String ticketId, String holderName, int yearOfBirth, int numberOfGames) {
        super(ticketId, holderName, yearOfBirth, numberOfGames);
    }

    @Override
    public double getPrice() {
        return 70000 + getNumberOfGames() * 20000;
    }

    @Override
    public String toString() {
        return "[Partial] " + super.toString();
    }
}

public class FullPackageTicket extends Ticket {

    public FullPackageTicket() {}

    public FullPackageTicket(String ticketId, String holderName, int yearOfBirth, int numberOfGames) {
        super(ticketId, holderName, yearOfBirth, numberOfGames);
    }

    @Override
    public double getPrice() {
        return 200000;
    }

    @Override
    public String toString() {
        return "[Full Package] " + super.toString();
    }
}

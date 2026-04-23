import java.util.ArrayList;

public class Room {
    private String roomType; // VIP1, VIP2, VIP3
    private double pricePerDay;
    private ArrayList<Guest> guests;
    private Staff staff;

    public Room() {
        this.guests = new ArrayList<>();
    }

    public Room(String roomType, Staff staff) {
        this.roomType = roomType;
        this.staff = staff;
        this.guests = new ArrayList<>();
        switch (roomType) {
            case "VIP1": this.pricePerDay = 900000; break;
            case "VIP2": this.pricePerDay = 700000; break;
            case "VIP3": this.pricePerDay = 500000; break;
            default: this.pricePerDay = 0;
        }
    }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public double getPricePerDay() { return pricePerDay; }
    public void setPricePerDay(double pricePerDay) { this.pricePerDay = pricePerDay; }

    public ArrayList<Guest> getGuests() { return guests; }

    public Staff getStaff() { return staff; }
    public void setStaff(Staff staff) { this.staff = staff; }

    public void addGuest(Guest guest) {
        guests.add(guest);
        System.out.println("Added guest: " + guest.getFullName());
    }

    public void removeGuest(String idCard) {
        for (int i = 0; i < guests.size(); i++) {
            if (guests.get(i).getIdCard().equals(idCard)) {
                System.out.println("Removed guest: " + guests.get(i).getFullName());
                guests.remove(i);
                return;
            }
        }
        System.out.println("Guest with CCCD " + idCard + " not found.");
    }

    public double calculateCost(int numberOfDays) {
        return pricePerDay * numberOfDays;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Room Type: ").append(roomType)
          .append(", Price/Day: ").append(pricePerDay).append(" VND")
          .append("\nStaff: ").append(staff)
          .append("\nGuests (").append(guests.size()).append("):");
        for (Guest g : guests) {
            sb.append("\n  - ").append(g);
        }
        return sb.toString();
    }
}

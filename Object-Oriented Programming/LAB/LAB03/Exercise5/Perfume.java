public class Perfume extends Product {

    public Perfume() {}

    public Perfume(String id, String type, double volume) {
        super(id, type, volume);
    }

    @Override
    public double getPrice() {
        if (getType().equalsIgnoreCase("Rose")) {
            return getVolume() * 20000;
        } else { // Chamomile
            return getVolume() * 15000;
        }
    }
}

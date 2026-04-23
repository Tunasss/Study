public class ShowerGel extends Product {

    public ShowerGel() {}

    public ShowerGel(String id, String type, double volume) {
        super(id, type, volume);
    }

    @Override
    public double getPrice() {
        if (getType().equalsIgnoreCase("Oily Skin")) {
            return getVolume() * 40000;
        } else { // Dry Skin
            return getVolume() * 20000;
        }
    }
}

public class Shampoo extends Product {
    private int standard; // 1 or 2 (only for Oily Hair type)

    public Shampoo() {}

    public Shampoo(String id, String type, double volume) {
        super(id, type, volume);
        this.standard = 0;
    }

    public Shampoo(String id, String type, double volume, int standard) {
        super(id, type, volume);
        this.standard = standard;
    }

    public int getStandard() { return standard; }
    public void setStandard(int standard) { this.standard = standard; }

    @Override
    public double getPrice() {
        if (getType().equalsIgnoreCase("Oily Hair")) {
            if (standard == 1) {
                return getVolume() * 30000;
            } else { // standard 2
                return getVolume() * 40000;
            }
        } else { // Dry Hair
            return getVolume() * 20000;
        }
    }

    @Override
    public String toString() {
        String extra = getType().equalsIgnoreCase("Oily Hair") ? ", Standard: " + standard : "";
        return super.toString() + extra;
    }
}

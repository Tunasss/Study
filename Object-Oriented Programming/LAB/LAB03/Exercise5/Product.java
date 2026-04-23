public abstract class Product {
    private String id;
    private String type;
    private double volume; // ml

    public Product() {}

    public Product(String id, String type, double volume) {
        this.id = id;
        this.type = type;
        this.volume = volume;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public double getVolume() { return volume; }
    public void setVolume(double volume) { this.volume = volume; }

    public abstract double getPrice();

    @Override
    public String toString() {
        return getClass().getSimpleName() + " [ID: " + id + ", Type: " + type +
               ", Volume: " + volume + " ml, Price: " + getPrice() + " VND]";
    }
}

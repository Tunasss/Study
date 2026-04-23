import java.util.ArrayList;

public abstract class ProductPackage {
    private ArrayList<Product> products;

    public ProductPackage() {
        this.products = new ArrayList<>();
    }

    public ArrayList<Product> getProducts() { return products; }

    public void addProduct(Product p) {
        products.add(p);
    }

    public double getPackagePrice() {
        double total = 0;
        for (Product p : products) {
            total += p.getPrice();
        }
        return total;
    }

    public abstract String getPackageName();

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Package: ").append(getPackageName())
          .append(", Total Price: ").append(getPackagePrice()).append(" VND");
        for (Product p : products) {
            sb.append("\n    ").append(p);
        }
        return sb.toString();
    }
}

public class Order {
    private String orderId;
    private Customer customer;
    private String invoiceDate;
    private ProductPackage productPackage;

    public Order() {}

    public Order(String orderId, Customer customer, String invoiceDate, ProductPackage productPackage) {
        this.orderId = orderId;
        this.customer = customer;
        this.invoiceDate = invoiceDate;
        this.productPackage = productPackage;
    }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }

    public String getInvoiceDate() { return invoiceDate; }
    public void setInvoiceDate(String invoiceDate) { this.invoiceDate = invoiceDate; }

    public ProductPackage getProductPackage() { return productPackage; }
    public void setProductPackage(ProductPackage productPackage) { this.productPackage = productPackage; }

    public double getOrderPrice() {
        return productPackage.getPackagePrice();
    }

    @Override
    public String toString() {
        return "Order [ID: " + orderId + ", Date: " + invoiceDate +
               ", Price: " + getOrderPrice() + " VND]\n  " + customer +
               "\n  " + productPackage;
    }
}

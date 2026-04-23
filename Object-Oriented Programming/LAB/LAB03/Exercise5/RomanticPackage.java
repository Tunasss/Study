public class RomanticPackage extends ProductPackage {

    // Always includes Rose Perfume; optional Shampoo & Shower Gel
    public RomanticPackage(Perfume rosePerfume, Shampoo shampoo, ShowerGel showerGel) {
        super();
        addProduct(rosePerfume);
        if (shampoo != null) addProduct(shampoo);
        if (showerGel != null) addProduct(showerGel);
    }

    @Override
    public String getPackageName() {
        return "Romantic Package";
    }
}

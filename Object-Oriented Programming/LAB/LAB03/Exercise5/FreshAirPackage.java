public class FreshAirPackage extends ProductPackage {

    // Always includes Oily Hair Shampoo; optional Perfume & Shower Gel
    public FreshAirPackage(Shampoo oilyHairShampoo, Perfume perfume, ShowerGel showerGel) {
        super();
        addProduct(oilyHairShampoo);
        if (perfume != null) addProduct(perfume);
        if (showerGel != null) addProduct(showerGel);
    }

    @Override
    public String getPackageName() {
        return "Fresh-Air Package";
    }
}

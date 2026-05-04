public class Person {
    private String name;
    private BloodType bloodType;

    public Person() {}

    public Person(String name, BloodType bloodType) {
        this.name = name;
        this.bloodType = bloodType;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BloodType getBloodType() { return bloodType; }
    public void setBloodType(BloodType bloodType) { this.bloodType = bloodType; }

    @Override
    public String toString() {
        return name + " (Blood Type: " + bloodType.getFullType() + ")";
    }
}

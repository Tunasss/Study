public class Prince {
    private double money;
    private int intelligence;
    private int power;

    public Prince() {}

    public Prince(double money, int intelligence, int power) {
        this.money = money;
        this.intelligence = intelligence;
        this.power = power;
    }

    public double getMoney() { return money; }
    public void setMoney(double money) { this.money = money; }

    public int getIntelligence() { return intelligence; }
    public void setIntelligence(int intelligence) { this.intelligence = intelligence; }

    public int getPower() { return power; }
    public void setPower(int power) { this.power = power; }

    @Override
    public String toString() {
        return "Prince [Money: " + money + ", Intelligence: " + intelligence + ", Power: " + power + "]";
    }
}

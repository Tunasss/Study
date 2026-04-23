public class Singer {
    private String fullName;
    private int yearsOfExperience;
    private int albumsSold;
    private int performances;

    public Singer() {}

    public Singer(String fullName, int yearsOfExperience, int albumsSold, int performances) {
        this.fullName = fullName;
        this.yearsOfExperience = yearsOfExperience;
        this.albumsSold = albumsSold;
        this.performances = performances;
    }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public int getYearsOfExperience() { return yearsOfExperience; }
    public void setYearsOfExperience(int yearsOfExperience) { this.yearsOfExperience = yearsOfExperience; }

    public int getAlbumsSold() { return albumsSold; }
    public void setAlbumsSold(int albumsSold) { this.albumsSold = albumsSold; }

    public int getPerformances() { return performances; }
    public void setPerformances(int performances) { this.performances = performances; }

    public double calculateSalary() {
        return 3000000 + 500000.0 * yearsOfExperience + 1000.0 * albumsSold + 200000.0 * performances;
    }

    @Override
    public String toString() {
        return "Name: " + fullName + ", Years: " + yearsOfExperience +
               ", Albums: " + albumsSold + ", Performances: " + performances +
               ", Salary: " + calculateSalary() + " VND";
    }
}

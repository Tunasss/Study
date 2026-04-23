public class FamousSinger extends Singer {
    private int gameShows;

    public FamousSinger() {}

    public FamousSinger(String fullName, int yearsOfExperience, int albumsSold,
                        int performances, int gameShows) {
        super(fullName, yearsOfExperience, albumsSold, performances);
        this.gameShows = gameShows;
    }

    public int getGameShows() { return gameShows; }
    public void setGameShows(int gameShows) { this.gameShows = gameShows; }

    @Override
    public double calculateSalary() {
        return 5000000 + 500000.0 * getYearsOfExperience() + 1200.0 * getAlbumsSold() +
               500000.0 * getPerformances() + 500000.0 * gameShows;
    }

    @Override
    public String toString() {
        return "[Famous] Name: " + getFullName() + ", Years: " + getYearsOfExperience() +
               ", Albums: " + getAlbumsSold() + ", Performances: " + getPerformances() +
               ", Game Shows: " + gameShows + ", Salary: " + calculateSalary() + " VND";
    }
}

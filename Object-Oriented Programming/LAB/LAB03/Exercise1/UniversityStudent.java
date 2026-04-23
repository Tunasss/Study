public class UniversityStudent extends Student {
    private String thesisTitle;
    private double thesisScore;

    public UniversityStudent() {}

    public UniversityStudent(String studentId, String fullName, String address,
                             int totalCredits, double gpa, String thesisTitle, double thesisScore) {
        super(studentId, fullName, address, totalCredits, gpa);
        this.thesisTitle = thesisTitle;
        this.thesisScore = thesisScore;
    }

    public String getThesisTitle() { return thesisTitle; }
    public void setThesisTitle(String thesisTitle) { this.thesisTitle = thesisTitle; }

    public double getThesisScore() { return thesisScore; }
    public void setThesisScore(double thesisScore) { this.thesisScore = thesisScore; }

    public boolean isGraduated() {
        return getTotalCredits() >= 170 && getGpa() >= 5.0 && thesisScore >= 5.0;
    }

    @Override
    public String toString() {
        return super.toString() + ", Thesis: " + thesisTitle + ", Thesis Score: " + thesisScore +
               ", Graduated: " + isGraduated();
    }
}

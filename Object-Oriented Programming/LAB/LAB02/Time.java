class Time {
    private int hour;
    private int minute;
    private int second;

    public Time() {
        this.hour = 0;
        this.minute = 0;
        this.second = 0;
    }

    public Time(int hour, int minute, int second) {
        if (hour < 0 || hour >= 24 || minute < 0 || minute >= 60 || second < 0 || second >= 60) {
            throw new IllegalArgumentException("Invalid time.");
        }
        this.hour = hour;
        this.minute = minute;
        this.second = second;
    }

    public Time addHours(int hoursToAdd) {
        int newHour = (this.hour + hoursToAdd) % 24;
        if (newHour < 0) newHour += 24;
        return new Time(newHour, this.minute, this.second);
    }

    public Time subtractHours(int hoursToSubtract) {
        return addHours(-hoursToSubtract);
    }
}




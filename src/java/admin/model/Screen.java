package admin.model;


import java.sql.Timestamp;

public class Screen {
    private Timestamp startTime;
    private String format;

    // Getters and Setters
    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }
}


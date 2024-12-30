import java.time.LocalDateTime;

public class ShowTime {
    private int showtimeid;
    private int movieid;
    private int screenid;
    private LocalDateTime showtime;

    public int getShowtimeid() {
        return showtimeid;
    }

    public void setShowtimeid(int showtimeid) {
        this.showtimeid = showtimeid;
    }

    public int getMovieid() {
        return movieid;
    }

    public void setMovieid(int movieid) {
        this.movieid = movieid;
    }

    public int getScreenid() {
        return screenid;
    }

    public void setScreenid(int screenid) {
        this.screenid = screenid;
    }

    public LocalDateTime getShowtime() {
        return showtime;
    }

    public void setShowtime(LocalDateTime showtime) {
        this.showtime = showtime;
    }
    
     
    

    
}

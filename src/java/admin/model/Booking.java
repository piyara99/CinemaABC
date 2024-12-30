
import java.time.LocalDateTime;

public class Booking {
    private int bookingId;
    private int seatId;
    private String customerid;
    private LocalDateTime showtimeid;

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public String getCustomerid() {
        return customerid;
    }

    public void setCustomerid(String customerid) {
        this.customerid = customerid;
    }

    public LocalDateTime getShowtimeid() {
        return showtimeid;
    }

    public void setShowtimeid(LocalDateTime showtimeid) {
        this.showtimeid = showtimeid;
    }
    
    
    public void bookTicket(int customerid){
        
        
    }
    
    public void seeTicket(int customerid){
        
    }
    
    public void cancelTicket(int customerid){
    
    }

    
}


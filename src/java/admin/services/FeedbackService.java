package admin.services;

import admin.dao.FeedbackDAO;
import java.util.List;
import java.util.Map;

public class FeedbackService {

    private final FeedbackDAO feedbackDAO;

    public FeedbackService() {
        this.feedbackDAO = new FeedbackDAO();
    }

    public List<Map<String, Object>> getFeedbackData(int movieId) {
        return feedbackDAO.getFeedbackData(movieId);
    }
}

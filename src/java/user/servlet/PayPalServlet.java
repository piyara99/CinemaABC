//package user.servlet;
//
//import com.paypal.api.payments.*;
//import com.paypal.base.rest.APIContext;
//import com.paypal.base.rest.PayPalRESTException;
//import com.paypal.api.payments.Links;
//import java.io.IOException;
//import java.util.Collections;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//public class PayPalServlet extends HttpServlet {
//
//    // PayPal credentials for sandbox environment
//    private static final String CLIENT_ID = "AUvwKjTPAfcV_ajm6N3UsopVgAtLRWRgMmwv3xFoH9cVdzqi9WxPtK9Rug9ukj-CFdxz-TGHuLFB9ANB";
//    private static final String CLIENT_SECRET = "EH1fQ24zxLQZdIuXf6RTm3hTuddIQ_xKN6UY5QNKXbPJfjwjtL9xsntdl0dpcsRh97eAliOZzIqGwHZe";
//    private static final String MODE = "sandbox"; // or "live" when you're ready for production
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        // Create APIContext instance
//        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
//
//        // Set up payment amount
//        Amount amount = new Amount();
//        amount.setCurrency("USD");
//        amount.setTotal("20.00"); // Replace this with the actual amount dynamically
//
//        // Create transaction object
//        Transaction transaction = new Transaction();
//        transaction.setDescription("Purchase description");
//        transaction.setAmount(amount);
//
//        // Set up payer (PayPal as payment method)
//        Payer payer = new Payer();
//        payer.setPaymentMethod("paypal");
//
//        // Set up the payment with intent and payer
//        Payment payment = new Payment();
//        payment.setIntent("sale");
//        payment.setPayer(payer);
//        payment.setTransactions(Collections.singletonList(transaction));
//
//        // Set up redirect URLs (for success and cancel)
//        RedirectUrls redirectUrls = new RedirectUrls();
//        redirectUrls.setCancelUrl("http://localhost:8080/your-app/cancel");
//        redirectUrls.setReturnUrl("http://localhost:8080/your-app/success");
//        payment.setRedirectUrls(redirectUrls);
//
//        try {
//            // Create payment
//            Payment createdPayment = payment.create(apiContext);
//
//            // Look for the approval link and redirect user to PayPal
//            for (Links link : createdPayment.getLinks()) {
//                if ("approval_url".equals(link.getRel())) {
//                    // Redirect to PayPal approval page
//                    response.sendRedirect(link.getHref());
//                    return;
//                }
//            }
//        } catch (PayPalRESTException e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Payment creation failed.");
//        }
//    }
//
//    @Override
//    public String getServletInfo() {
//        return "PayPal Payment Servlet";
//    }
//}

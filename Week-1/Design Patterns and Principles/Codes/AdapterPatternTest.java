interface PaymentProcessor {
    void processPayment(double amount);
}

class PayPalGateway {

    public void payWithPayPal(double amount) {
        System.out.println("Payment of Rs." + amount + " processed through PayPal.");
    }
}

class StripeGateway {

    public void makePayment(double amount) {
        System.out.println("Payment of Rs." + amount + " processed through Stripe.");
    }
}

class RazorpayGateway {

    public void sendMoney(double amount) {
        System.out.println("Payment of Rs." + amount + " processed through Razorpay.");
    }
}

class PayPalAdapter implements PaymentProcessor {

    private PayPalGateway paypal;

    public PayPalAdapter(PayPalGateway paypal) {
        this.paypal = paypal;
    }

    @Override
    public void processPayment(double amount) {
        paypal.payWithPayPal(amount);
    }
}

class StripeAdapter implements PaymentProcessor {

    private StripeGateway stripe;

    public StripeAdapter(StripeGateway stripe) {
        this.stripe = stripe;
    }

    @Override
    public void processPayment(double amount) {
        stripe.makePayment(amount);
    }
}

class RazorpayAdapter implements PaymentProcessor {

    private RazorpayGateway razorpay;

    public RazorpayAdapter(RazorpayGateway razorpay) {
        this.razorpay = razorpay;
    }

    @Override
    public void processPayment(double amount) {
        razorpay.sendMoney(amount);
    }
}

public class AdapterPatternTest {

    public static void main(String[] args) {

        PaymentProcessor paypal =
                new PayPalAdapter(new PayPalGateway());

        PaymentProcessor stripe =
                new StripeAdapter(new StripeGateway());

        PaymentProcessor razorpay =
                new RazorpayAdapter(new RazorpayGateway());

        paypal.processPayment(1000);

        stripe.processPayment(2500);

        razorpay.processPayment(5000);
    }
}
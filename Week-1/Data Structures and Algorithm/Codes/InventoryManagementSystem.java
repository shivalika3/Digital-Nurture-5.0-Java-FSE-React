import java.util.HashMap;
import java.util.Map;

class Product {

    int productId;
    String productName;
    int quantity;
    double price;

    public Product(int productId, String productName,
                   int quantity, double price) {

        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }

    @Override
    public String toString() {
        return "Product ID: " + productId +
               ", Product Name: " + productName +
               ", Quantity: " + quantity +
               ", Price: " + price;
    }
}

class Inventory {

    private HashMap<Integer, Product> products = new HashMap<>();

    public void addProduct(Product product) {
        products.put(product.productId, product);
        System.out.println("Product Added.");
    }

    public void updateProduct(int id, int quantity, double price) {

        Product product = products.get(id);

        if (product != null) {
            product.quantity = quantity;
            product.price = price;
            System.out.println("Product Updated.");
        } else {
            System.out.println("Product Not Found.");
        }
    }

    public void deleteProduct(int id) {

        if (products.remove(id) != null) {
            System.out.println("Product Deleted.");
        } else {
            System.out.println("Product Not Found.");
        }
    }

    public void displayInventory() {

        System.out.println("\nInventory Details:");

        for (Map.Entry<Integer, Product> entry : products.entrySet()) {
            System.out.println(entry.getValue());
        }
    }
}

public class InventoryManagementSystem {

    public static void main(String[] args) {

        Inventory inventory = new Inventory();

        Product p1 = new Product(
                101,
                "Laptop",
                10,
                50000.0);

        Product p2 = new Product(
                102,
                "Mouse",
                50,
                500.0);

        inventory.addProduct(p1);
        inventory.addProduct(p2);

        inventory.displayInventory();

        inventory.updateProduct(
                101,
                15,
                52000.0);

        inventory.displayInventory();

        inventory.deleteProduct(102);

        inventory.displayInventory();
    }
}
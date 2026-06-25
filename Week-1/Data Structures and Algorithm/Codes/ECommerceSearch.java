class Product {

    int productId;
    String productName;
    String category;

    public Product(int productId,
                   String productName,
                   String category) {

        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    @Override
    public String toString() {
        return "Product ID: " + productId +
               ", Name: " + productName +
               ", Category: " + category;
    }
}

public class ECommerceSearch {

    public static Product linearSearch(Product[] products,
                                       int targetId) {

        for (Product product : products) {

            if (product.productId == targetId) {
                return product;
            }
        }

        return null;
    }

    public static Product binarySearch(Product[] products,
                                       int targetId) {

        int low = 0;
        int high = products.length - 1;

        while (low <= high) {

            int mid = (low + high) / 2;

            if (products[mid].productId == targetId) {
                return products[mid];
            }

            if (products[mid].productId < targetId) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return null;
    }

    public static void main(String[] args) {

        Product[] products = {

                new Product(101,
                        "Laptop",
                        "Electronics"),

                new Product(102,
                        "Mouse",
                        "Electronics"),

                new Product(103,
                        "Keyboard",
                        "Electronics"),

                new Product(104,
                        "Shoes",
                        "Fashion"),

                new Product(105,
                        "Watch",
                        "Accessories")
        };

        int targetId = 104;

        System.out.println("Linear Search:");

        Product result1 =
                linearSearch(products,
                        targetId);

        if (result1 != null) {
            System.out.println(result1);
        } else {
            System.out.println("Product Not Found");
        }

        System.out.println();

        System.out.println("Binary Search:");

        Product result2 =
                binarySearch(products,
                        targetId);

        if (result2 != null) {
            System.out.println(result2);
        } else {
            System.out.println("Product Not Found");
        }
    }
}
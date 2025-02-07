using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryManagementSystem
{
    public class InventoryManagement
    {
        private static List<Product> products = new List<Product>();

        public static void addProduct(Product product)
        {
            products.Add(product);
            Console.WriteLine($"\nProduct {product.productName} added successfully.\n");
        }

        public static Product createProduct()
        {
            while (true)
            {
                Console.WriteLine("\nEnter a Product Name to Add (Ex.Apple) : ");
                string? productName = Console.ReadLine();

                while (string.IsNullOrEmpty(productName) || productName.Any(char.IsDigit))
                {
                    Console.WriteLine("Please try again, Enter a Product Name to Add (Ex.Apple) : ");
                    productName = Console.ReadLine();
                }

                Console.WriteLine("\nEnter Product Quantity (Ex.2) : ");
                if (int.TryParse(Console.ReadLine(), out int productQuantity) && productQuantity > 0)
                {
                    Console.WriteLine("\nEnter Product Price (Ex. 50) : ");
                    if (int.TryParse(Console.ReadLine(), out int productPrice) && productPrice > 0)
                    {
                        Product newProduct = new Product(products.Count + 1, productName, productQuantity, productPrice);
                        return newProduct;
                    }
                    else
                    {
                        Console.WriteLine("Invalid Product Price, Please Enter a Valid Price");
                    }
                }
                else
                {
                    Console.WriteLine("Invalid Quantity, Please Enter a Valid Integer");
                }
            }
        }

        public static Product? FindProductById(int productId)
        {
            return products.Find(x => x.productId == productId);
        }

        public static void removeProduct(int productId)
        {
            Product? productToRemove = FindProductById(productId);

            if (productToRemove != null)
            {
                products.Remove(productToRemove);
                Console.WriteLine($"\nProduct with ID {productId} removed.\n");
            }
            else
            {
                Console.WriteLine($"\nNo Product found with ID {productId}.\n");
            }

        }

        public static void updateProduct(int productId, int newQuantity)
        {
            Product? productToUpdate = FindProductById(productId);

            if (productToUpdate != null)
            {
                productToUpdate.productQuantity = newQuantity;
                Console.WriteLine($"\nQuantity of product ID {productId} has been updated.\n");
            }
            else
            {
                Console.WriteLine("\nNo product found with ID {productId}.\n");
            }
        }

        public static void viewProduct()
        {
            if (products.Count > 0)
            {
                Console.WriteLine("\n--PRODUCT LIST--\n");
                foreach (Product product in products)
                {
                    Console.WriteLine($"ID: {product.productId} \nName: {product.productName} \nQuantity: {product.productQuantity} \nPrice: {product.productPrice}");
                    Console.WriteLine();
                }
            }
            else
            {
                Console.WriteLine("There are no products available.");
            }
        }

        public static void getTotalValue()
        {
            double totalValue = 0;
            foreach (Product product in products)
            {
                totalValue += product.productQuantity * product.productPrice;
            }
            Console.WriteLine($"\nTotal Value of Products: {totalValue:N2} Pesos\n");
        }
    }
}

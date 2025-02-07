using System.Diagnostics;
using System.Linq.Expressions;

namespace InventoryManagementSystem
{
    public class Program
    {
        static void Main(string[] args)
        {

            bool exit = true;
            while (exit!=false)
            {

                Console.WriteLine("-------------------------------");
                Console.WriteLine("| Inventory Management System |");
                Console.WriteLine("-------------------------------");
                Console.WriteLine("\n1. Add Product");
                Console.WriteLine("2. Remove Product");
                Console.WriteLine("3. Update Product");
                Console.WriteLine("4. List Products");
                Console.WriteLine("5. Get Total Value\n");
                Console.WriteLine("Choose a number from 1 to 5 or enter 'X' to exit the system");
                string? userChoice = Console.ReadLine();

                switch (userChoice)
                {
                    case "1":
                        InventoryManagement.addProduct(InventoryManagement.createProduct());
                        break;
                    case "2":
                        Console.WriteLine("\nEnter the product ID to be removed");
                        if (int.TryParse(Console.ReadLine(), out int productId))
                        {
                            InventoryManagement.removeProduct(productId);
                        }
                        else
                        {
                            Console.WriteLine("\nInvalid Product ID, Please input a valid integer.\n");
                        }
                        break;
                    case "3":
                        Console.WriteLine("\nEnter a product ID to update");
                        if (int.TryParse(Console.ReadLine(), out int updateId))
                        {
                            Console.WriteLine("\nEnter new quanity to update");
                            if (int.TryParse(Console.ReadLine(), out int newQuantity))
                            {
                                InventoryManagement.updateProduct(updateId, newQuantity);
                            }
                        }
                        break;
                    case "4":
                        InventoryManagement.viewProduct();
                        break;
                    case "5":
                        InventoryManagement.getTotalValue();
                        break;
;                   case "x":
                    case "X":
                        exit = false;
                        Console.WriteLine("\nYou have exited the system.");
                        break;
                    default:
                        Console.WriteLine("\nInvalid input, please try again \n");
                        break;
                }

            }
        }
    }
}

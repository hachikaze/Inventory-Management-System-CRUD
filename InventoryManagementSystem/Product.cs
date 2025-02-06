using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryManagementSystem
{
    public class Product
    {
        public int productId {  get; set; }
        public string productName { get; set; }
        public int productQuantity { get; set; }
        public double productPrice { get; set; }

        public Product(int id, string name, int quantity, double price)
        {
            productId = id;
            productName = name;
            productQuantity = quantity;
            productPrice = price;
        }
    }
}

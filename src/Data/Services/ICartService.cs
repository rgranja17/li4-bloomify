using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{
    public interface ICartService
    {
        void AddToCart(ProductModel produto);

        List<ProductModel> GetCartProducts();

        int GetProductQuantity(string nome);

        void RemoveFromCart(string productName);

        void ClearCart();
    }
}
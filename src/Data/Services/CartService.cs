using System;
using System.Collections.Generic;
using System.Linq;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{
    public class CartService : ICartService
    {
        private readonly List<(ProductModel produto, int quantity)> _cartProducts;

        public CartService()
        {
            _cartProducts = new List<(ProductModel produto, int quantity)>();
        }

        public void AddToCart(ProductModel produto)
        {
            if (produto == null)
                throw new ArgumentNullException(nameof(produto));

            var existingProductIndex = _cartProducts.FindIndex(p => p.produto.Nome == produto.Nome);

            if (existingProductIndex != -1)
            {
                var existingProduct = _cartProducts[existingProductIndex];
                _cartProducts[existingProductIndex] = (existingProduct.produto, existingProduct.quantity + 1);
            }
            else
            {
                _cartProducts.Add((produto, 1));
            }
        }

        public void RemoveFromCart(string productName)
        {
            if (string.IsNullOrWhiteSpace(productName))
                throw new ArgumentException("Nome do produto inválido", nameof(productName));

            var existingProductIndex = _cartProducts.FindIndex(p => p.produto.Nome.Equals(productName, StringComparison.OrdinalIgnoreCase));

            if (existingProductIndex != -1)
            {
                var existingProduct = _cartProducts[existingProductIndex];

                if (existingProduct.quantity > 1)
                {
                    // Reduz a quantidade do produto
                    _cartProducts[existingProductIndex] = (existingProduct.produto, existingProduct.quantity - 1);
                }
                else
                {
                    // Remove o produto do carrinho se a quantidade for 1
                    _cartProducts.RemoveAt(existingProductIndex);
                }
            }
        }

        public List<ProductModel> GetCartProducts()
        {
            return _cartProducts.Select(p => p.produto).ToList();
        }

        public int GetProductQuantity(string nome)
        {
            var product = _cartProducts.FirstOrDefault(p => p.produto.Nome.Equals(nome, StringComparison.OrdinalIgnoreCase));
            return product.produto != null ? product.quantity : 0;
        }

        public void ClearCart()
        {
            _cartProducts.Clear();
        }
    }
}

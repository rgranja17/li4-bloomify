using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{

    public interface IProductService
    {
        Task<List<ProductModel>> GetProducts();

        Task<ProductModel> GetProduct(int productId);
        
        Task<ProductModel> GetProductByName(string productId);

        Task<int> GetTotalSpentByEncomenda(int id);

        Task<int> GetNProductsByEncomenda(int id);

        Task<string> GetFavoriteProductByOrder(int encomendaId);

        Task<int> CreateProduct(string nome, int encomendaId);

        Task<List<ProductModel>> GetProductsByOrderId(int orderId);

        Task UpdateProduct(int productId, string nome, string descricao, decimal preco, string imagem, string titulo);

        Task DeleteProduct(int productId);
    }
}

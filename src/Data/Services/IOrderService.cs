using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{
    public interface IOrderService
    {
        Task<List<OrderModel>> GetOrders();

        Task<OrderModel?> GetOrder(int orderId);

        Task<int?> GetOrderFuncionario(int orderId);

        Task<List<OrderModel>> GetOrdersByClient(string NIF);

        Task<List<OrderModel>> GetOrdersByFuncionario(int funcionarioId);

        Task<List<OrderModel>> GetOrdersByEstado(string estado);

        Task<int> CreateOrder(string rua, string codigoPostal, int porta, string NIF);

        Task<string?> GetEstadoEncomenda(int encomendaId);

        Task UpdateOrder(int orderId, DateOnly deliveryDate, string rua, string codigoPostal, int porta, int estadoId);

        Task UpdateOrderState(int orderId, int estadoId);

        Task<List<LinhaDeMontagemModel>> GetLinhasDeMontagemByProductId(int productId);
        
        Task DeleteOrder(int orderId);
    }
}
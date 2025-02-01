using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services {

    public interface IComponentService {
        Task<List<ComponentModel>> GetComponentes();

        Task<List<ComponentModel>> GetComponentesParaMontagem(int productId);

        Task<ComponentModel?> GetComponent(int componentId);

        Task<List<ComponentModel>> GetComponentsByProduct(int productId) ;

        Task UpdateComponentQuantity(int componentId, int quantidade);

        Task DeleteComponent(int componentId);
    }
}
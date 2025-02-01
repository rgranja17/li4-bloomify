using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services {

    public class ComponentService : IComponentService {

        private readonly ISqlDataAccess db;

        public ComponentService(ISqlDataAccess db) {
            this.db = db;
        }

        public async Task<List<ComponentModel>> GetComponentes() {
            const string sql = "SELECT * FROM Componente";
            return await this.db.LoadData<ComponentModel, dynamic>(sql, new { });
        }

        public Task<List<ComponentModel>> GetComponentesParaMontagem(int productId)
        {
            const string sql = @"
                SELECT c.Id, c.Nome, c.Cor, cp.Quantidade
                FROM Componente c
                LEFT JOIN Componente_Produto cp ON c.Id = cp.Componente_Id
                WHERE cp.Produto_Id = @ProdutoId";

            return this.db.LoadData<ComponentModel, dynamic>(sql, new { ProdutoId = productId });
        }


        public Task<ComponentModel?> GetComponent(int componentId) {
            const string sql = "SELECT * FROM Componente WHERE Id = @ComponenteId";
            return this.db.LoadData<ComponentModel, dynamic>(sql, new { ComponenteId = componentId })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public Task<List<ComponentModel>> GetComponentsByProduct(int productId) 
        {
            const string sql = @"
                SELECT c.Id, c.Nome, c.Quantidade, c.Cor
                FROM Componente c
                JOIN Componente_Produto cp ON c.Id = cp.Componente_Id
                WHERE cp.Produto_Id = @ProdutoId";
            return this.db.LoadData<ComponentModel, dynamic>(sql, new { ProdutoId = productId });
        }

        public async Task UpdateComponent(int componentId, string nome, int quantidade, string cor) 
        {
            const string sql = @"
                UPDATE Componente
                SET Nome = @Nome,
                    Quantidade = @Quantidade,
                    Cor = @Cor
                WHERE Id = @ComponenteId";

            await this.db.SaveData(sql, new
            {
                ComponenteId = componentId,
                Nome = nome,
                Quantidade = quantidade,
                Cor = cor
            });
        }

        public async Task UpdateComponentQuantity(int componentId, int quantidade) 
        {
            const string sql = @"
                UPDATE Componente
                SET Quantidade = @Quantidade
                WHERE Id = @ComponenteId";

            await this.db.SaveData(sql, new
            {
                ComponenteId = componentId,
                Quantidade = quantidade
            });
        }

        public Task DeleteComponent(int componentId) 
        {
            const string sql = "DELETE FROM Componente WHERE Id = @ComponenteId";
            return this.db.SaveData(sql, new { ComponenteId = componentId });
        }
    }
}

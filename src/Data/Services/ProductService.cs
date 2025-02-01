using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{
    public class ProductService : IProductService
    {
        private readonly ISqlDataAccess db;

        public ProductService(ISqlDataAccess db)
        {
            this.db = db;
        }

        public async Task<List<ProductModel>> GetProducts()
        {
            const string sql = @"
                SELECT pd.Id, pd.Nome, pd.Descricao, pd.Preco, pd.Imagem, pd.Titulo
                FROM ProdutoDisplay pd";

            return await this.db.LoadData<ProductModel, dynamic>(sql, new { });
        }

        public async Task<ProductModel> GetProduct(int productId)
        {
            const string sql = @"
                SELECT pd.Id, pd.Nome, pd.Descricao, pd.Preco, pd.Imagem, pd.Titulo
                FROM Produto p
                JOIN ProdutoDisplay pd ON p.Display_ID = pd.Id
                WHERE p.Id = @ProductId";
            
            var result = await db.LoadData<ProductModel, dynamic>(sql, new { ProductId = productId });
            return result.FirstOrDefault()!;
            
        }

        public async Task<ProductModel> GetProductByName(string productId)
        {
            const string sql = @"
                SELECT pd.Id, pd.Nome, pd.Descricao, pd.Preco, pd.Imagem, pd.Titulo
                FROM ProdutoDisplay pd
                WHERE pd.Nome = @ProductId";
            
            var result = await db.LoadData<ProductModel, dynamic>(sql, new { ProductId = productId });
            return result.FirstOrDefault()!;
        }

        public async Task<int> GetNProductsByEncomenda(int id)
        {
            const string sql = "SELECT COUNT(*) FROM Produto WHERE Encomenda_Id = @id";
            var result = await this.db.LoadData<int, dynamic>(sql, new { id = id });
            return result.FirstOrDefault();
        }

        public async Task<int> GetTotalSpentByEncomenda(int id)
        {
            const string sql = @"
                SELECT 
                    COALESCE(SUM(pd.Preco), 0) AS TotalSpent,
                    (SELECT TOP 1 pd.Nome 
                        FROM Produto p
                        JOIN ProdutoDisplay pd ON p.Display_ID = pd.Id
                        WHERE p.Encomenda_Id = @id 
                        GROUP BY pd.Nome 
                        ORDER BY COUNT(*) DESC) AS ProdutoFavorito
                FROM Produto p
                JOIN ProdutoDisplay pd ON p.Display_ID = pd.Id
                WHERE p.Encomenda_Id = @id";

            var result = await this.db.LoadData<int, dynamic>(sql, new { id = id });
            return result.FirstOrDefault();
        }

        public async Task<string> GetFavoriteProductByOrder(int encomendaId)
        {
            const string sql = @"
                SELECT TOP 1 pd.Nome AS ProdutoFavorito
                FROM Produto p
                JOIN ProdutoDisplay pd ON p.Display_ID = pd.Id
                WHERE p.Encomenda_Id = @EncomendaId
                GROUP BY pd.Nome
                ORDER BY COUNT(*) DESC";

            var result = await db.LoadData<string, dynamic>(sql, new { EncomendaId = encomendaId });
            return result.FirstOrDefault()!;
        }

        public async Task<int> CreateProduct(string nome, int encomendaId)
        {
            const string sqlFindDisplayId = @"
                SELECT Id FROM ProdutoDisplay 
                WHERE Nome = @Nome";

            var displayIdResult = await db.LoadData<int, dynamic>(sqlFindDisplayId, new { Nome = nome });
            int displayId = displayIdResult.FirstOrDefault();

            if (displayId == 0)
            {
                throw new Exception($"No ProdutoDisplay found with name: {nome}");
            }

            const string sqlInsertProduto = @"
                INSERT INTO Produto (Display_ID, Encomenda_ID)
                VALUES (@DisplayId, @Encomenda_Id);
                SELECT CAST(SCOPE_IDENTITY() as int);
            ";

            var result = await db.LoadData<int, dynamic>(sqlInsertProduto, new
            {
                DisplayId = displayId,
                Encomenda_Id = encomendaId
            });

            return result.FirstOrDefault();
        }

        public async Task<List<ProductModel>> GetProductsByOrderId(int orderId)
        {
            const string sql = @"
                SELECT p.Id, pd.Nome, pd.Descricao, pd.Preco, pd.Imagem, pd.Titulo
                FROM Produto p
                JOIN ProdutoDisplay pd ON p.Display_ID = pd.Id
                WHERE p.Encomenda_Id = @OrderId";

            return await db.LoadData<ProductModel, dynamic>(sql, new { OrderId = orderId });
        }

        public async Task UpdateProduct(int productId, string nome, string descricao, decimal preco, string imagem, string titulo)
        {
            const string sql = @"
                UPDATE ProdutoDisplay
                SET Nome = @Nome,
                    Descricao = @Descricao,
                    Preco = @Preco,
                    Imagem = @Imagem,
                    Titulo = @Titulo
                WHERE Id = @ProductId;
            ";

            await this.db.SaveData(sql, new
            {
                ProductId = productId,
                Nome = nome,
                Descricao = descricao,
                Preco = preco,
                Imagem = imagem,
                Titulo = titulo
            });
        }

        public async Task DeleteProduct(int productId)
        {
            const string sql = "DELETE FROM Produto WHERE Id = @ProductId";
            await this.db.SaveData(sql, new { ProductId = productId });
        }
    }
}

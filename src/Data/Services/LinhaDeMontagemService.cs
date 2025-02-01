using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{

    public class LinhaDeMontagemService : ILinhaDeMontagemService
    {

        private readonly ISqlDataAccess db;

        public LinhaDeMontagemService(ISqlDataAccess db)
        {
            this.db = db;
        }

        public Task<List<LinhaDeMontagemModel>> GetLinhasDeMontagem()
        {
            const string sql = "SELECT * FROM LinhaDeMontagem";
            return this.db.LoadData<LinhaDeMontagemModel, dynamic>(sql, new { });
        }

        public Task<LinhaDeMontagemModel?> GetLinhaDeMontagem(int linhaDeMontagemId)
        {
            const string sql = "SELECT * FROM LinhaDeMontagem WHERE Id = @LinhaDeMontagemId";
            return this.db.LoadData<LinhaDeMontagemModel, dynamic>(sql, new { LinhaDeMontagemId = linhaDeMontagemId })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public Task<LinhaDeMontagemModel?> GetLinhaDeMontagemByProduto(int produtoId)
        {
            const string sql = @"
                SELECT lp.Id, l.Nome, l.TempoEstimado, lp.TempoDeMontagem, lp.Percentagem_Conclusao
                FROM LinhaDeMontagem l
                JOIN Linha_Produto lp ON l.Id = lp.Linha_Id
                WHERE lp.Produto_Id = @ProdutoId";
            return this.db.LoadData<LinhaDeMontagemModel, dynamic>(sql, new { ProdutoId = produtoId })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public async Task UpdateLinhaDeMontagem(int linhaProdutoId, TimeSpan tempoDeMontagem, int percentagemConclusao, int estadoMontagemId)
        {
            const string sql = @"
                UPDATE Linha_Produto
                SET TempoDeMontagem = @TempoDeMontagem,
                    Percentagem_Conclusao = @PercentagemConclusao,
                    Estado_Montagem_Id = @EstadoMontagemId
                WHERE Id = @LinhaProdutoId;
            ";

            await this.db.SaveData(sql, new
            {
                LinhaProdutoId = linhaProdutoId,
                TempoDeMontagem = tempoDeMontagem,
                PercentagemConclusao = percentagemConclusao,
                EstadoMontagemId = estadoMontagemId
            });
        }

        public async Task CreateLinhaDeMontagem(int produtoId, int tamanhoComponentes)
        {
            const string sql = @"
                INSERT INTO Linha_Produto (TempoDeMontagem, Percentagem_Conclusao, Estado_Montagem_Id, Produto_Id, Linha_Id)
                VALUES (@TempoDeMontagem, 0, 1, @ProdutoId, @LinhaId);
            ";

            TimeSpan tempoDeMontagem = TimeSpan.Zero;

            int linhaId = (tamanhoComponentes == 3) ? 1 : 2;

            await this.db.SaveData(sql, new
            {
                TempoDeMontagem = tempoDeMontagem,
                ProdutoId = produtoId, 
                LinhaId = linhaId
            });
        }
    }
}
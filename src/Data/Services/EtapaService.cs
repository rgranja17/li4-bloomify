using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{

    public class EtapaService : IEtapaService
    {

        private readonly ISqlDataAccess db;

        public EtapaService(ISqlDataAccess db)
        {
            this.db = db;
        }

        public Task<EtapaModel?> GetEtapa(int etapaId)
        {
            const string sql = "SELECT * FROM Etapa WHERE Id = @EtapaId";
            return this.db.LoadData<EtapaModel, dynamic>(sql, new { EtapaId = etapaId })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public async Task<int?> GetNEtapasByLinhaDeMontagem(int idLinhaProduto)
        {
            const string sql = @"
                SELECT COUNT(*) 
                FROM Etapa AS e
                INNER JOIN LinhaDeMontagem AS l ON e.LinhaDeMontagem_ID = l.Id
                INNER JOIN Linha_Produto AS lp ON lp.Linha_Id = l.Id
                WHERE lp.Id = @LinhaProdutoId;
            ";

            var result = await this.db.LoadData<int, dynamic>(sql, new { LinhaProdutoId = idLinhaProduto });
            return result.FirstOrDefault();
        }

        public async Task<List<EtapaModel>> GetEtapasByLinhaDeMontagem(int linhaDeMontagemId)
        {
            const string sql = @"
                SELECT Linha_Id FROM Linha_Produto
                WHERE Id = @LinhaDeMontagemId
            ";
            var id = await this.db.LoadData<int, dynamic>(sql, new { LinhaDeMontagemId = linhaDeMontagemId });

            var Id = id.FirstOrDefault();
            const string sql2 = @"
                SELECT * FROM Etapa
                WHERE LinhaDeMontagem_ID = @Id
            ";

            return await this.db.LoadData<EtapaModel, dynamic>(sql2, new { Id = Id });
        }

        public async Task<int> CreateEtapa(int numeroEtapa, string descricao, string instrucao, string imagem, int linhaDeMontagemId, int estadoId)
        {
            const string sql = @"
                INSERT INTO Etapa (NumeroEtapa, Descricao, Instrucao, Imagem, LinhaDeMontagem_Id, Estado_ID)
                VALUES (@NumeroEtapa, @Descricao, @Instrucao, @Imagem, @LinhaDeMontagemId, @EstadoId);
                SELECT CAST(SCOPE_IDENTITY() as int);
            ";

            var etapaId = await db.LoadData<int, dynamic>(sql, new
            {
                NumeroEtapa = numeroEtapa,
                Descricao = descricao,
                Instrucao = instrucao,
                Imagem = imagem,
                LinhaDeMontagemId = linhaDeMontagemId,
                EstadoId = estadoId
            });

            return etapaId.FirstOrDefault();
        }

        public Task UpdateEtapa(int etapaId, string descricao, string instrucao, string imagem)
        {
            const string sql = @"
                UPDATE Etapa
                SET Descricao = @Descricao,
                    Instrucao = @Instrucao,
                    Imagem = @Imagem
                WHERE Id = @EtapaId
            ";

            return this.db.SaveData(sql, new
            {
                EtapaId = etapaId,
                Descricao = descricao,
                Instrucao = instrucao,
                Imagem = imagem
            });
        }

        public Task DeleteEtapa(int etapaId)
        {
            const string sql = "DELETE FROM Etapa WHERE Id = @EtapaId";
            return this.db.SaveData(sql, new { EtapaId = etapaId });
        }
    }
}

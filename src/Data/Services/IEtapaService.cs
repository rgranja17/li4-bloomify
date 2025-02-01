using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{

    public interface IEtapaService
    {

        Task<EtapaModel?> GetEtapa(int etapaId);

        Task<int?> GetNEtapasByLinhaDeMontagem(int idLinha);

        Task<List<EtapaModel>> GetEtapasByLinhaDeMontagem(int linhaDeMontagemId);

        Task<int> CreateEtapa(int numeroEtapa, string descricao, string instrucao, string imagem, int linhaDeMontagemId, int estadoId);

        Task UpdateEtapa(int etapaId, string descricao, string instrucao, string imagem);

        Task DeleteEtapa(int etapaId);
    }
}
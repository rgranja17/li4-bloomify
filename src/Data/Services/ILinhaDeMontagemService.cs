using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{

    public interface ILinhaDeMontagemService
    {
        Task<List<LinhaDeMontagemModel>> GetLinhasDeMontagem();

        Task<LinhaDeMontagemModel?> GetLinhaDeMontagem(int linhaDeMontagemId);

        Task<LinhaDeMontagemModel?> GetLinhaDeMontagemByProduto(int produtoId);

        Task UpdateLinhaDeMontagem(int linhaDeMontagemId, TimeSpan tempoDeMontagem, int percentagemConclusao, int estadoMontagemId);

        Task CreateLinhaDeMontagem(int produtoId,int tamanhoComponentes);
    }
}
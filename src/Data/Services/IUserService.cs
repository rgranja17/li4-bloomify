using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services {

    public interface IUserService {

        Task<UserModel?> GetUser(string email);

        Task<UserModel?> GetUserById(int Id);

        Task<int> GetFuncionarioUserId(int Id);

        Task<int> GetFuncionario(string email);

        Task<int> CreateUser(string nome, string email, string passwordHash, string telefone, Tipo tipo);

        Task CreateCliente(string nome, string email, string passwordHash, string telefone, Tipo tipo, string nif, DateOnly birthDate);

        Task<ClientModel?> GetCliente(int userId);

        Task<ClientModel?> GetClienteByNIF(string NIF);

    }
}

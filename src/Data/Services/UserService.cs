using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services {

	public class UserService : IUserService{

        private readonly ISqlDataAccess db;

        public UserService(ISqlDataAccess db) {
            this.db = db;
		}

        public Task<UserModel?> GetUserById(int Id) {
            const string sql = "SELECT * FROM Utilizador WHERE UserId = @Id";
            return this.db.LoadData<UserModel, dynamic>(sql, new { Id = Id })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public Task<UserModel?> GetUser(string email) {
            const string sql = "SELECT * FROM Utilizador WHERE Email = @Email";
            return this.db.LoadData<UserModel, dynamic>(sql, new { Email = email })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public async Task<int> GetFuncionarioUserId(int Id)
        {
            const string sql = @"
                SELECT UserId
                FROM Funcionario
                WHERE Id = @Id
            ";

            var result = await this.db.LoadData<int, dynamic>(sql, new { Id = Id });
            
            return result.FirstOrDefault();
        }

        public async Task<int> GetFuncionario(string email)
        {
            const string sql = @"
                SELECT f.Id
                FROM Utilizador AS u
                INNER JOIN Funcionario AS f ON u.UserId = f.UserId
                WHERE u.Email = @Email AND u.Tipo = 'Funcionario'
            ";

            var result = await this.db.LoadData<int, dynamic>(sql, new { Email = email });
            
            return result.FirstOrDefault();
        }

        public async Task<int> CreateUser(string nome, string email, string PasswordHash, string telefone, Tipo tipo) {
            const string sql = @"
                INSERT INTO Utilizador (Nome, Email, PasswordHash, Telefone, Tipo)
                VALUES (@Nome, @Email, @PasswordHash, @Telefone, @Tipo);
                SELECT CAST(SCOPE_IDENTITY() as int);
            ";

            var userId = await db.LoadData<int, dynamic>(sql, new {
                Nome = nome,
                Email = email,
                PasswordHash = PasswordHash,
                Telefone = telefone,
                Tipo = tipo.ToString()
            });

            return userId.FirstOrDefault();
        }

        public async Task CreateCliente(string nome, string email, string PasswordHash, string telefone, Tipo tipo, string nif, DateOnly birthDate) {
            int userId = await CreateUser(nome, email, PasswordHash, telefone, tipo);

            const string sql = @"
                INSERT INTO Cliente (UserId, NIF, BirthDate)
                VALUES (@UserId, @NIF, @BirthDate);
            ";

            await db.SaveData(sql, new {
                UserId = userId,
                NIF = nif,
                BirthDate = birthDate.ToString("yyyy-MM-dd")
            });
        }

        public Task<ClientModel?> GetCliente(int userId)
        {
            const string sql = "SELECT * FROM Cliente WHERE userId = @userId";
            return this.db.LoadData<ClientModel, dynamic>(sql, new { userId = userId })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public Task<ClientModel?> GetClienteByNIF(string NIF)
        {
            const string sql = "SELECT * FROM Cliente WHERE NIF = @NIF";
            return this.db.LoadData<ClientModel, dynamic>(sql, new { NIF = NIF })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }
    }
}
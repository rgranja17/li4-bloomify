using Dapper;
using Bloomify.Data.Utils;
using Microsoft.Data.SqlClient;

namespace Bloomify.Data
{
    public class SqlDataAccess : ISqlDataAccess
    {
        private readonly IConfiguration _config;

        public SqlDataAccess(IConfiguration config)
        {
            _config = config;
            SqlMapper.AddTypeHandler(new SqlDateOnlyTypeHandler());
        }

        public SqlConnection CreateConnection()
        {
            return new SqlConnection(_config.GetConnectionString("Default"));
        }

        public async Task<List<T>> LoadData<T, U>(string sql, U parameters)
        {
            using var connection = CreateConnection();
            await connection.OpenAsync();
            var data = await connection.QueryAsync<T>(sql, parameters);
            return data.ToList();
        }

        public async Task SaveData<T>(string sql, T parameters)
        {
            using var connection = CreateConnection();
            await connection.OpenAsync();
            await connection.ExecuteAsync(sql, parameters);
        }

        public async Task ExecuteTransaction<T>(Dictionary<string, T> queries)
        {
            using var connection = CreateConnection();
            await connection.OpenAsync();
            using var transaction = await connection.BeginTransactionAsync();

            try
            {
                foreach (var query in queries)
                {
                    await connection.ExecuteAsync(query.Key, query.Value, transaction);
                }

                await transaction.CommitAsync();
            }
            catch (Exception)
            {
                await transaction.RollbackAsync();
                throw;
            }
        }
    }
}

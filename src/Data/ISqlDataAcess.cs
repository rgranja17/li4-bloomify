﻿using Microsoft.Data.SqlClient;

namespace Bloomify.Data
{
    public interface ISqlDataAccess
    {
        //SqlConnection Connection { get; }

        Task<List<T>> LoadData<T, U>(string sql, U parameters);

        Task SaveData<T>(string sql, T parameters);

        Task ExecuteTransaction<T>(Dictionary<string, T> queries);
    }
}
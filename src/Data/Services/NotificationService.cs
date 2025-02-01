using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services {

	public class NotificationService : INotificationService{

        private readonly ISqlDataAccess db;

        public NotificationService(ISqlDataAccess db) {
            this.db = db;
		}
        public Task<List<NotificationModel>> GetNotifications()
        {
            const string sql = "SELECT * FROM Notificacao";
            return this.db.LoadData<NotificationModel, dynamic>(sql, new { });
        }

        public Task<NotificationModel?> GetNotification(int id)
        {
            const string sql = "SELECT * FROM Notificacao WHERE Id = @id";
            return this.db.LoadData<NotificationModel, dynamic>(sql, new { Id = id })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public async Task DeleteNotification(int id)
        {
            
            const string sql = "DELETE FROM Notificacao WHERE Id = @id";
            await this.db.SaveData(sql, new { Id = id });
        }

        public Task<List<NotificationModel>> GetUserNotifications(int userId)
        {
            const string sql = "SELECT * FROM Notificacao WHERE UserId = @userId";
            return this.db.LoadData<NotificationModel, dynamic>(sql, new { UserId = userId });
        }

        public async Task CreateNotificationForAdmin(NotificationModel notification)
        {
            const string sql = @"
                INSERT INTO Notificacao (Titulo, Descricao, UserId)
                VALUES (@Titulo, @Descricao, @UserId)";
            
            await this.db.SaveData(sql, new 
            {
                notification.Titulo,
                notification.Descricao,
                UserId = 1
            });
        }

        public async Task CreateNotification(NotificationModel notification, int Id)
        {
            const string sql = @"
                INSERT INTO Notificacao (Titulo, Descricao, UserId)
                VALUES (@Titulo, @Descricao, @UserId)";
            
            await this.db.SaveData(sql, new 
            {
                notification.Titulo,
                notification.Descricao,
                UserId = Id
            });
        }
    }
}

        /*public Task<List<FuncionarioModel>> GetFuncionarios();

        public Task<AdminModel?> GetAdmin(string email);

        public Task<List<ClientModel>> GetClients();

        public Task<ClientModel?> GetClient(string email);

    }
}*/
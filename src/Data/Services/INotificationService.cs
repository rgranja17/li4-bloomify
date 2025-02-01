using System;
using Bloomify.Data.Models;

namespace Bloomify.Data.Services {

    public interface INotificationService {
        Task<List<NotificationModel>> GetNotifications();

        Task<List<NotificationModel>> GetUserNotifications(int userId);

        Task<NotificationModel?> GetNotification(int id);

        Task DeleteNotification(int id);

        Task CreateNotificationForAdmin(NotificationModel notification);

        Task CreateNotification(NotificationModel notification, int Id);
    }
}

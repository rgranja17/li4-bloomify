namespace Bloomify.Data.Models {
    public class NotificationModel
    {
        public int Id { get; set; }
        public string Titulo { get; set; }
        public string Descricao { get; set; }
        public int UserId { get; set; }

        public NotificationModel() { 
            this.Id = 0;
            this.UserId = 0;
            this.Descricao = string.Empty;
            this.Titulo = string.Empty;
        }

        public NotificationModel(int id, int UserId, string Descricao, string Titulo)
        {
            this.Id = id;
            this.UserId = UserId;
            this.Descricao = Descricao;
            this.Titulo = Titulo;
        }

        public NotificationModel(NotificationModel other)
        {
            this.Id = other.Id;
            this.UserId = other.UserId;
            this.Descricao = other.Descricao;
            this.Titulo = other.Titulo;
        }

        public override string ToString() {
            return "Notification{" +
                    "Id=" + this.Id + ", " +
                    "UserId=" + this.UserId + ", " +
                    "Titulo='" + this.Titulo + "', " +
                    "Descricao='" + this.Descricao + "'}";
        }

        public override int GetHashCode()
        {
            throw new NotImplementedException();
        }
    }
}

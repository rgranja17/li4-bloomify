namespace Bloomify.Data.Models
{
    public class AdminModel : UserModel
    {
        public int Id { get; set; }

        public AdminModel() : base() {
            this.Id = 0;
        }
        public AdminModel(int userId, string nome, string email, string password, string telefone, Tipo role, int id)
            : base(userId, nome, email, password, telefone, role) {
            this.Id = id;
        }

        public AdminModel(AdminModel a) : base(a)
        {
            this.Id = a.Id;
        }

        public override string ToString()
        {
            return "Administrador{" +
                    "Id=" + this.Id + ", " +
                    base.ToString().Substring(5) +
                    "}";
        }

    }
}

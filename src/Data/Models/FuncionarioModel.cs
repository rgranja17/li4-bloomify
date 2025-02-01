namespace Bloomify.Data.Models
{
    public class FuncionarioModel : UserModel
    {
        public int Id { get; set; }

        public FuncionarioModel() : base()
        {
            this.Id = 0;
        }
        public FuncionarioModel(int userId, string nome, string email, string password, string telefone, Tipo role, int id)
            : base(userId, nome, email, password, telefone, role)
        {
            this.Id = id;
        }

        public FuncionarioModel(FuncionarioModel f) : base(f)
        {
            this.Id = f.Id;
        }

        public override string ToString()
        {
            return "Funcionario{" +
                    "Id=" + this.Id + ", " +
                    base.ToString().Substring(5) +
                    "}";
        }
    }
}
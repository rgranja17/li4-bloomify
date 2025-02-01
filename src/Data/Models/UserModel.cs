namespace Bloomify.Data.Models
{
    public enum Tipo
    {
        Cliente,
        Admin,
        Funcionario
    }

    public class UserModel
    {
        public int UserId { get; set; }
        public string Nome { get; set; }
        public string Email { get; set; }
        public string PasswordHash { get; set; }
        public string Telefone { get; set; }
        public Tipo Tipo { get; set; }
        public string TipoString => Tipo.ToString();


        // Construtor padrão com inicialização de propriedades
        public UserModel()
        {
            UserId = 0;
            Nome = string.Empty;
            Email = string.Empty;
            PasswordHash = string.Empty;
            Telefone = string.Empty;
            Tipo = Tipo.Cliente; // Definição de valor padrão
        }

        // Construtor parametrizado
        public UserModel(int userId, string nome, string email, string password, string telefone, Tipo role)
        {
            UserId = userId;
            Nome = nome;
            Email = email;
            PasswordHash = password;
            Telefone = telefone;
            Tipo = role;
        }

        // Construtor de cópia
        public UserModel(UserModel uM)
        {
            UserId = uM.UserId;
            Nome = uM.Nome;
            Email = uM.Email;
            PasswordHash = uM.PasswordHash;
            Telefone = uM.Telefone;
            Tipo = uM.Tipo;
        }

        // Método ToString corrigido com override
        public override string ToString()
        {
            return $"User{{userId='{UserId}', nome='{Nome}', email='{Email}', passwordHash='{PasswordHash}', telefone='{Telefone}', role='{Tipo}'}}";
        }
    }
}

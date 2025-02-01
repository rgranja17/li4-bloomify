namespace Bloomify.Data.Models {
    public class ClientModel : UserModel {

        public string NIF {  get; set; }   
        public DateOnly BirthDate { get; set; }

        public ClientModel() : base() {
            this.NIF = string.Empty;
            this.BirthDate = DateOnly.MinValue;
        }

        public ClientModel(int userId, string nome, string email, string password, string telefone, Tipo role, string nif, DateOnly birthDate)
            : base(userId, nome, email, password, telefone, role) {
            this.NIF = nif;
            this.BirthDate = birthDate;
        }

        public ClientModel(ClientModel c) : base(c) {
            this.NIF = c.NIF;
            this.BirthDate = c.BirthDate;
        }

        public override string ToString() {
            return "Client{" +
                    base.ToString().Substring(5) +
                    ", NIF='" + this.NIF + '\'' +
                    ", BirthDate='" + this.BirthDate.ToString("yyyy-MM-dd") + '\'' +
                    '}';
        }
    }
}

namespace Bloomify.Data.Models {
	public class ComponentModel {

		public int Id { get; set; }
		public string Nome { get; set; }
		public int Quantidade { get; set; }
		public string Cor { get; set; }

		public ComponentModel() {
			this.Id = 0;
            this.Nome = string.Empty;
			this.Quantidade = 0;
			this.Cor = string.Empty;
        }

        public ComponentModel(int id, string nome, int quantidade, string cor) {
            this.Id = id;
            this.Nome = nome;
            this.Quantidade = quantidade;
            this.Cor = cor;
        }

        public ComponentModel(ComponentModel cM) {
            this.Id = cM.Id;
            this.Nome = cM.Nome;
            this.Quantidade = cM.Quantidade;
            this.Cor = cM.Cor;
        }

        public override string ToString() {
            return $"Component{{Id='{this.Id}', Nome='{this.Nome}', Quantidade='{this.Quantidade}', Cor='{this.Cor}'}}";
        }
    }
}

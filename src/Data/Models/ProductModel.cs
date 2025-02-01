namespace Bloomify.Data.Models {
    public class ProductModel
    {
        public int Id { get; set; }
        public decimal Preco { get; set; }
        public string Descricao { get; set; }
        public string Nome { get; set; }

        public string Imagem { get; set; }
        public string Titulo { get; set; }
        public List<ComponentModel> Componentes { get; set; }

        public ProductModel() { 
            this.Id = 0;
            this.Preco = 0;
            this.Descricao = string.Empty;
            this.Nome = string.Empty;
            this.Imagem = string.Empty;
            this.Titulo = string.Empty;
            this.Componentes = new List<ComponentModel> ();
        }

        public ProductModel(int id, decimal Preco, string Descricao, string Nome, string Imagem, string titulo, List<ComponentModel> componentes)
        {
            this.Id = id;
            this.Preco = Preco;
            this.Descricao = Descricao;
            this.Nome = Nome;
            this.Imagem = Imagem;
            this.Titulo = titulo;
            this.Componentes = new List<ComponentModel>(componentes);
        }

        public ProductModel(ProductModel other)
        {
            this.Id = other.Id;
            this.Preco = other.Preco;
            this.Descricao = other.Descricao;
            this.Nome = other.Nome;
            this.Imagem = other.Imagem;
            this.Titulo = other.Titulo;
            this.Componentes = new List<ComponentModel>(other.Componentes);
        }

        public override string ToString() {
            return "Product{" +
                    "Id=" + this.Id + ", " +
                    "Preco=" + this.Preco.ToString("C") + ", " +
                    "Titulo=" + this.Titulo + ", " +
                    "Nome='" + this.Nome + "', " +
                    "Descricao='" + this.Descricao +
                    "Componentes='" + (this.Componentes != null ? this.Componentes.Count.ToString() : "0") + "'}";
        }
    }
}

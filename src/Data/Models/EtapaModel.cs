namespace Bloomify.Data.Models
{
    public class EtapaModel {
        public int Id { get; set; }
        public int NumeroEtapa { get; set; }
        public string Estado { get; set; }
        public string Instrucao { get; set; }
        public string Descricao { get; set; }
        public string Imagem { get; set; }

        public EtapaModel() {
            this.Id = 0;
            this.NumeroEtapa = 0;
            this.Estado = string.Empty;
            this.Instrucao = string.Empty;
            this.Descricao = string.Empty;
            this.Imagem = string.Empty;
        }

        public EtapaModel(int id, int NumeroEtapa, string estado, string instrucao, string descricao, string imagem) {
            this.Id = id;
            this.NumeroEtapa = NumeroEtapa;
            this.Estado = estado;
            this.Instrucao = instrucao;
            this.Descricao = descricao;
            this.Imagem = imagem;
        }

        public EtapaModel(EtapaModel other) {
            this.Id = other.Id;
            this.NumeroEtapa = other.NumeroEtapa;
            this.Estado = other.Estado;
            this.Instrucao = other.Instrucao;
            this.Descricao = other.Descricao;
            this.Imagem = other.Imagem;
        }

        public override string ToString() {
            return "Etapa{" +
                    "Id=" + this.Id + ", " +
                    "NumeroEtapa=" + this.NumeroEtapa + ", " +
                    "Estado='" + this.Estado + "', " +
                    "Instrucao='" + this.Instrucao + "', " +
                    "Descricao='" + this.Descricao + "}";
        }


    }
}

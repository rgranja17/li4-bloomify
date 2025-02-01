namespace Bloomify.Data.Models
{
    public class LinhaDeMontagemModel {
        public int Id { get; set; }

        public TimeSpan TempoDeMontagem { get; set; }
        
        public TimeSpan TempoEstimado { get; set; }

        public string? Nome { get; set; }

        public int Percentagem_Conclusao { get; set; }

        public List<EtapaModel> Etapas { get; set; }



        public LinhaDeMontagemModel() {
            this.Id = 0;
            this.TempoDeMontagem = TimeSpan.Zero;
            this.Percentagem_Conclusao = 0;
            this.Etapas = new List<EtapaModel>();
        }

        public LinhaDeMontagemModel(int id, TimeSpan tempoDeMontagem, int percentagemConclusao, List<EtapaModel> etapas) {
            this.Id = id;
            this.TempoDeMontagem = tempoDeMontagem;
            this.Percentagem_Conclusao = percentagemConclusao;
            this.Etapas = new List<EtapaModel>(etapas);
        }

        public LinhaDeMontagemModel(LinhaDeMontagemModel other) {
            this.Id = other.Id;
            this.TempoDeMontagem = other.TempoDeMontagem;
            this.Percentagem_Conclusao = other.Percentagem_Conclusao;
            this.Etapas = new List<EtapaModel>(other.Etapas);
        }

        public override string ToString() {
            return "LinhaDeMontagem{" +
                    "Id=" + this.Id + ", " +
                    "TempoDeMontagem=" + this.TempoDeMontagem.ToString() + ", " +
                    "PercentagemConclusao=" + this.Percentagem_Conclusao + "%, " +
                    "Etapas=" + (this.Etapas != null ? this.Etapas.Count.ToString() : "0") + " etapas}";
        }

    }
}
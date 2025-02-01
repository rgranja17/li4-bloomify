using System.Runtime.CompilerServices;

namespace Bloomify.Data.Models
{
    public class OrderModel
    {
        public int Id { get; set; }
        public DateOnly DataEntrega { get; set; }
        public string Rua { get; set; }
        public string CodigoPostal { get; set; }

        public int Porta { get; set; }

        public List<ProductModel> Products { get; set; }

        public string Estado { get; set; }
        
        public OrderModel() {
            this.Id = 0;
            this.DataEntrega = DateOnly.MinValue;
            this.Rua = string.Empty;
            this.CodigoPostal = string.Empty;
            this.Porta = 0;
            this.Products = new List<ProductModel>();
            this.Estado = string.Empty;
        }

        public OrderModel(int id, DateOnly dataEntrega, string rua, string codigoPostal, int porta,
            List<ProductModel> products, string estado) {
            this.Id = id;
            this.DataEntrega = dataEntrega;
            this.Rua = rua;
            this.CodigoPostal = codigoPostal;
            this.Porta = porta;
            this.Products = new List<ProductModel>(products);
            this.Estado = string.Empty;
        }

        public OrderModel(OrderModel oM)
        {
            this.Id = oM.Id;
            this.DataEntrega = oM.DataEntrega;
            this.Rua = oM.Rua;
            this.CodigoPostal = oM.CodigoPostal;
            this.Porta = oM.Porta;
            this.Products = new List<ProductModel>(oM.Products);
            this.Estado = oM.Estado;
        }

        public override string ToString()
        {
            return "Order{" +
                    "Id='" + this.Id + '\'' +
                    ", DataEntrega='" + this.DataEntrega.ToString("yyyy-MM-dd HH:mm:ss") + '\'' +
                    ", Rua='" + this.Rua + '\'' +
                    ", CodigoPostal='" + this.CodigoPostal + '\'' +
                    ", Porta=" + this.Porta +
                   ", Products=" + string.Join(", ", this.Products ?? new List<ProductModel>()) + // Concatena os produtos
                    ", Estado='" + this.Estado + '\'' +
                    '}';
        }
    }
}

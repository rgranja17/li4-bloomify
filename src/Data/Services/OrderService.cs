using Bloomify.Data.Models;

namespace Bloomify.Data.Services
{

    public class OrderService : IOrderService
    {

        private readonly ISqlDataAccess db;
        private readonly IProductService productService;

        public OrderService(ISqlDataAccess db, IProductService productService)
        {
            this.db = db;
            this.productService = productService;
        }

        public Task<List<OrderModel>> GetOrders()
        {
            const string sql = "SELECT * FROM Encomenda";
            return this.db.LoadData<OrderModel, dynamic>(sql, new { });
        }

        public Task<OrderModel?> GetOrder(int orderId)
        {
            const string sql = "SELECT * FROM Encomenda WHERE Id = @OrderId";
            return this.db.LoadData<OrderModel, dynamic>(sql, new { OrderId = orderId })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public Task<int?> GetOrderFuncionario(int orderId)
        {
            const string sql = "SELECT Funcionario_Id FROM Encomenda WHERE Id = @OrderId";
            return this.db.LoadData<int?, dynamic>(sql, new { OrderId = orderId })
                .ContinueWith(task => task.Result.FirstOrDefault());
        }

        public async Task<List<OrderModel>> GetOrdersByClient(string NIF)
        {
            const string sql = @"
            SELECT 
                e.Id, 
                e.Data_Entrega AS DataEntrega, 
                e.Rua, 
                e.CodigoPostal, 
                e.Porta, 
                se.Estado 
            FROM Encomenda e
            INNER JOIN EstadoEncomenda se ON e.Estado_Id = se.Id
            WHERE e.Cliente_Id = @ClienteId";

            var orders = await this.db.LoadData<OrderModel, dynamic>(sql, new { ClienteId = NIF });

            foreach (var order in orders)
            {
                order.Products = await productService.GetProductsByOrderId(order.Id); 
            }

            return orders;
        }

        public async Task<List<OrderModel>> GetOrdersByFuncionario(int funcionarioId)
        {
            const string sql = @"
            SELECT 
                e.Id, 
                e.Data_Entrega AS DataEntrega, 
                e.Rua, 
                e.CodigoPostal, 
                e.Porta, 
                se.Estado 
            FROM Encomenda e
            INNER JOIN EstadoEncomenda se ON e.Estado_Id = se.Id
            WHERE e.Funcionario_Id = @FuncionarioId";

            var orders = await this.db.LoadData<OrderModel, dynamic>(sql, new { FuncionarioId = funcionarioId });

            foreach (var order in orders)
            {
                order.Products = await productService.GetProductsByOrderId(order.Id); 
            }

            return orders;
        }

        public async Task<string?> GetEstadoEncomenda(int encomendaId)
        {
            const string sql = @"
                SELECT ee.Estado
                FROM EstadoEncomenda ee
                INNER JOIN Encomenda e ON e.Estado_Id = ee.Id
                WHERE e.Id = @EncomendaId";

            var estado = await db.LoadData<string, dynamic>(sql, new { EncomendaId = encomendaId });
            return estado.FirstOrDefault(); 
        }

        public async Task<List<OrderModel>> GetOrdersByEstado(string estado)
        {
            const string sql = @"
                SELECT 
                    e.Id, 
                    e.Data_Entrega AS DataEntrega, 
                    e.Rua, 
                    e.CodigoPostal, 
                    e.Porta, 
                    se.Estado 
                FROM Encomenda e
                INNER JOIN EstadoEncomenda se ON e.Estado_Id = se.Id
                WHERE se.Estado = @Estado";

            var orders = await this.db.LoadData<OrderModel, dynamic>(sql, new { Estado = estado });

            // Buscar os produtos associados a cada encomenda
            foreach (var order in orders)
            {
                order.Products = await productService.GetProductsByOrderId(order.Id);
            }

            return orders;
        }

        public async Task<List<LinhaDeMontagemModel>> GetLinhasDeMontagemByProductId(int productId)
        {
            const string sql = @"
            SELECT 
                l.Percentagem_Conclusao 
            FROM Linha_Produto l
            WHERE l.Produto_Id = @ProductId";
    
            return await this.db.LoadData<LinhaDeMontagemModel, dynamic>(sql, new { ProductId = productId });
        }

        public async Task<int> CreateOrder(string rua, string codigoPostal, int porta, string NIF)
        {
            // First, get a random employee
            const string sqlFuncionario = @"
                SELECT TOP 1 Id FROM Funcionario ORDER BY NEWID()";

            var funcionarioId = await db.LoadData<int, dynamic>(sqlFuncionario, new { });

            if (!funcionarioId.Any())
            {
                throw new Exception("No employees available for order assignment.");
            }

            // Calculate the delivery date (1 month from now)
            var dataEntregaPrevista = DateOnly.FromDateTime(DateTime.Now.AddMonths(1));

            // Create the order
            const string sqlEncomenda = @"
                INSERT INTO Encomenda 
                (Data_Entrega, Rua, CodigoPostal, Porta, Cliente_Id, Estado_Id, Funcionario_Id)
                VALUES 
                (@DataEntrega, @Rua, @CodigoPostal, @Porta, @ClientNIF, 1, @FuncionarioId);
                SELECT CAST(SCOPE_IDENTITY() as int)";

            var orderId = await db.LoadData<int, dynamic>(sqlEncomenda, new
            {
                DataEntrega = dataEntregaPrevista,
                Rua = rua,
                CodigoPostal = codigoPostal,
                Porta = porta,
                ClientNIF = NIF,
                FuncionarioId = funcionarioId.First()
            });

            return orderId.FirstOrDefault();
        }



        public Task UpdateOrder(int orderId, DateOnly deliveryDate, string rua, string codigoPostal, int porta, int estadoId)
        {
            const string sql = @"
                UPDATE Encomenda
                SET Data_Entrega = @DeliveryDate,
                    Rua = @Rua,
                    CodigoPostal = @CodigoPostal,
                    Porta = @Porta,
                    Estado_Id = @EstadoId
                WHERE Id = @OrderId;
            ";

            return this.db.SaveData(sql, new
            {
                OrderId = orderId,
                DeliveryDate = deliveryDate,
                Rua = rua,
                CodigoPostal = codigoPostal,
                Porta = porta,
                EstadoId = estadoId
            });
        }

        public Task UpdateOrderState(int orderId, int estadoId)
        {
            const string sql = @"
                UPDATE Encomenda
                SET Estado_Id = @EstadoId
                WHERE Id = @OrderId;
            ";

            return this.db.SaveData(sql, new
            {
                OrderId = orderId,
                EstadoId = estadoId
            });
        }

        public Task DeleteOrder(int orderId)
        {
            const string sql = "DELETE FROM Encomenda WHERE Id = @OrderId";
            return this.db.SaveData(sql, new { OrderId = orderId });
        }
    }
}
USE Bloomify;
GO

-- Inserir Utilizadores
INSERT INTO Utilizador (Nome, Email, PasswordHash, Telefone, Tipo)
VALUES 
    ('Carlos Silva', 'carlos.silva@exemplo.com', '$2a$12$/Q9jYtEHLVMMJ/IPgCQ4a.LJFY9VeoTB9e7R.WIhznRHL74nPh1JS', '912345678', 'Admin'), -- pass: senha1
    ('Maria Santos', 'maria.santos@exemplo.com', '$2a$12$on2jBBCxOrTAlbsXeOS/JucmU4HNz9Ybb38/GNzoaCbYIefCEAfiG', '923456789', 'Cliente'), -- pass: senha2
    ('João Costa', 'joao.costa@exemplo.com', '$2a$12$iy6yOHkef3QhTmWkloU9tOPBzIH3kwyYyi9ZMfIW8/oFjwQI4ZEfm', '934567890', 'Funcionario'); -- pass: senha3

DECLARE @AdminId INT, @ClienteId INT, @FuncionarioId INT;

SELECT @AdminId = UserId FROM Utilizador WHERE Tipo = 'Admin';
SELECT @ClienteId = UserId FROM Utilizador WHERE Tipo = 'Cliente';
SELECT @FuncionarioId = UserId FROM Utilizador WHERE Tipo = 'Funcionario';

-- Inserir Administrador
INSERT INTO Administrador (UserId) VALUES (@AdminId);

-- Inserir Cliente
INSERT INTO Cliente (NIF, BirthDate, UserId) 
VALUES ('123456789', '1990-05-15', @ClienteId);

-- Inserir Funcionário
INSERT INTO Funcionario (UserId) VALUES (@FuncionarioId);

-- Inserir Estados de Encomenda
INSERT INTO EstadoEncomenda (Id, Estado)
VALUES 
    (1, 'Pendente'),
    (2, 'Concluída');

-- Inserir Estados de Montagem
INSERT INTO EstadoMontagem (Id, Estado)
VALUES 
    (1, 'Não Iniciada'),
    (2, 'Em Progresso'),
    (3, 'Concluída');

-- Inserir Encomendas
INSERT INTO Encomenda (Data_Entrega, Rua, CodigoPostal, Porta, Cliente_Id, Estado_Id, Funcionario_Id)
VALUES 
    ('2025-01-30', 'Rua das Flores', '1234-567', 10, '123456789', 1, 1),
    ('2025-02-10', 'Avenida Central', '2345-678', 20, '123456789', 2, 1);

-- Inserir Produtos
INSERT INTO ProdutoDisplay (Nome, Titulo, Descricao, Preco, Imagem)
VALUES 
    ('Vaso Standard','Simplicidade e funcionalidade para o dia a dia', 'Mantenha as suas plantas sempre hidratadas com estilo e praticidade. O vaso autoirrigável Standard é a escolha ideal para quem deseja cuidar das suas plantas de forma descomplicada, assegurando o equilíbrio de água para um crescimento.', 15, 'assets/vasoPaginaInicial.png'),
    ('Vaso Deluxe','Elegância e tecnologia para os amantes de plantas', 'Eleve o cuidado das suas plantas com o vaso autoirrigável Deluxe. Com um acabamento de qualidade superior e um sistema ainda mais inteligente, combina design elegante com inovação, transformando qualquer espaço num oásis verde.', 50, 'assets/vasoDeluxe.png');

INSERT INTO Produto (Display_ID)
VALUES 
    (1),
    (2);

-- Associar Produtos às Encomendas
UPDATE Produto
SET Encomenda_ID = 1
WHERE Display_ID = 1;

UPDATE Produto
SET Encomenda_ID = 2
WHERE Display_ID = 2;

-- Inserir Componentes para os Produtos
INSERT INTO Componente (Id, Nome, Quantidade, Cor)
VALUES 
    (1, 'Fio de algodão', 20, 'Branco'),
    (2, 'Tanque de Água', 20, 'Transparente'),
    (3, 'Vaso Médio', 20, 'Branco'),
    (4, 'Recetor Bluetooth', 20, 'Preto'),
    (5, 'Tubo PVC', 20, 'Branco'),
    (6, 'Tanque de Água XL', 20, 'Transparente'),
    (7, 'Vaso Grande', 20, 'Cinza'),
    (8, 'Bomba Peq Pressão', 20, 'Vermelho');

INSERT INTO Componente_Produto (Componente_Id, Produto_Id, Quantidade)
VALUES 
    (1, 1, 8),  -- Fio de algodão para Vaso Standard
    (2, 1, 1),  -- Tanque de Água para Vaso Standard
    (3, 1, 1),  -- Vaso Médio para Vaso Standard
    (4, 2, 1),  -- Recetor Bluetooth para Vaso Deluxe
    (5, 2, 2),  -- Tubo PVC para Vaso Deluxe
    (6, 2, 1),  -- Tanque de Água XL para Vaso Deluxe
    (7, 2, 1),  -- Vaso Grande para Vaso Deluxe
    (8, 2, 1);

-- Inserir Linhas de Montagem
INSERT INTO LinhaDeMontagem (TempoEstimado, Nome)
VALUES 
    ('01:15:00', 'Montagem de Vaso Standard'),
    ('02:00:00', 'Montagem de Vaso Deluxe');

-- Insert Linha_Produto
INSERT INTO Linha_Produto (TempoDeMontagem, Percentagem_Conclusao, Produto_Id, Estado_Montagem_Id, Linha_Id)
VALUES 
    ('00:45:00', 50, 1, 2, 1),
    ('01:30:00', 25, 2, 2, 2);

-- Inserir Etapas para Linha de Montagem do Vaso Standard
INSERT INTO Etapa (Id, NumeroEtapa, Instrucao, Descricao, Imagem, LinhaDeMontagem_ID)
VALUES 
    (1, 1, 'Colocar os fios de algodão nos furos', 'Insira os fios de algodão nos furos do vaso com cuidado, garantindo que fiquem bem ajustados. Isto permitirá uma absorção eficiente da água para as plantas.', 'assets/linhas/standard/1.png', 1),
    (2, 2, 'Encaixar o tanque de água no vaso', 'Posicione o tanque de água na base do vaso e pressione suavemente até que esteja bem encaixado. Certifique-se de que não existam folgas.', 'assets/linhas/standard/2.png', 1),
    (3, 3, 'Encher o tanque de água até à medida', 'Adicione água ao tanque até atingir o limite indicado. Evite ultrapassar a marca para evitar derrames.', 'assets/linhas/standard/3.png', 1),
    (4, 4, 'Colocar solo e semente', 'Preencha o vaso com terra até cobrir completamente os fios de algodão. Coloque a semente escolhida e termine com uma leve camada de terra.', 'assets/linhas/standard/4.png', 1);

-- Inserir Etapas para Linha de Montagem do Vaso Deluxe
INSERT INTO Etapa (Id, NumeroEtapa, Instrucao, Descricao, Imagem, LinhaDeMontagem_ID)
VALUES 
    (5, 1, 'Preparação e Instalação do Tanque XL', 'Certifique-se de que o Tanque de Água XL está limpo e livre de obstruções. Encaixe-o na estrutura de suporte e assegure-se de que está bem fixo.', 'assets/linhas/deluxe/1.png', 2),
    (6, 2, 'Montagem dos Tubos de PVC e Bomba', 'Conecte os tubos de PVC à bomba, através das entradas. Garanta que as ligações estão bem seladas para evitar fugas de água.', 'assets/linhas/deluxe/2.png', 2),
    (7, 3, 'Posicionamento do Vaso', 'Coloque o vaso no local designado e conecte-o ao sistema de irrigação. Verifique se as ligações dos tubos estão seguras e alinhadas corretamente.', 'assets/linhas/deluxe/3.png', 2),
    (8, 4, 'Instalação do Recetor Bluetooth', 'Instale o recetor Bluetooth no local indicado e configure-o conforme o manual. Realize um teste inicial para garantir que está a funcionar corretamente.', 'assets/linhas/deluxe/4.png', 2),
    (9, 5, 'Verificação Final', 'Reveja todas as conexões e componentes instalados. Preencha o vaso com terra e coloque a semente escolhida e termine com uma leve camada de terra.', 'assets/linhas/deluxe/5.png', 2);

-- Inserir um novo Cliente
INSERT INTO Utilizador (Nome, Email, PasswordHash, Telefone, Tipo)
VALUES ('Ana Pereira', 'ana.pereira@exemplo.com', '$2a$12$d0P8Qkvadz2K//eaAG2.0eMTgxTwT9.XZNKcdMqGHqX79gXAbxcUy', '945678901', 'Cliente'); -- pass: senha4

DECLARE @NewClientId INT;
SELECT @NewClientId = UserId FROM Utilizador WHERE Email = 'ana.pereira@exemplo.com';

INSERT INTO Cliente (NIF, BirthDate, UserId)
VALUES ('987654321', '1985-03-25', @NewClientId);

-- Inserir uma nova encomenda para o novo Cliente
INSERT INTO Encomenda (Data_Entrega, Rua, CodigoPostal, Porta, Cliente_Id, Estado_Id, Funcionario_Id)
VALUES ('2025-03-01', 'Rua Nova', '5432-123', 15, '987654321', 1, 1);

-- Inserir Notificações para Utilizadores
INSERT INTO Notificacao (Titulo, Descricao, UserId)
VALUES 
    ('Bem-vindo!', 'A tua conta foi criada com sucesso.', @ClienteId),
    ('Nova Encomenda', 'A sua encomenda foi recebida.', @ClienteId),
    ('Nova Tarefa', 'Você tem uma nova encomenda para preparar.', @FuncionarioId);


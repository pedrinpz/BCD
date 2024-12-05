-- Criar tabela Cliente
CREATE TABLE Cliente (
	ClienteID INT PRIMARY KEY
AUTO_INCREMENT,
	Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Telefone VARCHAR(15)
);

-- Criar tabela Produto
CREATE TABLE Produto (
	ProdutoID INT PRIMARY KEY
AUTO_INCREMENT,
	NomeProduto VARCHAR(100) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL
);

-- Criar tabela Pedido
CREATE TABLE Pedido (
	PedidoID INT PRIMARY KEY 
AUTO_INCREMENT,
	Data DATE NOT NULL,
    ClienteID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES
Cliente(ClienteID),
	FOREIGN KEY (ProdutoID) REFERENCES
Produto(ProdutoID)
);

-- Inserir dados na tabela Cliente
INSERT INTO Cliente (Nome, Email, Telefone) VALUES
('João Silva', 'joao@email.com', '123456789'),
('Maria Oliveira', 'maria@email.com', '987654321'),
('Carlos Santos', 'carlos@email.com', ''),
('Ana Costa', 'ana@email.com', '333444555'),
('Pedro Lima', 'pedro@email.com', '666777888'),
('Carla Souza', 'carla@email.com', ''),
('Lucas Almeida', 'lucas@email.com', '999888777'),
('Mariana Duarte', 'mariana@email.com', ''),
('Rafael Pereira', 'rafael@email.com', ''),
('Fernanda Gonçalves', 'fernanda@email.com', '');

-- Inserir dados na tabela Produto
INSERT INTO Produto (NomeProduto, Preço) VALUES
('Produto A', 10.50),
('Produto B', 20.00),
('Produto C', 15.75),
('Produto D', 12.30),
('Produto E', 8.90),
('Produto F', 25.00),
('Produto G', 18.40),
('Produto H', 5.50),
('Produto I', 30.00),
('Produto J', 22.80);

-- Inserir dados na tabela Pedido
INSERT INTO Pedido (Data, ClienteID, ProdutoID, Quantidade) VALUES
('2024-01-01', 1, 1, 2),
('2024-01-02', 2, 2, 1),
('2024-01-03', 3, 3, 3),
('2024-01-04', 4, 4, 4),
('2024-01-05', 5, 5, 1),
('2024-01-06', 6, 6, 2),
('2024-01-07', 7, 7, 3),
('2024-01-08', 8, 8, 1),
('2024-01-09', 9, 9, 2),
('2024-01-10', 10, 10, 1);

-- Adicionar uma coluna na tabela Cliente
ALTER TABLE Cliente ADD DataCadastro DATE DEFAULT CURRENT_DATE;

-- Alterar o telefone de um cliente
UPDATE Cliente SET Telefone = '555666777' WHERE ClienteID = 3;

-- Exibir pedidos com informações do cliente e produto
SELECT 
    Pedido.PedidoID, 
    Cliente.Nome AS NomeCliente, 
    Produto.NomeProduto, 
    Pedido.Quantidade, 
    Produto.Preço, 
    (Pedido.Quantidade * Produto.Preço) AS ValorTotal
FROM 
    Pedido
JOIN Cliente ON Pedido.ClienteID = Cliente.ClienteID
JOIN Produto ON Pedido.ProdutoID = Produto.ProdutoID;

-- Criar uma View que exibe o resumo dos pedidos por cliente
CREATE VIEW ResumoPedidos AS
SELECT 
    Cliente.Nome AS NomeCliente,
    COUNT(Pedido.PedidoID) AS TotalPedidos,
    SUM(Pedido.Quantidade * Produto.Preço) AS ValorTotal
FROM 
    Pedido
JOIN Cliente ON Pedido.ClienteID = Cliente.ClienteID
JOIN Produto ON Pedido.ProdutoID = Produto.ProdutoID
GROUP BY 
    Cliente.Nome;
CREATE SCHEMA LOJAROUPAS;
USE LOJAROUPAS;

-- Tabela de Clientes
CREATE TABLE Clientes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Telefone VARCHAR(20),
    Endereco VARCHAR(255) NOT NULL
);

-- Tabela de Produtos
CREATE TABLE Produtos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10,2) NOT NULL,
    Estoque INT NOT NULL,
    Categoria VARCHAR(50) NOT NULL
);

-- Tabela de Pedidos
CREATE TABLE Pedidos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT NOT NULL,
    DataPedido DATE NOT NULL,
    Status ENUM('Em andamento', 'Concluído', 'Cancelado') NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);

-- Tabela de Itens do Pedido (resolvendo N:N entre Pedidos e Produtos)
CREATE TABLE ItensPedido (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(ID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ID)
);

-- Tabela de Pagamentos
CREATE TABLE Pagamentos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT NOT NULL,
    Tipo ENUM('Cartão', 'Boleto', 'Pix', 'Dinheiro') NOT NULL,
    Status ENUM('Pago', 'Pendente', 'Cancelado') NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(ID)
);

-- Inserindo dados nas tabelas
INSERT INTO Clientes (Nome, Email, Telefone, Endereco) VALUES
('Carlos Lima', 'carlos@email.com', '11987654321', 'Rua A, 123 - SP'),
('Ana Pereira', 'ana@email.com', '21987654321', 'Av. B, 456 - RJ'),
('Pedro Santos', 'pedro@email.com', '31987654321', 'Rua C, 789 - MG');

INSERT INTO Produtos (Nome, Descricao, Preco, Estoque, Categoria) VALUES
('Camiseta Branca', 'Camiseta básica de algodão', 49.90, 100, 'Camisetas'),
('Calça Jeans', 'Calça jeans slim', 129.90, 50, 'Calças'),
('Tênis Esportivo', 'Tênis leve para corrida', 199.90, 30, 'Calçados');

INSERT INTO Pedidos (ClienteID, DataPedido, Status, Total) VALUES
(1, '2024-02-10', 'Concluído', 179.80),
(2, '2024-02-12', 'Em andamento', 129.90);

INSERT INTO ItensPedido (PedidoID, ProdutoID, Quantidade, Subtotal) VALUES
(1, 1, 2, 99.80),
(1, 2, 1, 129.90);

INSERT INTO Pagamentos (PedidoID, Tipo, Status, Valor) VALUES
(1, 'Cartão', 'Pago', 179.80),
(2, 'Pix', 'Pendente', 129.90);

-- Consultas 
SELECT COUNT(*) AS TotalClientes FROM Clientes;
SELECT COUNT(*) AS TotalProdutos FROM Produtos;
SELECT COUNT(*) AS TotalPedidos FROM Pedidos;
SELECT COUNT(*) AS PedidosConcluidos FROM Pedidos WHERE Status = 'Concluído';
SELECT Categoria, COUNT(*) AS TotalProdutos FROM Produtos GROUP BY Categoria;
SELECT Status, COUNT(*) AS TotalPagamentos FROM Pagamentos GROUP BY Status;

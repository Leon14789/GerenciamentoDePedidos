CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(255),
    TotalPedidos INT
);

CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    descricao_pedido VARCHAR(255),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

INSERT INTO Clientes (id_cliente, nome, TotalPedidos) VALUES
    (1, 'Dona Maria 1', 0),
    (2, 'JosiCleide', 0),
    (3, 'Sonic 3', 0),
    (4, 'Valdiner 4', 0),
    (5, 'Cleitinho 5', 0);
    
    DELIMITER //

CREATE PROCEDURE InserirPedido(
    IN cliente_id INT,
    IN descricao_pedido VARCHAR(255)
)
BEGIN
    INSERT INTO Pedidos (id_cliente, descricao_pedido)
    VALUES (cliente_id, descricao_pedido);
    -- Atualizar o TotalPedidos do cliente
    UPDATE Clientes
    SET TotalPedidos = TotalPedidos + 1
    WHERE id_cliente = cliente_id;
END;
//

DELIMITER ;

CALL InserirPedido(1, 'Pedido Dona Maria nem sabe');

CREATE VIEW PedidosClientes AS
SELECT c.id_cliente, c.nome, p.id_pedido, p.descricao_pedido
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente;


SELECT pc.id_cliente, pc.nome, pc.id_pedido, pc.descricao_pedido, c.TotalPedidos
FROM PedidosClientes pc
JOIN Clientes c ON pc.id_cliente = c.id_cliente;


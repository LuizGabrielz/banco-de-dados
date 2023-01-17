create table cliente (
id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
nome VARCHAR (45) NOT NULL,
telefone VARCHAR (45) NOT NULL,
email VARCHAR (45) NOT NULL,
);
 
 create table vendedor (
 id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
 nome VARCHAR (45) NOT NUL
 );

  create table pagamento (
 id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
 forma_pagamento VARCHAR (45) NOT NULL
 ); 

create table venda (
id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
valor_total DECIMAL NOT NULL (10,2),
data DATETIME NOT NULL,
id_cliente INT NOT NULL,
id_vendedor INT NOT NULL,
id_pagamento INT NOT NULL,
CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
CONSTRAINT fk_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor),
CONSTRAINT fk_pagamento FOREIGN KEY (id_pagamento) REFERENCES pagamento (id_pagamento)
); 

create table fornecedores (
id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
cnpj BIGINT NOT NULL,
nome VARCHAR (45) NOT NULL
); 

create table categoria (
id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
nome VARCHAR (45)
);

create table produto (
id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
nome VARCHAR (45) NOT NULL,
preco DECIMAL (10,2) NOT NULL,
qtd_estoque VARCHAR (45) NOT NULL,
id_categoria INT,
id_fornecedores INT,
CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria),
CONSTRAINT fk_fornecedores FOREIGN KEY (id_fornecedores) REFERENCES fornecedores (id_fornecedores)
);

create table venda_produto (
id_venda INT,
id_produto INT,
CONSTRAINT fk_venda FOREIGN KEY (id_venda) REFERENCES venda (id_venda),
CONSTRAINT fk_produto FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
); 



INSERT INTO cliente (id,nome, telefone, email) OVERRIDING SYSTEM VALUE 
VALUES
('Gabriel', 988595286,'luizgabrielz@gmail.com'),
('Mariza', 98562128, 'marizapinheirop@gmail.com'),
('Rafael', 91234567, 'rafaelmacedo@gmail.com'),
('Ianko', 998634512, 'iankosmn@gmail.com'),
('Jorge', 988741320, 'jorgeneto@gmail.com')

INSERT INTO vendedor (id, nome) OVERRIDING SYSTEM VALUE 
VALUES
('Ricardo'),
('Gustavo'),
('Thomaz'),
('Andreza'),
('Lucas')

INSERT INTO pagamento (id, forma_pagamento) OVERRIDING SYSTEM VALUE 
VALUES
('Pix'),
('Cheque'),
('Crédito'),
('Débito'),
('Dinheiro')  

INSERT INTO venda (id, valor_total, data, cliente_id, vendedor_id, pagamento_id) OVERRIDING SYSTEM VALUE 
VALUES
(100,00, '2022-05-94'),
(200,00, '2022-01-17'),
(300,00,'2023-02-15'),
(200,00,'2019-06-19'),
(100,00,'2023-09-15')

INSERT INTO fornecedores (id, cnpj, nome) OVERRIDING SYSTEM VALUE 
VALUES
(1, 14589623578954, 'Calvin Klein'),
(2, 52698741235698, 'Nova Era'),
(3, 89657412365874, 'Adidas'),
(4, 23698741254589, 'Nike'),
(5, 036987456214587, 'Pulma') 

INSERT INTO categoria (id, nome) OVERRIDING SYSTEM VALUE 
VALUES
('Tenis'),
('Camisa'),
('Boné'),
('Cueca'),
('Pulseira')

INSERT INTO produto (id, nome, preco, qtd_estoque, categoria_id, fornecedores_id) OVERRIDING SYSTEM VALUE 
VALUES
(1, 'camisa', 30, 10, 4, 5 ),
(2, 'tenis', 60, 20, 2, 3),
(3, 'boné', 20, 5, 1, 3),
(4, 'Cueca', 10, 5,2,1),
(5, 'Pulseira', 5, 5, 4)

INSERT INTO venda_produto(venda_id, produto_id) OVERRIDING SYSTEM VALUE 
VALUES
(1,5),
(2,4), 
(3,3),
(4,2),
(5,1) 

UPTADE produto SET qtd_estoque = (qtd_estoque + 100)

ALTER TABLE cliente
RENAME COLUMN telefone TO contato;

select C.nome, v.valor_total, forma_pagamento from venda AS v 
inner Join cliente AS c ON v.cliente_id = c.id
inner join pagamento AS p ON v.pagamento_id = p.id

select v.*
from venda AS v
inner join venda_produto AS vp ON v.id = vp.venda_id
inner join produto AS p ON vp.produto_id = p.id
where v.id = 2

select nome from produto where preco IN (select max(preco) from produto)
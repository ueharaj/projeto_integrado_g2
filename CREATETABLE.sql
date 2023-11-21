DROP TABLE IF EXISTS cliente CASCADE;
CREATE TABLE cliente (
	cod_cliente	SERIAL PRIMARY KEY,
	Nome_cliente VARCHAR(50) NOT NULL,
	cpf_cliente NUMERIC(11) NOT NULL,
	data_nasci_cliente DATE NOT NULL,
	end_cliente VARCHAR(80),
	email_cliente VARCHAR(50),
	telefone_cliente NUMERIC(13),
	sexo_cliente CHAR(1) CHECK (sexo_cliente IN ('M','F')),
	cep	INTEGER,
	uf CHAR(2),
	cidade VARCHAR(30),
	bairro VARCHAR(30)
	);
SELECT * FROM cliente;

INSERT INTO cliente VALUES 
	(DEFAULT, 'MARIA SILVA', '23567483921', '15/07/1985', 'Avenida Principal, 123', 'maria.silva@gmail.com', '21987654321', 'F', 11500020, 'SP', 'Cubatão', NULL),
	(DEFAULT, 'JOÃO OLIVEIRA', '98765432123', '05/03/1990', 'Rua da Amizade, 456', 'joao.oliveira@gmail.com', '11998761234', 'M', 52011260, 'PE', 'Recife', 'Graças'),
	(DEFAULT, 'ANA SOUZA', '45671234567', '10/11/1978', 'Rua das Flores, 789', 'ana.souza@gmail.com', '21976543218', 'F', 09842070, 'SP', 'São Bernardo do Campo', 'Batistini'),
	(DEFAULT, 'ANDRÉ SANTOS', '76543210987', '20/05/1995', 'Rua das Árvores, 321', 'andre.santos@gmail.com', '21901234567', 'M', 07084070, 'SP', 'Guarulhos', 'Cabuçu'),
	(DEFAULT, 'LUCIA RIBEIRO', '54321678901', '08/11/1980', 'Avenida Central, 567', 'lucia.ribeiro@gmail.com', '11987654321', 'F', 06711205, 'SP', 'Cotia', 'Jardim da Glória'),
	(DEFAULT, 'CARLOS PEREIRA', '98765432198', '12/04/1975', 'Rua do Comércio, 987', 'carlos.pereira@gmail.com', '21987654321', 'M', 09400200, 'SP', 'Ribeirão Pires', 'Núcleo Colonial'),
	(DEFAULT, 'ANA PAULA FERREIRA', '23456789012', '14/02/1991', 'Avenida do Sol, 741', 'ana.paula@gmail.com', '11987654321', 'F', 09951465, 'SP', 'Diadema', 'Piraporinha'),
	(DEFAULT, 'MARCOS SILVEIRA', '76543210901', '07/09/1988', 'Rua da Praia, 543', 'marcos.silveira@gmail.com', '21987654321', 'M', 11680000, 'SP', 'Ubatuba', 'Maranduba'),
	(DEFAULT, 'SILVIA MELO', '54321678109', '03/06/1977', 'Avenida da Esperança, 654', 'silvia.melo@gmail.com', '11987654321', 'F', 13308030, 'SP', 'Itu', 'Cidade Nova'),
	(DEFAULT, 'FELIPE OLIVEIRA', '98765432176', '25/12/1993', 'Rua das Estrelas, 879', 'felipe.oliveira@gmail.com', '21987654321', 'M', 8330400, 'SP', 'São Paulo', 'São Mateus');
	
insert into cliente values
	(DEFAULT, 'Frederico Vasquez', 14725896888, '1989-04-18', 'Rua Capicharã, 475', 'fred.vasquez@fred.vasquez.com', 11918273645, 'M', 4281110, 'SP', 'São Paulo', 'Vila Nair'),
	(DEFAULT, 'Cezar Adriano Matos', 12349870892, '08/03/1987', 'Rua Santa Áurea, 39', 'cezarmatos@gmail.com', 11947483031, 'M', 4282040, 'SP', 'São Paulo', 'Ipiranga'),
	(DEFAULT, 'Mariana Nogueira', 32345850842, '14/06/1991', 'Rua Cunha Gago, 176, Apto 82', 'mariananog@uol.com.br', 11981829002, 'F', 5421000, 'SP', 'São Paulo', 'Pinheiros'),
	(DEFAULT, 'Simone Oliveira Santos', 27691390816, '18/10/1990', 'Rua Maria Fegueiredo, 283, Apto 315', 'simonesantos@terra.com.br', 11991238765, 'F', 4002901, 'SP', 'São Paulo', 'Vila Mariana'),
	(DEFAULT, 'Moacir Cardoso Tavares', 12932635812, '28/01/1989', 'Avenida Nossa Senhora do Sabará, 1015, Apto 201', 'moacirtavres@gmail.com', 11987861334, 'M', 4688000, 'SP', 'São Paulo', 'Campo Grande'),
	(DEFAULT, 'Jaqueline Rocha', 21313267890, '16/09/1987', 'Rua Dr. Augusto Toledo, 1091', 'jaquerocha@gmail.com', 11953565458, 'F', 9540080, 'SP', 'São Caetano do Sul', 'Santa Paula'),
	(DEFAULT, 'Renata Albuquerque', 10922847829, '05/07/1974', 'Rua João Ribeiro, 133', 'renataalbuquerque@hotmail.com', 11999762391, 'F', 9070250, 'SP', 'Santo André', 'Campestre'),
	(DEFAULT, 'Amanda Albuquerque de Oliveira', 24918747873, '09/02/1998', 'Rua João Ribeiro, 133', 'amandaalbuquerque@hotmail.com', 11999761243, 'F', 9070250, 'SP', 'Santo André', 'Campestre');


DROP TABLE IF EXISTS dependente CASCADE;
CREATE TABLE dependente (
Cod_dependente SERIAL PRIMARY KEY,
Nome_dependente VARCHAR(50) NOT NULL,
cpf_dependente NUMERIC(11) NOT NULL,
data_nasci_dependente DATE NOT NULL,
sexo_cliente CHAR(1) CHECK (sexo_cliente IN ('M','F')),
Cod_cliente INTEGER REFERENCES cliente 
	ON DELETE CASCADE ON UPDATE CASCADE
);

insert into dependente values
	(default, 'João Felix Nery', 23423454332, '2010/10/23',	'M', 1),
	(default, 'Melissa Felix Nery', 76556745656, '2012,09/20', 'F',	1),
	(default, 'Larrissa Pereira', 78776510998, '2014-04-04', 'F', 3);
	
INSERT INTO dependente VALUES
	(default, 'Lucas Silva', '98765432101', '15/03/2015', 'M', 4),
	(default, 'Sophia Oliveira', '23456789012', '08/12/2017', 'F', 5),
	(default, 'Enzo Pereira', '54321678109', '02/05/2019', 'M', 9),
	(default, 'Isabela Ribeiro', '98765432176', '12/07/2021', 'F', 8),
	(default, 'Davi Souza', '76543210987', '21/11/2013', 'M', 6);
	
insert into dependente values
	(default, 'Lucas Oliveira Santos', 39176248835, '30/05/2016', 'M', 17),
	(default, 'Beatriz Cardoso Vasquez', 35621960812, '2012/11/04', 'F', 14),
	(default, 'Bianca Cardoso Vasquez', 35621992847, '2013/07/25', 'F',	14),
	(default, 'Ronaldo Cardoso Vasquez', 35623441847, '2014/08/31', 'M', 14),
	(default, 'Larissa Nogueira Alves', 39123341829, '03/02/2011', 'M', 16),
	(default, 'Pedro Henrique Fortunato', 18026099851, '08/12/2009', 'M', 2),
	(default, 'Ana Lucia Matos', 30129375883, '29/11/2012', 'F', 15),
	(default, 'Ana Laura Matos', 30129376872, '29/11/2012', 'F', 15),
	(default, 'Tatiana Cardoso Tavares', 36216416834, '13/02/2011', 'F', 18),
	(default, 'Samantha Rocha Neves', 34029915838, '12/05/2017', 'F', 18),
	(default, 'Yasmin Albuquerque de Oliveira', 30922173815, '11/02/2015', 'F',18);
	
DROP TABLE IF EXISTS ingresso CASCADE;
CREATE TABLE ingresso (
Num_ingresso SERIAL PRIMARY KEY,
Cod_cliente SERIAL REFERENCES cliente
	ON DELETE CASCADE ON UPDATE CASCADE,
Cod_tipo_ingresso INTEGER REFERENCES tipo_ingresso,
Cod_pagamento INTEGER REFERENCES forma_pagamento,
Situacao_ingresso VARCHAR (7) NOT NULL CHECK ( 
	situacao_ingresso IN ('ATIVO', 'INATIVO')),
Valor_ingresso NUMERIC(7,2) NOT NULL, 
Cod_dependente INTEGER REFERENCES dependente
);

DROP TABLE IF EXISTS forma_pagamento CASCADE;
CREATE TABLE forma_pagamento (
Cod_pagamento SERIAL PRIMARY KEY,
Forma_pagamento VARCHAR(20) NOT NULL CHECK 
	(Forma_pagamento IN ('PIX','CREDITO', 'DEBITO', 'DINHEIRO', 'GRATUIDADE')),
Situacao_pagamento  VARCHAR(20) NOT NULL CHECK 
	(Situacao_pagamento IN ('APROVADO','REPROVADO'))
);
ALTER TABLE forma_pagamento DROP COLUMN Situacao_pagamento;
DROP TABLE IF EXISTS calendario CASCADE;

CREATE TABLE calendario (
cal_data DATE PRIMARY KEY,
Dia_semana  VARCHAR(13) NOT NULL CHECK 
	(Dia_semana IN ('DOMINGO','SEGUNDA-FEIRA', 'TERÇA-FEIRA', 
							'QUARTA-FEIRA', 'QUINTA-FEIRA', 
							'SEXTA-FEIRA', 'SABADO')),
Situacao_data VARCHAR (7) NOT NULL CHECK (
	situacao_data IN ('ATIVO', 'INATIVO'))
);

DROP TABLE IF EXISTS tipo_ingresso CASCADE;
CREATE TABLE tipo_ingresso (
Cod_tipo_ingresso SERIAL PRIMARY KEY,
Desc_tipo_ingresso VARCHAR (50) NOT NULL
);

INSERT INTO tipo_ingresso VALUES 
(DEFAULT, 'GESTANTE'),
(DEFAULT,'IDOSO'),
(DEFAULT, 'COMUM');

INSERT INTO forma_pagamento VALUES
(DEFAULT, 'PIX'),
(DEFAULT,'CREDITO'),
(DEFAULT, 'DEBITO'),
(DEFAULT, 'DINHEIRO'),
(DEFAULT, 'GRATUIDADE');

select * from forma_pagamento;

ALTER TABLE calendario ALTER COLUMN Situacao_data SET DEFAULT 'ATIVO' ;

INSERT INTO calendario VALUES
('31/10/2023', 'TERÇA-FEIRA', default),
('01/11/2023', 'QUARTA-FEIRA', default),
('02/11/2023', 'QUINTA-FEIRA', default);

SELECT * FROM ingresso;

SELECT * FROM CLIENTE

CREATE TABLE ingresso (
Num_ingresso SERIAL PRIMARY KEY,
Cod_cliente SERIAL REFERENCES cliente
	ON DELETE CASCADE ON UPDATE CASCADE,
Cod_tipo_ingresso INTEGER REFERENCES tipo_ingresso,
Cod_pagamento INTEGER REFERENCES forma_pagamento,
Situacao_ingresso VARCHAR (7) NOT NULL CHECK ( 
	situacao_ingresso IN ('ATIVO', 'INATIVO')),
Valor_ingresso NUMERIC(7,2) NOT NULL, 
Cod_dependente INTEGER REFERENCES dependente
);

ALTER TABLE ingresso ADD COLUMN cal_data DATE REFERENCES calendario
	ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO ingresso VALUES
(DEFAULT, 1, 3, 1, 'ATIVO', 130.50);

UPDATE ingresso SET cal_data = '31/10/2023' WHERE num_ingresso = 2;

INSERT INTO ingresso VALUES
(DEFAULT, 2, 3, 1, 'ATIVO', 130.50, null, '01/11/2023'),
(DEFAULT, 3, 1, 5, 'ATIVO', 0, null, '01/11/2023'),
(DEFAULT, 4, 3, 1, 'ATIVO', 130.50, null, '02/11/2023'),
(DEFAULT, 5, 3, 1, 'ATIVO', 130.50, null, '02/11/2023');
select * from ingresso;

select * from cliente;

SELECT i.num_ingresso, i.cod_cliente, c.nome_cliente 
from ingresso as i
INNER JOIN cliente as c on
i.cod_cliente = c.cod_cliente

SELECT * FROM DEPENDENTE
SELECT * FROM INGRESSO

-- pesquisa qtde ingressos vendidos com 
---faturamento agrupado por dia no Mês de Novembro
-- quantidade de ingressos disponíveis e a quantidade de gratuidades 'vendidas'


SELECT
    i.cal_data as data_ingresso,
    count(i.num_ingresso) as Qt_ingressos,
    sum(i.valor_ingresso) as Faturamento,
    300 - count(i.num_ingresso) as Capacidade_disponivel,
    count(*) FILTER (WHERE f.Forma_pagamento ILIKE 'GRATUIDADE') as Quantidade_gratuidades
FROM ingresso as i
INNER JOIN forma_pagamento as f ON f.Cod_pagamento = i.Cod_pagamento
WHERE (EXTRACT(MONTH FROM cal_data) = 11)
GROUP BY i.cal_data
ORDER BY i.cal_data;



--- Mulheres de São Paulo com dependentes  
--- Idade do filho mais velho e mais novo

select * from cliente;

select UPPER	(c.nome_cliente)		as CLIENTE,
		count(d.cod_cliente) as NUM_DEPENDENTES,
		MAX(EXTRACT(YEAR FROM AGE(current_date, d.data_nasci_dependente))) 
		AS filho_mais_velho,
		MIN(EXTRACT(YEAR FROM AGE(current_date, d.data_nasci_dependente))) 
		AS filho_mais_novo
FROM cliente c 
INNER JOIN dependente d ON 
c.cod_cliente=d.cod_cliente
WHERE c.sexo_cliente ILIKE 'F' 
AND c.uf ILIKE ('SP') 
GROUP by c.nome_cliente
ORDER BY c.nome_cliente;
	
-- mostra Valores das compras de cada cliente por data
select 	i.cod_cliente AS id_cliente, 
		c.nome_cliente	AS cliente,
		TO_CHAR(i.cal_data, 'DD-Mon-YYYY') as cal_data,
		count(i.cod_cliente) as ingressos,
		sum(i.valor_ingresso) as Total_Compra, 
		fp.forma_pagamento as pagamento
	from ingresso i 
		INNER JOIN cliente c ON(c.cod_cliente=i.cod_cliente)
		INNER JOIN forma_pagamento fp ON(i.cod_pagamento=fp.cod_pagamento)
	group by i.cod_cliente, c.nome_cliente, i.cal_data, fp.forma_pagamento
	order by c.nome_cliente, i.cal_data
	

	-- oi
CREATE TABLE cliente (
Cod_cliente INTEGER PRIMARY KEY,
Nome_cliente VARCHAR(50) NOT NULL,
cpf_cliente NUMERIC(11) NOT NULL,
data_nasci_cliente DATE NOT NULL,
end_cliente VARCHAR(80),
email_cliente VARCHAR(50),
telefone_cliente NUMERIC(13),
sexo_cliente CHAR(1) CHECK (sexo_cliente IN ('M','F'))
);

CREATE TABLE dependente (
Cod_dependente INTEGER PRIMARY KEY,
Nome_dependente VARCHAR(50) NOT NULL,
cpf_dependente NUMERIC(11) NOT NULL,
data_nasci_dependente DATE NOT NULL,
sexo_cliente CHAR(1) CHECK (sexo_cliente IN ('M','F')),
Cod_cliente INTEGER REFERENCES cliente 
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ingresso (
Num_ingresso INTEGER PRIMARY KEY,
Cod_cliente INTEGER REFERENCES cliente
	ON DELETE CASCADE ON UPDATE CASCADE,
Cod_tipo_ingresso INTEGER REFERENCES tipo_ingresso,
Cod_pagamento INTEGER REFERENCES forma_pagamento,
Situacao_ingresso VARCHAR (7) NOT NULL CHECK ( 
	situacao_ingresso IN ('ATIVO', 'INATIVO')),
Valor_ingresso NUMERIC(7,2) NOT NULL, 
Cod_dependente INTEGER REFERENCES dependente
);
--- APAGUEI A SITUACAO PAGAMENTO
CREATE TABLE forma_pagamento (
Cod_pagamento INTEGER PRIMARY KEY,
Forma_pagamento VARCHAR(8) NOT NULL CHECK 
	(Forma_pagamento IN ('PIX','CREDITO', 'DEBITO', 'DINHEIRO')),
Situacao_pagamento  VARCHAR(9) NOT NULL CHECK 
	(Situacao_pagamento IN ('APROVADO','REPROVADO'))
);

CREATE TABLE calendario (
cal_data DATE PRIMARY KEY,
Dia_semana  VARCHAR(13) NOT NULL CHECK 
	(Dia_semana IN ('DOMINGO','SEGUNDA-FEIRA', 'TERÇA-FEIRA', 
							'QUARTA-FEIRA', 'QUINTA-FEIRA', 
							'SEXTA-FEIRA', 'SABADO')),
Situacao_data VARCHAR (7) NOT NULL CHECK (
	situacao_data IN ('ATIVO', 'INATIVO'))
);

CREATE TABLE tipo_ingresso (
Cod_tipo_ingresso INTEGER PRIMARY KEY,
Desc_tipo_ingresso VARCHAR (50) NOT NULL
)

---popular as tabelas
SELECT * FROM tipo_ingresso
INSERT INTO tipo_ingresso VALUES 
(1, 'GESTANTE'),
(2,'IDOSO'),
(3, 'COMUM');
-- excluindo a coluna Situacao_pagamento
ALTER TABLE forma_pagamento DROP COLUMN Situacao_pagamento;
--popular forma_pagamento
INSERT INTO forma_pagamento VALUES
(1, 'PIX'),
(2,'CREDITO'),
(3, 'DEBITO'),
(4, 'DINHEIRO');
SELECT * FROM forma_pagamento
--tornar ativo default
ALTER TABLE calendario ALTER COLUMN Situacao_data SET DEFAULT 'ATIVO' ;
-- popular calendario
INSERT INTO calendario VALUES
('31/10/2023', 'TERÇA-FEIRA', default),
('01/11/2023', 'QUARTA-FEIRA', default),
('02/11/2023', 'QUINTA-FEIRA', default);
SELECT * FROM calendario;
--popular cliente

INSERT INTO cliente VALUES 
(1, 'João PEDRO NERY', '12332112332', 
'23/12/1992', 'Rua José Getúlio, 178', 
 'joao.nery@gmail.com', '11932324567', 'M'),
 (2, 'PEDRO FORTUNATO', '11399118832', 
'29/01/1982', 'AV. PADRE LEORNARDO, 56', 
 'pedro.fort34@hotmail.com', '12945456677', 'M'),
 (3, 'LUANA PEREIRA MATOS', '45687908765', 
  '13/09/1997', 'Rua Paulo alex, 45','luana.lulu@outlook.com','23987876767','F');

SELECT * FROM cliente;
---Popular dependetes


INSERT INTO dependente VALUES 
('1','João Felix Nery', '23423454332', '23/10/2010', 'M', '1'),
('2','Melissa Felix Nery', '76556745656', '20/09/2012', 'F', '1'),
('3', 'Larrissa Pereira', '78776510998', '04/04/2014', 'F', '3' );

SELECT * FROM dependente;

--popular ingresso


INSERT INTO ingresso VALUES
(1, 1, 3, 1, 'INATIVO', 130.50 )

SELECT * FROM ingresso;
INSERT INTO ingresso VALUES
(2, 2, 3, 1, 'INATIVO', 130.50 ),
(3,3,1,3,'ATIVO', 0);
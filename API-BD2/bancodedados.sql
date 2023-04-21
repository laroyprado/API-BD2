-- Configuração de usuário e senha padrão do banco de dados para conectar ao JDbC
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';

GRANT SELECT, INSERT, UPDATE ON 2rp.* TO 'admin'@'localhost';


FLUSH PRIVILEGES;

-- Criação do banco de dados
create database 2rp;

-- Define o banco de dados 2rp como o padrão
use 2rp;

-- Criação de tabelas
create table
    usuarios(
        username VARCHAR(20) not null PRIMARY KEY,
        nome VARCHAR (80) not null,
        senha VARCHAR(15) not NULL,
        funcao ENUM(
            'admin',
            'gestor',
            'colaborador'
        ) NOT NULL,
        status VARCHAR(10) not NULL
    );

create table
    centro_resultado(
        nome VARCHAR(30) NOT NULL,
        status_aprovacao ENUM('ativo', 'inativo') NOT NULL,
        codigo_cr VARCHAR(10) not NULL PRIMARY KEY,
        sigla VARCHAR (10) NOT NULL UNIQUE
    );

create table
    cliente (
        razao_social VARCHAR(70) NOT NULL,
        status_clientes ENUM('ativo', 'inativo') NOT NULL,
        cnpj BIGINT PRIMARY KEY NOT NULL
    );

create table
    hora(
        id int not null AUTO_INCREMENT PRIMARY KEY,
        data_hora_inicio DATETIME not NULL,
        data_hora_fim DATETIME not NULL,
        tipo VARCHAR(15) NOT NULL,
        username_lancador VARCHAR(20) not null,
        cod_cr VARCHAR(30) NOT NULL,
        justificativa VARCHAR(500),
        projeto VARCHAR(100),
        Foreign Key (username_lancador) REFERENCES usuarios(username),
        Foreign Key (cod_cr) REFERENCES centro_resultado(codigo_cr)
    );

create table
    contrato(
		id int(10) auto_increment primary key,
        cod_cr VARCHAR(10) not NULL,
        cnpj_cliente BIGINT NOT NULL,
        Foreign Key (cod_cr) REFERENCES centro_resultado(codigo_cr),
        Foreign KEY (cnpj_cliente) REFERENCES cliente(cnpj)
    );

create table
    integrantes (
        gestor BOOLEAN NOT NULL,
        username_integrante VARCHAR(20) not null,
        cod_cr VARCHAR(10) not NULL,
        Foreign Key (username_integrante) REFERENCES usuarios(username),
        Foreign Key (cod_cr) REFERENCES centro_resultado(codigo_cr),
        PRIMARY KEY (username_integrante, cod_cr)
    );

-- Inserção de dados na tabela
INSERT INTO
    usuarios(
        username,
        nome,
        senha,
        funcao,
        status
    )
VALUES (
        'admin',
        'Admin',
        'admin123',
        'admin',
        'Ativo'
    );

INSERT INTO
    usuarios(
        username,
        nome,
        senha,
        funcao,
        status
    )
VALUES (
        'brendel',
        'Brendel Marques',
        'dev123',
        'colaborador',
        'Ativo'
    ), (
        'caio',
        'Caio Sousa',
        'dev123',
        'colaborador',
        'Ativo'
    ), (
        'larissa',
        'Larissa Fernanda',
        'dev123',
        'colaborador',
        'Ativo'
    ), (
        'laroy',
        'Laroy Prado',
        'dev123',
        'colaborador',
        'Ativo'
    ), (
        'markus',
        'Markus Gomes',
        'dev123',
        'colaborador',
        'Ativo'
    ), (
        'mikaela',
        'Mikaela Petronilho',
        'dev123',
        'colaborador',
        'Ativo'
    ), (
        'nicole',
        'Nicole Souza',
        'dev123',
        'gestor',
        'Ativo'
    ), (
        'willian',
        'Willian Danko',
        'dev123',
        'colaborador',
        'Ativo'
    );

-- Adição de centro de resultados

INSERT INTO
    centro_resultado (
        nome,
        status_aprovacao,
        codigo_cr,
        sigla
    )
VALUES (
        'Codecats',
        'ativo',
        '13652',
        'CCTS'
    );

-- Adição de Clientes

INSERT INTO
    cliente (
        razao_social,
        status_clientes,
        cnpj
    )
VALUES ('Fatec', 'ativo', 123456789), 
('2RP', 'ativo', 987654321);

-- Adição de integrantes no centro de resultado

INSERT INTO
    integrantes (
        gestor,
        username_integrante,
        cod_cr
    )
VALUES (true, "nicole", 13652),
(false, "brendel", 13652),
(false, "caio", 13652),
(false, "larissa", 13652),
(false, "laroy", 13652),
(false, "markus", 13652), 
(false, "mikaela", 13652),
(false, "willian", 13652);

-- Adição dados de contrato

INSERT INTO
    contrato (cod_cr, cnpj_cliente)
VALUES ("13652", 987654321);

-- Adição de dados à tabela hora

INSERT INTO
    hora(
        data_hora_inicio,
        data_hora_fim,
        tipo,
        username_lancador,
        cod_cr,
        justificativa,
        projeto
    )
VALUES (
        "2023-04-15 23:30:00",
        "2023-04-16 01:20:00",
        "hora-extra",
        "larissa",
        13652,
        "Correção de bugs",
        "Projeto Integrador"
    ), (
        "2023-04-15 23:30:00",
        "2023-04-16 01:20:00",
        "hora-extra",
        "laroy",
        13652,
        "Conexão de banco de dados JDBC",
        "Projeto Integrador"
    );

-- Seleção de dados na tabela

SELECT * FROM usuarios;

SELECT * FROM centro_resultado;

SELECT * FROM cliente;

SELECT * FROM integrantes;

SELECT * FROM contrato;

SELECT * FROM hora;

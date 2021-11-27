/* TUDO OK*/

DROP TABLE Participa;
DROP TABLE Projetos;
DROP TABLE Trabalha;
DROP TABLE Departamento;
DROP TABLE Tecnico;
DROP TABLE Graduado;
DROP TABLE Instituicao;
DROP TABLE Telefone;
DROP TABLE Funcionario;

CREATE TABLE Funcionario (
    CPF VARCHAR2(14),
    CPF_lider VARCHAR2(14),
    nome VARCHAR2(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo CHAR(1),
    salario DECIMAL(6,2) NOT NULL,
    CEP VARCHAR2(9) NOT NULL,
    descricao_endereco VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    CONSTRAINT Funcionario_pk PRIMARY KEY (cpf),
	CONSTRAINT Funcionario_fk FOREIGN KEY (CPF_lider) REFERENCES Funcionario (CPF),
	CONSTRAINT Funcionario_check CHECK (sexo = 'M' OR sexo = 'F' OR sexo IS NULL)
);

CREATE TABLE Telefone (
    CPF VARCHAR2(14),
    numero VARCHAR2(15),
    CONSTRAINT telefone_pk PRIMARY KEY (CPF, numero),
	CONSTRAINT telefone_fk FOREIGN KEY (CPF) REFERENCES Funcionario (CPF)
);

CREATE TABLE Instituicao(
    codigo INT,
    nome VARCHAR2(100) UNIQUE NOT NULL,
    sigla CHAR(10) UNIQUE,
    CONSTRAINT codigo_pk PRIMARY KEY (codigo)
);

CREATE TABLE Graduado (
    CPF VARCHAR2(14),
    IES INT NOT NULL,
    grau VARCHAR2(30) NOT NULL,
    CONSTRAINT CPF_pk PRIMARY KEY (CPF),
    CONSTRAINT CPF_fk FOREIGN KEY (CPF) REFERENCES Funcionario (CPF),
    CONSTRAINT IES_fk FOREIGN KEY (IES) REFERENCES Instituicao (codigo)
);

CREATE TABLE Tecnico (
    CPF VARCHAR2(14),
    codigo INT NOT NULL,
    serie VARCHAR2(15) NOT NULL,
    CONSTRAINT CPFt_pk PRIMARY KEY (CPF),
    CONSTRAINT CPFt_fk FOREIGN KEY (CPF) REFERENCES Funcionario (CPF),
    CONSTRAINT cod_fk FOREIGN KEY (codigo) REFERENCES Instituicao (codigo)
);

CREATE TABLE Departamento (
	cpf_chefe VARCHAR2(14) UNIQUE NOT NULL, 
	codigo INT NOT NULL,
	descricao VARCHAR2(30) NOT NULL,
	CONSTRAINT departamento_pk PRIMARY KEY (codigo),
	CONSTRAINT departamento_fk FOREIGN KEY (cpf_chefe) REFERENCES Funcionario (CPF)
);

CREATE TABLE Trabalha (
	CPF VARCHAR2(14),
	codigo INT  NOT NULL,
	dataTra DATE UNIQUE NOT NULL,
	CONSTRAINT trabalha_pk PRIMARY KEY (codigo, CPF),
	CONSTRAINT trabalha_funcionario_fk FOREIGN KEY (CPF) REFERENCES Funcionario (CPF),
    CONSTRAINT trabalha_departamento_fk FOREIGN KEY (codigo) REFERENCES departamento (codigo)
);

CREATE TABLE Projetos (
	codigo INT,
	descricao VARCHAR2(100)  NOT NULL,
	valor DECIMAL(8, 2) NOT NULL,
	CONSTRAINT projetos_pk PRIMARY KEY (codigo)
);

CREATE TABLE Participa (
	codigo INT,
	CPF VARCHAR2(14),
	CONSTRAINT participa_pk PRIMARY KEY (codigo, CPF),
	CONSTRAINT participa_funcionario_fk FOREIGN KEY (CPF) REFERENCES Funcionario (CPF),
    CONSTRAINT participa_projetos_fk FOREIGN KEY (codigo) REFERENCES projetos (codigo)
);










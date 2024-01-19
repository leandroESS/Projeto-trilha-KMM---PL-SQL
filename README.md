
# Banco de dados de uma empresa de Software

Pequeno projeto de banco dados com o tema Empresa de software, usando tecnologia Oracle e linguagem PL/SQL

## ETAPAS

1- Comecei pelo minimundo e a partir da linguagem natural foi feita o modelo conceitual (arquivo Minimundo + Diagrama)

2- Logo em seguida modelei o projeto para o modelo lógico, fazendo a normalização

3- E por fim o modelo fisico, implementado com linguagem PLSQL com comandos de CREATE TABLE, INSERT INTO, FUNÇÕES, GATILHOS, CURSORES, PROCEDIMENTOS E ALGUMAS CONSULTAS (Simples e complexas)

# Projeto trilha KMM SQL/PL   – Empresa de Software

Descrição

Criei um diagrama com o tema empresa de software, onde existe um funcionário com os dados: CPF (CHAVE PRIMÁRIA), nome, data de nascimento, sexo, salário, descrição do endereço e CEP e telefone, como telefone é um atributo multivalorado decidi fazer uma tabela a parte com relacionamento 1:N.
Um empregado pode supervisionar outros empregados que são supervisionados apenas por um (auto relacionamento N:1). Esses funcionários participam de N projetos, que possui um código e uma descrição, e esses projetos participam N funcionários (Como era uma relação N:N criei a tabela participa para pegar as chaves primárias de ambas).
Um funcionário pode chefiar um departamento, que possui um código e uma descrição, no qual deve ser chefiado por um único funcionário (1:1).




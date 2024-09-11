# Banco de Dados de uma Empresa de Software

Este é um pequeno projeto de banco de dados com o tema **Empresa de Software**, desenvolvido utilizando **Oracle** e a linguagem **PL/SQL**.

## Etapas do Projeto

1. **Modelo Conceitual**: O projeto começou com a definição do minimundo, onde a partir da linguagem natural foi criado o modelo conceitual, representado pelo arquivo **Minimundo + Diagrama**.

2. **Modelo Lógico**: Após o modelo conceitual, foi feita a modelagem lógica, com foco na **normalização** dos dados para garantir a integridade e eficiência do banco de dados.

3. **Modelo Físico**: A implementação final foi realizada no modelo físico, utilizando **PL/SQL** com comandos como:
   - `CREATE TABLE`
   - `INSERT INTO`
   - **Funções**
   - **Gatilhos**
   - **Cursores**
   - **Procedimentos**
   - **Consultas simples e complexas**

## Descrição do Projeto

Este projeto, parte da trilha **KMM SQL/PL – Empresa de Software**, visa modelar os dados de uma empresa de software. A seguir, estão os principais detalhes:

- Um funcionário possui os seguintes atributos: 
  - `CPF` (chave primária)
  - Nome
  - Data de nascimento
  - Sexo
  - Salário
  - Endereço (incluindo CEP)
  - Telefone (multivalorado, modelado em uma tabela separada com relacionamento 1:N)
  
- Relacionamentos:
  - **Auto-relacionamento**: Um funcionário pode supervisionar outros funcionários, mas é supervisionado por apenas um (relação N:1).
  - **Projetos**: Um funcionário pode participar de N projetos e cada projeto pode ter N funcionários. Para modelar essa relação N:N, foi criada a tabela intermediária **Participa**, contendo as chaves primárias de ambos.
  - **Departamento**: Um funcionário pode chefiar um departamento, que é identificado por um código e uma descrição. Cada departamento é chefiado por um único funcionário (relação 1:1).

Este projeto explora o ciclo completo de desenvolvimento de um banco de dados, desde o modelo conceitual até a implementação física em PL/SQL, focando em funcionalidades e boas práticas de modelagem de dados.

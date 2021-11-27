/*Identar no sql developer -> ctrl + f7*/

/*Retorna os nomes de tecnicos junto onde concluiu e a sigla da instituição*/
SELECT F.NOME, I.NOME, I.SIGLA FROM FUNCIONARIO F, TECNICO T, INSTITUICAO I WHERE F.CPF = T.CPF AND T.CODIGO = I.CODIGO;

/*Quero os nomes de funcionários que não possuem líder*/
SELECT F.NOME FROM FUNCIONARIO F WHERE F.CPF_LIDER  IS NULL;

/* quero retornar os nomes das pessoas que trabalham no departamento de desenvolvimento
usando select aninhado*/

SELECT NOME FROM FUNCIONARIO  WHERE CPF IN (SELECT CPF  FROM TRABALHA  WHERE CODIGO IN 
(SELECT CODIGO FROM DEPARTAMENTO WHERE UPPER(DESCRICAO) = UPPER('Desenvolvimento')));

/*Mostrar o valor do maior salário dos
empregados e o nome do empregado que o
recebe*/
SELECT NOME, SALARIO FROM FUNCIONARIO WHERE SALARIO IN (SELECT MAX(SALARIO) FROM FUNCIONARIO);

/*Nome e CPF de funcionários em que o salário é maior que a média de salários*/
SELECT NOME,CPF FROM FUNCIONARIO WHERE SALARIO >  (SELECT AVG(SALARIO) FROM FUNCIONARIO);

/*Mostrar quantos funcionarios ganham mais de 3000.00*/
SELECT COUNT(*) FROM FUNCIONARIO WHERE SALARIO > 3000.00;

/*Quero as pessoas que foram admitidas recentementes em qualquer departamento(inner join implícito)*/
SELECT F.NOME AS NOVATOS FROM FUNCIONARIO F, TRABALHA T WHERE T.DATATRA > to_date ('01/01/2020', 'dd/mm/yyyy') AND F.CPF = T.CPF;

/*Listar os quantitativos de
empregados de cada sexo*/
SELECT SEXO, COUNT(*) FROM FUNCIONARIO GROUP BY SEXO;

/*Aumento de 50% para quem ganha 500.00*/
SELECT NOME, (SALARIO*1.50) AS NOVO_SALARIO FROM FUNCIONARIO WHERE SALARIO = 500.00;

/*Mostrar tabela funcionários ordenados dos mais velhos aos mais jovens*/
SELECT * FROM FUNCIONARIO ORDER BY DATA_NASCIMENTO DESC;

/*Ordenar a tabela empregados por idade calculada*/
SELECT trunc((months_between(sysdate, DATA_NASCIMENTO))/12) AS idade FROM FUNCIONARIO ORDER BY IDADE;

/*Retorna os salários distintos*/
SELECT DISTINCT SALARIO FROM FUNCIONARIO;

/*Retorna o nome e os números  fixos dos funcionários*/
SELECT F.NOME, T.NUMERO AS FIXO FROM FUNCIONARIO F, TELEFONE T WHERE T.NUMERO LIKE '_____3%' AND F.CPF = T.CPF;

/*Retorna o nome e os números dos celulares dos funcionários*/
SELECT F.NOME, T.NUMERO AS CEL FROM FUNCIONARIO F, TELEFONE T WHERE T.NUMERO LIKE '_____9%' AND F.CPF = T.CPF;

/*Quero a relação dos funcionários nascidos nos anos 90*/
SELECT NOME FROM FUNCIONARIO WHERE DATA_NASCIMENTO BETWEEN to_date ('01/01/1990', 'dd/mm/yyyy') AND to_date ('01/01/1999', 'dd/mm/yyyy');

/*Retorna os projetos que há ninguém participando*/
SELECT DESCRICAO FROM PROJETOS  WHERE CODIGO NOT IN (SELECT CODIGO FROM PARTICIPA);

/*Nomes dos funcionários que não estão em algum projeto*/
SELECT NOME FROM FUNCIONARIO  WHERE CPF NOT IN (SELECT CPF FROM PARTICIPA);


/*A pessoa mais recente admitida em algum departamento, junto com o nome do departamento e a data*/
SELECT F.NOME, T.DATATRA, D.DESCRICAO  FROM FUNCIONARIO F, DEPARTAMENTO D, TRABALHA T WHERE F.CPF = T.CPF AND D.CODIGO = T.CODIGO ORDER BY T.DATATRA DESC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

/*Os Projetos que tiverem mais de 3 pessoas trabalhando*/
SELECT P.DESCRICAO, COUNT(R.CPF) AS QUANTIDADE_MEMBROS FROM PARTICIPA R INNER JOIN PROJETOS P ON P.CODIGO = R.CODIGO GROUP BY P.DESCRICAO HAVING COUNT(CPF) > 3;

/*Funcionários que fazem aniversário em dezembro ganharam um bônus de 100 reais*/
UPDATE FUNCIONARIO SET SALARIO = SALARIO + 100.00 WHERE to_char(DATA_NASCIMENTO, 'mm') = '12';

/* retonar o ano de nascimento*/
SELECT to_char(data_nascimento, 'yyyy') AS ANO_NAS FROM FUNCIONARIO WHERE  cpf = '295.015.774-22';

/* retonar os dados de quem faz aniversário em dezembro */
SELECT * FROM FUNCIONARIO where to_char(DATA_NASCIMENTO, 'mm') = '12';


/*O projeto mais caro e  mais barato*/
SELECT MIN(VALOR)AS Projeto_mais_barato, MAX(VALOR) AS Projeto_mais_caro FROM PROJETOS;

/*Alterei a tabela projetos e add uma nova coluna localização pra saber de onde é o projeto*/
ALTER TABLE PROJETOS ADD (LOCALIZACAO VARCHAR2(30));

/*Usando inner join explicito, quero saber os números cadastrados de Allana*/
SELECT T.NUMERO FROM TELEFONE T INNER JOIN FUNCIONARIO F ON F.CPF = T.CPF AND UPPER(F.NOME) = UPPER('Allana Valentina de Paula');

/*Retorna o nome da instituição que a graduada Heloise estudou/estuda*/
SELECT NOME FROM INSTITUICAO  WHERE CODIGO IN (SELECT CODIGO FROM TECNICO WHERE CPF IN (SELECT CPF FROM FUNCIONARIO WHERE UPPER(NOME) = UPPER('Heloise Sandra Clara Vieira')));

/*rETORNA O NOME DAS PESSOAS E OS PROJETOS QUE ELAS PARTICIPARAM GRUPADAS */
SELECT  F.NOME, R.DESCRICAO FROM FUNCIONARIO F, PROJETOS R, PARTICIPA P WHERE F.CPF = P.CPF AND P.CODIGO = R.CODIGO GROUP BY F.NOME, R.DESCRICAO; 

/*Usando left join retorno o nome das pessoas e seus projetos mesmo não tendo projeto*/
SELECT F.NOME, R.DESCRICAO FROM FUNCIONARIO F LEFT JOIN PARTICIPA P ON P.CPF = F.CPF LEFT JOIN PROJETOS R ON P.CODIGO = R.CODIGO GROUP BY F.NOME, R.DESCRICAO;

/*Usando right join retorno o nome das pessoas e sesu projetos mesmo não tendo projeto */
SELECT F.NOME, R.DESCRICAO FROM PARTICIPA P RIGHT JOIN FUNCIONARIO F ON P.CPF = F.CPF LEFT JOIN PROJETOS R ON P.CODIGO = R.CODIGO GROUP BY F.NOME, R.DESCRICAO;

/*Agrupei os cpf os cpf's e a deescrição dos projetos por right join */
SELECT T.CPF, D.DESCRICAO FROM TRABALHA T RIGHT JOIN DEPARTAMENTO D ON T.CODIGO = D.CODIGO GROUP BY T.CPF, D.DESCRICAO;

/*Usando full join , ele traz os funconarios sem projetos e os projetos sem funcionarios*/
SELECT F.NOME, R.DESCRICAO FROM FUNCIONARIO F FULL JOIN PARTICIPA P ON P.CPF = F.CPF FULL JOIN PROJETOS R ON P.CODIGO = R.CODIGO GROUP BY F.NOME, R.DESCRICAO;

/*Criando view para ver as pessoas e os numeros de quem trabalha no departamento de RH*/
CREATE OR REPLACE VIEW depRH AS 
select f.nome, t.numero from 
telefone t, funcionario f 
where f.cpf = t.cpf 
and f.cpf in 
(select cpf from trabalha where codigo in
(select codigo from departamento where UPPER(descricao) = UPPER('RH')));

select * from depRH;
DROP VIEW depRH;

/*Alterando uma view. agora a pessoa que trabalha no RH que recebe menos de 3000*/
CREATE OR REPLACE VIEW depRH AS 
select f.nome, t.numero from 
telefone t, funcionario f 
where f.cpf = t.cpf and f.salario <= 3000
and f.cpf in 
(select cpf from trabalha where codigo in
(select codigo from departamento where UPPER(descricao) = UPPER('RH')));

select * from depRH;
DROP VIEW depRH;

/**/

/**/

/**/


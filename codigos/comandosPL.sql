/*Criando uma procedure de inserção de instituição*/
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE insereInstituicao (
    p_codigo instituicao.codigo%TYPE,
    p_nome   instituicao.nome%TYPE,
    p_sigla instituicao.sigla%TYPE
) AS BEGIN

INSERT INTO Instituicao (codigo, nome, sigla) VALUES (p_codigo, p_nome ,  p_sigla);
            DBMS_OUTPUT.PUT_LINE('Inserção Realizada com sucesso') ;

COMMIT;
END; 

EXECUTE insereInstituicao (15, 'Faculdade Santa Helena', 'FSH'); /*Teste*/

SELECT * FROM Instituicao;

DELETE FROM Instituicao WHERE UPPER(sigla) = UPPER('FSH');



/*Imprimindo nome e idade do funcionario passando cpf como parametro*/
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE imprimeNomeIdade (CPFfun IN Funcionario.CPF%TYPE)
IS
 idade NUMBER;
 nomeV VARCHAR2(100);
BEGIN
    SELECT trunc((months_between(sysdate, F.DATA_NASCIMENTO))/12), F.nome  INTO idade, nomeV
    FROM Funcionario F WHERE CPFfun = F.CPF;
    DBMS_OUTPUT.PUT_LINE ('A idade de ' || nomeV || ' é ' || idade );
COMMIT;
END;
    
EXECUTE  imprimeNomeIdade ('295.015.774-22'); /*Teste*/



/*Procedure, que passando o código do projeto,exclui se ele 
tem o valor menor  de 5000.00*/
SET SERVEROUTPUT ON 

CREATE OR REPLACE PROCEDURE tiraMenorQ1500 (codV IN Projetos.codigo%TYPE)
IS 
valorV DECIMAL;
descricaoV VARCHAR2(100);
BEGIN
    SELECT P.valor, P.descricao INTO valorV, descricaoV  FROM Projetos P WHERE P.codigo = codv;
    IF valorV < 1500.00 then
            DBMS_OUTPUT.PUT_LINE ('O ' || descricaoV || ', de valor: ' || valorV || ', Será deletado');
            DELETE FROM Projetos WHERE  codV = codigo;
    ELSE
         DBMS_OUTPUT.PUT_LINE ('O ' || descricaoV ||', de valor: ' || valorV || ', não será deletado');

    END IF;
COMMIT;
END;

EXECUTE tiraMenorQ5000 (0035); /*Teste*/



/*Função que recebe o código de um projeto e imprime os CPF's e nomes de todos os
Funcionários que participaram nesse projeto. A função deve retornar o número total de pessoas que trabalharam nesse projeto*/
SET SERVEROUTPUT ON 

CREATE OR REPLACE FUNCTION qtdTrabPro (codigoPro INT) RETURN NUMBER IS
   CURSOR C_participa(codigo_pro INT) IS
       SELECT F.NOME, F.CPF
        FROM Funcionario F INNER JOIN Participa P
        ON F.cpf = P.cpf 
       WHERE P.codigo = codigo_pro; /*Compara o código da tabela participa com a do projeto passado por parâmetro*/

       reg_participa C_participa%ROWTYPE;
       n Number;

    BEGIN
        n := 0;
        FOR reg_participa IN c_participa(codigoPro) LOOP
           DBMS_OUTPUT.PUT_LINE ( 'Cpf: ' || reg_participa.cpf || '| Nome: ' || reg_participa.nome);
           n := n + 1;
           END LOOP;
           RETURN n;
    COMMIT;
    END;

    
SELECT qtdTrabPro(0014) FROM dual ; /*Teste*/



/*Cursor que imprime os funcionários que são líderados pelo cpf 661.596.914-90*/
SET SERVEROUTPUT ON

DECLARE CURSOR lid661 IS 
SELECT * FROM Funcionario;
fun661 Funcionario%ROWTYPE;

BEGIN
    OPEN lid661;
    FETCH lid661 INTO fun661;
    WHILE lid661%found LOOP
        IF fun661.cpf_lider = '661.596.914-90' THEN
            dbms_output.put_line('O CPF 661.596.914-90 lidera o  funcionário ' || fun661.nome);
        END IF;

        FETCH lid661 INTO fun661;
    END LOOP;

    CLOSE lid661;
COMMIT;
END;


/*Procediemento que retora quantos projetos são mais caros ou iguais ao valor passado*/
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE qtdMaiorq_valor (valorV IN Projetos.valor%TYPE)
IS 
i number;
CURSOR qtdProjetos IS SELECT * FROM Projetos;
umProjeto Projetos%ROWTYPE;
  BEGIN 
    i:= 0;
    OPEN qtdProjetos;
     LOOP
         FETCH qtdProjetos INTO umProjeto;
         EXIT WHEN qtdProjetos%NOTFOUND;
           IF umProjeto.valor >= valorV THEN
            i := i + 1;
           END IF;
     END LOOP;
    CLOSE qtdProjetos;
    DBMS_OUTPUT.PUT_LINE ('A quantidade de projetos com valor igual ou maior a ' || valorV || ' é (são) ' || i);
COMMIT;
END;


EXECUTE qtdmaiorq_valor(1000); /*Teste*/


/*Impedir menores de idade e funconarios com mais de 60 anos ou igual com salario menor que 4000*/
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE impedirMenor (
    vCPF Funcionario.CPF%TYPE,
    vCPF_lider Funcionario.CPF_lider%TYPE,
    vNome Funcionario.nome%TYPE,
    vData_nascimento Funcionario.data_nascimento%TYPE,
    vSexo Funcionario.sexo%TYPE,
    vSalario Funcionario.salario%TYPE,
    vCEP Funcionario.CEP%TYPE,
    vDescricao_endereco Funcionario.descricao_endereco%TYPE,
    vEmail Funcionario.email%TYPE
)
 IS
  BEGIN
      IF trunc((months_between(sysdate, vData_nascimento))/12) >= 18 AND vSalario >= 500.00  THEN 
         IF trunc((months_between(sysdate, vData_nascimento))/12) >= 60 AND vSalario < 4000.00 THEN
           DBMS_OUTPUT.PUT_LINE('Inserção não permitida: Funcionário de maior ou igual a 60 com salário menor que 4000,00 R$');
         ELSE
           INSERT INTO Funcionario (CPF, CPF_lider, nome, data_nascimento, sexo, salario, CEP, descricao_endereco, email)
            VALUES (vCPF,
            vCPF_lider,
            vNome,
            vData_nascimento,
            vSexo,
            vSalario ,
            vCEP,
            vDescricao_endereco,
            vEmail);
            DBMS_OUTPUT.PUT_LINE('Inserção Realizada com sucesso') ;
         END IF;
      ELSE
         DBMS_OUTPUT.PUT_LINE('Inserção não permitida: Funcionário de menor ou salário muito baixo');
     END IF;
COMMIT;
END;


EXECUTE impedirMenor('794.193.844-89', NULL, 'Isabelly Marina Campos', to_date ('15/02/1957', 'dd/mm/yyyy'), 'F', 500, '55012-120', 'Avenida Walfrido Nunes 383', 'isabellymarinacampos-87@flextroniocs.copm.br');



/*Gatilho para impedir uma inserção ou uma atualização em que os valores do projeto não pode ser
menos que 1.500 e nem maior que 100.000 */
CREATE OR REPLACE TRIGGER limiteProjeto
BEFORE INSERT OR UPDATE OF  valor ON Projetos
FOR EACH ROW
BEGIN 
   IF :NEW.valor > 100000   OR :NEW.valor < 1500 THEN
           RAISE_APPLICATION_ERROR( num => -20000, msg => 'Os projetos não podem custar menos que 1.500,00 ou mais que 100.000,00');
    END IF;
COMMIT;
END;

INSERT INTO Projetos (codigo, descricao, valor) VALUES (0058, 'Projeto de redes', 10.00);
/

/**/

/**/
/**/

/**/
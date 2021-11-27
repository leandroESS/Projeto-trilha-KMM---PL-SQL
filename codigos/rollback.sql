INSERT INTO Projetos (codigo, descricao, valor) VALUES (00050, 'Projeto de redes 2', 8000.00 );

savepoint para_aqui;

select * from projetos;


INSERT INTO Projetos (codigo, descricao, valor) VALUES (00051, 'Projeto de redes 3', 7000.00 );

select * from projetos;

ROLLBACK to para_aqui; /*vai rolar rollback daqui até o savepoint, tudo antes de savepoint continua*/

select * from projetos;

rollback; /*aqui volta tudo, desde o inicio desse script*/
CREATE DATABASE SoftBlue;

use SoftBlue;

create table funcionarios
(
	id int unsigned primary key not null auto_increment,
    nome varchar(40) not null,
    salario double not null default '0',
    departamento varchar(40) not null
);

create table veiculos
(
	id int unsigned primary key not null auto_increment,
    funcionario_id int unsigned default null,
    constraint fk_func_vei foreign key(funcionario_id) references funcionarios(id),
    veiculo varchar(45) not null default '',
    placa varchar(10) not null default ''
    );
    
create table salarios
(
	faixa varchar(40) primary key not null,
    inicio double not null, 
    fim double not null
);

CREATE TABLE cpfs
(
	id int unsigned not null primary key,
    cpf varchar(14) not null,
    constraint fk_cpf foreign key (id) references funcionarios(id)
);

CREATE TABLE clientes
(
	id int unsigned not null primary key auto_increment,
    nome varchar(40) not null,
    quem_indicou int unsigned,
    constraint fk_quem_indicou foreign key(quem_indicou) references clientes(id)
);

CREATE TABLE contas_bancarias
(
	id int unsigned not null primary key auto_increment,
    titular varchar(45) not null,
    saldo double not null
) engine = InnoDB;

create table estoque
(
	id int unsigned not null primary key auto_increment,
    descricao varchar(50) not null,
    quantidade int not null
);

create table pedidos 
(
	id int unsigned not null primary key auto_increment,
    descricao varchar(100) not null,
    valor double not null default '0',
    pago varchar(3) not null default 'Não'
);

create index departamentos ON funcionarios (departamento);
create index nomes ON funcionarios (nome(3));

INSERT INTO funcionarios(nome, salario, departamento) VALUES('Roberto', 950.5, 'Financeiro');
INSERT INTO funcionarios(nome, salario, departamento) VALUES('Paloma', 1250.5, 'Vendas');
INSERT INTO funcionarios(nome, salario, departamento) VALUES('Sergio', 1250.5, 'Vendas');
INSERT INTO funcionarios(nome, salario, departamento) VALUES('Tiago', 1250.5, 'Vendas');
INSERT INTO funcionarios(nome, salario, departamento) VALUES('Diogo', 3550.5, 'Gerência');
INSERT INTO funcionarios(nome, salario, departamento) VALUES('Gilberto', 2900.5, 'TI');
INSERT INTO funcionarios(nome, salario, departamento) VALUES('Rodrigo', 4900.5, 'TI');


INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(2,'Honda Civic LEX 2020', 'SS-324PE');
INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(2,'Honda WR-V 2020', 'SS-423PE');
INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(3,'Honda HR-V Turbo 2020', 'SS-765PE');
INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(3,'Honda City 2020', 'SS-234PE');
INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(3,'Honda CRV 2020', 'SS-045PE');
INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(4,'Jaguar F-Pace 2020', 'US-998RJ');
INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(4,'Jaguar E-Pace R-Dynamic S 2020', 'US-344RJ');
INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(null,'Jaguar S-Pace Titanium X 2020', 'US-988RJ');

insert into cpfs(id,cpf) Values(1, '111.111.111-01');
insert into cpfs(id,cpf) Values(2, '222.222.222-02');
insert into cpfs(id,cpf) Values(3, '333.333.333-03');
insert into cpfs(id,cpf) Values(4, '444.444.444-04');
insert into cpfs(id,cpf) Values(5, '555.555.555-05');
insert into cpfs(id,cpf) Values(6, '666.666.666-06');
insert into cpfs(id,cpf) Values(7, '777.777.777-07');

INSERT INTO clientes( id,nome,quem_indicou) VALUES(1, 'Rômulo', null);
INSERT INTO clientes( id,nome,quem_indicou) VALUES(2, 'Carlos', 1);
INSERT INTO clientes( id,nome,quem_indicou) VALUES(3, 'Jacob', 2);
INSERT INTO clientes( id,nome,quem_indicou) VALUES(4, 'Luís', 1);

INSERT INTO salarios(faixa, inicio, fim) VALUES('Analista Junior', 1000, 2000);
INSERT INTO salarios(faixa, inicio, fim) VALUES('Analista Pleno', 2000, 4000);
INSERT INTO salarios(faixa, inicio, fim) VALUES('Analista Senior', 4000, 9000);

insert into contas_bancarias(titular, saldo) values('Lucas',1000);
insert into contas_bancarias(titular, saldo) values('Daniel',2000);
insert into contas_bancarias(titular, saldo) values('Sheila',3500);
insert into contas_bancarias(titular, saldo) values('Leôncio',8000);

set sql_safe_updates = 0;

alter table funcionarios change nome nome_f varchar(50) not null; 
drop table salarios;
update funcionarios set salario = salario * 1.1 where departamento = 'TI';
update funcionarios set salario = round(salario *1.1, 1);
update veiculos SET funcionario_id = 3 where id = 2;
update funcionarios set salario = 1800 where id = 1;


SELECT * FROM clientes;
select * from veiculos;
select * from salarios;
select * from cpfs;
select * from funcionarios;
select * from contas_bancarias;
select * from pedidos;
select * from estoque;

select * from funcionarios where salario > 2000;
select * from funcionarios where nome = 'Diogo';
select nome AS 'Funcionário', salario from funcionarios where salario > 2000; 


select a.nome as CLIENTE, b.nome as "QUEM INDICOU" from clientes a join clientes b on a.quem_indicou = b.id;
select * from funcionarios join veiculos on funcionarios.id = veiculos.funcionario_id;
select * from funcionarios left join veiculos on funcionarios.id = veiculos.funcionario_id;
select * from funcionarios right join veiculos on funcionarios.id = veiculos.funcionario_id;
select * from funcionarios join cpfs using (id);
select f.nome, f.salario, s.faixa from funcionarios f inner join salarios s on f.salario between s.inicio and s.fim;
select * from funcionarios join veiculos on funcionarios.id = veiculos.funcionario_id JOIN cpfs on cpfs.id = funcionarios.id;


select count(*) from funcionarios;
select count(*) from funcionarios where salario > 2000 and departamento = 'TI';
select sum(salario) from funcionarios;
select sum(salario) from funcionarios  where departamento = 'TI';
select avg(salario) from funcionarios;
select avg(salario) from funcionarios where departamento = 'TI';
select max(salario) from funcionarios;
select max(salario) from funcionarios where departamento = 'TI';
select min(salario) from funcionarios;
select min(salario) from funcionarios where departamento = 'TI';
select distinct(departamento) from funcionarios;
select * from funcionarios order by departamento;
select * from funcionarios order by salario desc;
select * from funcionarios order by departamento, salario;
select * from funcionarios LIMIT 2;
select * from funcionarios LIMIT 2 OFFSET 1;
select departamento, avg(salario) from funcionarios group by departamento;
select departamento, avg(salario) from funcionarios group by departamento HAVING avg(salario) > 2000;
select departamento, count(*) from funcionarios group by departamento;
SELECT nome FROM funcionarios WHERE departamento IN(SELECT departamento FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 2000);


select * from funcionarios where nome = 'Gilberto'
union
select * from funcionarios where id = 5;


select * from funcionarios left join veiculos on funcionarios.id = veiculos.funcionario_id
union
select * from funcionarios right join veiculos on funcionarios.id = veiculos.funcionario_id;


select * from funcionarios 
union
select * from veiculos;


create view funcionarios_a AS select * from funcionarios where salario >= 1700; 
select * from funcionarios_a;


start transaction;
update contas_bancarias SET saldo = saldo + 200 WHERE id = 1;
update contas_bancarias SET saldo = saldo - 200 WHERE id = 2;
rollback;
commit;

show engines;

UPDATE pedidos SET pago = 'Sim' WHERE id = 11;

CALL limpa_pedidos();

CREATE TRIGGER gatilho_limpa_pedidos BEFORE INSERT ON estoque FOR EACH ROW CALL limpa_pedidos();



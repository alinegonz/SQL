-- Database: postgres

-- DROP DATABASE postgres;

CREATE DATABASE postgres
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;

COMMENT ON DATABASE postgres
  IS 'default administrative connection database';



create table editora (
	codigoEditora serial NOT NULL, 
	descricao varchar(30) NOT NULL, 
	endereco varchar(80)
	);

create table livro(
	codigoLivro serial NOT NULL,
	isbn char(10) NOT NULL,
	titulo varchar(50) NOT NULL,
	numeroEdicao int NOT NULL,
	preco numeric(7,2) NOT NULL,
	codigoEditora int NOT NULL
);

create table autor(
	codigoAutor serial NOT NULL,
	nome varchar(80) NOT NULL,
	sexo char(1) NOT NULL,
	dataNascimento date NOT NULL
);

create table livro_autor(
	codigoLivro_Autor serial NOT NULL,
	codigoLivro int NOT NULL,
	codigoAutor int NOT NULL
);

create table funcionario(
	codigoFuncionario serial NOT NULL,
	nome varchar(80) NOT NULL,
	sexo char(1) NOT NULL
);


-- Restrição
-- Chaves Primárias
alter table editora 
add constraint pkEditora primary key(codigoEditora);

alter table livro 
add constraint pkLivro primary key(codigoLivro);

alter table autor 
add constraint pkAutor primary key(codigoAutor);

alter table livro_autor
add constraint pkLivro_autor primary key(codigoLivro_Autor);

alter table funcionario 
add constraint pkFuncionario primary key(codigoFuncionario);

-- Restrição
-- Chaves Estrangeiras

alter table livro 
add constraint fkcodigoEditora 
foreign key (codigoEditora) 
references editora(codigoEditora);

alter table livro_autor 
add constraint fklivro_autor
foreign key (codigoLivro) 
references livro(codigoLivro);

alter table livro_autor 
add constraint fklivro_autor_autor
foreign key (codigoAutor) 
references autor(codigoAutor);

-- Restrição de domínio (sexo)
alter table autor 
add constraint ck_sexo_autor
check (sexo in ('M','F'));

alter table funcionario
add constraint ck_sexo_funcionario
check (sexo in ('M','F'));

-- Inserção de registros (tuplas)
--insert into nome_tabela (atributo1, atributo2, ....)
--values (valor1, valor2,....);

insert into editora (descricao,endereco)
values ('Campus','Rua do Timbó');

insert into editora (descricao,endereco)
values ('Abril',NULL);

insert into editora (descricao)
values ('Editora Teste');

insert into tb_editora (descricao)
values ('Editora Saraiva');

 -- Seleção
select * from editora
order by codigoEditora;

update editora
set descricao = 'Editora do Brasil'
where codigoEditora = 3;

update editora
set endereco = 'Rua Jardim Nova Esperanca'
where codigoEditora = 1;

update editora
set descricao = 'Editora Cultura'
where codigoEditora = 1;

insert into livro (isbn, titulo, numeroEdicao, preco, codigoEditora) 
values ('12345', 'Banco de Dados', 3, 70.00, 1);

insert into livro (isbn, titulo, numeroEdicao, preco, codigoEditora) 
values ('35790', 'SGBD', 1, 85.00, 2);

insert into livro (isbn, titulo, numeroEdicao, preco, codigoEditora) 
values ('98765', 'Redes de Computadores', 2, 80.00, 2);

insert into autor (nome, sexo, dataNascimento) 
values ('João', 'M', '01.01.1970');

insert into autor (nome, sexo, dataNascimento) 
values ('Maria', 'F', '17.05.1974');

insert into autor (nome, sexo, dataNascimento) 
values ('Jose', 'M', '10.10.1977');

insert into autor (nome, sexo, dataNascimento) 
values ('Carla', 'F', '08.12.1964');

select * from autor;

insert into livro_autor (codigoLivro, codigoAutor)
 values (1, 1);

insert into livro_autor (codigoLivro, codigoAutor) 
values (1, 2);

insert into livro_autor (codigoLivro, codigoAutor)
 values (2, 2);

insert into livro_autor (codigoLivro, codigoAutor) 
values (2, 4);

insert into livro_autor (codigoLivro, codigoAutor)
 values (3, 3);

select * from livro_autor;

insert into funcionario (nome, sexo) 
values ('João', 'M');

insert into funcionario (nome, sexo)
values ('Carla', 'F');

insert into funcionario (nome, sexo)
 values ('Osvaldo', 'M');

select * from funcionario;

-- Questão 01
-- upper: maiusculo  lower: minusculo

select * from editora
order by codigoEditora;

update editora 
set endereco = 'Paulo VI' 
where upper(descricao) = 'campus';

update editora
set endereco = 'Av. ACM'
where endereco = 'Rua do Timbó';

select * from livro;
-- Questão 02
update livro
set preco = preco * 1.10
where codigoLivro = 3;

select * from editora
order by codigoEditora;

-- Questão 03

delete from editora 
where codigoEditora = 2;



delete from editora
where upper(descricao) = 'ABRIL';

-- Questão 04
 select nome, dataNascimento
 from autor;

-- Questão 05
-- asc: crescente    desc: decrecente
select nome, dataNascimento
 from autor 
 order by nome;


-- Questão 06
select * from autor;

select nome, dataNascimento
from autor
where sexo = 'F'
order by nome asc, dataNascimento desc;

select nome, data_nascimento
from tb_autor 
where sexo = 'F'
order by nome;

-- Distinct: atributo uma única vez. Eliminação de redudância do resultado
select distinct(sexo) 
from autor;

-- Questão 07
-- is null: são nulos    is not null: não são nulos
select descricao 
from editora
where endereco is null;

-- Questão 08
select * from livro;

select * from editora
order by codigoEditora;

-- Plano cartesiano
select titulo, descricao 
from livro, editora;

select titulo, descricao
from livro, editora
where livro.codigoLivro = editora.codigoEditora;

select l.titulo, e.descricao
from livro as l, editora as e
where l.codigoEditora = e.codigoEditora;

select l.titulo, e.descricao
from editora e 
join livro l
 on l.codigoEditora = e.codigoEditora;

-- Inner: quando uma tabela tem um atributo igual a outra
-- Inner: não aceita null
select l.titulo, e.descricao
from editora e 
inner join livro l 
on l.codigoEditora = e.codigoEditora;

-- Questão 09
-- Ex.: tb_editora está do lado esquerdo do join
select l.titulo, e.descricao 
from editora e 
left join livro l
 on l.codigoEditora = e.codigoEditora


-- Full: todos os lados
select l.titulo, e.descricao 
from editora e 
full join livro l 
on l.codigoEditora = e.codigoEditora;

-- Quando o nome do atributo são iguais
-- Junção natural
-- select *
 from tb_livro
 join tb_editora using (codigo_editora)

--Questão 10
select * from tb_livro;
select * from tb_autor;
select * from tb_livro_autor;

select l.titulo, a.nome 
from livro as l 
join livro_autor as la
on la.codigoLivro = l.codigoLivro
join autor a 
on la.codigoAutor = a.codigoAutor;

-- Questão 12
select titulo
from livro 
where lower(titulo) like 'banco%';

-- Questão 13
select titulo 
from livro
 where upper(titulo) like '%DO%';

-- Questão 14
select titulo, preco, preco * 1.05 as precoreajustado 
from livro ;

-- Questão 15
-- Extract: extrai parte de um atributo 
--(century, year, month,day, hour, minute,second)

select nome, data_nascimento 
from tb_autor 
where extract(month from data_nascimento) = 10;

select nome, data_nascimento
from tb_autor
where extract(month from data_nascimento)=10

-- Questão 16
select count(*) as acervo 
from livro;

-- Questão 17
select * from livro;
select * from tb_autor;
select * from tb_livro_autor;

select count(*) 
from livro_autor la
join livro l 
on l.codigoLivro = la.codigoLivro
where upper(l.titulo) = 'BANCO DE DADOS';

-- Questão 18, 19 e 20

select count(*), sum(preco), avg(preco), min(preco),
max(preco) 
from livro;

select sum(preco)
from  livro;

select avg(preco)
from livro
where upper()


-- Questão 21
-- min: mais velho    max: mais novo
select * from autor;

select min(dataNascimento) 
from autor;

-- Questão 22
select e.descricao, count(*) as quantidade
from livro l 
join editora e 
on e.codigoEditora = l.codigoEditora
group by e.descricao;

-- Questão 23
select e.descricao, sum(l.preco) as soma, avg(l.preco)as media
from livro l 
join editora e 
on e.codigoEditora = l.codigoEditora
group by e.descricao;

-- Questão 24
select * from tb_livro;
select * from tb_autor;
select * from tb_livro_autor;

-- having: sobre uma função agregada (count,sum,avg..)
select l.titulo, count(*)as num_autor
from livro l 
join livro_autor la 
on la.codigoLivro = l.codigoLivro
group by l.titulo
having count(*) > 1;

-- Questão 25
select e.descricao,avg(l.preco)as media 
from livro l 
join editora e 
on e.codigoEditora = l.codigoEditora
group by e.descricao
having avg(l.preco) > 100;



-- Subconsulta
-- Ex.:select nome from tb_funcionario f where
-- salario > (select avg(salario) from tb_funcionario)
--           (1500)
-- In:      Not in:.
-- Questão 27 e 28

select * from tb_autor;
select * from tb_funcionario;
-- Autores que são funcionários

select nome
from autor
where nome in 
		(select nome 
		from funcionario); 

-- Autores que não são funcionários
select nome
from autor
where nome not in 
			(select nome 
			from funcionario);

select a.nome 
from autor a
join funcionario f 
on a.nome = f.nome

-- Questão 26 
-- Union:mesma quantidade e mesmo tipo
	-- Descata duplicidade
	-- ALL traz todos, colocar depois do union

select nome, sexo, 'a' as tipo
from autor
union
select nome, sexo, 'f'
from funcionario
order by tipo;

-- Questão 27
select nome 
from autor 

intersect

select nome 
from funcionario;

-- Questão 28
select nome
 from autor 
 
except -- um menos o outro (diferença)

select nome
from funcionario;


select nome 
from autor 
where nome in 
		(select nome 
		 from funcionario); -- consulta não correlacionada

select nome
from autor a 
where exists 
		(select 1 
		from funcionario f 
		where f.nome = a.nome); -- consulta correlacionada

select nome 
from autor a 
where not exists 
			(select 1
			 from tb_funcionario f 
			 where f.nome = a.nome); --> consulta correlacionada

-- Questão 30
select descricao, count(*) 
from tb_editora e
join tb_livro l
on e.codigo = l.codigo_editora
group by descricao;

-- Consulta derivada
select qtd_abril, qtd_campus
from 
(select count(*) as qtd_abril
from tb_livro l
join tb_editora e 
on e.codigo = l.codigo_editora
where upper(descricao) = 'ABRIL') as tb_abril,

(select count(*) as qtd_campus from tb_livro l
join tb_editora e on e.codigo = l.codigo_editora
where upper(descricao) = 'CAMPUS') as tb_campus;


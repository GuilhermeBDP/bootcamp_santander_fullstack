

# Conceitos e melhores práticas com banco de dados PostgreSQL



## Módulo 1 - Introdução ao Banco de Dados PostgreSQL



### Aula 1 - Introdução



#### 1) Fundamentos de banco de dados

​	<b>Dados</b>: valores brutos, registros armazenados sem qualquer tratamento ou significado. Exemplo:

* 11987475587 81966480021 51988740255 1589632579 6277685920
* Emengarda Rogério Daniel Cleonice Divanildo



​	<b>Informações:</b> dados estruturados, organizados, relacionados entre si, que geram valor e criam sentido a esses dados. Exemplo:

* Telefones: 11987475587 81966480021 51988740255 1589632579 6277685920
* Proprietários: Emengarda Rogério Daniel Cleonice Divanildo



#### 2) Modelos Relacionais

<b>Modelar:</b> modelar é criar um modelo que explicite as características de funcionamento de um elemento, de um software. No caso dos dados, a modelagem de dados demonstram como as estruturas de dados estão organizadas e como se relacionam entre si.

<b>Modelo relacional:</b> é o modelo de dados representativo que se baseia no princípio de que todos os dados armazenados são armazenados em tabelas que possuem linhas e colunas. As linhas são conhecidas como tuplas e as colunas são conhecidas como atributos.

Exemplo:

|  Telefones  | Proprietários |
| :---------: | :-----------: |
| 11987475587 |   Emengarda   |
| 81966480021 |    Rogério    |
| 51988740255 |    Daniel     |
| 1589632579  |   Cleonice    |
| 6277685920  |   Divanildo   |



Mas, nem sempre a relação será 1 para 1, podendo ser do seguinte tipo:

<img src="https://i.loli.net/2021/07/14/dmqT3NwKr4aLuMW.png" alt="image-20210710111827673" style="zoom:50%;" />



<b>Tabelas:</b> conjuntos de dados dispostos em colunas e linhas referentes a um objetivo comum. Elementos que podem ser definidos como tabelas:

* Coisas tangíveis: elementos físicos (carro, produto, animal)
* Funções: perfis de usuário, status de compra
* Eventos ou ocorrências: produtos de um pedido, histórico de dados



<b>Colunas importantes:</b>

* Chave primária / Primary Key / PK: conjutno de um ou mais campos que nunca se repetem, é a identidade da tabela, utilizados como índice de referência na criação de relacionamentos entre tabelas.
* Chave estrangeira / Foreign Key / FK: valor de referência a uma PK de outra tabela ou da mesma tabela para criar um relacionamento entre as tabelas e garantir a integridade dos dados.

Exemplo:

![image-20210710112650746](https://i.loli.net/2021/07/14/XDnlCpu27KUyQZL.png)



<b>Sistema de gerenciamento de banco de dados (SGBD):</b> Conjunto de softwares responsáveis pelo gerenciamento de um banco de dados, facilitando a administração desse banco. São interfaces para se trabalhar e criar as tabelas e relacionamentos.



#### 3) Introdução ao PostgreSQL

<b>PostgreSQL:</b> é um SGBD relacional, criado em 1986 pelo departamento de ciência da computação na universidade da Califórnia em Berkeley. É um SGBD open source.



<b>Arquitetura:</b> o PostgreSQL possui uma arquitetura multiprocessos, realizando diversas tarefas como conexão do usuário ao banco de dados.

<img src="https://i.loli.net/2021/07/14/NWDwAc5fEZLCv7y.png" alt="image-20210710113504695" style="zoom:60%;" />

<sup>Fonte: https://pt.slideshare.net/thiago_alima/postgresql-7885374 - Slide 25</sup>



<b>Modelo cliente/servidor:</b> O PostgreSQL utiliza o esquema de cliente/servidor, ou seja, tem processos que são executados somente na máquina do cliente e processos que são executados somente na máquina do servidor.



<b>Principais características:</b>

* Opensource
* Point in time recovery: caso haja algum problema no banco de dados, é possível restaurá-lo até 12:59
* Linguagem procedural (SQL) com suporte a várias linguagens de programação (perl, python, etc)
* Views, functions, procedures, triggers
* Consultas complexas e Common table expressions (CTE)
* Suporte a dados geográficos (PostGIS)
* Controle de concorrência multi-versão



Site oficial: https://www.postgresql.org/



## Módulo 2 - Objetos e tipos de dados do PostgreSQL



### Aula 1 - Arquivos de configuração, comandos e arquitetura do PostgreSQL



#### 1) O arquivo postgresql.conf

Esse arquivo contém todas as configurações do servidor PostgreSQL. A view pg_settings, acessada por dentro do banco de dados, guarda todas as configurações atuais.

Ao acessar a view pg_settings, é possível visualizar todas as configurações atuais:

```sql
SELECT name, setting
FROM pg_settings;
```

ou então:

```sql
SHOW [parametro];
```

Por padrão, o arquivo postgresql.conf fica dentro do diretório PGDATA.

<sup>*No meu caso, fica no C:\Program Files\PostgreSQL\13\data</sup>

Configurações presentes no postgresql.conf:

* Configurações de conexão:
  * LISTEN_ADRESSES: Endereços TCP/IP das interfaces que o servidor PostgreSQL vai escutar/liberar conexões
  * PORT: A porta TCP que o servidor PostgreSQL vai ouvir. O padrão é 5432.
  * MAX_CONNECTIONS: Número máximo de conexões simultâneas no servidor PostgreSQL
  * SUPERUSER_RESERVED_CONNECTIONS: Número de conexões (slots) reservadas para conexões ao banco de dados de super usuários



* Configurações de autenticação:
  * AUTHENTICATION_TIMEOUT: Tempo máximo em segundos para o cliente conseguir uma conexão com o servidor
  * PASSWORD_ENCRYPTION: Algorítmo de criptografia das senhas dos novos usuários criados no banco de dados
  * SSL: Habilita a conexão criptografada por SSL (Somente se o PostgreSQL foi compilado com suporte SSL)



* Configurações de memória:
  * SHARED_BUFFERS: Tamanho da memória compartilhada do servidor PostgreSQL para cache/buffer de tabelas, índices e demais relações.
  * WORK_MEM: Tamanho da memória para operações de agrupamento e ordenação (ORDER BY, DISTINCT, MERGE JOINS)
  * MAINTENANCE_WORK_MEM: Tamanho da memória para operações como VACUUM, INDEX, ALTER TABLE



#### 2) O arquivo pg_hba.conf

Arquivo responsável pelo controle de autenticação dos usuários no servidor PostgreSQL. O formato do arquivo pode ser:

```
# local         DATABASE  USER  METHOD  [OPTIONS]
# host          DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
# hostssl       DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
# hostnossl     DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
# hostgssenc    DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
# hostnogssenc  DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
```



Métodos de autenticação:

* TRUST: Conexão sem requisição de senha
* REJECT: Rejeitar conexões
* MD5: Criptografia md5
* PASSWORD: senha sem criptografia
* GSS: Generic Security Service Application Program Interface
* SSPI: Security Support Provider Interface (Windows)
* KRB5: Kerberos V5
* IDENT: Utiliza o usuário do sistema operacional do cliente via ident server
* PEER: Utiliza o usuário do sistema operacional do cliente
* LDAP: Idap server
* RADIUS: Radius server
* CERT: Autenticação via certificado SSL do cliente
* PAM: Pluggable Authentication Modules



Exemplo:

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     scram-sha-256
# IPv4 local connections:
host    all             all             127.0.0.1/32            scram-sha-256
# IPv6 local connections:
host    all             all             ::1/128                 scram-sha-256
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     scram-sha-256
host    replication     all             127.0.0.1/32            scram-sha-256
host    replication     all             ::1/128                 scram-sha-256
# PARA TESTES
host	all				all				0.0.0.0/0				md5
```



#### 3) O arquivo pg_ident.conf

Arquivo responsável por mapear os usuários do sistema operacional com os usuários do banco de dados. Localizado no diretório do postgresql.conf.



```
# MAPNAME       SYSTEM-USERNAME         PG-USERNAME
diretoria		daniel					pg_diretoria
comercial		guilherme				pg_comercial
```



#### 4) Comandos administrativos (Windows)

Diferente do Ubuntu e do CentOS, devemos acessar o serviço do PostgreSQL, clicar com o botão direito e escolher qual opção utilizar.



#### 5)  Arquitetura/Hierarquia

<b>Cluster:</b> coleção de bancos de dados que compartilham as mesmas configurações (arquivos de configuração) do PostgreSQL e do sistema operacional (porta, listen_adresses, etc). 

<b>Banco de Dados (Database):</b> Conjunto de schemas com seus objetos/relações (tabelas, funções, views, etc).

<b>Schema:</b> Conjunto de objetos/relações (tabelas, funções, views, etc).



<img src="https://i.loli.net/2021/07/14/IEmDt2UxVzNyRnc.png" alt="image-20210710135336322" style="zoom:67%;" />

### Aula 2 - PGAdmin4

Site oficial: https://www.pgadmin.org/



<b>Importante para a conexão com o banco de dados:</b>

* Liberar acesso ao cluster em postgresql.conf
* Liberar acesso ao cluster para o usuário do banco de dados em pg_hba.conf
* Criar/editar usuários



<b>Criando primeiro server, database e table:</b>

* Server group:

![image-20210710151620664](https://i.loli.net/2021/07/14/5NC8qujmBGLn9cp.png)

![image-20210710151651366](https://i.loli.net/2021/07/14/1ISn2oEw9GjlArp.png)

* Server:

![image-20210710151733273](https://i.loli.net/2021/07/14/AOkWlGVK1qzfcet.png)

![image-20210710151817461](https://i.loli.net/2021/07/14/rsloxVuhv7Ra2p8.png)



![image-20210710151839155](https://i.loli.net/2021/07/14/tD38FVCIqR6SThX.png)



* Database:

  * Clicar no server criado > Tools > Query Tool

  ```sql
  CREATE DATABASE auladb;
  ```

  * Clicar com o botão direito no Databases > Refresh

    ![image-20210710152252245](https://i.loli.net/2021/07/14/J4el6KYjTqUGSDd.png)

  * Clicar na database criada > Tools > Query Tool

```sql
SELECT 1;
```

![image-20210710160005609](https://i.loli.net/2021/07/14/4xguQnwsMkoKJtz.png)





### Aula 3 - Usuários



#### 1) Conceitos users/roles/groups

Roles (papéis ou funções), users (usuáros) e grupo de usuários são "contas", perfis de atuação em um banco de dados, que possuem permissões em comum ou específicas.

Nas versões anteriores do PostgreSQL 8.1, usuários e roles tinham comportamentos diferentes. Atualmente, roles e users são alias.

É possível que roles pertençam a outras roles.

Exemplo:

<img src="https://i.loli.net/2021/07/14/8CEhbAj3LgcHUet.png" alt="image-20210710161058376" style="zoom:67%;" />

Observe que a role daniel e a role robert pertencem a role professores, herdando suas características ou não.



#### 2) Administrando users/roles/groups

A criação de uma role pode ser feita da seguinte maneira:

```sql
CREATE ROLE name [[ WITH ] option [...]];
```

Onde "option" pode ser:

|                      OPTION                      |                            Efeito                            |
| :----------------------------------------------: | :----------------------------------------------------------: |
|             SUPERUSER \| NOSUPERUSER             |             Opções irrestritas no banco de dados             |
|              CREATEDB \| NOCREATEDB              |               Pode ou não criar banco de dados               |
|            CREATEROLE \| NOCREATEROLE            |                   Pode ou não criar roles                    |
|               INHERIT \| NOINHERIT               | Herda ou não herda as permissões da role<br />em que essa role está inserida |
|                 LOGIN \| NOLOGIN                 |          Pode ou não se conectar no banco de dados           |
|           REPLICATION \| NOREPLICATION           |                 Pode ou não realizar backups                 |
|             BYPASSRLS \| NOBYPASSRLS             | Role Level Security<br />Referente a segurança em nivel de role |
|            CONNECTION LIMIT connlimit            | Define quantas conexões simultâneas<br />a role pode ter no banco de dados |
| [ENCRYPTED] PASSWORD 'password' \| PASSWORD NULL | Define se o password pode ou não<br />ser encriptografado. Utilizado em operações<br />de backup, restore em terminais. |
|             VALID UNTIL 'timestamp'              | Define até qual data a role possui<br />acesso ao banco de dados |
|             IN ROLE role_name[,...]              | Ao criar uma role e adicionar o IN ROLE,<br />a nova role vai pertencer a role definida pela option |
|             IN GROUP role_name[,...]             |    Função deprecada (descontinuada)<br />alias do IN ROLE    |
|               ROLE role_name[,...]               | Ao criar uma role e adicionar o ROLE,<br />a role definida pela option vai pertencer a nova role |
|              ADMIN role_name[,...]               | As roles definidas dentro dessa option passarão a fazer<br />parte da nova role e terão acessos administrativos nesse novo<br />grupo |
|               USER role_name[,...]               |             Função descontinuada, alias do ROLE              |
|                    SYSID uid                     |                     Função descontinuada                     |



Exemplos de códigos:

```sql
CREATE ROLE administradores
	CREATEDB
	CREATEROLE
	INHERIT
	NOLOGIN
	REPLICATION
	BYPASSRLS
	CONNECTION LIMIT -1;
	
CREATE ROLE professsores
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOLOGIN
	NOBYPASSRLS
	CONNECTION LIMIT 10;
	
CREATE ROLE alunos
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOLOGIN
	NOBYPASSRLS
	CONNECTION LIMIT 90;
```



Associação entre roles: Quando uma role assume as permissões de outra role, será necessária a opção INHERIT. No momento da criação da role, deve-se usar o IN ROLE ou ROLE para realizar a associação ou utilizar o GRANT, concedendo uma role para outra role.

Exemplo:

```sql
CREATE ROLE professsores
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOLOGIN
	NOBYPASSRLS
	CONNECTION LIMIT -1;

CREATE ROLE daniel
	LOGIN
	CONNECTION LIMIT 1
	PASSWORD '123'
	IN ROLE professores;

CREATE ROLE daniel
	LOGIN
	CONNECTION LIMIT 1
	PASSWORD '123'
	ROLE professores;
	
CREATE ROLE daniel
	LOGIN
	CONNECTION LIMIT 1
	PASSWORD '123';
GRANT professores TO daniel;
```



Desassociação entre roles: Utilizando o comando REVOKE [...] FROM [...]. 

Exemplo:

```sql
REVOKE professores FROM daniel;
```



Alterando uma role: Basta utilizar o comando ALTER ROLE.

Exemplo:

```sql
ALTER ROLE role_name [WITH] option [...]
```

Onde option pode ser:

|                      OPTION                      |                            Efeito                            |
| :----------------------------------------------: | :----------------------------------------------------------: |
|             SUPERUSER \| NOSUPERUSER             |             Opções irrestritas no banco de dados             |
|              CREATEDB \| NOCREATEDB              |               Pode ou não criar banco de dados               |
|            CREATEROLE \| NOCREATEROLE            |                   Pode ou não criar roles                    |
|               INHERIT \| NOINHERIT               | Herda ou não herda as permissões da role<br />em que essa role está inserida |
|                 LOGIN \| NOLOGIN                 |          Pode ou não se conectar no banco de dados           |
|           REPLICATION \| NOREPLICATION           |                 Pode ou não realizar backups                 |
|             BYPASSRLS \| NOBYPASSRLS             | Role Level Security<br />Referente a segurança em nivel de role |
|            CONNECTION LIMIT connlimit            | Define quantas conexões simultâneas<br />a role pode ter no banco de dados |
| [ENCRYPTED] PASSWORD 'password' \| PASSWORD NULL | Define se o password pode ou não<br />ser encriptografado. Utilizado em operações<br />de backup, restore em terminais. |
|             VALID UNTIL 'timestamp'              | Define até qual data a role possui<br />acesso ao banco de dados |
|             IN ROLE role_name[,...]              | Ao criar uma role e adicionar o IN ROLE,<br />a nova role vai pertencer a role definida pela option |
|               ROLE role_name[,...]               | Ao criar uma role e adicionar o ROLE,<br />a role definida pela option vai pertencer a nova role |
|              ADMIN role_name[,...]               | As roles definidas dentro dessa option passarão a fazer<br />parte da nova role e terão acessos administrativos nesse novo<br />grupo |



Excluindo uma role:

Exemplo:

```sql
DROP ROLE daniel;
```



Utilizando no PGAdmin4 e o terminal:

```sql
CREATE ROLE professsores
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOLOGIN
	NOBYPASSRLS
	CONNECTION LIMIT 10;

/* TERMINAL
postgres-# \du

                                    List of roles
  Role name  |                         Attributes                         | Member of
-------------+------------------------------------------------------------+-----------
 postgres    | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 professores | Cannot login                                              +| {}
             | 10 connections                                             |
*/
```

```SQL
ALTER ROLE professores
	PASSWORD '123';

/* TERMINAL
postgres-# \c auladb professores
Password for user professores:
FATAL:  role "professores" is not permitted to log in
Previous connection kept

postgres-# \du
                                    List of roles
  Role name  |                         Attributes                         | Member of
-------------+------------------------------------------------------------+-----------
 postgres    | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 professores | Cannot login                                              +| {}
             | 10 connections                                             |
*/
```

```sql
CREATE ROLE daniel
	LOGIN
	PASSWORD '123';

/* TERMINAL
                                    List of roles
  Role name  |                         Attributes                         | Member of
-------------+------------------------------------------------------------+-----------
 daniel      |                                                            | {}
 postgres    | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 professores | Cannot login                                              +| {}
             | 10 connections                                             |
*/
```

```SQL
DROP ROLE daniel;
CREATE ROLE daniel
	LOGIN
	PASSWORD '123'
	IN ROLE professores;

/* TERMINAL
                                      List of roles
  Role name  |                         Attributes                         |   Member of
-------------+------------------------------------------------------------+---------------
 daniel      |                                                            | {professores}
 postgres    | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 professores | Cannot login                                              +| {}
             | 10 connections                                             |
*/
```

```SQL
DROP ROLE daniel;
CREATE ROLE daniel
	LOGIN
	PASSWORD '123'
	ROLE professores;

/* TERMINAL
                                    List of roles
  Role name  |                         Attributes                         | Member of
-------------+------------------------------------------------------------+-----------
 daniel      |                                                            | {}
 postgres    | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 professores | Cannot login                                              +| {daniel}
             | 10 connections                                             |
*/
```



#### 3) Administrando acessos (GRANT e REVOKE)

São privilégios de acesso aos objetos do banco de dados. Privilégios:

* Tabela
* Coluna
* Sequence
* Database
* Domain
* Foreign data wrapper
* Foreign server
* Function
* Language
* Large object
* Schema
* Tablespace
* Type



Database:

```sql
GRANT {{ CREATE | CONNECT | TEMPORARY | TEMP}[,...] | ALL [PRIVILEGES]}
	ON DATABASE database_name[,...]
	TO role_name[,...] [WITH GRANT OPTION]

REVOKE [GRANT OPTION FOR]
	{{ CREATE | CONNECT | TEMPORARY | TEMP}[,...] | ALL [PRIVILEGES]}
	ON DATABASE database_name[,...]
	FROM {[GROUP] role_name | PUBLIC}[,...]
	[CASCADE | RESTRICT]
```

Schema:

```sql
GRANT {{ CREATE | USAGE}[,...] | ALL [PRIVILEGES]}
	ON SCHEMA schema_name[,...]
	TO role_name[,...] [WITH GRANT OPTION]
	
REVOKE [GRANT OPTION FOR]
	{{CREATE | USAGE}[,...] | ALL [PRIVILEGES]}
	ON SCHEMA schema_name[,...]
	FROM {[GROUP] role_name | PUBLIC}[,...]
	[CASCADE | RESTRICT]
```

Table:

```SQL
GRANT {{SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER}[,...] | ALL [PRIVILEGES]}
	ON {[TABLE] table_name[,...] | ALL TABLES IN SCHEMA schema_name [,...]}
	TO role_name[,...] [WITH GRANT OPTION]

REVOKE [GRANT OPTION FOR]
	{{SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER}[,...] | ALL [PRIVILEGES]}
	ON {[TABLE] table_name[,...] | ALL TABLES IN SCHEMA schema_name [,...]}
	FROM {[GROUP] role_name | PUBLIC}[,...]
	[CASCADE | RESTRICT]
```

Revogando todas as permissões:

```sql
REVOKE ALL ON ALL TABLES IN SCHEMA [schema] FROM [role];
REVOKE ALL ON SCHEMA [schema] FROM [role];
REVOKE ALL ON DATABASE [database] FROM [role];
```



Exemplo:

```sql
CREATE TABLE teste(
	nome VARCHAR
);
GRANT ALL ON TABLE teste TO professores;
```

```sql
DROP ROLE daniel;
CREATE ROLE daniel
	LOGIN
	PASSWORD '123';

/* TERMINAL
postgres-# \c auladb daniel
Password for user daniel:
You are now connected to database "auladb" as user "daniel".

auladb=> SELECT nome FROM teste;
ERROR:  permission denied for table teste
*/
```

```sql
REASSIGN OWNED BY professores TO postgres;  -- or some other trusted role
DROP OWNED BY professores;
DROP ROLE professores;
CREATE ROLE professores
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOLOGIN
	NOBYPASSRLS
	CONNECTION LIMIT 10;
	
GRANT ALL ON TABLE teste TO professores;

DROP ROLE daniel;
CREATE ROLE daniel
	INHERIT
	LOGIN
	PASSWORD '123'
	IN ROLE professores;

/* TERMINAL
auladb=> SELECT nome FROM teste;
 nome
------
(0 rows)
*/
```

```sql
REVOKE professores FROM daniel;

/* TERMINAL
auladb=> SELECT nome FROM teste;
ERROR:  permission denied for table teste
*/
```





### Aula 4 - Objetos e comandos do banco de dados



#### 1) Database, Schemas e Objetos



<b>Database:</b> Database é o banco de dados em si. Dentro dele, temos schemas e objetos. É importante frisar que Databases não compartilham os objetos dentro de cada banco. Eles apenas compartilham os usuários (roles) e as configurações globais dentro do cluster.



<b>Schemas:</b> São grupos de objetos, como tabelas, views, funções, etc. Esses objetos podem ser compartilhados, interagindo entre si no banco de dados.



<b>Objetos:</b> Tudo aquilo que será possível interagir e administrar dentro dos schemas. Sâo os types, sequences, tabelas, views, etc.



Comandos importantes:

```sql
CREATE DATABASE name(
	[[WITH] [OWNER [=] user_name]
    [TEMPLATE [=] template]
    [ENCODING [=] encoding]
    [LC_COLLATE [=] lc_collate]
    [LC_CTYPE [=] lc_ctype]
    [TABLESPACE [=] tablespace_name]
    [ALLOW_CONNECTIONS [=] allowconn]
    [CONNECTION LIMIT [=] connlimit]
    [IS_TEMPLATE [=] istemplate]]
);

CREATE SCHEMA schema_name [AUTHORIZATION role_specification];
```

```sql
ALTER DATABASE name RENAME TO new_name;
ALTER DATABASE name OWNER TO {new_owner | CURRENT_USER | SESSION_USER};
ALTER DATABASE name SET TABLESPACE new_tablespace;

ALTER SCHEMA name RENAME TO new_name ALTER SCHEMA name OWNER TO {new_owner | CURRENT_USER | SESSION_USER};
```

```sql
DROP DATABASE [nome];

DROP SCHEMA [nome];
```



Melhores práticas:

```sql
CREATE SCHEMA IF NOT EXISTS schema_name [AUTHORIZATION role_specification];

DROP SCHEMA IF EXISTS [nome];
```



#### 2) Tabelas, colunas e tipos de dados

Conjuntos de dados dispostos em colunas e linhas referentes a um objetivo comum. As colunas são consideradas como "campos da tabela", como atributos da tabela. As linhas de uma tabela são chamadas também de tuplas, e é onde estão contidos os valores, os dados. 

Exemplo: 

* TABELA = automovel
  * COLUNA 1 = tipo (carro, moto, aviao, helicoptero)
  * COLUNA 2 = ano_fabricacao (2010, 2011, 2020)
  * COLUNA 3 = capacidade_pessoas (1, 2, 350)
  * COLUNA 4 = fabricante (Honda, Avianca, Yamaha) 
* TABELA = produto
  * COLUNA 1 = codigo serial do produto
  * COLUNA 2 = tipo (vestuário, eletronico, beleza)
  * COLUNA 3 = preco 



Na prática, a tabela de produto seria:

| NOME   | MARCA  | TAMANHO | COR    |
| ------ | ------ | ------- | ------ |
| Camisa | Hering | GG      | Branca |
| Calça  | Levis  | 46      | Preta  |



Mas, pode ocorrer a inserção de dados iguais na tabela, como mostrado abaixo:

| NOME   | MARCA  | TAMANHO | COR    |
| ------ | ------ | ------- | ------ |
| Camisa | Hering | GG      | Branca |
| Calça  | Levis  | 46      | Preta  |
| Camisa | Hering | GG      | Branca |



Para resolver esse conflito de dados, devemos entrar no conceito de chave primária.

<b>Primary Key / Chave Primária / PK:</b> Olhando o conceito do modelo de dados relacional e as regras de normalização de banco de dados. uma PK é um conjunto de um ou mais campos que nunca se repetem na tabela e os valores contidos nesses campos garantem a integridade de dado único e a utilização do mesmo como referência para o relacionamento com as demais tabelas.



<b>Foreign Key / Chave Estrangeira / FK:</b>  A FK é um campo ou conjunto de campo que são referências das chaves primárias de outras tabelas

 ou da mesma tabela. A principal função é garantir a integridade referencial entre as tabelas.



<b>Tipos de dados:</b> O PostgreSQL possui diversos tipos de dados, como mostrado a seguir.

| Tipos de dados    | -                     | -                       |
| ----------------- | --------------------- | ----------------------- |
| Numeric Types     | Geometric Types       | Arrays                  |
| Monetary Types    | Network Address Types | Range Types             |
| Character Types   | Bit String Types      | Domain Types            |
| Binary Data Types | Text Search Types     | Object Identifier Types |
| Date/Time Types   | UUID Type             | pg_Isn Type             |
| Boolean Type      | XML Type              | Pseudo-Types            |
| Enumerated Types  | JSON Types            | Composite Types         |



#### 3) DML e DDL

DML é Data Manipulation Language, ou seja, linguagem de manipulação dos dados. Dentre as funções, temos: INSERT, UPDATE, DELETE e SELECT. DDL é Data Definition Language, ou seja, linguagem de definição de dados. Dentre as funções, temos CREATE, ALTER e DROP.



<b> DDL </b>

```sql
CREATE [objeto] [nome do objeto] [opcoes];

ALTER [objeto] [nome do objeto] [opcoes];

DROP [objeto] [nome do objeto] [opcoes];
```

```sql
CREATE DATABASE dadosbancarios;
ALTER DATABASE dadosbancarios OWNER TO diretoria;
DROP DATABASE dadosbancarios;

CREATE SCHEMA IF NOT EXISTS bancos;
ALTER SCHEMA bancos OWNER TO diretoria;
DROP SCHEMA IF EXISTS bancos;
```

```sql
CREATE TABLE [IF NOT EXISTS] [nome da tabela](
	[nome do campo] [tipo] [regras] [opcoes],
	[nome do campo] [tipo] [regras] [opcoes],
	[nome do campo] [tipo] [regras] [opcoes]
);

ALTER TABLE [nome da tabela] [opcoes];

DROP TABLE [nome da tabela] [opcoes];
```

```sql
CREATE TABLE IF NOT EXISTS banco(
    codigo INTEGER PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    data_criacao TIMESTAMP NOT NULL DEFAULT NOW() 
);

CREATE TABLE IF NOT EXISTS banco(
    codigo INTEGER,
    nome VARCHAR(50) NOT NULL,
    data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (codigo)
);

ALTER TABLE banco
	ADD COLUMN tem_poupanca BOOLEAN;
	
DROP TABLE IF EXISTS banco;
```



<b>DML</b>

```sql
INSERT INTO [nome da tabela] ([campos da tabela,])
	VALUES ([valores de acordo com a ordem dos campos acima,]);
	
INSERT INTO [nome da tabela] ([campos da tabela,])
	SELECT [valores de acordo com a ordem dos campos acima,];
```

```sql
INSERT INTO banco (codigo, nome, data_criacao)
	VALUES (100, 'Banco do Brasil', now());
	
INSERT INTO banco (codigo, nome, data_criacao)
	SELECT 100, 'Banco do Brasil', now(); 
```

```sql
UPDATE [nome da tabela] SET
	[campol] = [novo valor do campol],
	[campo2] = [novo valor do campo2],
	[WHERE + condicoes];
```

```sql
UPDATE banco SET
	codigo = 500
	WHERE codigo = 100;
	
UPDATE banco SET
	data_criacao = now()
	WHERE data_criacao IS NULL; 
```

```sql
DELETE FROM [nome da tabela]
	[WHERE + condicoes];
```

```sql
DELETE FROM banco
	WHERE codigo = 512;

DELETE FROM banco
	WHERE nome = 'Conta Digital';
```

```sql
SELECT [campos da tabela]
	FROM [nome da tabela]
	[WHERE + condicoes];
```

```sql
SELECT codigo, nome
	FROM banco; 
SELECT codigo, nome
	FROM banco
	WHERE data_criacao > '2019-10-15 15:00:00'; 

```



Colocando as funções aprendidas na prática:

```sql
CREATE DATABASE financas;
```

```sql
CREATE TABLE IF NOT EXISTS banco (
	numero INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE, -- Boas praticas
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Boas praticas
	PRIMARY KEY (numero)
);
```

```sql
CREATE TABLE IF NOT EXISTS agencia (
	banco_numero INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	nome VARCHAR(80) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (banco_numero, numero),
	FOREIGN KEY (banco_numero) REFERENCES banco (numero)
);
```

```sql
CREATE TABLE cliente (
	numero BIGSERIAL PRIMARY KEY,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR(250) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

```sql
CREATE TABLE conta_corrente (
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	numero BIGINT NOT NULL,
	digito SMALLINT NOT NULL,
	cliente_numero BIGINT NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (banco_numero, agencia_numero, numero, digito, cliente_numero),
	FOREIGN KEY (banco_numero, agencia_numero) REFERENCES agencia (banco_numero, numero),
	FOREIGN KEY (cliente_numero) REFERENCES client (numero)
);
```

```sql
CREATE TABLE tipo_transacao (
	id SMALLSERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

```sql
CREATE TABLE cliente_transacoes (
	id BIGSERIAL PRIMARY KEY,
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	conta_corrente_numero BIGINT NOT NULL,
	conta_corrente_digito SMALLINT NOT NULL,
	cliente_numero BIGINT NOT NULL,
	tipo_transacao_id SMALLINT NOT NULL,
	valor NUMERIC(15, 2) NOT NULL,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero) REFERENCES conta_corrente (banco_numero, agencia_numero, numero, digito, cliente_numero),
    FOREIGN KEY (tipo_transacao_id) REFERENCES tipo_transacao (id)
);
```



Assim que as tabelas foram criadas, os dados devem ser inseridos de acordo com os arquivos destes links:

https://github.com/drobcosta/digital_innovation_one/blob/master/dml.sql





## Módulo 3 - Fundamentos da Structured Query Language (SQL)



### Aula 1 - DML (Data Manipulation Language)



#### 1) Revisão

* PK: conjunto de um ou mais campos que formam a identidade da tabela
* FK: referência para chaves primárias de outra tabela ou da mesma tabela
* Tipos de dados: Serial, bigint, varchar, etc
* DDL: Data Definition Language
* DML: Data Manipulation Language



<b>Idempotência:</b> É a propriedade que algumas ações ou operações possuem que possibilitam elas de serem executadas diversas vezes sem alterar o resultado após a aplicação inicial. Alguns comandos são:

* IF EXISTS
* Comandos pertinentes ao DDL e DML

Exemplo:

```sql
CREATE TABLE cliente (
	numero BIGSERIAL PRIMARY KEY,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR(250) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

Agora, com a propriedade de idempotência:

```sql
CREATE TABLE IF NOT EXISTS cliente (
	numero BIGSERIAL PRIMARY KEY,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR(250) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```



<b>Melhores práticas em DDL</b>

É importante que as tabelas possuam campos que realmente serão utilizados e que sirvam de atributo direto a um objetivo em comum. Algumas outras práticas são:

* Tomar cuidado com regras (constraints)
* Tomar cuidado com excesso de FKs
* Tomar cuidado com o tamanho indevido de atributos. Ex: coluna CEP VARCHAR(255), sendo que o CEP tem apenas 8 dígitos.



#### 2) DML / CRUD (Create Read Update Delete)

```sql
SELECT [campos da tabela]
	FROM [nome da tabela]
	[WHERE + condicoes];
```

```sql
SELECT codigo, nome
	FROM banco; 
SELECT codigo, nome
	FROM banco
	WHERE data_criacao > '2019-10-15 15:00:00';
SELECT numero, nome FROM banco
	WHERE ativo IS TRUE;

SELECT nome
	FROM cliente
	WHERE email LIKE '%gmail.com';
	
SELECT numero
	FROM agencia
	WHERE banco_numero IN(
        SELECT numero
        	FROM banco
            WHERE nome ILIKE '%Bradesco%'
);
```



Condições do SELECT: WHERE, AND e OR

* WHERE (coluna/condição):
  * =
  * \> / \>= 
  * \< / \<=
  * <> / !=
  * LIKE
  * ILIKE
  * IN



<b>SELECT - Idempotência</b>

Essa forma não é recomendável, pois gasta muitos recursos da database.

```sql
SELECT (campos,)
	FROM tabelal
	WHERE EXISTS (
        SELECT (campo,)
        	FROM tabela2
        	WHERE campol = valorl
        		[AND/OR campoN = valorN]
  	); 

```



<b>INSERT</b>

```SQL
INSERT (campos,)
	VALUES (valores,);
	
INSERT (campos,)
	SELECT (valores,);
```

Exemplos

```sql
INSERT INTO agenda (banco_numero, numero, nome)
	VALUES (341,1,'Centro da cidade');
	
INSERT INTO agenda (banco_numero, numero, nome)
	SELECT 341,1,'Centro da cidade'
	WHERE NOT EXISTS (
        SELECT banco_numero, numero, nome
        FROM agencia
        	WHERE banco_numero = 341 AND numero = 1 AND nome = 'Centro da cidade'); -- Não é boa prática
```



<b>ON CONFLICT</b>

```sql
INSERT INTO agenda (banco_numero, numero, nome)
	VALUES (341,1,'Centro da cidade')
	ON CONFLICT (banco_numero, numero) DO NOTHING; 
```



<b>UPDATE</b>

```SQL
UPDATE (tabela) SET campo1 = novo_valor
	WHERE (condicao);
```



<b>DELETE</b>

```sql
DELETE FROM tabela SET campo1 = novo_valor
	WHERE condicao;
```



#### 3) TRUNCATE

Esse comando esvazia a tabela. 

```sql
TRUNCATE [TABLE] [ONLY] name [*] [,...]
	[RESTART IDENTITY | CONTINUE IDENTITY] [CASCADE | RESTRICT]
```

* RESTART IDENTITY: numero serial (id) é reiniciado
* CONTINUE IDENTITY: o numero serial é continuado de onde a tabela anterior parou (padrão)



<b>Prática</b>

```sql
SELECT numero, nome FROM banco;
```

![image-20210712231042427](https://i.loli.net/2021/07/14/MwdGIt6zuErX57e.png)

```sql
SELECT numero, nome, ativo FROM banco;
```

![image-20210712231121992](https://i.loli.net/2021/07/14/94gOKPjCGUbzSeJ.png)

```sql
SELECT banco_numero, numero, nome FROM agencia;
```

![image-20210712231606983](https://i.loli.net/2021/07/14/kEFmX6ZaGRihWql.png)

```sql
SELECT numero, nome, email FROM cliente;
```

![image-20210712231625594](https://i.loli.net/2021/07/14/1IOmhDozAepGLMP.png)

```sql
SELECT id, nome FROM tipo_transacao;
```

![image-20210712231641321](https://i.loli.net/2021/07/14/vLAtCpGogQ1STVd.png)

```sql
SELECT banco_numero, agencia_numero, numero, cliente_numero FROM conta_corrente;
```

![image-20210712231702860](https://i.loli.net/2021/07/14/pfqVZCMEy7XdShl.png)

```sql
SELECT banco_numero, agencia_numero, cliente_numero FROM cliente_transacoes;
```

![image-20210712231717324](https://i.loli.net/2021/07/14/SCpjH2NfFxUq8OL.png)

```sql
SELECT * FROM conta_corrente;
```

![image-20210712231824608](https://i.loli.net/2021/07/14/e4nXOoZGxb7sJam.png)

```sql
SELECT * FROM information_schema.columns WHERE table_name = 'banco'
```

![image-20210712231843002](https://i.loli.net/2021/07/14/s5CUeYTdXx8mJSj.png)

```sql
CREATE TABLE IF NOT EXISTS teste(
	id serial PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS teste;

CREATE TABLE IF NOT EXISTS teste(
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(50) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (cpf)
);

INSERT INTO teste (cpf, nome)
VALUES ('25222555225', 'José Colmeia') ON CONFLICT (cpf) DO NOTHING;
```

![image-20210712232000852](https://i.loli.net/2021/07/14/9vEMwUGbgy3rHV2.png)

```sql
UPDATE teste SET nome = 'Pedro Alvares' WHERE cpf = '25222555225';
SELECT * FROM teste;
```

![image-20210712232014469](https://i.loli.net/2021/07/14/FD2KNI3z1G4dwrE.png)





### Aula 2 - Funções Agregadas



#### 1) Funções agregadas

Documentação: https://www.postgresql.org/docs/13/functions-aggregate.html

Funções agregadas mais comumente usadas:

* AVG
* COUNT (opção: HAVING)
* MAX
* MIN
* SUM



Para selecionar os dados que você quer de uma tabela, basta oferecer os nomes das colunas e da tabela de origem:

```sql
SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;
SELECT numero, nome, email FROM cliente;
SELECT banco_numero, agencia_numero, cliente_numero FROM cliente_transacoes;
```



Mas, caso você não lembre os nomes das colunas, é possível utilizar o ```SELECT * FROM tabela```, o que não é recomendado pois gasta muitos recursos do banco de dados. Assim, é possível utilizar essa função auxiliar para adquirir os nomes das colunas de uma tabela:

```sql
SELECT * FROM information_schema.columns WHERE table_name = 'banco';
```

![image-20210714111930613](https://i.loli.net/2021/07/14/ESdnuhTLbvPjR9m.png)



Ou então:

```sql
SELECT column_name, data_type
	FROM information_schema.columns
	WHERE table_name = 'banco';
```

![image-20210714112205843](https://i.loli.net/2021/07/14/AdNeFHVbuEnTg6s.png)



```sql
SELECT AVG (valor) FROM cliente_transacoes;
```

![image-20210714112426169](https://i.loli.net/2021/07/14/xEpJAIKG4gPzZqf.png)

```sql
SELECT COUNT(numero)
	FROM cliente;
```

![image-20210714112559150](https://i.loli.net/2021/07/14/GpT8vaEjNiuSLwn.png)

```sql
SELECT COUNT(numero), email
	FROM cliente
	WHERE email ILIKE '%gmail.com';
```

![image-20210714112702130](https://i.loli.net/2021/07/14/l5i2zSHTcv9RBaY.png)



O erro acima é devido ao fato de que as funções agregadas são funções de agrupamento, então no momento que o código é executado, todos os valores são agrupados em uma coluna e linha, apenas, assim como o email. Então, para contornar esse problema, utiliza-se a função GROUP BY:

```sql
SELECT COUNT(numero), email
	FROM cliente
	WHERE email ILIKE '%gmail.com'
	GROUP BY email;
```

![image-20210714115806959](https://i.loli.net/2021/07/14/kuTfjhpaHnzVvAg.png)

Observe que o que foi contado foi quantos valores da coluna "numero" existiam pra cada email que terminasse com "gmail". Para contar quantos emails existem com o final gmail, usa-se a primeira função do COUNT apresentada, ou seja:

```sql
SELECT COUNT(email)
	FROM cliente
	WHERE email ILIKE '%gmail.com';
```

![image-20210714115949737](https://i.loli.net/2021/07/14/SJzhE5DC4mBFTMn.png)

```sql
SELECT MAX(numero), MIN(numero)
	FROM cliente;
```

![image-20210714120424871](https://i.loli.net/2021/07/14/aSIWEwbeKsohcZV.png)

```sql
SELECT MAX(valor), MIN(valor)
	FROM cliente_transacoes;
```

![image-20210714120544958](https://i.loli.net/2021/07/14/MAEwLHqKfZ78I2C.png)

```sql
SELECT MAX(valor), MIN(valor), tipo_transacao_id
	FROM cliente_transacoes
	GROUP BY tipo_transacao_id;
```

![image-20210714120801629](https://i.loli.net/2021/07/14/PuQgpRCjNFMTk41.png)

```sql
SELECT COUNT(id), tipo_transacao_id
	FROM cliente_transacoes
	GROUP BY tipo_transacao_id;
```

![image-20210714123007400](https://i.loli.net/2021/07/14/8eks3goiMVG2U4z.png)

```sql
SELECT COUNT(id), tipo_transacao_id
	FROM cliente_transacoes
	GROUP BY tipo_transacao_id
	HAVING COUNT(id) < 150;
```

![image-20210714123112378](https://i.loli.net/2021/07/14/WcoT5UrOZvm2ztu.png)

```sql
SELECT SUM(valor)
	FROM cliente_transacoes;
```

![image-20210714123202016](https://i.loli.net/2021/07/14/r75QYmIoZjpxLTX.png)

```sql
SELECT SUM(valor), tipo_transacao_id
	FROM cliente_transacoes
	GROUP BY tipo_transacao_id;
```

![image-20210714123257314](https://i.loli.net/2021/07/14/yM5GezYNiEqInQ9.png)

```sql
SELECT SUM(valor), tipo_transacao_id
	FROM cliente_transacoes
	GROUP BY tipo_transacao_id;
```

![image-20210714123417134](https://i.loli.net/2021/07/14/jRBH912fbxLnkdY.png)



### Aula 3 - Relacionamento entre tabelas (JOINS)



#### 1) JOINS

Tipos de JOINs que podemos utilizar:

* JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL JOIN
* CROSS JOIN



<b>JOIN (INNER JOIN)</b>

​	Imagine que você tenha duas tabelas e vai realizar o JOIN entre elas, ao realizar o JOIN deve-se sempre utilizar campos das tabelas que referenciem umas as outras. Assim, o resultado da query é somente os dados que pertençam a essa relação. É uma boa prática utilizar PKs, FKs ou índices das tabelas para as referências do JOIN pois assim o processo é mais rápido.

<img src="https://i.loli.net/2021/07/14/ZHaVwLUfFWNEA17.png" alt="image-20210714125240409" style="zoom:80%;" />

Sintaxe básica:

```sql
SELECT tabela_1.campos, tabela_2.campos
	FROM tabela_1
	JOIN tabela_2
		ON tabela_2.campo = tabela1.campo;
```



Considerando as seguintes tabelas:

![image-20210714125600255](https://i.loli.net/2021/07/14/Uzfiy3X6RKHBFOl.png)



 Utilizando o JOIN:

![image-20210714125619849](https://i.loli.net/2021/07/14/kFCYz2a8OJRpqiD.png)



<b>LEFT JOIN (LEFT OUTER JOIN)</b>

​	Ao relacionar tabelas, temos as tabelas a esquerda e tabelas a direita. Ao realizar um LEFT JOIN, você quer dizer que as tabelas que estão a esquerda vão ser trazidas por completo e as tabelas da direita irão ser trazidas apenas nos locais que houverem relação com a tabela da esquerda.

<img src="https://i.loli.net/2021/07/15/Q5nRMBm2Z1LVpzt.png" alt="image-20210714131150924" style="zoom:80%;" />

Sintaxe básica:

```sql
SELECT tabela_1.campos, tabela_2.campos
	FROM tabela_1
	LEFT JOIN tabela_2
		ON tabela_2.campo = tabela1.campo;
```



Considerando as tabelas do exemplo anterior e aplicando agora o LEFT JOIN, temos:

![image-20210714131442356](https://i.loli.net/2021/07/15/O5bM86hXkfxCWiF.png)



<b>RIGHT JOIN (RIGHT OUTER JOIN)</b>

De maneira análoga ao LEFT JOIN, mas a prioridade é da tabela da direita.



Sintaxe básica:

```sql
SELECT tabela_1.campos, tabela_2.campos
	FROM tabela_1
	RIGHT JOIN tabela_2
		ON tabela_2.campo = tabela1.campo;
```



Considere o novo exemplo abaixo:

![image-20210714131933551](https://i.loli.net/2021/07/15/2a3Wo6fLJuIHSUZ.png)

Através da seguinte tabela de relações, temos:

![image-20210714132050510](https://i.loli.net/2021/07/15/8buxFqvITSJGpKf.png)

Utilizando o RIGHT JOIN, temos:

![image-20210714132111866](https://i.loli.net/2021/07/15/ipYELJAk5N4aV2n.png)



<b>FULL JOIN (FULL OUTER JOIN)</b>

O FULL JOIN irá trazer todas as relações possíveis.

<img src="https://i.loli.net/2021/07/15/tHWDfxyRLBkjqhd.png" alt="image-20210714132247802" style="zoom:80%;" />

Não é recomendável utilizar o FULL JOIN em operação pois gastam muitos recursos. É mais utilizado quando deseja-se fazer relatórios.



Sintaxe básica:

```sql
SELECT tabela_1.campos, tabela_2.campos
	FROM tabela_1
	FULL JOIN tabela_2
		ON tabela_2.campo = tabela1.campo;
```



Do exemplo anterior, temos:

![image-20210714132450025](https://i.loli.net/2021/07/15/UP27kbEVrChJ86a.png)



<b>CROSS JOIN</b>

Recomendado apenas para situações extremas. Todos os dados de uma tabela serão cruzados com todos os dados da tabela referenciada, criando uma matriz. Utilizar essa função em produção pode consumir demais os recursos, afetando a dinâmica de produção.



Sintaxe básica:

```sql
SELECT tabela_1.campos, tabela_2.campos
	FROM tabela_1
	CROSS JOIN tabela_2;
```



Utilizando as seguintes tabelas como exemplo e aplicando o CROSS JOIN, temos:

<img src="https://i.loli.net/2021/07/15/VwDWYPb2HArzJKt.png" alt="image-20210714132832069" style="zoom:80%;" />

<img src="https://i.loli.net/2021/07/15/acqroi6gsH45G92.png" alt="image-20210714132854065" style="zoom:80%;" />



Prática:

```sql
SELECT COUNT(1)
	FROM banco; --153
	
SELECT COUNT(1)
	FROM agencia; --296
```

```sql
-- Selecionando os bancos e suas respectivas agencias com base no número do banco

SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
	FROM banco
	JOIN agencia
		ON agencia.banco_numero = banco.numero;
		
SELECT COUNT(banco.numero)
	FROM banco
	JOIN agencia
		ON agencia.banco_numero = banco.numero; -- 296 agencias
```



Observe que o SELECT COUNT(banco.numero) não retornou o número de bancos, mas sim o número de registros em que o agencia.banco_numero era igual a banco.numero. Para contar o número de bancos, usa-se o DISTINCT.

```sql
SELECT banco.numero
	FROM banco
	JOIN agencia
		ON agencia.banco_numero = banco.numero
	GROUP BY banco.numero;
```

![image-20210714135201567](https://i.loli.net/2021/07/15/1KnN4kA5pxCeLIJ.png)

Utilizando o DISTINCT:

```sql
SELECT COUNT(DISTINCT banco.numero)
	FROM banco
	JOIN agencia
		ON agencia.banco_numero = banco.numero -- Resultado: 9
```

```sql
SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
    FROM banco
    LEFT JOIN agencia
        ON agencia.banco_numero = banco.numero; -- 440 registros

SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
    FROM agencia
    RIGHT JOIN banco
        ON banco.numero = agencia.banco_numero; -- 440 registros
```

```sql
	SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM agencia
LEFT JOIN banco
	ON banco.numero = agencia.banco_numero; -- 296 registros
```

```sql
SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
    FROM banco
    FULL JOIN agencia
        ON agencia.banco_numero = banco.numero; -- 440 registros
```



Realizando o CROSS JOIN com duas tabelas:

```sql
CREATE TABLE IF NOT EXISTS teste_a(
	id serial PRIMARY KEY,
	valor VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS teste_b(
	id serial PRIMARY KEY,
	valor VARCHAR(10)
);

INSERT INTO teste_a (valor) VALUES ('teste1');
INSERT INTO teste_a (valor) VALUES ('teste2');
INSERT INTO teste_a (valor) VALUES ('teste3');
INSERT INTO teste_a (valor) VALUES ('teste4');

INSERT INTO teste_b (valor) VALUES ('testeA');
INSERT INTO teste_b (valor) VALUES ('testeB');
INSERT INTO teste_b (valor) VALUES ('testeC');
INSERT INTO teste_b (valor) VALUES ('testeD');

SELECT tbla.valor, tblb.valor
FROM teste_a tbla
CROSS JOIN teste_b tblb;

DROP TABLE IF EXISTS teste_a;
DROP TABLE IF EXISTS teste_b;
```

![image-20210714141030798](https://i.loli.net/2021/07/15/gs3AhN8miK5qIrw.png)



```sql
SELECT	banco.nome,
		agencia.nome,
		conta_corrente.numero,
		conta_corrente.digito,
		cliente.nome
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero
JOIN conta_corrente
		-- ON conta_corrente.banco_numero = agencia.banco_numero
		ON conta_corrente.banco_numero = banco.numero
		AND conta_corrente.agencia_numero = agencia.numero
JOIN cliente
		ON cliente.numero = conta_corrente.cliente_numero;
```

![image-20210714141824865](https://i.loli.net/2021/07/15/ZwikxOLdbaEtYuP.png)



Teste: A partir do SELECT acima, incluir as transacoes de cada cliente e os tipos de transacoes de cada cliente.

```SQL
SELECT	banco.nome,
		agencia.nome,
		conta_corrente.numero,
		conta_corrente.digito,
		cliente.nome,
		cliente_transacoes.valor,
		tipo_transacao.nome
	FROM banco
	JOIN agencia
		ON agencia.banco_numero = banco.numero
	JOIN conta_corrente
		-- ON conta_corrente.banco_numero = agencia.banco_numero
		ON conta_corrente.banco_numero = banco.numero
		AND conta_corrente.agencia_numero = agencia.numero
	JOIN cliente
		ON cliente.numero = conta_corrente.cliente_numero
	JOIN cliente_transacoes
		ON cliente_transacoes.cliente_numero = cliente.numero
	JOIN tipo_transacao
		ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
	ORDER BY cliente_transacoes.valor DESC;
```

![image-20210714143505363](https://i.loli.net/2021/07/15/IpNCgxLoicuyv5D.png)





### Aula 4 - CTE



#### 1) Commom Table Expressions - CTE

CTE é uma forma auxiliar de organizar statements (blocos de códigos) para consultas muito grande, gerando tabelas temporárias e criando relacionamentos entre elas. Dentre dos statements, podem ter SELECTs, INSERTs, UPDATEs ou DELETEs. É uma ferramenta para você agilizar e organizar seu código.



<b>WITH statements</b>

Sintaxe básica:

```sql
WITH nome1 AS (
	SELECT campos
    	FROM tabela_A
    	[WHERE condicao]
),
	nome2 AS (
    SELECT campos
    	FROM tabela_B
    	[WHERE condicao]
)

SELECT nome1.campos, nome2.campos
	FROM nome1
	JOIN nome2...
```



Exemplos:

```sql
WITH tbl_tmp_banco AS (
	SELECT numero, nome
	FROM banco
)
SELECT numero, nome
FROM tbl_tmp_banco;
```

![image-20210714185430608](https://i.loli.net/2021/07/15/lQropAnH74ImJX8.png)

```sql
-- Método 1: CTE
WITH params AS (
	SELECT 213 AS banco_numero
), tbl_tmp_banco AS (
	SELECT numero, nome
		FROM banco
		JOIN params ON params.banco_numero = banco.numero
)
SELECT numero, nome
	FROM tbl_tmp_banco;

-- Método 2: SUBSELECT
SELECT banco.numero, banco.nome
FROM banco
JOIN (
	SELECT 213 AS banco_numero
) params ON params.banco_numero = banco.numero;

```

![image-20210714190525087](https://i.loli.net/2021/07/15/KcUBrJY6IeZFWlx.png)



```SQL
WITH clientes_e_transacoes AS (
	SELECT 	cliente.nome AS cliente_nome,
			tipo_transacao.nome AS tipo_transacao_nome,
			cliente_transacoes.valor AS tipo_transacao_valor
	FROM cliente_transacoes
	JOIN cliente
		ON cliente.numero = cliente_transacoes.cliente_numero
	JOIN tipo_transacao
		ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
)

SELECT cliente_nome, tipo_transacao_nome, tipo_transacao_valor
FROM clientes_e_transacoes;
```

![image-20210714194808175](https://i.loli.net/2021/07/15/zxs4uJX5ivcC3OV.png)

```sql
WITH clientes_e_transacoes AS (
	SELECT 	cliente.nome AS cliente_nome,
			tipo_transacao.nome AS tipo_transacao_nome,
			cliente_transacoes.valor AS tipo_transacao_valor
	FROM cliente_transacoes
	JOIN cliente 
		ON cliente.numero = cliente_transacoes.cliente_numero
	JOIN tipo_transacao 
		ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
	JOIN banco 
		ON banco.numero = cliente_transacoes.banco_numero 
			AND banco.nome ILIKE '%Itaú%'
)
SELECT cliente_nome, tipo_transacao_nome, tipo_transacao_valor
FROM clientes_e_transacoes;
```

![image-20210714195738893](https://i.loli.net/2021/07/15/FcHXG6CIvif5Yy8.png)



## Módulo 4 - Comandos avançados da SQL



### Aula 1 - Views



#### 1) Views

Views são visões, são camadas para as tabelas. São camadas que ficam à frente das tabelas, à frente das consultas SQL, sendo essas consultas robustas ou não. Aceitam comandos de SELECT, INSERT, UPDATE e DELETE. Somente as views que fazem referência a apenas uma tabela permitem o uso do INSERT, UPDATE e DELETE. Views que façam referência a mais de uma tabela aceitam apenas o SELECT.

As views simplificam o acesso mais rápido às consultas, sendo uma boa prática de segurança, pois as pessoas que utilizarem as views irão consumir apenas as views e não terão acesso direto às tabelas.



Sintaxe

```sql
CREATE [ OR REPLACE ] [ TEMP | TEMPORARY ] [ RECURSIVE ] VIEW name [ ( column_name [, ...] ) ]
	[ WITH ( view_option_name [= view_option_value] [, ] ) ]
	AS query [
        WITH [ CASCADED | LOCAL ] CHECK OPTION ]
```



<b>Idempotência</b>

```sql
CREATE OR REPLACE VIEW vw_bancos AS (
    SELECT numero, nome, ativo
    	FROM banco
); 
SELECT numero, nome, ativo
	FROM vw_bancos; 

CREATE OR REPLACE VIEW vw_bancos (banco_numero, banco_nome, banco_ativo) AS (
    SELECT numero, nome, ativo
    	FROM banco
); 
SELECT banco_numero, banco_nome, banco_ativo
	FROM vw_bancos; 
```

As views não possuem tipo de dado pois eles assumem o tipo de dado da consulta.



<b>INSERT, UPDATE E DELETE</b>

```SQL
CREATE OR REPLACE VIEW vw_bancos AS (
    SELECT numero, nome, ativo
    	FROM banco
);
SELECT numero, nome, ativo
	FROM vw_bancos;
	
INSERT INTO vw_bancos (numero, nome, ativo)
	VALUES (100, 'Banco CEM', TRUE);

UPDATE vw_bancos
	SET nome = 'Banco 100'
	WHERE numero = 100;

DELETE FROM vw_bancos
	WHERE numero = 100; 
```



<b>TEMPORARY</b>

```sql
CREATE OR REPLACE TEMPORARY VIEW vw_bancos AS (
    SELECT numero, nome, ativo
    FROM banco
); 
SELECT numero, nome, ativo
	FROM vw_bancos; 
```

Essa view ficará presente apenas na sessão do usuário, ao desconectar-se, ela será perdida.



<b>RECURSIVE</b>

```sql
CREATE OR REPLACE RECURSIVE VIEW (nome_da_view)(campos_da_view) AS (
    SELECT base 
    UNION ALL 
    SELECT campos
    	FROM tabela_base
    JOIN (nome_da_view)
);
```

* UNION - Agrupa, unifica dados iguais
* UNION ALL - Não unifica

No RECURSIVE, é obrigatória a existência dos campos da VIEW.

Exemplo:

Considerando a tabela criada abaixo:

```sql
CREATE TABLE IF NOT EXISTS funcionarios (
    id SERIAL NOT NULL,
    nome VARCHAR (50),
    gerente INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (gerente) REFERENCES funcionarios (id)
);

INSERT INTO funcionarios (nome, gerente)
	VALUES ('Ancelmo', null);
INSERT INTO funcionarios (nome, gerente)
	VALUES ('Beatriz',1);
INSERT INTO funcionarios (nome, gerente)
	VALUES ('Magno',1);
INSERT INTO funcionarios (nome, gerente)
	VALUES ('Cremilda',2);
INSERT INTO funcionarios (nome, gerente)
	VALUES ('Wagner',4); 
```

Os INSERTs, então, ficam nesse formato:

![image-20210714213002683](https://i.loli.net/2021/07/15/7EAqItRTGkPanM1.png)

Ao executar o comando abaixo, temos:

```SQL
SELECT id, nome, gerente
	FROM funcionarios
	WHERE gerente IS NULL;
```

![image-20210714213134499](https://i.loli.net/2021/07/15/ZCXrLh5oanOwPsj.png)

```SQL
SELECT id, nome, gerente
	FROM funcionarios
	WHERE gerente = 999;
```

![image-20210714213232806](https://i.loli.net/2021/07/15/N2nl54VSAOrFpEv.png)

Utilizando o comando UNION ALL:

```SQL
SELECT id, nome, gerente
	FROM funcionarios
        WHERE gerente IS NULL
	UNION ALL
SELECT id, nome, gerente
	FROM funcionarios
    	WHERE gerente = 999;
```

![image-20210714213426234](https://i.loli.net/2021/07/15/tR38mEZPSXKJjWy.png)



Agora, criando uma VIEW mais complexa:

```sql
CREATE OR REPLACE RECURSIVE VIEW vw_funcionarios(id, gerente, funcionario) AS (
    SELECT id, gerente, nome
        FROM funcionarios
            WHERE gerente IS NULL
    UNION ALL
    SELECT funcionarios.id, funcionarios.gerente, funcionarios.nome
    	FROM funcionarios
    	JOIN vw_funcionarios
    		ON vw_funcionarios.id = funcionarios.gerente
);
SELECT id, gerente, funcionario
	FROM vwfuncionarios;
```

Repare que na VIEW acima, o JOIN é feito em cima da própria VIEW. Logo, na primeira vez que a VIEW for executada, irá ser retornado id = 1, gerente = null e nome = ancelmo.  O gerente é NULL pois na primeira execução, a ação vw_funcionarios.id = funcionarios.gerente iguala o id do funcionário atual com o seu respectivo gerente para que, assim, seja possível resgatar o id do gerente do funcionário. Como o Ancelmo não possui gerente, o JOIN vw_funcionarios irá juntar um registro nulo.

Na segunda execução, o JOIN irá juntar o Ancelmo com os funcionários que possuem ele como gerente, pois o JOIN irá juntar o registro que tiver o id = 1 (Ancelmo) como gerente.



Realizando uma busca mais inteligente:

```sql
CREATE OR REPLACE RECURSIVE VIEW vw_funcionarios(id, gerente, funcionario) AS (
    SELECT id, CAST(AS VARCHAR) AS gerente, nome
    	FROM funcionarios
    	WHERE gerente IS NULL
    UNION ALL
    SELECT funcionarios.id, gerentes.nome, funcionarios.nome
    	FROM funcionarios
    	JOIN vw_funcionarios
    		ON vw_funcionarios.id = funcionarios.gerente
    	JOIN funcionarios gerentes
    		ON gerentes.id = vw_funcionarios.id 
);

SELECT id, gerente, funcionario FROM vw_funcionarios;
```



<b>WITH OPTIONS</b>

```sql
CREATE OR REPLACE VIEW vw_bancos AS (
    SELECT numero, nome, ativo
    FROM banco
);
INSERT INTO vw_bancos (numero, nome, ativo)
	VALUES (100, 'Banco CEM', FALSE) -- OK 

CREATE OR REPLACE VIEW vw_bancos AS (
    SELECT numero, nome, ativo
    	FROM banco
    	WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION; 

INSERT INTO vw_bancos (numero, nome, ativo)
	VALUES (100, 'Banco CEM', FALSE) -- ERRO 
```

```sql
CREATE OR REPLACE VIEW vw_bancos_ativos AS (
    SELECT numero, nome, ativo
    	FROM banco
    	WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION;

CREATE OR REPLACE VIEW vw_bancos_maiores_que_l00 AS (
    SELECT numero, nome, ativo
    	FROM vw_banco
    	WHERE numero > 100
) WITH LOCAL CHECK OPTION;

INSERT INTO vw_bancos_maiores_que_100 (numero, name, ativo)
	VALUES (99, 'Banco DIO', FALSE) -- ERRO
	
INSERT INTO vw_bancos_maiores_que_100 (numero, nome, alivo)
	VALUES (200, 'Banco DIO', FALSE) -- ERRO 
```

Repare que no primeiro INSERT o erro foi devido a condição da VIEW vw_bancos_maiores_que_100. Já no segundo INSERT, o erro foi devido à VIEW vw_bancos_ativos.



Testes no pgAdmin:

```sql
CREATE OR REPLACE VIEW vw_bancos AS (
	SELECT numero, nome, ativo
		FROM banco
);

SELECT numero, nome, ativo
	FROM vw_bancos;
```

![image-20210715220218472](https://i.loli.net/2021/07/16/RCJLjIUQyNEh3kz.png)



```sql
CREATE OR REPLACE VIEW vw_bancos_2 (banco_numero, banco_nome, banco_ativo) AS (
	SELECT numero, nome, ativo
		FROM banco
);

SELECT banco_numero, banco_nome, banco_ativo
	FROM vw_bancos_2;
```

![image-20210715220403634](https://i.loli.net/2021/07/16/2ENfJdbCjzLc8Sv.png)



```sql
INSERT INTO vw_bancos_2 (banco_numero, banco_nome, banco_ativo)
	VALUES (51, 'Banco Boa Ideia', TRUE);

SELECT banco_numero, banco_nome, banco_ativo
    FROM vw_bancos_2
    WHERE banco_numero = 51;
```

![image-20210715220915189](https://i.loli.net/2021/07/16/kK2pgDjFIz78Hmc.png)



```SQL
SELECT numero, nome, ativo
    FROM banco
    WHERE numero = 51;
```

![image-20210715221206202](https://i.loli.net/2021/07/16/ZA1UYxvdWQwJGM7.png)

```SQL
UPDATE vw_bancos_2
	SET banco_ativo = FALSE
	WHERE banco_numero = 51;

SELECT banco_numero, banco_nome, banco_ativo
    FROM vw_bancos_2
    WHERE banco_numero = 51;
```

![image-20210715221555620](https://i.loli.net/2021/07/16/WVIUqbXk17QNwjS.png)



```sql
SELECT numero, nome, ativo
	FROM banco
	WHERE numero = 51;
```

![image-20210715222536070](https://i.loli.net/2021/07/16/vL89h5oUnJXGlZW.png)

```sql
DELETE FROM vw_bancos_2
	WHERE banco_numero = 51;

SELECT banco_numero, banco_nome, banco_ativo
    FROM vw_bancos_2
    WHERE banco_numero = 51;
```

![image-20210715222706646](https://i.loli.net/2021/07/16/VNHxoTeLvfKmFOJ.png)

```sql
SELECT numero, nome, ativo
	FROM banco
	WHERE numero = 51;
```

![image-20210715222722031](https://i.loli.net/2021/07/16/pP1NZk2stH3oAq7.png)



```sql
CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
	SELECT nome
		FROM agencia
);

SELECT nome
	FROM vw_agencia;
```

![image-20210715222847802](https://i.loli.net/2021/07/16/HrXFRBLWDyI4l85.png)

Ao deslogar e logar no banco de dados novamente:

```sql
SELECT nome
	FROM vw_agencia;
```

![image-20210715222931607](https://i.loli.net/2021/07/16/g2DBotjW7cSaKb8.png)

```sql
CREATE OR REPLACE VIEW vw_bancos_ativos AS (
	SELECT numero, nome, ativo
        FROM banco
        WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION;

INSERT INTO vw_bancoS_ativos (numero, nome, ativo)
	VALUES (51, 'Banco Boa Ideia', FALSE);
```

![image-20210715223308348](https://i.loli.net/2021/07/16/Uesk4otKDJETWfi.png)



```sql
CREATE OR REPLACE VIEW vw_bancos_com_a AS (
	SELECT numero, nome, ativo
	FROM vw_bancos_ativos
	WHERE nome ILIKE 'a%'
) WITH LOCAL CHECK OPTION;

INSERT INTO vw_bancos_com_a (numero, nome, ativo)
	VALUES (333, 'Beta Omega', TRUE);
```

![image-20210715223508961](https://i.loli.net/2021/07/16/LPAvDpzTl8fnVoX.png)



```sql
CREATE TABLE IF NOT EXISTS funcionarios (
    id SERIAL NOT NULL,
    nome VARCHAR (50),
    gerente INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (gerente) REFERENCES funcionarios (id)
);

INSERT INTO funcionarios (nome, gerente)
	VALUES ('Ancelmo', null);
INSERT INTO funcionarios (nome, gerente)
	VALUES ('Beatriz',1);
INSERT INTO funcionarios (nome, gerente)
	VALUES ('Magno',1);
INSERT INTO funcionarios (nome, gerente)
	VALUES ('Cremilda',2);
INSERT INTO funcionarios (nome, gerente)
	VALUES ('Wagner',4); 

SELECT id, nome, gerente
	FROM funcionarios;
```

![image-20210715223923878](https://i.loli.net/2021/07/16/g6KEUdPSsrjDLbv.png)



```sql
SELECT id, nome, gerente
	FROM funcionarios
	WHERE gerente IS NULL;
```

![image-20210715224004195](https://i.loli.net/2021/07/16/Y4BHmyWdgiMxPNn.png)



```sql
SELECT id, nome, gerente
	FROM funcionarios
        WHERE gerente IS NULL
	UNION ALL
SELECT id, nome, gerente
	FROM funcionarios
    	WHERE gerente = 999;
```

![image-20210715224056943](https://i.loli.net/2021/07/16/XbyAtUROVh468au.png)



```sql
CREATE OR REPLACE RECURSIVE VIEW vw_func(id, gerente, funcionario) AS (
    SELECT id, gerente, nome
        FROM funcionarios
            WHERE gerente IS NULL
    UNION ALL
    SELECT funcionarios.id, funcionarios.gerente, funcionarios.nome
    	FROM funcionarios
    	JOIN vw_func
    		ON vw_func.id = funcionarios.gerente
);
SELECT id, gerente, funcionario
	FROM vw_func;
```

![image-20210715224344083](https://i.loli.net/2021/07/16/aqFmwgAB71Q8Y9n.png)



Desafio:

```sql
```




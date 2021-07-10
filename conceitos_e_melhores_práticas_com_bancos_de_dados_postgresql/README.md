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

<img src="C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710111827673.png" alt="image-20210710111827673" style="zoom:50%;" />



<b>Tabelas:</b> conjuntos de dados dispostos em colunas e linhas referentes a um objetivo comum. Elementos que podem ser definidos como tabelas:

* Coisas tangíveis: elementos físicos (carro, produto, animal)
* Funções: perfis de usuário, status de compra
* Eventos ou ocorrências: produtos de um pedido, histórico de dados



<b>Colunas importantes:</b>

* Chave primária / Primary Key / PK: conjutno de um ou mais campos que nunca se repetem, é a identidade da tabela, utilizados como índice de referência na criação de relacionamentos entre tabelas.
* Chave estrangeira / Foreign Key / FK: valor de referência a uma PK de outra tabela ou da mesma tabela para criar um relacionamento entre as tabelas e garantir a integridade dos dados.

Exemplo:

![image-20210710112650746](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710112650746.png)



<b>Sistema de gerenciamento de banco de dados (SGBD):</b> Conjunto de softwares responsáveis pelo gerenciamento de um banco de dados, facilitando a administração desse banco. São interfaces para se trabalhar e criar as tabelas e relacionamentos.



#### 3) Introdução ao PostgreSQL

<b>PostgreSQL:</b> é um SGBD relacional, criado em 1986 pelo departamento de ciência da computação na universidade da Califórnia em Berkeley. É um SGBD open source.



<b>Arquitetura:</b> o PostgreSQL possui uma arquitetura multiprocessos, realizando diversas tarefas como conexão do usuário ao banco de dados.

<img src="C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710113504695.png" alt="image-20210710113504695" style="zoom:60%;" />

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



<img src="C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710135336322.png" alt="image-20210710135336322" style="zoom:67%;" />

### Aula 2 - PGAdmin4

Site oficial: https://www.pgadmin.org/



<b>Importante para a conexão com o banco de dados:</b>

* Liberar acesso ao cluster em postgresql.conf
* Liberar acesso ao cluster para o usuário do banco de dados em pg_hba.conf
* Criar/editar usuários



<b>Criando primeiro server, database e table:</b>

* Server group:

![image-20210710151620664](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710151620664.png)

![image-20210710151651366](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710151651366.png)

* Server:

![image-20210710151733273](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710151733273.png)

![image-20210710151817461](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710151817461.png)



![image-20210710151839155](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710151839155.png)



* Database:

  * Clicar no server criado > Tools > Query Tool

  ```sql
  CREATE DATABASE auladb;
  ```

  * Clicar com o botão direito no Databases > Refresh

    ![image-20210710152252245](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710152252245.png)

  * Clicar na database criada > Tools > Query Tool

```sql
SELECT 1;
```

![image-20210710160005609](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710160005609.png)





### Aula 3 - Usuários



#### 1) Conceitos users/roles/groups

Roles (papéis ou funções), users (usuáros) e grupo de usuários são "contas", perfis de atuação em um banco de dados, que possuem permissões em comum ou específicas.

Nas versões anteriores do PostgreSQL 8.1, usuários e roles tinham comportamentos diferentes. Atualmente, roles e users são alias.

É possível que roles pertençam a outras roles.

Exemplo:

![image-20210710161058376](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710161058376.png)

Observe que a role daniel e a role robert pertencem a role professores, herdando suas características ou não.



#### 2) Administrando users/roles/groups

A criação de uma role pode ser feita da seguinte maneira:

```sql
CREATE ROLE name [[ WITH ] option [...]];
```

Onde "option" pode ser:

|             OPTION              |                            Efeito                            |
| :-----------------------------: | :----------------------------------------------------------: |
|    SUPERUSER \| NOSUPERUSER     |             Opções irrestritas no banco de dados             |
|     CREATEDB \| NOCREATEDB      |               Pode ou não criar banco de dados               |
|   CREATEROLE \| NOCREATEROLE    |                   Pode ou não criar roles                    |
|      INHERIT \| NOINHERIT       | Herda ou não herda as permissões da role em que essa role está inserida |
|        LOGIN \| NOLOGIN         | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
|  REPLICATION \| NOREPLICATION   |                                                              |
|   CONNECTION LIMIT connlimit    |                                                              |
| [ENCRYPTED] PASSWORD 'password' |                                                              |
|          PASSWORD NULL          |                                                              |
|     VALID UNTIL 'timestamp'     |                                                              |
|     IN ROLE role_name[,...]     |                                                              |
|    IN GROUP role_name[,...]     |                                                              |
|      ROLE role_name[,...]       |                                                              |
|      ADMIN role_name[,...]      |                                                              |
|      USER role_name[,...]       |                                                              |






# Conceitos e melhores práticas com banco de dados PostgreSQL



## Introdução



### 1) Fundamentos de bancos de dados

​	<b>Dados</b>: valores brutos, registros armazenados sem qualquer tratamento ou significado. Exemplo:

* 11987475587 81966480021 51988740255 1589632579 6277685920
* Emengarda Rogério Daniel Cleonice Divanildo



​	<b>Informações:</b> dados estruturados, organizados, relacionados entre si, que geram valor e criam sentido a esses dados. Exemplo:

* Telefones: 11987475587 81966480021 51988740255 1589632579 6277685920
* Proprietários: Emengarda Rogério Daniel Cleonice Divanildo



### 2) Modelos relacionais

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

![image-20210710111827673](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710111827673.png)



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



### 3) Introdução ao PostgreSQL

<b>PostgreSQL:</b> é um SGBD relacional, criado em 1986 pelo departamento de ciência da computação na universidade da Califórnia em Berkeley. É um SGBD open source.



<b>Arquitetura:</b> o PostgreSQL possui uma arquitetura multiprocessos, realizando diversas tarefas como conexão do usuário ao banco de dados.

![image-20210710113504695](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\image-20210710113504695.png)

<sup>Fonte: https://pt.slideshare.net/thiago_alima/postgresql-7885374 - Slide 25</sup>


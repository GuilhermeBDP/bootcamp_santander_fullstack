# Introdução ao Git e ao Github

 

GUI: Graphic User Interface

CLI: Command Line Interface

Comandos:

| Função                  | Windows          | Unix             |
| ----------------------- | ---------------- | ---------------- |
| Mudar  de pasta         | cd               | cd               |
| Listar  pasta           | dir              | ls               |
| Criar  pasta            | mkdir            | mkdir            |
| Remover  conteúdo/pasta | del  / rmdir     | rm  -rf          |
| Escrever                | echo  “mensagem” | echo  “mensagem” |

 

SHA1: Secure Hash Algorithm, é um conjunto de funções hash criptráficas projetada pela NSA. Essa encriptação gera um conjunto de caracteres identificador de 40 dígitos.

 

Blobs: O git manipula os objetos (arquivos) dentro de um objeto chamado blob, que contém metadados dentro dele.

![Interface gráfica do usuário, Aplicativo  Descrição gerada automaticamente](https://i.loli.net/2021/07/14/tVeEgSQYxMbfl9J.jpg)

Trees: as arvores armazenam blobs.

![Interface gráfica do usuário, Aplicativo  Descrição gerada automaticamente](https://i.loli.net/2021/07/14/PgncZtYi3IKXD5b.jpg)

![Interface gráfica do usuário, Diagrama, Aplicativo  Descrição gerada automaticamente](https://i.loli.net/2021/07/14/OkqKDc6lZh15H3W.jpg)

Commits: é o objeto que junta as trees e os blobs, apontando para uma árvore, para o último commit realizado anteriormente (commit pai), aponta para o autor e para a mensagem.

![Interface gráfica do usuário, Aplicativo  Descrição gerada automaticamente](https://i.loli.net/2021/07/14/3fzUESDAZ9Jk6Cb.jpg)

![Diagrama  Descrição gerada automaticamente](https://i.loli.net/2021/07/14/XGNT19RdMHWVLPC.jpg)

Sistema distribuído seguro: devido a facilidade de compartilhar o código, alterá-lo em conjunto, atualizá-lo em conjunto e com total encriptação e controle das alterações.

 

Criando um repositório local e remoto:

* Criando repositorio local:

  ```git
  git init
  git add <b>.</b> ou git add nome_do_arquivo nome_da_pasta/
  git commit -m "mensagem"
  git status
  ```



* Sincronizando com repositorio remoto

  ```git
  git remote add origin link_do_repositorio
  git branch -M main
  git push -u origin main
  ```

  

![Interface gráfica do usuário  Descrição gerada automaticamente](https://i.loli.net/2021/07/14/JzOZX8stEI9hKVG.jpg)

 

* Clonando projeto na pasta local: Na pasta de preferência, copia o projeto todo para a pasta designada.

```git
git clone link_do_projeto
```



* Em casos de conflito ao dar pull de um projeto:

Em projetos em equipe, se existe qualquer alteração na sua area de trabalho (branch) que você fez desde a ultima atualização e vc não commitar essas alterações,  o github nao entende que você finalizou as alterações que desejava.

Ao commitar, ele consegue conferir se haverá algum conflito com o pull que vc está solicitando. Imagine que vc nao commite alteração no mesmo arquivo que você fez pull e foi alterado por outra pessoa, o que daria um conflito, porém se você não commitou essa alteração, o git nao veria esse conflito e ficaria uma bagunça. Logo, ele nao permite nem pull nem push sem que todos as alterações tenham sido ou descartadas ou commitadas

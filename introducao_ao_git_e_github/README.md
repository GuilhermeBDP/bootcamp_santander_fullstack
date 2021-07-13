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

![Interface gráfica do usuário, Aplicativo  Descrição gerada automaticamente](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\clip_image002-1626021443043.jpg)

Trees: as arvores armazenam blobs.

![Interface gráfica do usuário, Aplicativo  Descrição gerada automaticamente](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\clip_image004.jpg)

![Interface gráfica do usuário, Diagrama, Aplicativo  Descrição gerada automaticamente](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\clip_image006.jpg)

Commits: é o objeto que junta as trees e os blobs, apontando para uma árvore, para o último commit realizado anteriormente (commit pai), aponta para o autor e para a mensagem.

![Interface gráfica do usuário, Aplicativo  Descrição gerada automaticamente](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\clip_image008.jpg)

![Diagrama  Descrição gerada automaticamente](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\clip_image010.jpg)

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

  

![Interface gráfica do usuário  Descrição gerada automaticamente](C:\Users\guilh\Google Drive\Cursos Online\Bootcamp Santander Fullstack DIO\conceitos_e_melhores_práticas_com_bancos_de_dados_postgresql\images\clip_image012.jpg)

 

* Clonando projeto na pasta local: Na pasta de preferência, copia o projeto todo para a pasta designada.

```git
git clone link_do_projeto
```


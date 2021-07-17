# Desenvolvimento básico em Java



## Módulo 1 - O que precisamos saber sobre Java



* O que é Java?

Java é uma linguagem de programação e plataforma computacional lançada em 1995 pela Sun Microsystems, por um time comandado por James Gosling. Anos depois foi adquirida pela Oracle. 
Diferente de outras linguagens de programação, que são compiladas para código nativo, o Java é compilado para um bytecode que é interpretado por uma máquina virtual.



* O que é compilador?

Um compilador é um programa que, a partir de um código fonte, cria um programa semanticamente equivalente, porém escrito em outra linguagem, código objeto. Um compilador traduz um programa de uma linguagem textual para uma linguagem de máquina, específica para um processador e sistema operacional. 
O nome compilador é usado principalmente para os programas que traduzem o código fonte de uma linguagem de programação de alto nível para uma linguagem de programação de baixo nível (por exemplo, Assembly ou código de máquina). 



* O que é bytecode?

É o código originado da compilação de programas Java. O bytecode é o programa interpretado e executado pela Máquina Virtual Java, JVM. 



* O que é JVM?

Primeiramente explicar o que é uma VM. 
Uma Máquina Virtual, ou Virtual machine, é um software que simula uma máquina física e consegue executar vários programas, gerenciar processos, memória e arquivos. Tudo isso faz parte de uma plataforma com memória, processador e outros recursos totalmente virtuais, sem dependência do hardware. 

A JVM é uma máquina virtual que executa programas Java, executando os bytecodes em linguagem de máquina para cada sistema operacional. 
Em linguagens compiladas diretamente para um sistema operacional (SO) específico, esse programa não irá executar em outro SO, havendo a necessidade de compilar uma versão do software para cada SO. 
Com o Java, compilamos para a JVM, o bytecode será executado pela máquina virtual, e não diretamente pelo SO, assim, o software escrito em Java possui portabilidade para qualquer sistema operacional, porém, cada JVM deve ser construída para um SO específico. 

![image-20210716220354217](https://i.loli.net/2021/07/17/j9IKyUZ48PT72Ge.png)

* O que é JRE?

JRE significa Java Runtime Environment, ou Ambiente de Execução do Java, é composto pela Java Virtual Machine (JVM), bibliotecas e APIs da linguagem Java e outros componentes para suporte da plataforma Java. 
Ele representa a parte responsável pela execução do software Java.



* O que é JDK?

Java Development Kit (JDK), Kit de Desenvolvimento Java, é um conjunto de utilitários que permitem criar software para a plataforma Java. É composto pelo compilador Java, bibliotecas da linguagem, ferramentas e a JRE. 



* O que é Java SE?

Java Standard Edition (SE), é a distribuição mínima da plataforma de desenvolvimento de aplicações Java. 
OpenJDK é a implementação de referência opensource da Plataforma Java, Java SE, que ainda é mantida pela Oracle. 



* O que é Java EE?

Java Enterprise Edition, é uma extensão da Java SE que possui suporte a desenvolvimento de sistemas corporativos. 
Além do mínimo da plataforma, o Java EE possui diversas especificações de partes da infra estrutura de aplicações, como acesso a banco de dados, mensageria, serviços web, parser de arquivos e outras. 
Servidores de Aplicações Java EE, sabem seguir essas especificações e implementar os recursos para os usuários.

Ex.: JBoss (RedHat), Weblogic (Oracle), WebSphere (IBM) e Glassfish = Implementação de Referência Opensource : https://javaee.github.io/glassfish 



* O que é Jakarta EE?

Com a falta de investimento da Oracle no Java, ela cedeu todo o código, implementações e especificações do Java EE para a Eclipse Foundation, mas como o nome Java EE é uma marca registrada, foi escolhido o nome Jakarta EE. 
Agora a evolução da especificações e padrões do Java será feito sob o nome Jakarta EE, com compatibilidade com o Java EE. 



## Módulo 2 - Características da Linguagem



### Aula 1) Iniciando um projeto Java

Github do professor: https://github.com/andrelugomes/digital-innovation-one



#### Classes

Todo programa Java roda em cima de uma classe e toda classe tem um nome.

* Main
* Atributos
* Métodos
  * Retornos
  * Parâmetros
  * Assinatura
* Construtores

Exemplos:

```java
package one.digitalinnovation.classes; // Onde a classe está localizada

// modificador_de_acesso class nome_do_programa
public class Programa {
	// método principal para executar um programa em java
    public static void main(String[] args) { // Método principal para executar um programa em Java
	// String[] args -> assinatura do método
        System.out.println("Hello world!");
    }

}
```

```java
package one.digitalinnovation.classes.usuario;

public class SuperUsuario {
	
    // Atributos
    private String login;
    private String senha;
    String nome;
	
    // Construtor da classe: leva o nome da classe e fala como instanciar a classe ao criar um objeto dela
    public SuperUsuario(final String login, final String senha) {
        this.login = login;
        this.senha = senha;
    }
	
    // Métodos
    
    public String getLogin() {

        return login;
    }

    protected String getSenha() {

        return senha;
    }

}
```

```java
package one.digitalinnovation.classes.usuario;

public class ProgramaDoSuperUsuario {
	
    // Main onde cria um usuario novo
    public static void main(String[] args) {
        final var superUsuario = new SuperUsuario("root", "1234%$#@");


        superUsuario.getLogin();

        superUsuario.getSenha();

        String root = superUsuario.nome;

    }

}
```



### Aula 2) Tipos primitivos, wrappers, não primitivos, tipagem forte e tipagem estática



#### Tipos primitivos

São divididos em alguns grupos:

![Tipos primitivos do Java.](https://i.loli.net/2021/07/17/82RXE4qFLyJt9Ue.png)

<sup>Fonte: http://www.universidadejava.com.br/materiais/java-tipos-primitivos/</sup>

```java
package one.digitalinnovation.tipos.primitivos;

public class Primitivos {

    public static void main(String[] args) {
        //INTEIROS

        //byte nullByte = null;

        byte b;             //8 bits
        byte b1 = 127;
        byte b2 = -128;
        //byte b3 = 129;    //to large

        char c;             //16 bits
        char c1 = 'A';
        char c2 = 15;
        //char c3 = 'AA';   //NOK
        //char c4 = -100;   //NOK

        short s;    //16 bits
        short s1 = 32767;
        short s2 = -32768;

        int i = 2147483647;     //32 bits
        int i2 = -2147483648;
        //int i3 = -2147483649; //to large


        long l = 9223372036854775807l;      //64 bits
        long l2 = -9223372036854775808L;
        //long l3 = 9223372036854775808L;   //to large

        //FLUTUANTES

        float f = 65f;      //32 bits    3.402,823,5 E+38
        float f2 = 65.0f;
        float f3 = -0.5f;   //1.4 E-45

        
        double d = 1024.99;  //64 bits  1.797,693,134,862,315,7 E+308
        double d2 = 10.2456; // 4.9 E-324

        //Boleano

        boolean bo = true;
        boolean bo2 = false;
        //boolean bo3 = "false";  //NOK
        //boolean bo4 = 'true';   //NOK


        //void v; //palavra reservada


        //System.out.println("byte : " + b); //ERROR

    }

}
```

Tipos primitivos não aceitam atribuição de valor NULL, eles possuem valores padrão (default):

![image-20210717104123267](https://i.loli.net/2021/07/17/S3JZKCIFgmc2B8q.png)



#### Wrappers

São os objetos que representam os tipos primitivos do Java.

```java
package one.digitalinnovation.tipos.wrappers;

public class Wrappers {

    public static void main(String[] args) {
        //Autoboxing: Os tipos não são mais primitivos, pois eles iniciam com letra maiúscula, simbolizando
        //que são classes. Além disso, o autoboxing faz com que não seja necessário escrever 'new' antes
        //de instanciar o objeto

        Byte b = 127;   //byte
        Byte b2 = -128;
        Byte nullByte = null;

        Character c = 'A'; //char
        Character c2 = 15;

        Short s = 32767; //short
        Short s2 = -32768;

        Integer i = 2147483647;  //int
        Integer i2 = -2147483648;

        Long l = 9223372036854775807L; //long
        Long l2 = -9223372036854775808L;

        Float f = 65f; //float
        Float f2 = 65.0f;
        Float f3 = -0.5f;

        Double d = 1024.99;  //Double
        Double d2 = 10.2456;

        Boolean bo = true;  //boolean
        Boolean bo2 = false;

        Boolean bo3 = Boolean.getBoolean("false");  //OK
        Boolean bo4 = Boolean.valueOf("true");   //OK
        
    }

}
```

```java
package one.digitalinnovation.tipos.naoprimitivos;

public class Unboxing {
	
    public static void main(String[] args) {
        // Unboxing: dada uma classe, um wrapper de um objeto primitivo, é possível atribuir o valor absoluto
        // de um objeto a um tipo primitivo
        
        int i = new Integer(3); // Depreciado desde a versão 9 do java

        int inteiro = Integer.valueOf(1024);

        //boolean b = new Boolean(true);
        boolean b2 = Boolean.TRUE;
        boolean b3 = Boolean.getBoolean("false");

    }

}
```



#### Não primitivos

```java
package one.digitalinnovation.tipos.naoprimitivos;

public class NaoPrimitivos {

    public static void main(String[] args) {

        String texto = "Meu texto para apresentação"; //Sequência de caracteres

        Void v; //Tipo válido

        Object o = new Object();

        Number numero = Integer.valueOf(100);

        numero.toString();
    }

}
```



#### Tipagem estática

Os tipos são verificados em tempo de compilação.

Exemplo:

```java
package one.digitalinnovation.tipos.tipagem;

public class TipagemEstatica {

    public static void main(String[] args) {

        Integer numero = "123456789"; //ERROR: a propria IDE avisa antes e na compilação

    }

}
```



#### Tipagem forte

Uma vez que um tipo foi atribuído a uma variável, não é possível mudá-lo.

```JAVA
package one.digitalinnovation.tipos.tipagem;

public class TipagemForte {

    public static void main(String[] args) {

        String texto = "meu texto";

        texto = 1000; //ERRO

        Integer numero = Integer.valueOf("1024");

        numero = 512; //OK
    }

}
```



#### Tipo inferido

É possível criar variáveis sem atribuir de forma explícita o tipo. Palavra reservada ```var```

```java
package one.digitalinnovation.tipos.tipagem;

public class TipoInferido {

    public static void main(String[] args) {

        var numero = Integer.valueOf("123456");

        var texto = "O Numero é : " ;

        System.out.println(texto + numero);

    }

}
```



### Aula 3) Modificadores de acesso



#### Public

Public pode ser acessada de qualquer lugar por qualquer entidade que possa visualizar a classe a que ela pertence. 



#### Private

Os métodos e atributos da classe definidos como privados não podem ser acessados ou usados por nenhuma outra classe. Esses atributos e métodos também não podem ser visualizados pelas classes herdadas. 



#### Protected

O protected faz com que o método ou atributo não possa ser acessado por classes de pacotes diferentes.



#### Default

Semelhante ao protected, mas ele não é declarado.



Exemplo:

```java
package one.digitalinnovation.classes.usuario;

public class SuperUsuario {

    private String login; // Login e senha não estão acessíveis fora da classe.
    private String senha;
    String nome; // valor default: acessível para classes do mesmo pacote

    public SuperUsuario(final String login, final String senha) {
        this.login = login;
        this.senha = senha;
    }

    public String getLogin() { // Como é publico, é possível acessá-lo de qualquer outra classe

        return login;
    }

    protected String getSenha() { // O protected faz ser possível o acesso apenas para classes do mesmo pacote

        return senha;
    }

}
```



#### Abstract

Esse modificador não é aplicado nas variáveis, apenas em classes e métodos. Uma classe abstrata não pode ser instanciada. Se houver alguma declaração de um método como abstract (abstrato), a classe também deve ser marcada como abstract. 



```java
package one.digitalinnovation.abstracts;

public abstract class FormaGeometrica {

    public abstract String nome();
    public abstract Double area();

    public String desenha(int x , int y) {
        return "Desenhando nas coordenadas X="+x+" Y:"+y;
    }
}
```



Utilizando a classe abstrata



```java
package one.digitalinnovation.abstracts;

public class Quadrado extends FormaGeometrica {

    private String nome;
    private Double area;

    public Quadrado(final String nome, final Double area) {
        this.nome = nome;
        this.area = area;
    }

    @Override
    public String nome() {

        return nome;
    }

    @Override
    public Double area() {
        return area;
    }

    @Override
    public String toString() {
        final StringBuilder builder = new StringBuilder()//
                .append("Quadrado [")//
                .append("nome=\"")//
                .append(nome).append("\"")//
                .append(",area=")//
                .append(area)//
                .append("]");
        return builder.toString();
    }
}
```



#### Static

É usado para a criação de uma variável que poderá ser acessada por todas as instâncias de objetos desta classe como uma variável comum, ou seja, a variável criada será a mesma em todas as instâncias e quando seu conteúdo é modificado numa das instâncias, a modificação ocorre em todas as demais. E nas declarações de métodos ajudam no acesso direto à classe, portanto não é necessário instanciar um objeto para acessar o método. 

```java
package one.digitalinnovation.statics;

public class Cachorro {

    //public String zoologia = "Quadrupede"; //Uma instância
    public static String zoologia = "Quadrupede"; //Todas instâncias

    public static String late() {
        return "Au!Au!";
    }

}
```



#### Final

Quando é aplicado na classe, não permite estender, nos métodos impede que o mesmo seja sobrescrito (overriding) na subclasse, e nos valores de variáveis não pode ser alterado depois que já tenha sido atribuído um valor. 



### Aula 4) Métodos abstratos, métodos default e herança múltipla



#### Métodos abstratos

Devem ser implementados por todos. Novos métodos quebram as implementações.



#### Métodos default

São herdados a todos que implementam. Novos métodos não quebram as implementações.



#### Interfaces

Exemplo: Interface de um carro

```java
package one.digitalinnovation.interfaces;

public interface Carro{

    String marca(); // Método abstrato. Modificador de acesso implícito: classe public, método public
    Double valor();

    default void ligar() {
        System.out.println("Ligando o carro!");
    }

    default String codigoRenavan() {
        return "6533jijiio";
    }

}
```



Classe Gol

```java
package one.digitalinnovation.interfaces;

// A classe Gol implementa Carro, logo, a classe Gol É um Carro
public class Gol implements Carro {

    @Override
    public String marca() {
        return "Volkswagen";
    }

    @Override
    public Double valor() {
        return null;
    }
}
```

Ao implementar uma classe, é obrigatório implementar e sobrescrever todos os métodos dessa classe. Não é necessário sobrescrever o método default, pois ele é herdado.



Exemplo 2: Interface de veículo

```java
package one.digitalinnovation.interfaces;

public interface Veiculo {

    String registro();

    default void ligar() {

        System.out.println("Ligando o veículo!");
    }

    //void desligar();

    /*default void desligar() {
        System.out.println("Desligando o veículo!");
    }*/
}
```



Classe trator:

```java
package one.digitalinnovation.interfaces;

public class Trator implements Veiculo {

    @Override
    public String registro() {
        return "AWD12387465GFDA";
    }
}
```



<b>Herança Múltipla</b>

Classe Fiesta:

```java
package one.digitalinnovation.interfaces;

public class Fiesta implements Carro, Veiculo {

    @Override
    public String marca() {
        return "Ford";
    }

    @Override
    public Double valor() {
        return null;
    }

    @Override
    public String registro() {
        return "123AFG547TR";
    }

    @Override
    public void ligar() {
        //codigo

        Carro.super.ligar();

        Veiculo.super.ligar();
    }
}
```

A classe Fiesta é, portanto, um carro e ao mesmo tempo um veículo, sendo necessário criar os métodos de ambas as interfaces. A herança múltipla garante uma boa abstração.

A Interface realiza um contrato com suas implementações, pois caso algum método da interface seja criado, será necessário implementá-lo em todas as classes que são a interface. Isso não se aplica para métodos default, pois as classes herdam o comportamento default automaticamente.

Caso a classe implemente um método com nome igual de duas interfaces diferentes, o método deve ser implementado uma única vez, misturando os dois métodos, delegando qual método de qual classe utilizar ou implementando algo diferente.



#### Enums

Basicamente são dicionários de dados imutável onde não é permitido criar novas instâncias. O construtor é sempre declarado como private e, por convenção, por serem objetos constantes e imutáveis (static final), os nomes são em MAIÚSCULOS. 



Exemplos: TipoVeiculo e Status

```java
package one.digitalinnovation.enums;

public enum  TipoVeiculo {

    TERRESTRE,
    AQUATICO,
    AEREO

}
```

```java
package one.digitalinnovation.enums;

public enum Status {
    OPEN(13, "Aberto"),
    CLOSE(02, "Fechado");

    private int cod;
    private String texto;

    Status(final int cod, final String texto) {

        this.cod = cod;
        this.texto = texto;
    }

    public int getCod() {
        return cod;
    }

    public String getTexto() {
        return texto;
    }
}
```



##  Módulo 3 - Características da Linguagem II



### Aula 1) String e o pacote java.lang



#### Strings

É uma classe que representa uma sequência de caracteres, contida no pacote java.lang.

```java
package strings;

public class Strings {

  public static void main(String[] args) {

    var nome = "André";
    var sobreNome = "Gomes";
    final var nomeCompleto = nome + sobreNome;

    System.out.println(nome);
    System.out.println("Nome do cliente : " + nome);
    System.out.println("Nome completo do cliente : " + nomeCompleto);
    var string = new String(" Minha  String ");

    System.out.println("Char na posição : " + string.charAt(5));
    System.out.println("Quantidade=" + string.length());
    System.out.println("Sem Trim [" + string + "]");
    System.out.println("Com Trim [" + string.trim() + "]");
    System.out.println("Lower " + string.toLowerCase());
    System.out.println("Upper " + string.toUpperCase());
    System.out.println("Contém M? " + string.contains("M"));
    System.out.println("Contém X? " + string.contains("X"));
    System.out.println("Replace " + string.replace("n", "$"));
    System.out.println("Equals? " + string.equals(" Minha String "));
    System.out.println("EqualsIgnoreCase? " + string.equalsIgnoreCase(" minha sTrinG "));
    System.out.println("Substring(1,6)=" + string.substring(1, 6));
    System.out.println("A B C D E F G".toCharArray());
    System.out.println("Aula de java".split(" "));
    System.out.println("Aula".concat(" de Java"));
    System.out.println("1234 asda qw".replaceAll("[0-9]","#"));

  }
}
```

Dentro de algumas funções de string, temos o regex (regular expression), que são sequencias de caracteres que formam um padrão de busca.



### Aula2) Laços, Condicionais e Operadores

* IF, IF Ternário
* FOR
* While, Do/While
* Operadores
  * Igualdade: ```==```
  * Lógicos
  * Incremento: ```++/--```
  * Matemáticos
  * Relacionais



#### If

Exemplo:

```java
package ifs;

public class IF {

  public static void main(String[] args) {

    final var condicao = false;

    if (condicao) {
      System.out.println("A condição é verdadeira");
    } else {
      System.out.println("A condição é falsa");
    }

    if (condicao)
      System.out.println("Uma única linha..."); // Quando tem uma única linha

    final var ternario = condicao ? "é verdadeira" : "é falsa"; // Ternário

    System.out.println(ternario);
  }
}
```



#### Igualdade

```java
package operadores;

public class Igualdade {

  public static void main(String[] args) {

    final var numero = 11;

    if (numero == 10) {
      System.out.println("O número é 10");
    } else {
      System.out.println("O número  não é 10");
    }

    if (numero != 10) {
      System.out.println("O número não é 10");
    } else {
      System.out.println("O número é 10");
    }

    final var letra = "B";

    if ("A".equals(letra)) {
      System.out.println("É a letra A");
    }

    if (!letra.equals("A")) {
      System.out.println("Não é a letra A");
    }
  }
}
```



#### Operadores Matemáticos

```java
package operadores;

public class Matematicos {

  public static void main(String[] args) {

    System.out.println(0 + 1);

    System.out.println(3 - 1);

    System.out.println(3 * 1);

    System.out.println(8 / 2);

    System.out.println(8 % 2); //módulo - resto da divisão

    var numero = 10;
    numero *= 2;
    System.out.println(numero);

  }
}
```



#### Operadores Relacionais

```java
package operadores;

public class Relacionais {

  public static void main(String[] args) {

    final var numero = 6;

    if (numero > 20) {
      System.out.println("O número é maior que 20");
    } else if (numero >= 10) {
      System.out.println("O número é maior ou igual a 10");
    } else if (numero <= 5) {
      System.out.println("O número é menor ou igual que 5");
    } else {
      System.out.println("nenhuma da anteriores");
    }
  }
}
```



#### Operadores Lógicos

```java
package operadores;

public class Logicos {

  public static void main(String[] args) {

    final var numero = 2;
    final var letra = "A";

    //Sort Circuit
    if (numero < 5 && letra.equals("A")) {
      System.out.println("Atendeu a condição");
    }

    if (numero < 5 || letra.equals("A")) {
      System.out.println("Atendeu a outracondição");
    }

    if ((10 - 5) > 1 && (5 - 3) > 1) {
      System.out.println("Lógica maluca...");
    }

    //Non Sort Circuit
    /*if (verifica(15) | verifica("A")) {
        System.out.println("OK");
    } else {
        System.out.println("Não OK");
    }*/

  }

  private static boolean verifica(String letra) {
    System.out.println("Verificando letra...");
    return letra.equals("A");
  }

  private static boolean verifica(Integer numero) {
    System.out.println("verificando numero...");
    return numero > 10;
  }
}
```



#### Incremento

```java
package operadores;

public class Incremento {

  public static void main(String[] args) {

    var numero = 1;

    System.out.println(++numero);

    var variavel = 10;

    System.out.println(variavel--);
    System.out.println(variavel);
  }
}
```





### Aula 3) Laços, Condicionais e Operadores II



#### Laço For

```java
package fors;

public class For {

  public static void main(String[] args) {

    for (int i = 0; i <= 10; i = i + 1) {
      System.out.println("I=" + i);
    }

    for (int x = 0; x <= 5; x++)
      System.out.println("X=" + x);
    
  }

}
```



#### Laço While

```java
package whiles;

public class While {

  public static void main(String[] args) {

    var x = 0;

    //Testa a condição antes
    while (x < 1) {
      System.out.println("Dentro do while...");
      x++;
    }

    var y = 0;

    //Testa a condição depois
    do {
      System.out.println("Dentro do do/while...");
    } while (y++ < 1);
  }

}
```



### Aula 4)  Convenções de nomes



* Nomes de classes:
  * Nome único: primeira letra maiúscula. Exemplo: ```class Automovel```
  * Nome composto: camel case. Exemplo:  ```class NomeComposto```
* Nomes de métodos:
  * Nome único: letras minúsculas. Exemplo: ```private static boolean metodo```
  * Nome composto: primeira letra maiúscula e o resto minúscula. Exemplo: ```nomeDoMetodo```
* Nomes de variáveis:
  * Nome único: letras minusculas. Exemplo: ```variavel```


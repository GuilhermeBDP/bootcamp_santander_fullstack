programa
{
	
	funcao inicio()
	{
		escreva("1 - Abrir Netflix" + "\n" + "2 - Abrir Amazon Prime" + "\n" + "3 - Abrir HBO GO" + "\n" + "4 - Sair")
		inteiro menu = 0
		escreva("\n" + "Sua opcao:")
		leia(menu)
		
		/*
		se (menu==1){
			escreva("OK! Abrir Netflix!")
		}
		se (menu==2){
			escreva("OK! Amazon Prime!")
		}
		se (menu==3){
			escreva("OK! Abrir HBO GO!")
		}
		se (menu==4){
			escreva("OK! Sair!")
		}
		*/

		escolha (menu) {

		caso 1:
		escreva("OK! Abrir Netflix!")
		pare
		
		caso 2:
		escreva("OK! Amazon Prime!")
		pare

		caso 3:
		escreva("OK! Abrir HBO GO!")
		pare

		caso 4:
		escreva("OK! Sair!")
		pare

		caso contrario:
		escreva("Voce deve escolher as opcoes 1, 2, 3 ou 4!")

		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 417; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
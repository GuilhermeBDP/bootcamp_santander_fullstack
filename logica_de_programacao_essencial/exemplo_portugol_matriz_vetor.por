programa
{
	
	funcao inicio()
	{
		cadeia nomes[10]
		cadeia nome
		inteiro indice = 0
		
		
		faca{
			escreva("Digite um nome: ")
			leia(nome)
			nomes[indice] = nome
			indice ++
		}enquanto (indice < 10)

		indice = 0
		
		faca{
			escreva(nomes[indice])
			indice ++
		}enquanto (indice < 10)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 208; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
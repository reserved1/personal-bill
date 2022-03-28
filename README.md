
# Gerenciador de Contas CHA2

O projeto é um modelo teste, criado para estudo de linguagem Swift,
Se trata de um controle de contas simplificado, onde armazeno algumas informações de contas de casa
Para saber se já as paguei ou não.
# Documentação

## Como Baixar?

Basta clonar o reposítorio e clicar no executável.
clone: https://github.com/reserved1/personal-bill.git

## Utilizando o Programa

O programa possui um menu de entrada com 4 opções de interação:
1 - Cadastrar Conta
2 - Alterar Conta
3 - Apagar Conta
4 - Exibir Conta

As Opções devem ser escolhidas baseadas nos números;
1, 2, 3 ou 4.

** Ao escolher alguma opção fora as oferecidas o programa retorna ao menu de entrada.
** Ao escolher alguma opção fora as oferecidas no menu de entrada o programa encerra.


## Cadastrar Conta

Ao escolher cadastrar conta, perguntas serão feitas a respeito da conta;
Em sequência serão:
- Digitar o Código de Barra da Conta;
- Descrição da Conta;
- Digitar o Estado da Conta;
- Digitar o Valor da Conta;

** Código de Barra: É uma série de characteres que serão tratados como String, utilizados como
identificador único da conta.

** Descrição da Conta: É uma String utilizada para lembrete da conta, como Conta de Água, Conta de Luz e afins.

** Estado da Conta: É a condição da conta como Paga ou Não Paga, para controle de pagamento(String também).

** Valor da Conta: É o Valor numérico do custo da conta em tipo Double.

## Alterar Conta

Ao escolher alterar conta, é pedido o Código de Barra da Conta para achá-la.
Caso a conta seja encontrada, um menu se abre perguntando qual dado deverá ser alterado, após isso um novo dado é pedido(para sobrepor o anterior).
Caso a conta não seja encontrada, ele retorna ao menu de entrada.

## Apagar Conta

Ao escolher apagar conta, é pedido o Código de Barra da Conta para achá-la.
Caso a conta seja encontrada, a mesma é removida e retorna pro menu de entrada.
Caso a conta não seja encontrada, o programa retorna ao menu de entrada.

## Exibir Conta

Ao escolher exibir conta, um menu de exibição aparece, listando as opções:

- Exibir Todas as Contas
- Exibir Contas Não Pagas
- Exibir Contas Pagas
- Voltar

** Exibir Todas as Contas: Mostrará na tela todas as contas cadastradas no programa.

** Exibir Contas Não Pagas: Mostrará na tela todas as contas cadastradas no programa com o estado de Não Paga.

** Exibir Contas Pagas: Mostrará na tela todas as contas cadastradas no programa com o estado de Paga.

** Voltar: Retornará ao menu de entrada.
## Autores

- [@reserved1](https://github.com/reserved1/)

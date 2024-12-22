# Vault Vulnerável

## Fundo
Um novo protocolo de finanças descentralizadas (DeFi) surgiu, prometendo altos rendimentos e gerenciamento seguro de ativos. No coração deste protocolo está o VulnerableVault, uma implementação do ERC-4626 Tokenized Vault Standard. O cofre rapidamente ganhou popularidade, com muitos usuários depositando ansiosamente seus tokens suados.

## Sua Missão
Você é um hacker habilidoso que tem analisado secretamente o contrato inteligente do VulnerableVault. Após dias de escrutínio, você descobriu uma vulnerabilidade crítica que poderia colocar todos os fundos dos depositantes em risco. No entanto, simplesmente relatar a vulnerabilidade pode não ser suficiente para convencer os desenvolvedores excessivamente confiantes do protocolo.

Sua missão, se você optar por aceitá-la, é explorar eticamente a vulnerabilidade para demonstrar sua gravidade. Seu objetivo é drenar uma parte significativa dos fundos do cofre, visando especificamente uma vítima de alto perfil que recentemente depositou 10.000 tokens.

## Objetivos
  1. Explorar a vulnerabilidade no contrato VulnerableVault.
  2. O jogador deve ter ganho mais de 100 tokens (o token tem 18 decimais).
  3. O Vault deveria ter perdido mais de 100 tokens.
  4. Complete o exploit em uma única transação (dentro da função `testExploit()`).

## Recursos ao Seu Disposição
  - Você começa com 1.000 tokens em sua carteira.
  - Você tem acesso total ao código-fonte do VulnerableVault.
  - O cofre atualmente possui 10.000 tokens depositados pela vítima.

## Restrições
  - Você deve trabalhar dentro dos limites da Máquina Virtual Ethereum (EVM).
  - Você não pode modificar o contrato VulnerableVault em si.
  - Seu exploit deve ser executado por meio de interações com a interface pública do cofre.
  - Você só pode usar o player endereço no teste, você não pode brincar com outros endereços.

## Dicas
  - Preste muita atenção à implementação das funções de depósito e retirada.
  - A relação entre ativos e ações nos cofres ERC-4626 é crucial.
  - Pense em como você pode manipular a taxa de câmbio entre ativos e ações.

## Considerações Éticas
Lembre-se, em um cenário do mundo real, explorar vulnerabilidades para ganho pessoal é ilegal e antiético. Este desafio é uma simulação projetada para ajudá-lo a entender e prevenir tais vulnerabilidades no futuro.

Boa sorte, os usuários do hacker.estão contando com você para expor essa vulnerabilidade antes que atores mal-intencionados reais possam explorá-la!
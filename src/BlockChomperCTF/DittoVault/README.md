# O Desafio DittoVulnerableVault
Bem-vindo, aspirante a especialista em segurança blockchain! Você foi encarregado de auditar um novo protocolo DeFi chamado DittoVault. O protocolo afirma oferecer aos usuários uma maneira de depositar seus tokens e ganhar recompensas através de um mecanismo de negociação exclusivo. No entanto, há sussurros na comunidade de criptografia de que algo pode estar errado com sua implementação.

## Fundo
O DittoVault permite que os usuários:

  1. Deposite tokens no cofre
  2. Execute negociações com um recurso especial de "desconto"
  3. Retire seus tokens (esperançosamente com lucros)

O cofre está ativo há uma semana, e cinco adotantes iniciais (endereços de 0x1 a 0x5) depositaram 100 tokens ether cada.

## Sua Missão
Como um hacker, seu objetivo é investigar o contrato inteligente do DittoVault e determinar se há alguma vulnerabilidade que possa ser explorada. Se você encontrar uma vulnerabilidade, precisará demonstrar como ela pode ser usada para drenar uma parte significativa dos ativos do cofre.

## Critérios de Sucesso
Você será considerado bem sucedido se puder:

  1. Identificar a vulnerabilidade no contrato
  2. Desenvolva uma exploração que permita lucrar mais de 25% da oferta total inicial

## Ferramentas à Sua disposição
  - O código fonte completo do contrato DittoVault
  - Um ambiente de teste onde você pode interagir com o contrato
  - Seu conhecimento sobre vulnerabilidades Solidity e DeFi

## Considerações Éticas
Lembre-se, este é um ambiente controlado para fins educacionais. No mundo real, sempre divulgue vulnerabilidades de forma responsável e nunca as explore para ganho pessoal.

## Dica
Preste muita atenção em como as taxas são calculadas e distribuídas na função `executeTrade()`. Pode haver uma maneira de manipular esse mecanismo a seu favor.

Boa sorte !
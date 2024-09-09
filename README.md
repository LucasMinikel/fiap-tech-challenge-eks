# Tech Challenge EKS

Este projeto implementa uma infraestrutura EKS (Elastic Kubernetes Service) na AWS usando Terraform.

## Requisitos

Para executar este projeto localmente, você precisa ter:

1. Terraform instalado
2. AWS CLI instalado
3. AWS CLI configurado com suas credenciais

## Configuração do AWS CLI

Antes de começar, certifique-se de que o AWS CLI está configurado corretamente:

## Executando o Terraform

Siga estes passos para planejar, aplicar e destruir a infraestrutura:

### Plan

1. Navegue até o diretório do projeto
2. Execute o comando:
   ```
   terraform plan
   ```
3. Revise o plano de execução

### Apply

1. Para aplicar as mudanças, execute:
   ```
   terraform apply
   ```
2. Digite 'yes' quando solicitado para confirmar

### Destroy

1. Para destruir a infraestrutura, use:
   ```
   terraform destroy
   ```
2. Confirme digitando 'yes' quando solicitado

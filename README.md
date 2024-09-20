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

## Configuração das Credenciais da AWS

Para que o Terraform possa interagir com a AWS, é necessário configurar as seguintes variáveis de ambiente com suas credenciais da AWS:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION`

Você pode configurar essas variáveis no seu ambiente local ou no seu pipeline de CI/CD.

## Criação de um Bucket S3 para o Estado do Terraform

O estado do Terraform será armazenado em um bucket S3. Para criar este bucket, execute o seguinte comando:

aws s3api create-bucket --bucket minikel-eks-tfstate --region sa-east-1 --create-bucket-configuration LocationConstraint=sa-east-1

## Comandos Executados no GitHub Actions

O pipeline de CI/CD no GitHub Actions executa os seguintes comandos:

1. **`terraform init`**: Inicializa o Terraform e configura o backend para armazenar o estado no bucket S3.
2. **`terraform plan`**: Gera um plano de execução mostrando as mudanças que serão aplicadas na infraestrutura.
3. **`terraform apply`**: Aplica as mudanças na infraestrutura conforme o plano gerado.

Esses comandos são executados nas seguintes etapas do GitHub Actions:

- **`terraform init`**: Executado na etapa de inicialização do pipeline.
- **`terraform plan`**: Executado após a inicialização para verificar as mudanças.
- **`terraform apply`**: Executado após a aprovação do plano para aplicar as mudanças.

Certifique-se de que as credenciais da AWS estejam configuradas corretamente no GitHub Actions para que esses comandos possam ser executados com sucesso.

# FIAP Tech Challenge EKS - Automação com Terraform

Este repositório tem como objetivo automatizar a infraestrutura do desafio de integração com o AWS EKS usando Terraform, juntamente com uma CI/CD pipeline via GitHub Actions.

## Passo a Passo para Utilização do Repositório

### 1. Fazer um Fork
Primeiro, faça um fork deste repositório para sua conta do GitHub.

### 2. Criar um Bucket S3 para o State do Terraform

O Terraform utiliza um backend para armazenar o estado da infraestrutura. No AWS, o estado pode ser armazenado em um bucket S3. Para criar o bucket, execute o comando apropriado.

> **Importante:** O nome do bucket deve ser único globalmente na AWS. Substitua `<nome-do-bucket-unique>` por um nome exclusivo.

```bash
aws s3api create-bucket --bucket <nome-do-bucket-unique> --region sa-east-1 --create-bucket-configuration LocationConstraint=sa-east-1
```

Depois de criar o bucket, atualize o arquivo `providers.tf` no bloco de configuração do Terraform com o novo nome do bucket.

```hcl
terraform {
  backend "s3" {
    bucket = "<nome-do-bucket-unique>"
    key    = "terraform/state"
    region = "sa-east-1"
  }
}
```

Isso permitirá que o Terraform use o bucket recém-criado para armazenar o estado da sua infraestrutura. Lembre-se de manter o nome do bucket consistente entre o comando e o arquivo de configuração.

### 3. Criar um Usuário com Permissões no AWS
Crie um usuário no AWS IAM com as permissões necessárias para a execução do Terraform, utilizando a política abaixo. Lembre-se de gerar uma chave de acesso para este usuário.

Política IAM (JSON)
```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": "ec2:*",
			"Resource": "*"
		},
		{
			"Effect": "Allow",
			"Action": "eks:*",
			"Resource": "*"
		},
		{
			"Effect": "Allow",
			"Action": [
				"iam:CreateRole",
				"iam:AttachRolePolicy",
				"iam:PutRolePolicy",
				"iam:GetRolePolicy",
				"iam:CreatePolicy",
				"iam:DeletePolicy",
				"iam:GetPolicy",
				"iam:ListPolicyVersions",
				"iam:GetPolicyVersion",
				"iam:CreateOpenIDConnectProvider",
				"iam:DeleteOpenIDConnectProvider",
				"iam:GetOpenIDConnectProvider",
				"iam:GetRole",
				"iam:ListAttachedRolePolicies",
				"iam:ListRolePolicies",
				"iam:ListInstanceProfilesForRole",
				"iam:PassRole",
				"iam:DetachRolePolicy",
				"iam:DeleteRolePolicy",
				"iam:DeleteRole",
				"iam:TagOpenIDConnectProvider",
				"iam:TagPolicy",
				"iam:UntagOpenIDConnectProvider",
				"iam:UntagPolicy",
				"iam:CreateServiceLinkedRole"
			],
			"Resource": "*"
		},
		{
			"Effect": "Allow",
			"Action": "s3:*",
			"Resource": "arn:aws:s3:::*"
		},
		{
			"Effect": "Allow",
			"Action": "kms:*",
			"Resource": "*"
		},
		{
			"Effect": "Allow",
			"Action": "logs:*",
			"Resource": "arn:aws:logs:*:*:*"
		}
	]
}
```

### 4. Cadastrar as Chaves no GitHub

Para que o Terraform e os workflows do GitHub Actions funcionem corretamente, será necessário cadastrar as credenciais da AWS no repositório do GitHub. Siga os passos abaixo:

1. No repositório GitHub, acesse **Settings** > **Secrets and variables** > **Actions** > **New repository secret**.
2. Adicione as seguintes chaves e valores:

- `AWS_ACCESS_KEY_ID`: Sua chave de acesso (Access Key ID) da AWS.
- `AWS_SECRET_ACCESS_KEY`: Sua chave secreta (Secret Access Key) da AWS.

Essas chaves serão utilizadas para autenticar o Terraform no AWS durante os workflows.

---

## GitHub Actions

Este repositório contém três workflows principais para automatizar a criação e destruição de infraestrutura usando Terraform, além de validar mudanças via pull requests.

### 1. **Terraform Plan (Pull Request)**

Esse workflow é acionado automaticamente sempre que uma pull request é aberta ou modificada na branch `main`. Ele segue as mesmas etapas de inicialização e validação dos outros workflows, mas ao invés de aplicar as mudanças, ele:

- **Checkout do repositório**: Clona o repositório.
- **Configuração da AWS CLI**: Autentica a AWS CLI.
- **Setup Terraform**: Configura o ambiente com a versão especificada do Terraform.
- **Inicializar Terraform**: Executa `terraform init`.
- **Formatar e Validar Configurações**: Formata e valida os arquivos Terraform.
- **Gerar Plano de Execução**: Executa `terraform plan` para exibir o plano de mudanças sem aplicar nada.

### 2. **Terraform Apply**

Este workflow é acionado em qualquer push na branch `main` e executa as seguintes etapas:

- **Checkout do repositório**: Clona o repositório para a execução do pipeline.
- **Configuração da AWS CLI**: Autentica a AWS CLI usando as credenciais fornecidas nos secrets.
- **Setup Terraform**: Configura o ambiente com a versão especificada do Terraform.
- **Inicializar Terraform**: Executa `terraform init` para inicializar o backend de estado.
- **Planejar e Aplicar Infraestrutura**: Gera um plano de execução (`terraform plan`) e aplica automaticamente as mudanças (`terraform apply`).

### 3. **Terraform Destroy**

Este workflow é acionado manualmente (via `workflow_dispatch`) e é responsável por destruir a infraestrutura provisionada. Os passos são:

- **Checkout do repositório**: Clona o repositório.
- **Configuração da AWS CLI**: Autentica a AWS CLI.
- **Inicializar Terraform**: Inicializa o backend para preparar a destruição dos recursos.
- **Verificar Recursos em execução no cluster**: Bloqueia destruição se houver pods em execução no cluster.
- **Destruir Infraestrutura**: Executa `terraform destroy` para remover os recursos provisionados.
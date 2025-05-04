# 🚀  Estudos Terraform - Aws

- [1) AWS](#1-aws)
  - [1.1) Configure Account](#11-configure-account)

## 1) AWS

Este projeto, conterá exemplos práticos de como usar ***Terrafor/Terragrunt*** em uma cloud AWS. Acredito que as funcionalidades descritas aqui, podem ser facilmente adaptada para outras clouds.

### 1.1) Configure Account

As imagens abaixo, nos auxiliará a configurar um usuário no ***IAM*** com previlégios de Administrador, bem como deixa-lo seguro com ativação de MFA.

Uma vez criado a conta, vamos personaliza-la. Clique no menu ***Account*** como mostrado abaixo.

![alt text](_docs/img/root-account/1-Account.png "Root Account")

Ativar o Billing para usuários do **IAM**

![alt text](_docs/img/root-account/2-Account.png "Root Account")

Defina um Grupo e atache as permissões de Administrador para ele...

![alt text](_docs/img/root-account/3-Account.png "Root Account")

Crie e Atache um usuário para administrar sua account... Esse usuário também é importante ativar ***MFA***

![alt text](_docs/img/root-account/4-Account.png "Root Account")

Ainda logado como ***root***, vamos ativar MFA na conta do Root.

![alt text](_docs/img/root-account/5-Account.png "Root Account")

![alt text](_docs/img/root-account/6-Account.png "Root Account")

Para mantermos nosso parque sem custo, vamos configurar um ***Budget*** para não termos surpresas.

![alt text](_docs/img/root-account/7-Account.png "Root Account")

![alt text](_docs/img/root-account/8-Account.png "Root Account")

## Terraform

#### Variáveis
---
>**lab-wordpress/terraform/provider.tf**

| Variável | Default | Descrição
| ------ | ------ |  ------ | 
| pvt_key | ~/.ssh/id_rsa | Local de sua chave privada que será copiada para o server |
| pub_key | ~/.ssh/id_rsa.pub | Local de sua chave pública que será inserida no "authorized_keys do server |
| gcp_key | ~/gcp.json | Arquivo de autenticação do Google Cloud |
| project_name | lab-wordpress-cloud | Nome do Projeto no Google Cloud |
| region | us-west1 | Região utilizada no Google Cloud |
| region_zone | us-west1-a | Zona dentro da região |
| fw_name | lab-wordpress-fw | Nome do serviço de Firewall a ser criado no Google Cloud |
| instance_name | lab-wordpress | Nome da instância |
| instance_type | e2-small | Tipo da instância |
| image | ubuntu-1804-bionic-v20210315a | Imagem de Sistema Operacional do Servidor **(Obs: somente Ubuntu 18.04+ permitido, suporte para CentOS em desenvolvimento)**

Cloud Providers compatíveis:
- Google Cloud
- (AWS ainda em desenvolvimento)
- (Azure ainda em desenvolvimento)
- (Digital Ocean ainda em desenvolvimento)

#### Subindo o Projeto
#### Para executar o Projeto em Cloud:
```sh
cd lab-wordpress/terraform
terraform init
terraform plan
```
O comando `terraform plan` mostrará o que será criado durante o projeto, confirme se os dados estão corretos e execute o comando abaixo:
```sh
terraform apply
```
O processo de criação do Projeto seguirá os seguintes passos:
- Criação do servidor;
- Provisionamento de Softwares necessários;
- Configuração do Apache como Proxy Reverso na porta 80
- Criação dos Containers de Banco de Dados e Wordpress

Após a finalização dos passos acima, o script de criação deverá retornar com um endereço de IP público de seu servidor, ao acessar o endereço de IP em algum navegador, a tela de configuração do Wordpress deve aparecer para que você possa utilizá-lo como você preferir. 
O endereço também pode ser acessado via ssh com o usuário `root` e a chave privada definida em `provider.tf`.

Para o ***desligar e destruir*** os recursos em Cloud criados pelo Projeto, executar os passos abaixo:
```sh
cd lab-wordpress/terraform
terraform destroy -force
```
Aparecerá na tela os recursos que serão destruídos, caso esteja de acordo digite `yes` e prossiga com a exclusão.
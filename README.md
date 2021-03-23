# Wordpress Cloud/Local Deployment 

Deploy automatizado de uma aplicação Wordpress com Banco de Dados MySQL em Containers Docker.

## Tecnologias utilizadas

- [Ubuntu 18.04 LTS](https://releases.ubuntu.com/18.04/) - sistema operacional dos servidores criados
- [Terraform](https://www.terraform.io/) - para o provisionamento do servidor em Cloud
- [Vagrant](https://www.vagrantup.com/) - para o provisionamento do servidor em Máquina Virtual Local
- [Docker](https://docs.docker.com/) - para a criação dos Containers de Aplicação e Banco de Dados
- [Ansible](https://docs.ansible.com/) - para o provisionamento de recursos dos Servidores e Deploy da Aplicação
- [Apache](https://httpd.apache.org/) - proxy reverso para o acesso externo à aplicação na porta 80

## Requisitos técnicos para executar o projeto
- [Terraform v0.14.8+](https://www.terraform.io/downloads.html)
- [Virtual Box - v6.1+](https://www.virtualbox.org/wiki/Linux_Downloads)
- [Vagrant 2.2.10+](https://www.vagrantup.com/downloads)
- [Host com ao menos 4 GB de RAM. Recomendado executar em algum sistema Ubuntu-based]

## Instalação

Baixar reposiório:

```sh
git clone https://github.com/xjoohnny/lab-wordpress.git
```

A seguinte estrutura de diretórios será exibida:

>-ansible  - **armazena as playbooks responsáveis pelo provisionamento de recursos e deploy**
>-apache - **armazena os templates de vhost para o proxy reverso**
>-terraform - **arquivos de configuração para o provisionamento em Cloud**
>-vagrant - **arquivos de configuração para o provisionamento em VM**

Criar arquivo de senha Ansible-vault:
```sh
cd lab-wordpress ; echo "sua-senha" >> .vault
```
Este arquivo conterá a senha que você utilizará no Ansible-Vault para encriptar as credenciais de seu Banco de Dados, para alterar a senha default do vault execute os passos abaixo:
```sh
cd lab-wordpress/ansible/playbooks/playbook-setupWordpress/roles/deploy/vars/
ansible-vault decrypt main.vault
```
A senha default deste projeto é **vaultsecret**
Após decriptar e alterar as variáveis conforme sua preferência, execute o comando abaixo para encriptar novamente com sua nova senha:
***ATENÇÃO: esta senha precisa ser a mesma declarada no arquivo .vault que você criou***
```sh
cd lab-wordpress/ansible/playbooks/playbook-setupWordpress/roles/deploy/vars/
ansible-vault encrypt main.vault
```

## Alteração de variáveis
O projeto vem com senhas e variáveis genéricas para facilitar o deploy, portanto, considere verificar os arquivos abaixo e alterar as variáveis para a sua melhor funcionalidade (especialmente os que contém senhas e usuários).
##### Ansible
---
>**lab-wordpress/ansible/playbooks/playbook-setupWordpress/roles/deploy/vars/main.yml**

| Chave | Descrição |
| ------ | ------ |
| DB_PASS | Alterado dentro do arquivo "main.vault", após sua decriptação |
| DB_USER | Alterado dentro do arquivo "main.vault", após sua decriptação |
| MYSQL_ROOT_PASSWORD | Alterado dentro do arquivo "main.vault", após sua decriptação |
| DB_HOST | Hostname do Banco de Dados que o container do Wordpress buscará para conexão **("default: db")**
| DB_NAME | Nome da Base de Dados que o Wordpress se conectará |
| DB_EXTERNAL_PATH |  Local que o Banco de Dados terá seus arquivos persistidos fora do Container **(default: "/opt/db_data")** |
| APP_DIR | Local no SO que conterá os arquivos baixados do Git **(default: "/var/deploy/lab-wordpress")** |
| APP_NAME | Nome da aplicação para facilitar o acesso e manipulação dos Containers |
| GIT_REPO | Endereço do repositório do Git |
| GIT_BRANCH | Branch do repositório a ser baixada |

Sugestão de verificar também o arquivo **lab-wordpress/ansible/playbooks/playbook-setupWordpress/roles/deploy/tasks/after-symlink/main.yml** para verificar outras propriedades do Container.

#### Apache
---
>**lab-wordpress/apache/default-vhost-example.conf**

```sh 
ProxyPass        "/" "http://localhost:8000/" --> alterar porta caso necessário
ProxyPassReverse "/" "http://localhost:8000/" --> alterar porta caso necessário
```
#### Terraform
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

#### Vagrant
---
>**lab-wordpress/vagrant/machines.yml**

| Variável | Default | Descrição
| ------ | ------ |  ------ | 
| name | server01 | Nome do servidor no Virtual Box |
| cpus | 2 | Número de CPUs Alocadas |
| memory | 2048 | Memória RAM Alocada |
| hostname | server01.lab.com | Hostname do Servidor |
| ip | 192.168.55.11 | Endereço de IP do Servidor |
| system | ubuntu/bionic64 | Sistema Operacional do Servidor **(Obs: somente Ubuntu 18.04+ permitido, suporte para CentOS em desenvolvimento)** |
| basic-tools | true (Recomendado) | Instalação de ferramentas básicas de debug *[python, curl, wget, net-tools, git, telnet, software-properties-common]* através do script localizado em ***vagrant/scripts/basic-tools/{versão_do_SO}.sh*** |
| docker | true (Obrigatório) | Instalação do Docker através do script localizado em ***vagrant/scripts/docker/{versão_do_SO}.sh*** 
| ansible | true (Obrigatório) | Instalação do Ansible através do script localizado em ***vagrant/scripts/ansible/{versão_do_SO}.sh*** 
| apache | true (Recomendado) | Instalação do Apache através do script localizado em ***vagrant/scripts/apache/{versão_do_SO}.sh*** 
| nginx | false (Recomendado) | Instalação do Nginx através do script localizado em ***vagrant/scripts/nginx/{versão_do_SO}.sh***. Obs: automação do Deploy com o Nginx ainda em desenvolvimento. |

## Subindo o Projeto
Após a criação do arquivo .vault conforme a documentação e as variáveis terem sido devidamente alteradas, podemos executar o projeto em um Cloud Provider ou em uma Máquina Virtual Local.
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

#### Para executar o Projeto em Máquina Virtual:
```sh
cd lab-wordpress/vagrant
vagrant up
```
O processo de criação do Projeto seguirá os seguintes passos:
- Criação do servidor;
- Provisionamento de Softwares necessários;
- Criação dos Containers de Banco de Dados e Wordpress
- Configuração do Apache como Proxy Reverso na porta 80

Após a finalização dos passos acima, você pode acessar o endereço de IP definido em `machines.yml` em algum navegador, a tela de configuração do Wordpress deve aparecer para que você possa utilizá-lo como você preferir. 
Para acessar o servidor, executar o comando abaixo (dentro da pasta do Vagrant):
```sh
vagrant ssh
```

Para o ***desligar e destruir*** a VM criada pelo Projeto, executar os passos abaixo:
```sh
cd lab-wordpress/vagrant
vagrant destroy -f
```

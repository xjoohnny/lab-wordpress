## Vagrant

#### Variáveis
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

## Iniciando o Lab
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

Repare que, no diretório do Vagrant, serão criados os seguintes arquivos.

Chaves de SSH:

* id_rsa
* id_rsa.pub

Base para /etc/hosts:

* hosts
* .hosts.tmp

*O arquivo .hosts.tmp é um arquivo oculto para armazenamento da identificação das máquinas virtuais, no entanto, já que ele faz parte de um loop, deve conter uma série de valores repetidos - que são filtrados e armazenamos no arquivo hosts.


## Para atualizar o laboratório:

Se você tiver uma nova máquina virtual para o laboratório, resincronize o conteúdo do diretório /vagrant de dentro das VMs com o comando:

```
vagrant rsync
```

A seguir reprovisione as máquinas virtuais que já estão em execução para que elas sincronizem o arquivo /etc/hosts com a identificação da nova VM, usando:

```
vagrant up --provision
```

Para o ***desligar e destruir*** a VM criada pelo Projeto, executar os passos abaixo:
```sh
cd lab-wordpress/vagrant
vagrant destroy -f
```

# Informações do Autor

Criado por [Jonathan Dantas Alves](https://www.linkedin.com/in/jonathandantasalves/).
Forked por [João Vithor - xjoohnny](https://www.linkedin.com/in/jvfogaca/).

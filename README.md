# README

## Pré-requisitos

Antes de começar, certifique-se de ter os seguintes itens instalados:

- [Docker](https://www.docker.com/get-started)
- [Visual Studio Code (VSCode)](https://code.visualstudio.com/)
- Extensão [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) para VSCode

## Configuração do Ambiente de Desenvolvimento

### 1. Clonar o Repositório

```bash 
git clone git@github.com:ninobessa/estudologia.git
cd estudologia
```



### 2. Abrir a Pasta no VSCode com DevContainer

Abra a pasta do projeto no VSCode. Após abrir, você deve ver uma notificação sugerindo que os recursos do contêiner estão disponíveis e perguntando se deseja reabrir o workspace no contêiner.

#### 3.Documentação

Após iniciar a aplicação, você pode visualizar a documentação gerada pelo Swagger acessando o seguinte endereço no seu navegador:

```bash 
http://localhost:8080/swagger-ui.html
```

Isso abrirá a interface do Swagger UI, onde você pode explorar e testar os endpoints da API.

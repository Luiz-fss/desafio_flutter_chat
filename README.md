#  Chat Realtime Flutter

Aplicativo de chat em tempo real desenvolvido em Flutter utilizando Firebase como backend.

O projeto permite cadastro e autenticação de usuários, controle de presença online/offline e troca de mensagens em tempo real entre usuários conectados.

---

#  Funcionalidades

## Autenticação

- Cadastro de novos usuários
- Login utilizando email e senha
- Logout
- Persistência de sessão
- Validação dos campos de entrada
- Tratamento de erros de autenticação


## Usuários

- Listagem de usuários cadastrados
- Identificação de usuários online/offline
- Atualização de presença em tempo real
- Exibição das informações do perfil


## Chat

- Envio de mensagens em tempo real
- Recebimento automático de novas mensagens
- Histórico de mensagens
- Identificação do remetente
- Validação de mensagens vazias


## Presença em tempo real

O aplicativo atualiza automaticamente o status do usuário:

- Ao realizar login -> usuário fica online
- Ao realizar logout -> usuário fica offline
- Ao fechar o aplicativo -> presença é atualizada
- Ao perder conexão -> presença é atualizada
- Ao bloquear o celular -> presença é atualizada


A presença é controlada utilizando recursos realtime do Firebase Firestore.

---

#  Tecnologias utilizadas

## Front-end

- Flutter
- Dart
- Material Design
- Flutter Bloc (Cubit)


## Backend

- Firebase Authentication
- Cloud Firestore


## Principais dependências

| Biblioteca | Utilização |
|---|---|
| flutter_bloc | Gerenciamento de estado |
| firebase_auth | Autenticação de usuários |
| cloud_firestore | Banco de dados realtime |
| equatable | Comparação de estados |
| intl | Formatação de datas |

---

#  Arquitetura

O projeto utiliza uma arquitetura baseada em camadas, buscando separar responsabilidades e facilitar manutenção.

---

#  Gerenciamento de estado

O gerenciamento de estado foi realizado utilizando Cubit (Flutter Bloc).

Responsabilidades:

### CubitAuth

Responsável por:

- Login
- Logout
- Estado da autenticação
- Monitoramento da sessão


### CubitRegister

Responsável por:

- Cadastro do usuário
- Criação do perfil no Firestore


### CubitUsers

Responsável por:

- Buscar usuários
- Atualizar presença
- Usuário atualmente logado
- Lista em tempo real


### CubitChat

Responsável por:

- Escutar mensagens
- Enviar mensagens
- Controle de estado do chat

---

#  Tratamento de erros

O projeto possui uma camada centralizada de tratamento de exceções.

O objetivo é evitar que mensagens internas do Firebase sejam exibidas diretamente ao usuário.

#  Testes

O projeto possui testes unitários para validar regras de negócio e comportamentos importantes da aplicação.

Testes implementados:

- Validação de email e senha;
- Comportamento do Cubit de autenticação;
- Tratamento de cenários de erro.

Para executar os testes, rodar o comando no terminal:
- flutter test

#  Como executar o projeto

## Requisitos

Antes de executar, tenha instalado:

- Flutter SDK
- Dart SDK
- Android Studio ou VS Code
- Emulador Android ou dispositivo físico

---

# Ambiente de desenvolvimento

Projeto desenvolvido utilizando:
- Flutter sdk: 3.44.6
- Dart: 3.12.2
- link para apk:https://drive.google.com/drive/folders/1vhCZlJbhBj9mTfUxHVs6mZK6YsL3aSHq?usp=drive_link
#!/bin/bash

# Função para contar linhas de um arquivo
contar_linhas() {
  echo "Digite o caminho do arquivo:"
  read arquivo

  if [ -f "$arquivo" ]; then
    linhas=$(wc -l < "$arquivo")
    echo "O arquivo '$arquivo' contém $linhas linhas."
  else
    echo "Erro: O arquivo '$arquivo' não foi encontrado."
  fi
}

# Função para verificar a existência de um arquivo
verificar_arquivo() {
  echo "Digite o caminho do arquivo:"
  read arquivo

  if [ -f "$arquivo" ]; then
    echo "O arquivo '$arquivo' existe."
  else
    echo "Erro: O arquivo '$arquivo' não foi encontrado."
  fi
}

# Função para renomear arquivos com uma extensão específica
renomear_arquivos() {
  echo "Digite o caminho do diretório:"
  read diretorio

  echo "Digite a extensão dos arquivos (ex: .txt):"
  read extensao

  echo "Digite o novo prefixo para os arquivos:"
  read prefixo

  if [ -d "$diretorio" ]; then
    contador=1
    for arquivo in "$diretorio"/*"$extensao"; do
      if [ -f "$arquivo" ]; then
        novo_nome="${diretorio}/${prefixo}_${contador}${extensao}"
        mv "$arquivo" "$novo_nome"
        echo "Renomeado: $(basename "$arquivo") -> $(basename "$novo_nome")"
        contador=$((contador + 1))
      fi
    done
    echo "Renomeação concluída!"
  else
    echo "Erro: O diretório '$diretorio' não foi encontrado."
  fi
}

# Função para realizar backup de arquivos
fazer_backup() {
  echo "Digite o caminho do diretório de origem:"
  read origem

  echo "Digite o caminho do diretório de backup:"
  read destino

  if [ -d "$origem" ]; then
    if [ ! -d "$destino" ]; then
      mkdir -p "$destino"
    fi

    for arquivo in "$origem"/*; do
      if [ -f "$arquivo" ]; then
        cp "$arquivo" "$destino"
        echo "Copiado: $(basename "$arquivo")"
      fi
    done
    echo "Backup concluído!"
  else
    echo "Erro: O diretório de origem '$origem' não foi encontrado."
  fi
}

# Menu principal
while true; do
  echo "\nEscolha uma opção:"
  echo "1. Contar linhas de um arquivo"
  echo "2. Verificar se um arquivo existe"
  echo "3. Renomear arquivos em um diretório"
  echo "4. Fazer backup de arquivos de um diretório"
  echo "5. Sair"
  echo "Digite sua escolha:"

  read opcao

  case $opcao in
    1) contar_linhas ;;
    2) verificar_arquivo ;;
    3) renomear_arquivos ;;
    4) fazer_backup ;;
    5) echo "Saindo..."; exit 0 ;;
    *) echo "Opção inválida. Tente novamente." ;;
  esac

done
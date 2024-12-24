#!/bin/bash

# Função para contar linhas de um arquivo
contar_linhas() {
  arquivo=$(zenity --file-selection --title="Selecione um arquivo")
  
  if [ -f "$arquivo" ]; then
    linhas=$(wc -l < "$arquivo")
    zenity --info --text="O arquivo '$arquivo' contém $linhas linhas."
  else
    zenity --error --text="Erro: O arquivo '$arquivo' não foi encontrado."
  fi
}

# Função para verificar a existência de um arquivo
verificar_arquivo() {
  arquivo=$(zenity --file-selection --title="Selecione um arquivo")

  if [ -f "$arquivo" ]; then
    zenity --info --text="O arquivo '$arquivo' existe."
  else
    zenity --error --text="Erro: O arquivo '$arquivo' não foi encontrado."
  fi
}

# Função para renomear arquivos com uma extensão específica
renomear_arquivos() {
  diretorio=$(zenity --file-selection --directory --title="Selecione o diretório")
  extensao=$(zenity --entry --title="Digite a extensão" --text="Exemplo: .txt")
  prefixo=$(zenity --entry --title="Digite o novo prefixo" --text="Exemplo: arquivo")

  if [ -d "$diretorio" ]; then
    contador=1
    for arquivo in "$diretorio"/*"$extensao"; do
      if [ -f "$arquivo" ]; then
        novo_nome="${diretorio}/${prefixo}_${contador}${extensao}"
        mv "$arquivo" "$novo_nome"
        contador=$((contador + 1))
      fi
    done
    zenity --info --text="Renomeação concluída!"
  else
    zenity --error --text="Erro: O diretório '$diretorio' não foi encontrado."
  fi
}

# Função para realizar backup de arquivos
fazer_backup() {
  origem=$(zenity --file-selection --directory --title="Selecione o diretório de origem")
  destino=$(zenity --file-selection --directory --title="Selecione o diretório de backup")

  if [ -d "$origem" ]; then
    if [ ! -d "$destino" ]; then
      mkdir -p "$destino"
    fi

    for arquivo in "$origem"/*; do
      if [ -f "$arquivo" ]; then
        cp "$arquivo" "$destino"
      fi
    done
    zenity --info --text="Backup concluído!"
  else
    zenity --error --text="Erro: O diretório de origem '$origem' não foi encontrado."
  fi
}

# Menu principal com Zenity
while true; do
  opcao=$(zenity --list --title="Menu Principal" --column="Opção" --width=400 --height=300 \
    "Contar linhas de um arquivo" \
    "Verificar se um arquivo existe" \
    "Renomear arquivos em um diretório" \
    "Fazer backup de arquivos de um diretório" \
    "Sair")

  case $opcao in
    "Contar linhas de um arquivo") contar_linhas ;;
    "Verificar se um arquivo existe") verificar_arquivo ;;
    "Renomear arquivos em um diretório") renomear_arquivos ;;
    "Fazer backup de arquivos de um diretório") fazer_backup ;;
    "Sair") exit 0 ;;
    *) zenity --error --text="Opção inválida. Tente novamente." ;;
  esac
done

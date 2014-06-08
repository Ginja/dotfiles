#!/bin/bash

# Author: Riley Shott

encrypt() {
  __check_for_existence $1 'encrypting' 
  openssl enc -aes-256-cbc -a -salt -in "${1}" -out "${1}.enc" 
  chmod 600 "${1}.enc"
}

decrypt() {
  __check_for_existence $1 'decrypting'
  newfile=${1%.*}
  openssl enc -aes-256-cbc -d -a -in "${1}" -out "${newfile}"
  chmod 600 "${newfile}"
}

__check_for_existence() {
  if [[ -f $1 ]]; then
    return 0
  else
    echo "${1} doesn't exit for ${2}, exiting"
    exit 1
  fi
}

__usage() {
  echo "Usage: ${0} [encrypt|decrypt] [FILE]"
  exit 1
}

[[ $# -ne 2 ]] && echo "Incorrect number of parameters, exiting" && __usage

case $1 in
  encrypt)
    encrypt $2
  ;;
  decrypt)
    decrypt $2
  ;;
  *)
    __usage
  ;;
esac

exit 0

#!/bin/bash

# Author: Riley Shott

TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)

if [[ ! -d ~/dotfiles ]]; then
  echo "~/dotfiles doesn't appear to exist. Move your cloned repo there, and try again."
  exit 1
fi

add() {
  cd ~/dotfiles
  __create_folders
  for i in `find . -type f -not -iname *.enc -not -iname *.md -not -path . -not -path '*/\.git*' -not -path '*/\scripts*' -not -path '*/\backups*'`; do
    newfile=".${i:2}"
    if [[ -f ~/$newfile ]]; then
      echo "~/${newfile} exists! Copying original to ~/dotfiles/backups/${TIMESTAMP}"
      mkdir -p ~/dotfiles/backups/${TIMESTAMP}
      mv -f ~/${newfile} ~/dotfiles/backups/${TIMESTAMP}/${newfile}
      rm -f ~/${newfile}
    fi
    ln -s ~/dotfiles/${i:2} ~/$newfile
  done
}

remove() {
  cd ~/dotfiles
  for i in `find . -type f -not -path . -not -path '*/\.git*' -not -path '*/\scripts*' -not -path '*/\backups*'`; do
    file=".${i:2}"
    rm -f ~/$file
  done
}

purge_backups() {
  rm -rf ~/dotfiles/backups/*
}

__create_folders() {
  cd ~/dotfiles
  for i in `find . -type d -not -path . -not -path '*/\.git*' -not -path '*/\scripts*' -not -path '*/\backups*'`; do
    folder=${i:2}
    newfolder=".${folder}"
    mkdir -p ~/$newfolder
    chmod 700 ~/$newfolder
  done
}

case $1 in
add)
  add
  ;;
remove)
  remove
  ;;
redeploy)
  remove
  add
  ;;
purge_backups)
  purge_backups
  ;;
*)
  echo "Usage: ${0} [add|remove|redeploy|purge_backups]"
  ;;
esac

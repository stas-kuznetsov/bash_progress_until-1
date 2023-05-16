#!/bin/bash

#. $DIR_PATH/../routine/err_throw.sh

_w_archive_extract()
{

  local -
  set -o errexit
  set -o nounset
  set -o pipefail

  ## Extract archive.
  #
  ## Sample
  #
  # extrac some/archive.7z
  #

  local name && name="${1#%.*}"
  target_dir=$( echo "${1%/*}" )



  if [ -f $1 ]
  then
  case $1 in
    *.tar.bz2)   tar xjf $1 -C $target_dir          ;;
    *.tar.gz)    tar xzf $1 -C $target_dir          ;;
    *.tar.xz)    tar xvf $1 -C $target_dir          ;;
    *.bz2)       bzip2 -dk $1 $target_dir           ;;
    *.rar)       unrar x $1 $target_dir             ;;
    *.gz)        gunzip -c $1 > ${name%.gz}         ;;
    *.tar)       tar xf $1 -C $target_dir           ;;
    *.tbz2)      tar xjf $1 -C $target_dir          ;;
    *.tgz)       tar xzf $1 -C $target_dir          ;;
    *.zip)       unzip $1 -d $target_dir            ;;
    *.Z)         uncompress -k $1                   ;;
    *.7z)        7z e -y $1 -o$target_dir           ;;
    *.ace)       unace x $1                         ;;
    *)           echo "'$1' cannot be extracted with _w_archive_extract" ;;
  esac
  else
  echo "'$1' is not a valid file"
  fi

  printf '%s\n' "$name"

  # qqq2 : make it working for all listed archives
  # qqq2 : make sure it return proper path to extracted file
  # qqq2 : write tests

}
export -f _w_archive_extract

if [[ "${BASH_SOURCE[0]}" == "$0" ]]
then
  _w_archive_extract "$@"
fi

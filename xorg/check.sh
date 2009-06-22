#!/bin/bash

TXT_GREEN=$(tput setaf 2)
TXT_RED=$(tput setaf 1)
TXT_RESET=$(tput sgr0)

check_command()
{
  if command -v $1 &>/dev/null
  then
    echo "[ ${TXT_GREEN}OK${TXT_RESET} ]  command '${1}' was found"
    return 1
  else
    echo "[${TXT_RED}FAIL${TXT_RESET}]  command '${1}' was not found!!"
    return 0
  fi
}

commands="pkg-config gperf ed intltoolize gcc ld grep make autoconf automake gettext xmlto"

for command in $commands
do
  check_command $command
done

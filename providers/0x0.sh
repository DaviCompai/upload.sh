#!/usr/bin/bash
#script to automate the use of 0x0.st, a site that allows for easy upload trought the terminal for up to 512 mbs and 30 days.
set -e
info=0
help=0
simple=0
filepath=$1
if [[ $# -lt 1 ]] || [[ "$1" = -i ]] || [[ "$1" = -info ]] || [[ "$1" = -h ]] || [[ "$1" = -help ]]; then
  echo "Error: no file specified. use ${0##*/} -h for help." >&2
  exit 1
fi

if [[ ! -f "$filepath" ]]; then
  echo "Error: File '$filepath' not found" >&2
  exit 1
fi

for argument in "$@"; do
  if [[ $argument = -i || $argument = -info ]]; then
    info=1
  fi
  if [[ $argument = -h || $argument = -help ]]; then
    help=1
  fi
  if [[ $argument = -s || $argument = -simple ]]; then
    simple=1
  fi
done

if [[ $help -eq 1 ]]; then
  echo -e "Uploads your files to 0x0.st. expects a file as it's first argument\n-i or -info: tells you an estimative on how long your files are going to be stored for\n-h or -help: shows this text."
  exit
fi
# "-A" stands for user agent (this site requires it)
# duration of file in the server (-i/-info argument):
if [[ $info -eq 1 ]]; then

  min_age=30   # days
  max_age=365  # days
  max_size=512 #MiB
  file_size=$(bc -l <<<"$(stat -c %s "$filepath")/ 1048576")
  retention=$(bc -l <<<"scale=2; $min_age +($min_age - $max_age) * (($file_size / $max_size - 1) ^ 3)")
  echo 'this file will be stored for '$retention', and it is '$file_size' MiBs. '
fi
#test
link=$(curl -A "upload.shBydavicompai@gmail.com/$USER" -F"file=@$filepath" https://0x0.st -w "\\n")
if [[ simple -eq 0 ]]; then
  echo "$link" | tee>(xclip -selection clipboard)
  echo 'link to file copied!'
else
  echo "$link"
fi

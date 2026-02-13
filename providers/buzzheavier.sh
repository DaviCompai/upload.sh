#!/usr/bin/bash

help=0
simple=0
note=0

for argument in "$@"; do
  argument=${argument,,}
  #accepts uppercase arguments too.
  case $argument in
  -h | -help) help=1 ;;
  -s | -simple) simple=1 ;;
  -note:* | -n:*)
    note=1
    note_content=${argument##*:}
    ;;
  esac
done

if [[ $help -eq 1 ]]; then
  echo -e "Uploads a file to buzzheavier.com . Expects a file path as it's first parameter.
  -s or -simple: Only outputs the file link. Usefull for scripts.
  -h or -help: Shows this text."
  exit
fi

file_path=$1

if [[ $# -lt 1 ]] || [[ "$1" = -i ]] || [[ "$1" = -info ]] || [[ "$1" = -h ]] || [[ "$1" = -help ]]; then
  echo "Error: no file specified. use ${0##*/} -h for help." >&2
  exit 1
fi

if [[ ! -f "$file_path" ]]; then
  echo "Error: File '$file_path' not found" >&2
  exit 1
fi

file_name=${file_path##*/}
getUploadId() {
  if [[ simple -eq 0 && note -eq 0 ]]; then
    upload_output=$(curl -#o - -T "$file_path" "https://w.buzzheavier.com/$file_name" | cat)
  elif [[ simple -eq 1 && note -eq 0 ]]; then
    upload_output=$(curl -#o - -T "$file_path" "https://w.buzzheavier.com/$file_name")
  elif [[ simple -eq 0 && note -eq 1 ]]; then
    upload_output=$(curl -#o - -T "$file_path" "https://w.buzzheavier.com/${file_name}?note=$(echo -n "${note_content}" | base64)" | cat)
  elif [[ simple -eq 1 && note -eq 1 ]]; then
    upload_output=$(curl -#o - -T "$file_path" "https://w.buzzheavier.com/${file_name}?note=$(echo -n "${note_content}" | base64)")
  fi
  upload_id=${upload_output##*\"id\":\"}
  upload_id=${upload_id%%\"*}
  echo "$upload_id"
}

link=https://buzzheavier.com/$(getUploadId)

if [[ simple -eq 0 ]]; then
  echo "$link" | tee >(xclip -selection clipboard)
  echo 'link to file copied!'
else
  echo "$link"
fi

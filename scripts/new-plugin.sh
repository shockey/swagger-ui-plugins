#!/bin/bash

set -e

SUCCESS=0

function bold() {
  local bold="\e[1m" plain="\e[0m"
  echo -e "${bold}$@${plain}"
}

function revert() {
  if [ "$SUCCESS" -eq 0 ]; then
    if [ -n "$PLUGIN_KEBAB_CASE" ]; then
      if [ -e "packages/$PLUGIN_KEBAB_CASE" ]; then
        rm -Rf "packages/$PLUGIN_KEBAB_CASE"
      fi
    fi
  fi
}

function gather_info() {
  echo "$(bold Plugin Name)"
  echo "What should the name of your plugin be? Some examples are 'Hide Empty Tags' and"
  echo "'Disable Try-It-Out Without Servers'."
  echo
  read -p "Name: " PLUGIN_NAME
  echo
  echo "$(bold Plugin Author)"
  echo "Who should be listed as the plugin author. This is usually something like"
  echo "'Your Name<your.name@example.com>'."
  echo
  read -p "Author: " PLUGIN_AUTHOR
  echo
  echo "$(bold Plugin Description)"
  echo "Your plugin should have a short description (for package.json) and a long"
  echo "description (for the readme)."
  echo
  read -p "Short Description: " PLUGIN_SHORT_DESC
  read -p "Long Description: " PLUGIN_LONG_DESC
  echo
}

function gather_loop() {
  while true; do
    # Gather
    gather_info

    # Then validate
    local MISSING=
    if [ -z "$PLUGIN_NAME" ]; then MISSING="$MISSING,name"; fi
    if [ -z "$PLUGIN_AUTHOR" ]; then MISSING="$MISSING,author"; fi
    if [ -z "$PLUGIN_SHORT_DESC" ]; then MISSING="$MISSING,short-description"; fi
    if [ -z "$PLUGIN_LONG_DESC" ]; then MISSING="$MISSING,long-description"; fi
    if [ -n "$MISSING" ]; then
      echo "Hm... Looks like we didn't get all the info we needed. We're missing the following"
      echo "fields: $(bold "$(echo "$MISSING" | sed s/^,//)"). Please try again."
    else
      return 0
    fi
  done
}

trap "revert" EXIT

# Intro
echo "Hi! Sounds like you want to make a new Swagger UI plugin. Please fill in the following"
echo "information and we'll get you set up."
echo

while true; do
  # Gather info
  gather_loop

  # Now generate from boilerplate
  echo -n "$(bold REVIEW) Here's what we got:"
  echo
  echo "$(bold "Name:") $PLUGIN_NAME"
  echo "$(bold "Author:") $PLUGIN_AUTHOR"
  echo "$(bold "Short Description:") $PLUGIN_SHORT_DESC"
  echo "$(bold "Long Description:") $PLUGIN_LONG_DESC"
  echo
  read -p "Does that look right? (Y/n) " ANS
  ANS="$(echo "$ANS" | tr '[:upper:]' '[:lower:]')"
  if [ "$ANS" == "n" ]; then
    echo "Ok, let's try again"
    sleep 1
  else
    echo "$(bold "Great!") generating a new plugin from the boilerplate...."
    sleep 1
    break
  fi
done

PLUGIN_PROPER_NAME="$(echo "$PLUGIN_NAME" | sed 's/ +/ /g' | sed 's/.*/\L&/; s/[a-z]*/\u&/g' | sed "s/'S/'s/g")"
PLUGIN_KEBAB_CASE="$(echo "$PLUGIN_PROPER_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g' | sed  -r 's/ +/-/g')"
PLUGIN_PASCAL_CASE="$(echo "$PLUGIN_PROPER_NAME" | sed 's/[^a-zA-Z0-9 ]//g' | sed -r 's/ +//g')"

cp -R packages/.boilerplate "packages/${PLUGIN_KEBAB_CASE}"

# Mac requires a backup string, which we're providing as "empty" here
if command -v lsb_release &>/dev/null; then
  sed="sed -i"
else
  sed="sed -i ''"
fi

$sed s/'{author}'/"$PLUGIN_AUTHOR"/g $(find packages/${PLUGIN_KEBAB_CASE} -type f)
$sed s/'{proper-name}'/"$PLUGIN_PROPER_NAME"/g $(find packages/${PLUGIN_KEBAB_CASE} -type f)
$sed s/'{name-kebab-case}'/"$PLUGIN_KEBAB_CASE"/g $(find packages/${PLUGIN_KEBAB_CASE} -type f)
$sed s/'{name-pascal-case}'/"$PLUGIN_PASCAL_CASE"/g $(find packages/${PLUGIN_KEBAB_CASE} -type f)
$sed s/'{short-desc}'/"$PLUGIN_SHORT_DESC"/g $(find packages/${PLUGIN_KEBAB_CASE} -type f)

readme="packages/${PLUGIN_KEBAB_CASE}/README.md"
n="$(grep -n "{long-desc}" "$readme" | sed -r 's/^([0-9]+).*$/\1/g')"
one="$(head -n$((n-1)) "$readme")"
two="$(tail -n "+$((n+1))" "$readme")"
echo "$one"$'\n'"$PLUGIN_LONG_DESC"$'\n'"$two" > "$readme"

while read f; do
  NEW_NAME="$(echo "$f" | sed s/'{name-kebab-case}'/"$PLUGIN_KEBAB_CASE"/g)"
  mv "$f" "$NEW_NAME"
done < <(find "packages/${PLUGIN_KEBAB_CASE}" -name '*{name-kebab-case}*')

SUCCESS=1

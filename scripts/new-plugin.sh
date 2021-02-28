#!/bin/bash

set -e

SUCCESS=0

# Get bold/plain variables using tput, if available
if command -v tput &>/dev/null; then
    bold="$(tput bold)"
    reset="$(tput sgr0)"
fi

function bold() {
  echo "${bold}$@${reset}"
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
  echo "$(bold "Plugin Name")"
  echo "What should the name of your plugin be? Some examples are 'Hide Empty Tags' and 'Disable Try-It-Out Without Servers'."
  echo
  read -p "Name: " PLUGIN_NAME
  echo
  echo "$(bold "Plugin Author")"
  echo "Who should be listed as the plugin author. This is usually something like 'Your Name<your.name@example.com>'."
  echo
  read -p "Author: " PLUGIN_AUTHOR
  echo
  echo "$(bold "Plugin Description")"
  echo "Come up with a short description for package.json so others know what this plugin is for."
  echo
  read -p "Description: " PLUGIN_SHORT_DESC
  echo

  # Generate derivative name values
  PLUGIN_PROPER_NAME="$([ -n "$PLUGIN_PROPER_NAME" ] && echo "$PLUGIN_PROPER_NAME" || echo "$PLUGIN_NAME" | sed 's/ +/ /g' | sed 's/.*/\L&/g' | sed 's/[a-z]*/\u&/g' | sed "s/'[ST]/\\L&/g")"

  echo "$(bold "Good. Now we're going to generate a few name derivatives for you.") Make sure they look ok, or change them if they don't."
  echo
  echo "$(bold "Proper Name")"
  echo "This will be your plugin's name in the Readme"
  echo
  read -p "Proper name: [${PLUGIN_PROPER_NAME}] " ANS
  if [ -n "$ANS" ]; then
    PLUGIN_PROPER_NAME="$ANS"
  fi
  PLUGIN_KEBAB_CASE="$([ -n "$PLUGIN_KEBAB_CASE" ] && echo "$PLUGIN_KEBAB_CASE" || echo "$PLUGIN_PROPER_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g' | sed  -r 's/ +/-/g')"
  echo
  echo "$(bold "Kebab-Case Name")"
  echo "There are a variety of places where your plugin will be referenced by a 'kebab-case' variant. Enter that here or accept the default."
  echo
  read -p "Kebab-case name: [${PLUGIN_KEBAB_CASE}] " ANS
  if [ -n "$ANS" ]; then
    PLUGIN_KEBEB_CASE="$ANS"
  fi
  echo
  PLUGIN_PASCAL_CASE="$([ -n "$PLUGIN_PASCAL_CASE" ] && echo "$PLUGIN_PASCAL_CASE" || echo "$PLUGIN_PROPER_NAME" | sed 's/[^a-zA-Z0-9 ]//g' | sed -r 's/ +//g')"
  echo "$(bold "PascalCase Name")"
  echo "There are a variety of places where your plugin will be referenced by a 'PascalCase' variant. Enter that here or accept the default."
  echo
  read -p "PascalCase name: [${PLUGIN_PASCAL_CASE}] " ANS
  if [ -n "$ANS" ]; then
    PLUGIN_PASCAL_CASE="$ANS"
  fi
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
    if [ -n "$MISSING" ]; then
      echo "Hm... Looks like we didn't get all the info we needed. We're missing the following fields: $(bold "$(echo "$MISSING" | sed s/^,//)"). Please try again."
    else
      return 0
    fi
  done
}

trap "revert" EXIT

# Intro
echo "Hi! Sounds like you want to make a new Swagger UI plugin. Please fill in the following information and we'll get you set up."
echo

while true; do
  # Gather info
  gather_loop

  # Now generate from boilerplate
  echo "$(bold "REVIEW") - Here's what we got:"
  echo
  echo "$(bold "Name:") $PLUGIN_PROPER_NAME"
  echo "$(bold "Author:") $PLUGIN_AUTHOR"
  echo "$(bold "Short Description:") $PLUGIN_SHORT_DESC"
  echo "$(bold "Kebab-Case Name:") $PLUGIN_KEBAB_CASE"
  echo "$(bold "PascalCase Name:") $PLUGIN_PASCAL_CASE"
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

while read f; do
  NEW_NAME="$(echo "$f" | sed s/'{name-kebab-case}'/"$PLUGIN_KEBAB_CASE"/g)"
  mv "$f" "$NEW_NAME"
done < <(find "packages/${PLUGIN_KEBAB_CASE}" -name '*{name-kebab-case}*')

echo "$(bold "Ok! Your new plugin is ready for development at ./packages/$PLUGIN_KEBAB_CASE".)"

SUCCESS=1

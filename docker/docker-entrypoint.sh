#!/bin/bash

# set -ex

# for modPath in ${STARDEW_PATH}/Stardew\ Valley/Mods/*/; do
#   mod=$(basename "$modPath")

#   # Normalize mod name ot uppercase and only characters, eg. "Always On Server" => ENABLE_ALWAYS_ON_SERVER_MOD
#   var="ENABLE_$(echo "${mod}" | tr -cd '[a-zA-Z _-]' | sed 's/\([a-z]\)\([A-Z]\)/\1_\2/g' | tr '[a-z]' '[A-Z]' | tr '[- ]' '_')_MOD"

#   # Remove the mod if it's not enabled
#   if [ "$(eval echo \$$var)" != "true" ]; then
#     echo "Removing ${modPath} (${var}=$(eval echo \$$var))"
#     rm -rf "$modPath"
#     continue
#   fi

#   if [ -f "${modPath}/config.json.template" ]; then
#     echo "Configuring ${modPath}config.json"

#     # Seed the config.json only if one isn't manually mounted in (or is empty)
#     if [ ! -s "${modPath}config.json" ]; then
#       envsubst < "${modPath}config.json.template" > "${modPath}config.json"
#     fi
#   fi
# done

# Run extra steps for certain mods
# /opt/configure-remote-control-mod.sh

# /opt/tail-smapi-log.sh &

# Ready to start!

# export XAUTHORITY=~/.Xauthority
# TERM=

if [ ! -f "${STARDEW_PATH}/Stardew Valley/StardewValley.bak" ]; then
  cp ${STARDEW_PATH}/Stardew\ Valley/StardewValley ${STARDEW_PATH}/Stardew\ Valley/StardewValley.bak

  # sed -i -e 's/env TERM=xterm $LAUNCHER "$@"$/env SHELL=\/bin\/bash TERM=xterm xterm -e "\/bin\/bash -c $LAUNCHER "$@""/' ${STARDEW_PATH}/Stardew\ Valley/StardewValley
fi

# exec ${STARDEW_PATH}/Stardew\ Valley/StardewValley
bash -c "${STARDEW_PATH}/Stardew\ Valley/StardewValley"

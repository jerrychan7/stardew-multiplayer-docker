#!/bin/bash

# set -ex

/opt/tail-smapi-log.sh &

if [ ! -d "/data/mods/SMAPI_BUILD_IN" ]; then
  mkdir -p /data/mods/SMAPI_BUILD_IN

  if [ "${ENABLE_CONSOLE_COMMANDS_MOD}" != "true" ]; then
    mv "${STARDEW_PATH}/Stardew Valley/Mods.bak/ConsoleCommands" "/data/mods/SMAPI_BUILD_IN/.ConsoleCommands"
  else
    mv "${STARDEW_PATH}/Stardew Valley/Mods.bak/ConsoleCommands" "/data/mods/SMAPI_BUILD_IN/ConsoleCommands"
  fi

  if [ "${ENABLE_SAVE_BACKUP_MOD}" != "true" ]; then
    mv "${STARDEW_PATH}/Stardew Valley/Mods.bak/SaveBackup" "/data/mods/SMAPI_BUILD_IN/.SaveBackup"
  else
    mv "${STARDEW_PATH}/Stardew Valley/Mods.bak/SaveBackup" "/data/mods/SMAPI_BUILD_IN/SaveBackup"
  fi
fi

bash -c "${STARDEW_PATH}/Stardew\ Valley/StardewValley"

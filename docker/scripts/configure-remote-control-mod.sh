#!/bin/sh

# Quit if we don't have any default admins
if [ -z "${REMOTE_CONTROL_DEFAULT_ADMINS}" ] || [ ! -f "${STARDEW_PATH}/Stardew Valley/Mods/RemoteControl/config.json" ]; then
    return
fi

# Add default admins to the admin list
jq ".admins[.admins | length] |= . + ${REMOTE_CONTROL_DEFAULT_ADMINS}" "${STARDEW_PATH}/Stardew Valley/Mods/RemoteControl/config.json" > "${STARDEW_PATH}/Stardew Valley/Mods/RemoteControl/config.json.out"
mv -f "${STARDEW_PATH}/Stardew Valley/Mods/RemoteControl/config.json.out" "${STARDEW_PATH}/Stardew Valley/Mods/RemoteControl/config.json"

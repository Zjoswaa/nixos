DISPLAY_NAMES=(Lock Logout 'Power Off' Reboot Suspend)
COMMANDS=('loginctl lock-session' 'hyprctl dispatch exit' 'systemctl poweroff' 'systemctl reboot' 'systemctl suspend')
ICON_PATHS=(
  /run/current-system/sw/share/icons/Papirus-Dark/64x64/apps/system-lock-screen.svg
  /run/current-system/sw/share/icons/Papirus-Dark/64x64/apps/system-log-out.svg
  /run/current-system/sw/share/icons/Papirus-Dark/64x64/apps/system-shutdown.svg
  /run/current-system/sw/share/icons/Papirus-Dark/64x64/apps/system-reboot.svg
  /run/current-system/sw/share/icons/Papirus-Dark/64x64/apps/system-suspend.svg
)

MENU_ITEMS=()
for i in "${!DISPLAY_NAMES[@]}"; do
  MENU_ITEMS+=("img:${ICON_PATHS[i]}:text:${DISPLAY_NAMES[i]}")
done

CHOICE=$(printf '%s\n' "${MENU_ITEMS[@]}" | wofi --normal-window --show dmenu --allow-images --prompt "Choose an action")

# Extract label from `text:...`
SELECTED_NAME="${CHOICE#*:text:}"

# Match selection and run command
for i in "${!DISPLAY_NAMES[@]}"; do
  if [[ "${DISPLAY_NAMES[i]}" == "$SELECTED_NAME" ]]; then
    eval "${COMMANDS[i]}"
    break
  fi
done

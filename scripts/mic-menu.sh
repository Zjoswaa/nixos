mapfile -t MIC_LINES < <(wpctl status | awk '/Sources:/,/^$/' | grep '│' | grep -v 'Monitor' | grep -v 'V4L2' | grep -oP '[\*\s]*\d+\.\s.+')

DISPLAY_NAMES=("Mute Microphone" "Unmute Microphone")
WP_IDS=("__mute__" "__unmute__")

for line in "${MIC_LINES[@]}"; do
  id=$(echo "$line" | grep -oP '^\s*\*?\s*\K\d+(?=\.)')
  name=$(echo "$line" | sed 's/^\s*\*\?\s*[0-9]\+\.\s*//' | sed 's/\s*\[vol.*$//' | xargs)
  [[ -z "$id" || -z "$name" ]] && continue
  WP_IDS+=("$id")
  DISPLAY_NAMES+=("$name")
done

MIC_ICON="/run/current-system/sw/share/icons/Papirus-Dark/64x64/devices/audio-input-microphone.svg"
MUTE_ICON="/run/current-system/sw/share/icons/Papirus/48x48/status/mic-off.svg"
UNMUTE_ICON="/run/current-system/sw/share/icons/Papirus/48x48/status/microphone-sensitivity-low.svg"

ICON_PATHS=()
for id in "${WP_IDS[@]}"; do
  if [[ "$id" == "__mute__" ]]; then
    ICON_PATHS+=("$MUTE_ICON")
  elif [[ "$id" == "__unmute__" ]]; then
    ICON_PATHS+=("$UNMUTE_ICON")
  else
    ICON_PATHS+=("$MIC_ICON")
  fi
done

MENU_ITEMS=()
for i in "${!DISPLAY_NAMES[@]}"; do
  MENU_ITEMS+=("img:${ICON_PATHS[i]}:text:${DISPLAY_NAMES[i]}")
done

CHOICE=$(printf '%s\n' "${MENU_ITEMS[@]}" | wofi --normal-window --show dmenu --allow-images --prompt "Microphone" --cache-file=/dev/null)
SELECTED_NAME="${CHOICE#*:text:}"

for i in "${!DISPLAY_NAMES[@]}"; do
  if [[ "${DISPLAY_NAMES[i]}" == "$SELECTED_NAME" ]]; then
    id="${WP_IDS[i]}"
    case "$id" in
      __mute__)   wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1 ;;
      __unmute__) wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0 ;;
      *)          wpctl set-default "$id" ;;
    esac
    break
  fi
done

#!/usr/bin/env bash

THEME_DIR="$HOME/themes/shitbox_red"

echo "Applying theme from: $THEME_DIR"

# Ensure config directories exist
mkdir -p ~/.config/i3
mkdir -p ~/.config/kitty
mkdir -p ~/.config/picom
mkdir -p ~/.config/polybar
mkdir -p ~/.config/rofi

#######################################
# 1. i3
#######################################
if [ -f "$THEME_DIR/i3/config" ]; then
    cp "$THEME_DIR/i3/config" ~/.config/i3/config
    echo "✔ i3 config applied"
else
    echo "✖ Missing i3 config"
fi

#######################################
# 2. Kitty terminal
#######################################
if [ -f "$THEME_DIR/kitty/kitty.conf" ]; then
    cp "$THEME_DIR/kitty/kitty.conf" ~/.config/kitty/kitty.conf
fi

if [ -f "$THEME_DIR/kitty/current-theme.conf" ]; then
    cp "$THEME_DIR/kitty/current-theme.conf" ~/.config/kitty/current-theme.conf
fi

echo "✔ Kitty configs applied"

#######################################
# 3. Picom
#######################################
if [ -f "$THEME_DIR/picom/picom.conf" ]; then
    cp "$THEME_DIR/picom/picom.conf" ~/.config/picom/picom.conf
    echo "✔ Picom config applied"
fi

#######################################
# 4. Polybar
#######################################
if [ -d "$THEME_DIR/polybar" ]; then
    cp -r "$THEME_DIR/polybar/"* ~/.config/polybar/
    echo "✔ Polybar files applied"
fi

#######################################
# 5. Rofi
#######################################
if [ -f "$THEME_DIR/rofi/config" ]; then
    cp "$THEME_DIR/rofi/config" ~/.config/rofi/config
fi

if [ -f "$THEME_DIR/rofi/config.rasi" ]; then
    cp "$THEME_DIR/rofi/config.rasi" ~/.config/rofi/config.rasi
fi

echo "✔ Rofi configs applied"

#######################################
# 6. Wallpaper via feh
#######################################
if [ -f "$THEME_DIR/achjaj.png" ]; then
    feh --bg-scale "$THEME_DIR/achjaj.png"
    echo "✔ Wallpaper set"
else
    echo "✖ Wallpaper not found"
fi

#######################################
# 7. Restart necessary services
#######################################
echo "Restarting environment..."

# Restart picom
pkill picom 2>/dev/null
picom &

# Restart polybar (if launch.sh exists)
if [ -f ~/.config/polybar/launch.sh ]; then
    pkill polybar 2>/dev/null
    bash ~/.config/polybar/launch.sh &
fi

# Reload i3 to apply changes
i3-msg reload
i3-msg restart

echo "-------------------------------------"
echo "✔ Theme successfully applied!"
echo "-------------------------------------"

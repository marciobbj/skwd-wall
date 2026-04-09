SCHEME_DIR="$HOME/.local/share/color-schemes"
ALT="${SCHEME}Alt"

# exit if plasma-apply-colorscheme isn't installed
command -v plasma-apply-colorscheme >/dev/null || exit 0

# make a copy of the scheme file with "Alt" appended to the name
cp "$SCHEME_DIR/$SCHEME.colors" "$SCHEME_DIR/$ALT.colors" 2>/dev/null

# update the Name= line inside the copy so KDE sees it as a distinct scheme
sed -i "s/^Name=.*/Name=$ALT/" "$SCHEME_DIR/$ALT.colors" 2>/dev/null

# read which color scheme is currently active
CURRENT=$(grep '^ColorScheme=' "$HOME/.config/kdeglobals" | cut -d= -f2)

# toggle: if the alt scheme is active, switch back to the original, and vice versa
if [ "$CURRENT" = "$ALT" ]; then
    plasma-apply-colorscheme "$SCHEME"
else
    plasma-apply-colorscheme "$ALT"
fi

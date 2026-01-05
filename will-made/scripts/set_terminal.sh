#!/usr/bin/env fish

# Define the folder and filename
set kittyfolder "$HOME/.config/kitty"
set filename "colors.conf"
set filepath "$kittyfolder/$filename"

# Check if the file exists
if test -e $filepath
    echo "File already exists, writing to it..."
else
    # If the file doesn't exist, create it
    touch $filepath
    echo "File created."
end

# Add some text to the file (this will overwrite any existing content)
# Write the exact content to the file
# Write the exact content to the file using printf
# Define variables for each color in hex

# Add the exact content to the file with updated colors
printf "%s\n" \
"cursor $cursor_color" \
"cursor_text_color $cursor_text_color" \
"" \
"foreground $foreground_color" \
"background $background_color" \
"selection_foreground $selection_foreground_color" \
"selection_background $selection_background_color" \
"url_color $url_color" \
"" \
"# black" \
"color8 $black_color" \
"color0 #4c4c4c" \
"" \
"# red" \
"color1 $red_color" \
"color9 #c49ea0" \
"" \
"# green" \
"color2 $green_color" \
"color10 #9ec49f" \
"" \
"# yellow" \
"color3 $yellow_color" \
"color11 #c4c19e" \
"" \
"# blue" \
"/* color4 #8f8aac */" \
"color4 $blue_color" \
"color12 #a39ec4" \
"" \
"# magenta" \
"color5 $magenta_color" \
"color13 #c49ec4" \
"" \
"# cyan" \
"color6 $cyan_color" \
"color14 #9ec3c4" \
"" \
"# white" \
"color15 $white_color" \
"color7 #f0f0f0" > $filepath

# Optionally, if you want to append to the file instead of overwriting:
# echo "This is additional text." >> $filepath

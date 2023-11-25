#!/bin/sh

if [ -z "$XDG_PICTURES_DIR" ] ; then
    XDG_PICTURES_DIR="$HOME/Pictures"
fi

save_dir="${2:-$XDG_PICTURES_DIR/Screenshots}"
save_filename=$(date "+%y%m%d_%H%M%S.png")
tmp_screenshot=/tmp/screenshot.png

mkdir -p "$save_dir"

cat << EOF > $HOME/.config/swappy/config
[Default]
save_dir=$save_dir
save_filename_format=$save_filename
line_size=2
text_size=12
text_font=Mononoki Nerd Font
EOF

print_error() {
cat << "EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p : print all screens
        s : snip current screen
        m : print focused monitor
EOF
}

case $1 in
p)  # print all outputs
  grimblast copysave screen $tmp_screenshot && swappy -f $tmp_screenshot ;;
s)  # drag to manually snip an area / click on a window to print it
  grimblast --freeze copysave area $tmp_screenshot && swappy -f $tmp_screenshot ;;
m)  # print focused monitor
  grimblast copysave output $tmp_screenshot && swappy -f $tmp_screenshot ;;
*)  # invalid option
  print_error ;;
esac

rm "$tmp_screenshot"

if [ -f "$save_dir/$save_filename" ] ; then
    dunstify "Saved as $save_dir/$save_filename" -i "$save_dir/$save_filename" -r 91190 -t 2200
fi

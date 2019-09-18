#!/usr/bin/env bash

xset 120 5
xss-lock -l -- '/home/jose/.config/script/lock_screen' &!
autocutsel -fork &!
autocutsel -selection PRIMARY -fork &! #Makes cut and paste behave as expected
mpd &> /dev/null &!
dunst -config /home/jose/.config/dunst/dunstrc &!
# /usr/lib/notify-osd/notify-osd &!
# blueman-applet &!
compton --config /home/jose/.config/compton/compton.conf &!
/home/jose/Apps/precompile/lifecalendar/lifecalendar.py -c /home/jose/Apps/precompile/lifecalendar/examples/default.cfg -o "/home/jose/Apps/precompile/lifecalendar/BgLifetime.png"
feh --bg-fill --no-fehbg /home/jose/Apps/precompile/lifecalendar/BgLifetime.png
setxkbmap latam
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient PalmDetect=1
numlockx on

/home/jose/.config/herbstluftwm/panel_var.sh &!

cd /home/jose/.dotfiles/installed/

yaourt -Q --date > packages.system
pip2 freeze --local > py2ckages.system
pip3 freeze --local > py3ckages.system
gem list > gemckages.system
npm list > npmackages.system
julia -e 'print(Pkg.installed())' | sed 's/,/\n/g' > juliackges.system

git add packages.system py2ckages.system py3ckages.system gemckages.system npmackages.system juliackges.system
git commit -m "Updating .system files ($(date '+%H:%M %d-%m-%y'))"
git push -u origin master

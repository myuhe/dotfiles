#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export LANG=ja_JP.utf8
export LC_ALL=ja_JP.UTF8

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

xrdb -merge ~/.Xresources

xset r rate 300 60

export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS=@im='uim'

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS="@im=fcitx"

uim-toolbar-gtk-systray &

# if [ -x /usr/bin/autocutsel ]; then
#     #this will keep the clipboard in sync
#     #   with the primary buffer
#     autocutsel -selection CLIPBOARD -fork

#     #this will keep the primary in sync
#     #   with the clipboard buffer
#     autocutsel -selection PRIMARY -fork
# fi

exec  awesome

# #ONLY THIS LINE
# exec  gnome-session


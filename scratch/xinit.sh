userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap# merge in defaults and keymapsif [ -f $sysresources ]; then
    xrdb -merge $sysresources
fiif [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fiif [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fiif [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fiif [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

exec i3
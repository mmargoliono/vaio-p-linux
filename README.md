vaio-p-linux
============
Contains some setting for using (Arch)Linux on sony vaio p series



Multi monitor using modesetting driver
--------------------------------------
Multi monitor setup can be achieved using xrandr after setting 
the xorg driver to modesetting (Modesetting driver must be 
installed first). Add __10-modesetting.conf__ to xorg 
directory.
> file:///etc/X11/xorg.cof.d/10-modesetting.conf


Brightness
----------
Brightness can be manipulated by echo-ing value to 
/sys/class/backlight/psb-bl/brightness (for gma500_gfx, if 
using emgd driver the location change). To enable changing 
brightness as normal user, that 'file' must be writeable to all 
user. The __brightness.service__ systemd unit will change the 
permission to allow that, and reduce brightness to 20%.
> file:///etc/systemd/system/brightness.service

__brightness-control.sh__ enable changing the brightness 
incrementally. At the end of change it will pop notification using 
notify-send (can be removed if not needed). 
Do not forget to mark it as executable.


Keyboard mapping
----------------
Most keys are recognized by default with the exception of 
zoomin/zoomout (fn + f9/f10) and vaio key (key between assist 
and web) on VPCP111KX.

Those keys are generating scancodes, but mapped to keycode 
greater than 255. X11 does not support keycode gerater than 
255. 
Zoomin/zoomout will be mapped to prog3/prog4 and vaio key to 
prog1. Those keycode can later be remapped using desktop 
environment shortcut, or using xbindkeys.

###1. Using udev keymap (prior to systemd 206)
Create a mapping file (__module-sony-vaio__) for the extra key 
in 
keymaps folder.
> file:///lib/udev/keymaps/module-sony-vaio-p

Create a udev rules (__98-keymap-vaio-p.rules__) to run the 
keymap for the file
> file:///etc/udev/rules.d/98-keymap-vaio-p.rules

###2. Using hwdb
Create a mapping file for hwdb (__88-vaio-p-hwdb__).
/etc/udev/hwdb/88-vaio-p.hwdb

Update hwdb
> udevadm hwdb --update
> reboot


xbindkeys helper
----------------
__.xbindkeysrc__ can be used to map extra keys to desired 
functionality
> file: ///home/min/.xbindkeysrc


Touchstick Scrolling
--------------------
Vaio p touchstick is only recognised as a mouse. By default it 
doesn’t allow middle click scroling (holding the middle button 
and move the touchstick to scroll. Put the 
__42-touchstick.conf__ in xorg config directory to enable it. 
I can not find a way to enable the press to select.
> file:///etc/42-touchstick.conf

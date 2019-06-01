sudo apt-get update
sudo apt-get install -y ubuntu-gnome-desktop
sudo apt-get install -y xrdp
sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
sudo nano /etc/polkit-1/localauthority.conf.d/02-allow-colord.conf

polkit.addRule(function(action, subject) {
if ((action.id == "org.freedesktop.color-manager.create-device" ||
action.id == "org.freedesktop.color-manager.create-profile" ||
action.id == "org.freedesktop.color-manager.delete-device" ||
action.id == "org.freedesktop.color-manager.delete-profile" ||
action.id == "org.freedesktop.color-manager.modify-device" ||
action.id == "org.freedesktop.color-manager.modify-profile") &&
subject.isInGroup("{group}")) {
return polkit.Result.YES;
}
});

sudo apt-get install gnome-tweak-tool -y

sudo apt install policykit-1-gnome
sudo gnome-software
sudo chown labuser:labuser /usr/bin/gnome-software
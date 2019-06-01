
```shell
sudo apt-get update

sudo apt-get install -y ubuntu-gnome-desktop

sudo apt-get install -y xrdp

sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config

sudo nano /etc/polkit-1/localauthority.conf.d/02-allow-colord.conf
```
/etc/polkit-1/localauthority.conf.d/02-allow-colord.conf 파일에 아래 내용 추가하고 저장

```
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
```

아래 추가 실행

```shell
sudo apt-get install gnome-tweak-tool -y

sudo apt install policykit-1-gnome
sudo gnome-software
sudo chown <<user_name>>:<<user_name>> /usr/bin/gnome-software
```


* ref : [http://www.techkb.onl/azure-installing-gnome-desktop-and-xrdp-to-access-an-ubuntu-1710-server/](http://www.techkb.onl/azure-installing-gnome-desktop-and-xrdp-to-access-an-ubuntu-1710-server/)


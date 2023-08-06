#!/bin/bash

# install dwm
read -p "install dwm? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd x11/dwm/
    make clean
    doas make clean install
    make clean
    cd ../..
fi

# install st
read -p "install st? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd x11/st/
    make clean
    doas make clean install
    make clean
    cd ../..
fi

# install slock
read -p "install slock? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd x11/slock/
    make clean
    doas make clean install
    make clean
    cd ../..
fi

# update emacs.d
read -p "update .emacs.d? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -r ~/.emacs.d.old
    mv ~/.emacs.d ~/.emacs.d.old
    cp -r ./apps/emacs.d ~/.emacs.d
fi

# update bashrc
read -p "update .bashrc and .bash_profile? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mv ~/.bashrc ~/.bashrc.old
    cp ./rc/bashrc ~/.bashrc
    mv ~/.bash_profile ~/.bash_profile.old
    cp ./rc/bash_profile ~/.bash_profile
fi

# update xsession
read -p "update .xsession? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mv ~/.xsession ~/.xsession.old
    cp ./rc/xsession ~/.xsession
fi

# update ncmpcpp
read -p "update .config/ncmpcpp? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -r ~/.config/ncmpcpp.old
    mv ~/.config/ncmpcpp ~/.config/ncmpcpp.old
    cp -r apps/ncmpcpp ~/.config/
fi

# update themes
read -p "update themes? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    doas cp -r themes/Numix /usr/share/themes/
    doas chmod u=rwx,g=rx,o=rx -R /usr/share/themes/Numix
    mv ~/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini.old
    cp themes/settings.ini ~/.config/gtk-3.0/settings.ini
fi

# update xorg.conf.d
read -p "update xorg.conf.d? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    doas rm -r /etc/X11/xorg.conf.d.old
    doas mv /etc/X11/xorg.conf.d /etc/X11/xorg.conf.d.old
    doas cp -r ./x11/xorg.conf.d /etc/X11/xorg.conf.d
fi

# update fp
read -p "fp.sh? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mv ~/.local/bin/fp ~/.local/bin/fp.old
    cp ./misc/launchers/fp.sh ~/.local/bin/fp
    chmod +x ~/.local/bin/fp
fi

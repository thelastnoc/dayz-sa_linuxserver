#!/bin/bash
# the script needs root or sudo privileges
if [ "$(sudo -v)" != "" ]; then
        printf "[ FAIL ] You have to run this script as root!\n"
        exit 1
fi

# get the distribution of the os
distroid=$(grep ID /etc/os-release | grep -v _ID | grep -v ID_ | sed 's/ID=//g' | sed 's/\"//g')
# debian and ubuntu
if [ "${distroid}" == "debian" ] || [ "${distroid}" == "ubuntu" ]; then
        wget -nc https://dl.winehq.org/wine-builds/Release.key
        sleep 0.5
        sudo apt-key add Release.key
        printf "deb https://dl.winehq.org/wine-builds/${distroid}/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/winehq.source.list > /dev/null
        # ubuntu serves needs universe repo
        if [ "${distroid}" == "ubuntu" ]; then
                sudo add-apt-repository universe
        fi
        # install required packages
        sudo dpkg --add-architecture i386
        sudo apt install apt-transport-https -y
        sudo apt update
        sudo apt install --install-recommends winehq-stable xvfb winbind tmux nano htop curl lib32gcc1 libstdc++6 libstdc++6:i386 psmisc wget -y
# archlinux
elif [ "${distroid}" == "arch" ]; then
        sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
        sudo locale-gen
        # enable multilib
        mlibln=$(grep -nr multilib] pacman.conf | cut -d : -f 1)
        sudo sed -i "${mlibln}s/^#//g" /etc/pacman.conf
        mlibln=$(($mlibln + 1))
        sudo sed -i "${mlibln}s/^#//g" /etc/pacman.conf
        sudo pacman -Syu
        sudo pacman -S wine xorg-server-xvfb tmux nano htop curl psmisc wget lib32-gcc-libs
else
        printf "[ INFO ] Your Linux Distribution is not tested yet.\n"
fi


# add a new user for the gameserver
sudo useradd -m -s /bin/bash dayz
sleep 0.5
sudo su - dayz

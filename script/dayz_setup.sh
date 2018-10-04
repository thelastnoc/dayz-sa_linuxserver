# the script needs root or sudo privileges
if [ "$(sudo -v)" != "" ]; then
        printf "[ FAIL ] You have to run this script as root!\n"
        exit 1
fi

sudo dpkg --add-architecture i386
# get the distribution of the os
distroid=$(grep ID /etc/os-release | grep -v _ID | grep -v ID_ | sed 's/ID=//g' | sed 's/\"//g')

# debian and ubuntu will pass
if [ "${distroid}" == "debian" ] || [ "${distroid}" == "ubuntu" ]; then
        wget -nc https://dl.winehq.org/wine-builds/Release.key
        sleep 0.5
        sudo apt-key add Release.key
        printf "deb https://dl.winehq.org/wine-builds/${distroid}/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/winehq.source.list > /dev/null
else
        printf "[ INFO ] Your Linux Distribution wasn't tested yet.\n"
fi

# ubuntu serves needs universe repo
if [ "${distroid}" == "ubuntu" ]; then
        sudo add-apt-repository universe
fi

# install required packages
sudo apt install apt-transport-https -y
sudo apt update
sudo apt install --install-recommends winehq-stable xvfb winbind tmux nano htop curl lib32gcc1 libstdc++6 libstdc++6:i386 psmisc -y

# add a new user for the gameserver
sudo useradd -m -s /bin/bash dayz && sudo su - dayz

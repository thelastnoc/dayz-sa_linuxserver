WIP

# debian 9
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/Release.key | sudo apt-key add Release.key
printf "deb https://dl.winehq.org/wine-builds/debian/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/winehq.source.list > /dev/null
sudo apt install apt-transport-https -y


# ubuntu
sudo add-apt-repository universe && sudo apt update
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/Release.key | sudo apt-key add Release.key
printf "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/winehq.source.list > /dev/null
sudo apt install apt-transport-https -y

# packs
sudo apt update && sudo apt install --install-recommends winehq-stable xvfb winbind tmux nano htop curl lib32gcc1 libstdc++6 libstdc++6:i386 psmisc -y

sudo useradd -m -s /bin/bash dayz && sudo su - dayz

# Prevent from running this script as root.
if [ "$(whoami)" == "root" ]; then
                printf "[ \033[0;31mFAIL\033[0m ] \033[01;33mDo NOT run this script as root!\n         Switch to the dayz user!\033[0m\n"
                exit 1
	else
    if [ ! -d "steamcmd" ]; then
      mkdir steamcmd
      curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - -C steamcmd
    fi

    if [ ! -d "serverfiles" ]; then
      mkdir serverfiles
    fi

    printf "tmux send-keys C-c -t dayzserver > /dev/null 2>&1\nsleep 5\nsteamcmd/steamcmd.sh +login username +@sSteamCmdForcePlatformType windows +force_install_dir ~/serverfiles +app_update 223350 validate +quit" > install_dayz.sh \
    && printf "export WINEARCH=win64\nexport WINEPREFIX=~/.wine64\ntmux send-keys C-c -t dayzserver > /dev/null 2>&1\nsleep 5\ntmux new-session -d -x 23 -y 80 -s dayzserver xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine serverfiles/DayZServer_x64.exe -config=serverDZ.cfg -port=2302 -freezecheck" > start_dayz.sh \
    && chmod u+x install_dayz.sh && chmod u+x start_dayz.sh && nano install_dayz.sh && ./install_dayz.sh
	fi
fi

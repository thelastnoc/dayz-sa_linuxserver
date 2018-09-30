tmux send-keys C-c -t dayzserver > /dev/null 2>&1
sleep 5
steamcmd/steamcmd.sh +login username +@sSteamCmdForcePlatformType windows +force_install_dir ~/serverfiles +app_update 223350 validate +quit

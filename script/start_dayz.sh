export WINEARCH=win64
export WINEPREFIX=~/.wine64
tmux send-keys C-c -t dayzserver > /dev/null 2>&1
sleep 5
tmux new-session -d -x 23 -y 80 -s dayzserver xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine serverfiles/DayZServer_x64.exe -config=serverDZ.cfg -port=2302 -freezecheck

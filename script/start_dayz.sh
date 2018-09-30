export WINEARCH=win64
export WINEPREFIX=~/.wine64
tmuxstatus=$(tmux list-sessions -F dayzserver | grep -Ecx dayzserver)

fn_start_dayz(){
tmux new-session -d -x 23 -y 80 -s dayzserver xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine ~/test/serverfiles/DayZServer_x64.exe -config=serverDZ.cfg -port=2302 -freezecheck
}

if [ "{dayzstatus}" == "1" ]; then
printf "[ \033[0;33mDayZ\033[0m ] Server already running. Terminating\n"
tmux send-keys C-c -t dayzserver > /dev/null 2>&1
sleep 5
fi

if [ -d ".wine64" ]; then
tmux send-keys C-c -t dayzserver > /dev/null 2>&1 sleep 10
printf "[\033[0;32m DayZ \033[0m] Starting server...\n"
fn_start_dayz
else
printf "[ \033[01;33mINFO\033[0m ] The first start of the server may freeze!\n         Please start the server again with \033[0;32m./start_dayz.sh\033[0m\n"
fn_start_dayz
sleep 5
killall -u dayz
fi

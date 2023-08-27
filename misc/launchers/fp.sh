#!/bin/bash

steam-launch() {
    if [[ $(ps -x | grep -i steam | wc -l) -gt 1 ]]; then
        xdg-open steam://rungameid/$1
    fi
}

batch-kill () {
    ps -x | grep -i $1 | awk '{print $1}' | xargs kill
}

obs-studio() {
    APPID="1905180"
    steam-launch $APPID &
    obs --startreplaybuffer
    batch-kill $APPID
}

plutonium() {
    xrandr --output HDMI-A-0 --off

    MOUSEDEV=$(ratbagctl list | awk {'print $1'} | cut -f1 -d':')
    ratbagctl $MOUSEDEV rate set 100

    WINECOMMAND=/usr/bin/wine64
    MYPFXDIR=/mnt/sda/games/wine-plutonium/pfx
    APPID=""

    case $1 in
        'winecfg')
            WINEPREFIX=$MYPFXDIR $WINECOMMAND winecfg;;
        'mw3')
            APPID='42690';;
        'bo2')
            APPID='202990';;
        'bo2z')
            APPID='212910';;
        'waw')
            APPID='10090';;
        *)
            APPID="-1";;
    esac

    steam-launch -i $APPID &

    st -e "WINEPREFIX=$MYPFXDIR DXVK_STATE_CACHE=1 DXVK_STATE_CACHE_PATH=$MYPFXDIR STAGING_SHARED_MEMORY=0 __GL_SHADER_DISK_CACHE=1 __GL_SHADER_DISK_CACHE_PATH=$MYPFXDIR __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=true __GL_THREADED_OPTIMIZATIONS=1 $WINECOMMAND $MYPFXDIR/../plutonium.exe"

    ratbagctl $MOUSEDEV rate set 1000

    batch-kill $APPID
    batch-kill 'Call of Duty'

}

clonehero() {
    APPID=1224900
    steam-launch $APPID &
    st -e "/mnt/sdg/games/clonehero/clonehero"
    batch-kill $APPID
}

usc() {
    APPID=980610

    OUTPUT="DisplayPort-2"

    xrandr --output $OUTPUT --rotate right

    steam-launch $APPID &

    /mnt/sdg/games/sdvx/usc-game

    xrandr --output $OUTPUT --rotate normal

    batch-kill $APPID
}

osu() {
    APPID=607260
    steam-launch $APPID &
    st -e "/mnt/sdc/games/pc/osu/osu.AppImage"
    batch-kill $APPID
}
APP="echo 'application not found: $@'"

declare -A APPS=(
    [steam]='flatpak run com.valvesoftware.Steam'
    [jd]='dbus-run-session flatpak run org.jdownloader.JDownloader'
    [plutonium]='plutonium'
    [usc]='usc'
    [ch]='clonehero'
    [obs]='obs-studio'
    [osu]='osu'
)

! [[ -z ${APPS[$1]} ]] && echo "launching $1" && APP=${APPS[$1]}

$APP $2

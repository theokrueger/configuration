#!/bin/bash
obs-studio() {
    APPID="1905180"

    samrewritten -i $APPID &

    obs --startreplaybuffer

    ps -x | grep -i $APPID | awk {'print $1'} | xargs kill
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

    WINEPREFIX=$MYPFXDIR DXVK_STATE_CACHE=1 DXVK_STATE_CACHE_PATH=$MYPFXDIR STAGING_SHARED_MEMORY=0 __GL_SHADER_DISK_CACHE=1 __GL_SHADER_DISK_CACHE_PATH=$MYPFXDIR __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=true __GL_THREADED_OPTIMIZATIONS=1 $WINECOMMAND $MYPFXDIR/../plutonium.exe &

    samrewritten -i $APPID

    ratbagctl $MOUSEDEV rate set 1000

    #WINEPREFIX=$MYPFXDIR wine64 $MYPFXDIR/../plutonium.exe

    ps -x | grep -i $APPID | awk {'print $1'} | xargs kill
    ps -x | grep -i 'Call of Duty' | awk {'print $1'} | xargs kill

    xrandr --output HDMI-A-0 --auto
    xrandr --output HDMI-A-0 --left-of DisplayPort-2
}

clonehero() {
    APPID=1224900

    /mnt/sdg/games/clonehero/clonehero &

    samrewritten -i $APPID

    ps -x | grep -i $APPID | awk {'print $1'} | xargs kill
}

usc() {
    APPID=980610

    xrandr --output DisplayPort-2 --rotate right

    samrewritten -i $APPID &

    /mnt/sdg/games/sdvx/usc-game

    xrandr --output DisplayPort-2 --rotate normal

    ps -x | grep -i $APPID | awk {'print $1'} | xargs kill
}

APP="echo 'application not found: $@'"

declare -A APPS=(
    [freetube]='dbus-run-session flatpak run io.freetubeapp.FreeTube'
    [steam]='flatpak run com.valvesoftware.Steam'
    [jd]='dbus-run-session flatpak run org.jdownloader.JDownloader'
    [plutonium]='plutonium'
    [fgo]='/home/me/Android/Sdk/emulator/emulator -avd FGO'
    [usc]='usc'
    [clonehero]='clonehero'
    [ch]='st -e fp clonehero'
    [obs]='obs-studio'
    [osu]='/mnt/sdc/games/pc/osu/osu.AppImage'
    [tf2]='/mnt/sdg/games/steam/steamapps/common/Titanfall2/Viper-1.6.3.AppImage'
)

! [[ -z ${APPS[$1]} ]] && echo "launching $1" && APP=${APPS[$1]}

$APP $2

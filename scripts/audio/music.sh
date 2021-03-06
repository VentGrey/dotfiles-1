#!/usr/bin/env bash

APPNAME=Music
ICON=""

case $1 in
    "pos")
        if [[ -z $2 ]] || [[ -z $3 ]]
        then
            printf "Are needed at least two more arguments (+|-, numeric).\n"
            exit
        fi
        case $2 in
            "+")
                ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-seek-forward.svg
                ;;
            "-")
                ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-seek-backward.svg
                ;;
            *)
                exit
                ;;
        esac
        ;;
    "next")
        ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-skip-forward.svg
        ;;
    "prev")
        ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-skip-backward.svg
        ;;
    "play")
        ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playback-start.svg
        ;;
    "pause")
        ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playback-pause.svg
        ;;
    "toggle")
        if [[ $(playerctl status) = Playing ]]
        then
            ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playback-start.svg
        else
            ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playback-pause.svg
        fi
        ;;
    "toggle-random")
        if [[ $(mpc | sed -E -e '3,3!d' -e 's/.*dom: ([a-z]+).*/\1/') = on ]]
        then
            ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playlist-repeat.svg
        else
            ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playlist-shuffle.svg
        fi
        ;;
esac

source $HOME/.config/scripts/lib/notify.sh


MPD=$(playerctl -l | grep mpd)
MPV=$(playerctl -l | grep mpv)
PLM=$(playerctl -l | grep plasma)
MSC=''

[[ -z $MPD ]] || MSC=$MPD   # Works thank to mpd-mpris
[[ -z $PLM ]] || MSC=$PLM   # Works thank to plasma-browser-integrations
[[ -z $MPV ]] || MSC=$MPV   # Works thank to mpv-mpris

case $1 in
    "pos")
        SEEK=$3
        if [[ $2 = "+" ]]
        then
            playerctl --player=$MSC position $SEEK+
        else
            playerctl --player=$MSC position $SEEK-
        fi
        ;;
    "next")
        playerctl --player=$MSC next
        ;;
    "prev")
        playerctl --player=$MSC previous
        ;;
    "play")
        playerctl --player=$MSC play
        ;;
    "pause")
        playerctl --player=$MSC pause
        ;;
    "toggle")
        playerctl --player=$MSC play-pause
        ;;
    "toggle-random")
        mpc random
        notify "Music" "Random $(mpc | sed -E -e '3,3!d' -e 's/.*dom: ([a-z]+).*/\1/')" "true"
        exit
        ;;
esac

STATUS="$(playerctl status)"
SONG="$(playerctl --player=$MSC metadata --format '{{title}} ({{artist}})' | colrm 20)"

notify "$SONG" "$STATUS" "true"

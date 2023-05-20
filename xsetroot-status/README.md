# xsetroot-status

text-based statusbar using `xsetroot` to display various modules of information

## directory

- [current-functions](#functions)
  - [track](#track)
  - [memory](#memory)
  - [storage](#storage)
  - [battery](#battery)
  - [brightness](#brightness)
  - [date](#date)
  - [game](#game)
- [installation](#installation)
- [usage](#usage)

## functions

### `track`

displays what is now playing using playerctl metadata

format:
```
<status>: <track title> <pos>/<len>
```

display:
```
Playing: Touhiron 3:42/4:35
```

dependencies: `playerctl`

### `memory`

displays used memory

format:
```
mem: <usedmem><unit of storage>
```

display:
```
mem: 6.9Gi
```

### `drives`

cycles printing all storage drives and their % usage

format:
```
<disk><spacing><percent used>
```

display:
```
sda 42%
```

### `battery`

displays current battery status and charge %

format
```
<status>: <percentage>%
```

display:
```
Charging: 69%
```

### `brightness`

displays current screen brightness (for laptops)

format
```
BL: <brightness>%
```

display:
```
BL: 13%
```

dependencies: `brightnessctl`

### `iso_time`

displays current date and time

format:
```
[<weekday>] <fullyear>-<month>-<day> <time>
```

display:
```
[4] 1970-01-01 00:00
```

### `game`

play a highscore-based engagement game

score is ticks survived, run `touch /tmp/xsetroot_game.play` to
refill tags

format:
```
[<score>] [<status>]
```

display:
```
[23] [#######   ]
```

## installation

1. download

```
$ git clone https://gitlab.com/theokrueger/configuration
$ cd configuration/xsetroot-status/
```

2. install dependencies

gentoo
```
$ emerge -a x11-apps/xsetroot media-sound/playerctl app-misc/brightnessctl
```

brightnessctl can be found in the [guru](https://wiki.gentoo.org/wiki/Project:GURU) overlay

3. make the script and modules executable

```
$ chmod +x xsetroot-status.sh functions/*
```

## usage

simply run the script and xsetroot will be updated:

```
$ ./xsetroot-status.sh
```

if you would like your bar to be displayed when x starts, add it to your `.xinitrc`

## customisation

edit the `xsetroot-status.sh` file

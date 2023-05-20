#!/bin/sh

# game module for xsetroot-status
# theokrueger <git@gitlab.com/theokrueger>
# MIT License

# module dependencies:
# none

# gain score as meter goes down, `touch /tmp/xsetroot_game.play` to refill meter

GAME_FILE='/tmp/xsetroot_game.play'
GAME_SCORE=0
GAME_STATE=10
GAME_STATE_MAX=10
GAME_FILL_CHAR='#'

function game()
{
	STR=""
	for (( i=0; i < $GAME_STATE; i++ )); do
		STR="$STR$GAME_FILL_CHAR"
	done
	for (( i=0; i < $(( $GAME_STATE_MAX - $GAME_STATE )); i++ )); do
		STR="$STR "
	done
	echo "[$GAME_SCORE] [$STR]"
}

function game_play()
{
        # play a game
	# [score] [state]
        # for example:
        # [12] [########  ]
	if [ -f "$GAME_FILE" ]; then
		rm $GAME_FILE
		GAME_STATE=$GAME_STATE_MAX
	fi
	if [[ $(($RANDOM % 20)) == 0 ]]; then
		GAME_SCORE=$(( $GAME_SCORE + 1 ))
		GAME_STATE=$(( $GAME_STATE -1 ))
		if [[ $GAME_STATE -lt 0 ]]; then
			# game over
			GAME_SCORE=0
			GAME_STATE=$GAME_STATE_MAX
		fi
	fi
}

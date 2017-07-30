SCRIPT=$(basename "$0")

#Choose path

PICTURE_DIR="$HOME/BingWallpaper"
mkdir -p "$PICTURE_DIR"

help() {
cat <<- _EOF_
Usage:
    $SCRIPT [options]
    $SCRIPT -h | --help

Options:
    -r --random                    Randomly get a wallpaper from www.bing.com.
    -n                             Get a wallpaper n days ago.
                                    (e.g. "./Wallpaper.sh -5" where n = 5)
    -c --clean                     Clean all pictures.
    -h --help                      Show this help.
_EOF_
}

if [ $# == 0 ]; then
	PICTURE_URL="http://bing.ioliu.cn/v1?w=1980&h=1200"
else
	case $1 in
        -r|--random)
            PICTURE_URL="http://bing.ioliu.cn/v1/rand?w=1980&h=1200"
            ;;
        -h|--help)
            help
			exit 1
            ;;
        -c|--clean)
            rm $PICTURE_DIR/*
            echo "All cleaned up."
			exit 1
            ;;
        *)
			if [[ ${1:1:1} =~ ^[0-9]+$ ]]; then
				PICTURE_URL="http://bing.ioliu.cn/v1?d=${1:1:1}&w=1980&h=1200"
			else
				help
				exit 1
			fi
            ;;
    esac
fi
PICTURE_TIME=`date "+%Y-%m-%d %H:%M"`
PICTURE="$PICTURE_DIR/Paper$PICTURE_TIME.jpeg"
if [[ $( curl -sLo "$PICTURE" "$PICTURE_URL" ) ]]; then
    echo -e "Connect Fail...\nPlease check the internet." >&2
    exit 1
fi


if [[ ! $( osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$PICTURE\"" ) ]]; then
    echo -e "Success! Have a nice day."
    exit
else
    for time in {0..2}; do 
        sleep 3
        echo "Retrying the $(( time+1 )) time(s)."
        if [[ ! $( osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$PICTURE\"" ) ]]; then
            echo -e "Success! Have a nice day."
            exit
        fi
    done
    echo "Sorry, the script failed." >&2
    exit 2
fi

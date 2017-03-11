SCRIPT=$(basename "$0")
#默认壁纸下载路径，可自行更改
PICTURE_DIR="$HOME/Pictures/BingWallpaper"
mkdir -p "$PICTURE_DIR"

help() {
cat <<EOF
Usage:
  $SCRIPT [options]
  $SCRIPT -h | --help

Options:
  -r --random                    Randomly get a wallpaper from www.bing.com.
  -n                             Get a wallpaper n days ago.
                                 (e.g. "./Wallpaper.sh -5" where n = 5)
  -h --help                      Show this help.
EOF
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
        *)
			if [[ ${1:1:1} =~ ^-?[0-9]+$ ]]; then
				PICTURE_URL="http://bing.ioliu.cn/v1?d=${1:1:1}&w=1980&h=1200"
			else
				help
				exit 1
			fi
            ;;
    esac
fi
#用系统时间保证命名唯一
PICTURE_TIME=`date "+%Y-%m-%d %H:%M:%S"`
PICTURE="$PICTURE_DIR/Paper$PICTURE_TIME.jpeg"
curl -sLo "$PICTURE" "$PICTURE_URL"
#使用AppleScript来更新壁纸
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$PICTURE\""
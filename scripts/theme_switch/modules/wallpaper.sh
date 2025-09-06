THEME=$1
MODE=$2

PID_FILE=$HOME/.cache/wallpaper_slide.pid

if [[ -z $MODE ]]; then
    MODE=static
fi

if [[ -f $PID_FILE ]]; then
    previous_process=$(< $PID_FILE) 
    log "\tPreparing to kill slide (PID: $previous_process)"

    if kill -0 $previous_process 2> /dev/null; then
        log "\tKilling previous slide"
        kill $previous_process
        rm -f $PID_FILE
    fi
fi

$SCRIPT_DIR/../wallpaper_manager/wallpaper_manager.sh $THEME $MODE 1> /dev/null &
PID=$!

if [[ $MODE == 'slide' ]]; then
    log "\tSaving new PID (PID: $PID)"
    echo "$PID" > "$PID_FILE"
fi


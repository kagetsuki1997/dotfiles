SCREENSHOT_DIR_PATH="$HOME/Screenshots"
TMP_SCREENSHOT_DIR_PATH="$HOME/ramdisk/Screenshots"
TIMESTAMP_FORMAT='+%Y-%m-%d-%H:%M:%S%z'

maim-save() {
    if [[ ! -d $SCREENSHOT_DIR_PATH ]]; then
        mkdir -p "$SCREENSHOT_DIR_PATH"
    fi

    filename="$SCREENSHOT_DIR_PATH/screenshot-$(date $TIMESTAMP_FORMAT).png"
    echo "Screenshot: $filename"
    maim $@ >$filename
}

maim-range() {
    maim-save -s
}

maim-save-tmp() {
    if [[ ! -d $TMP_SCREENSHOT_DIR_PATH ]]; then
        mkdir -p "$TMP_SCREENSHOT_DIR_PATH"
    fi

    filename="$TMP_SCREENSHOT_DIR_PATH/screenshot-$(date $TIMESTAMP_FORMAT).png"
    echo "Screenshot: $filename"
    maim $@ >$filename
}

maim-range-tmp() {
    maim-save-tmp -s
}

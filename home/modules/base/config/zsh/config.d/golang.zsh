function tmp-gopath() {
    TMP_DIR=/tmp
    TMP_GOPATH="${TMP_DIR}/go"

    mkdir -pv ${TMP_GOPATH}/{bin,pkg,src}

    export GOPATH=$TMP_GOPATH
    echo "GOPATH=$GOPATH"
}

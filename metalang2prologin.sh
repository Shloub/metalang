
rename () {
    local i
    local filename
    for i in `ls "$1"`; do
        filename="${i%.*}"
        if [ "$filename" != "ref" ]; then
        if [ "$filename" != "gen" ]; then
        if [ "$filename" != "gentests" ]; then
        if [ "$filename" != "gen-worstcase" ]; then
        extension="${i##*.}"
        if [ "$extension" = "$2" ] ; then
            git mv "$1/$filename.$2" "$1/$filename.$3"
            mv "$1/$filename.$2" "$1/$filename.$3"
        fi
        fi
        fi
        fi
        fi
    done

}

indir() {
    rename $1 "py" "py3"
    rename $1 "ml" "ocaml"
    rename $1 "cc" "c++"
}

indir "."

for i in `ls`; do
    if [ -d "$i" ]; then
        indir "$i"
    fi
done



rename () {
    local i
    local filename
    for i in `ls "$1"`; do
        filename="${i%.*}"
        extension="${i##*.}"
        if [ "$extension" = "$2" ] ; then
            git mv "$1/$filename.$2" "$1/$filename.$3"
        fi
    done

}

for i in `ls`; do
    rename $i "py" "py3"
    rename $i "ml" "ocaml"
    rename $i "cc" "c++"
done


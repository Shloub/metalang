
count(){
		find out -name "$1" -exec cat {} \; | wc "$2"
}

st(){
		lines=`count "$1" "-l"`
		chars=`count "$1" "-c"`
		echo -e "$1\t$lines\t$chars"
}
echo "GENERATED CODE"
echo -e "----\tLines\tChars"
st "*.c"
st "*.cc"
st "*.ml"
st "*.php"
st "*.js"
st "*.go"
st "*.cl"
st "*.py"
st "*.rb"
st "*.cs"
st "*.java"

echo "metalang :"
find . -name "*.metalang" -exec cat {} \; | wc

echo "compiler :"
find . -name "*.ml"  -not -path "./tests/"  -not -path "./_build/*" -exec cat {} \; | wc

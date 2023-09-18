rm -rf llvm-project
git clone https://github.com/llvm/llvm-project --branch release/16.x --depth=1
cd llvm-project
git checkout 7cbf1a259
cd ..

for file in `find cmake compiler-rt -type f`
do
    if ! cmp --silent -- "$file" "llvm-project/$file"; then
      echo "$file may be modified"
    fi
done

# bin/bash
echo "Building the lexical parser"

# Compile the lexical parser
for folder in $(ls -d */)
do
    echo "Building $folder"
    cd $folder
    for file in $(ls *.l)
    do
        echo "Building $file"
        filename=$(basename -- $file)
        filename="${filename%.*}"
        lex -o $filename.c $file 
        gcc $filename.c -lfl -o $filename
        echo "Done building $file"
    done
    cd ..
    echo "Done building $folder"
done

cFile=$1.c
hFile=$1.h

echo "id,grade" > grade.csv
for dir in */ ; do
    if [[ $(basename "$dir") =~ ^[0-9] ]]; then
        echo "dir: $dir"
        id=$(basename "$dir")

        # Copy the files to the root directory
        cp ${dir}/$cFile .
        cp ${dir}/$hFile .

        # Compile and run the program
        gcc Main.c $cFile -o ${dir}/a.out
        ${dir}/a.out > ${dir}output.txt

        # Compare the output to the answer
        diff -w ${dir}output.txt answer.txt > ${dir}/diff.txt

        # If the diff file is empty, then the output is correct
        if [ ! -s ${dir}diff.txt ]; then
            touch "${dir}/100"
            echo "${id},100" >> grade.csv
        else
            touch "${dir}/0"
            echo "${id},0" >> grade.csv
        fi

        # Remove the files from the root directory
        rm -f $cFile
        rm -f $hFile
    fi
done

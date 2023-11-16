unzip *.zip

for dir in */; do
    if [[ -d "$dir" ]]; then
        new_name=$(echo "${dir%/}" | cut -d' ' -f1)
        mv "$dir" "$new_name"
    fi
done

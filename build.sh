#!/bin/bash

# Define color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_colored() {
    local message_color=$1
    local message=$2
    echo -e "${message_color}${message}${NC}"
}

# Function to draw progress bar
draw_progress_bar() {
    local percent=$1
    local bar_length=50
    local filled_length=$((bar_length * percent / 100))

    printf "\rProgress: [%s] %3d%%" \
           "$(printf '%*s' $filled_length | tr ' ' '=')" \
           $percent
}

# Print initial message
print_colored $GREEN "Building the lexical parser\n"

# Compile the lexical parser
total_files=0
built_files=0
current_folder=0
curr_built=0
for folders in $(ls -d */); do
    if (ls $folders*.l 1> /dev/null 2>&1); then
        print_colored $GREEN "Found lex files in $folders\n"
    else
        print_colored $YELLOW "No lex files found in $folders\n"
        continue
    fi
    for files in $(ls $folders*.l); do
        total_files=$((total_files+1))
    done
done


for folder in $(ls -d */); do
    current_folder=$((current_folder+1))
    print_colored $YELLOW "Building $folder"
    cd $folder || { print_colored $RED "Failed to change directory to $folder"; continue; }

    if (ls *.l 1> /dev/null 2>&1); then
        print_colored $GREEN " Found lex files in $folder"
    else
        print_colored $RED " No lex files found in $folder"
        cd .. || { print_colored $RED "Failed to change directory back to parent"; continue; }
        continue
    fi

    for file in $(ls *.l); do

        filename=$(basename -- $file)
        filename="${filename%.*}"

        if [ -f $filename ]; then
            print_colored $RED " $filename already exists. Skipping building $file\n"
            built_files=$((built_files+1))
            continue
        fi

        print_colored $YELLOW " Building $file"
        lex -o $filename.c $file > /dev/null 2>&1 || { print_colored $RED "Failed to build $file"; continue; }
        gcc $filename.c -lfl -o $filename > /dev/null 2>&1 || { print_colored $RED "Failed to compile $filename"; continue; }
        built_files=$((built_files+1))
        curr_built=$((curr_built+1))
        print_colored $GREEN "\n Done building $file"
    done
    if [ $built_files -eq $total_files ]; then
    progress_percent=100
    else
    progress_percent=$(($built_files * 100 / ($total_files)))
    fi
    draw_progress_bar $progress_percent
    cd .. || { print_colored $RED "Failed to change directory back to parent"; continue; }
    print_colored $GREEN "\nDone building $folder\n"
done

# Calculate and print progress bar
if [ $total_files -eq 0 ]; then
    progress_percent=0
else if [ $built_files -eq $total_files ]; then
    progress_percent=100
else
progress_percent=$(($built_files * 100 / ($total_files)))
fi
fi
draw_progress_bar $progress_percent
# Print summary
print_colored $GREEN "\n\nTotal files: $total_files\nBuilt files: $curr_built\n"
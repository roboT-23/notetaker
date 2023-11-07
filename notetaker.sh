#!/bin/bash

# One night project no.1
# NoteTaker - minimal note taking script

# Features:
# - Add note
# - Delete note
# - Edit note
# - Open note in editor
# - Copy note to clipboard
# - List all notes

# Requirements:
# - FZF (sudo apt install fzf)
# - xclip (sudo apt install xclip)
# - nano (sudo apt install nano)

# Author: @roboT-23
# Version: 0.1
# Date: 2023-11-06
# License: MIT

#Set whatever directory you want
notes_directory="$HOME/projects/notetaker/notes"


# Create a directory if not already created one 
if [ ! -d "$notes_directory" ]; then
    mkdir "$notes_directory"
fi


# List all notes
show_notes() {
clear
echo -e "\e[33m================================#\e[0m"
    
echo -e "\e[33m===\e[0m Notes list: \e[33m================#\e[0m"
    for note in "$notes_directory"/*; do
        if [ -f "$note" ]; then
            filename=$(basename "$note")
            creation_date=$(stat -c %y "$note" | cut -d ' ' -f1)
            echo -e "\e[1;34m$filename\e[0m \e[0;32m$creation_date\e[0m"
        fi
    done
echo -e "\e[33m================================#\e[0m"
    
}


# Function to add note
add_note() {
clear
    echo -e  "\e[1;32m+++\e[0m Insert note name \e[1;32m+++#\e[0m"
    read note_title
    # You can create whatever file format you need - .md/.txt ...
    new_note="$notes_directory/$note_title.txt"

    if [ -e "$new_note" ]; then
        echo "Note with this name already exists, do you want to edit? (Y/N): "
        read response
        if [ "$response" == "Y" ] || [ "$response" == "y" ]; then
            nano "$new_note"
        echo -e "\e[32m===\e[0m Editing...		\e[32m========#\e[0m"
        echo -e "\e[33m*==============================*#\e[0m"

	else
        echo -e "\e[31m===\e[0m Operation cancelled \e[31m========#\e[0m"
        echo -e "\e[33m*==============================*#\e[0m"
	fi
    else
        echo -e "\e[33m===\e[0m Note was added \e[33m=============#\e[0m"
        echo -e "\e[33m*===============================*\e[0m"
	nano "$new_note"
    fi

}

# Delete note function
delete_note() {
clear    
show_notes
    echo -e "\e[36m===\e[0m Select note to delete \e[36m======#\e[0m" 
    note_to_delete=$(ls "$notes_directory" | fzf) # FZF 
    if [ -e "$notes_directory/$note_to_delete" ]; then
        rm "$notes_directory/$note_to_delete"
        echo "$note_to_delete"
	echo -e "\e[31m===\e[0m Note was deleted \e[31m===========#\e[0m" 
   else
       
	echo -e "\e[33m===\e[0m Note does not exist \e[33m==========#\e[0m"
    fi
}


# Edit function
edit_note() {
clear    
show_notes
    echo -e "\e[33m*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*#\e[0m"
    echo -e "\e[32m~~~\e[0m Select note to edit	     \e[32m~~~#\e[0m "
    note_to_edit=$(ls "$notes_directory" | fzf) # FZF 
    echo "$note_to_edit"
    if [ -e "$notes_directory/$note_to_edit" ]; then
        echo -e "\e[32m~~~\e[0m Editing...              \e[32m ~~~#\e[0m"
        echo -e "\e[33m*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*#\e[0m"

        nano "$notes_directory/$note_to_edit" # Change nano to your favorite editor
    
    
    fi
}
#Copy to clipboard
copy_note() {
clear 
show_notes
 note_to_copy=$(ls "$notes_directory" | fzf)
	 if [ -f "$notes_directory/$note_to_copy" ]; then
		echo -e "\e[33m*##############################*#\e[0m"
		echo -e "\e[33m###\e[0m Copying to clibpboard... \e[33m####\e[0m"
		echo "$note_to_copy"
	        echo -e "\e[33m*##############################*#\e[0m"
	        cat "$notes_directory/$note_to_copy" | xclip -selection clipboard
	 fi
}
# Opens note in editor
open_note() {
    clear
    show_notes
    echo -e "\e[36m===\e[0m Select note to open \e[36m=======#\e[0m"
    note_to_open=$(ls "$notes_directory" | fzf) # FZF
    if [ -e "$notes_directory/$note_to_open" ]; then
	echo "$note_to_open"
        nano "$notes_directory/$note_to_open"
    else
        echo -e "\e[33m===\e[0m Note does not exist \e[33m==========#\e[0m"
    fi
}

# Main routine
while true; do
    echo -e "\e[42m#########--\e[0m NoteTaker \e[42m--#########\e[0m"    
    echo -e "\e[32m================================#\e[0m"
    echo -e "\e[36m***\e[0m Select option:	     \e[36m***#\e[0m"
    echo -e "\e[1;35m===\e[0m 1. List all		     \e[1;35m===#\e[0m"
    echo -e "\e[1;32m+++\e[0m 2. Add note		     \e[1;32m+++#\e[0m "
    echo -e "\e[1;31m---\e[0m 3. Delete note	     \e[1;31m---#\e[0m"    
    echo -e "\e[1;33m~~~\e[0m 4. Edit note	     \e[1;33m~~~#\e[0m"
    echo -e "\e[1;43m###\e[0m 5. Copy note	     \e[1;43m####\e[0m"
    echo -e "\e[1;32mOOO\e[0m 6. Open note	     \e[1;32mOOO#\e[0m"
    echo -e "\e[1;31mXXX\e[0m 7. Exit		     \e[1;31mXXX#\e[0m"
    echo -e "\e[32m================================#\e[0m"
    read choice

    case $choice in
        1)
            show_notes
            ;;
        2)
            add_note
            ;;
        3)
            delete_note
            ;;
        4)
            edit_note
            ;;
	5)
	    copy_note
	    ;;
	6)
	    open_note
	    ;;
        7)	
	        echo -e "\e[1;33m    __"
                echo -e "___( o)>"
                echo -e "\ <_. )"
                echo -e " '---' "
		echo -e "\e[1;31mXXX\e[0m Exiting... :q            \e[1;31mXXX#\e[0m"
                break
            ;;
        *)
            echo ""
            ;;
    esac
done

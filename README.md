# NoteTaker 
A simple bash script to take notes in a terminal.

Part of - One night project

## Features
- Show notes
- Create notes
- Edit notes
- Delete notes
- Copy notes to clipboard
- Open notes in editor

## Usage
```
$ ./notetaker.sh

or

$ notes (if you have set alias in bash.rc)
```
Check bash.rc for alias

## Installation
```
$ git clone 
$ cd notetaker
$ sudo chmod +x notetaker.sh
```

## Configuration
```
set notes_directory to your desired directory 
    - default is $HOME/projects/notetaker/notes
 
set editor to your desired editor
    - default is nano 

set clipboard to your desired clipboard
    - default is xclip        
```

## Dependencies
```
$ sudo apt install xclip
$ sudo apt install fzf
$ sudo apt install nano
```
- nano
- xclip
- fzf

## License
[MIT](https://choosealicense.com/licenses/mit/)


 

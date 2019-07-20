#!/bin/env sh

if [[ $1 = -h ]] || [[ $1 = "--help" ]]
then
    echo 'New C Project script, v1.0 (made by José Joaquín Zubieta Rico)

newcprojectc.sh [-h|--help] args.
The possible args are 3, and always will
be interpretated in this way:

    ARG         DESCRIPTION                     DEFAULT
    arg1        Name of the project directory   "new_c_project"
    arg2        Name of the prooject            "Name of the Project"
    arg3        Description of the project      "Description of the project"

Please do not use % in you arg2 or arg3 because it will cause troubles
with sed substitution.
For help please use

    -h  --help  Print this menu'
        exit
fi

if [[ -n "$1" ]]
then
    mkdir "$1"
    if [[ $? != 0 ]]
    then
        exit 
    fi
    cd "$1"
else
    mkdir new_c_project
    cd new_c_project
fi

if [[ -n "$2" ]]
then
    PROJECT_NAME="$2"
else
    PROJECT_NAME="Project Name"
fi

if [[ -n "$3" ]]
then
    PROJECT_DESC="$3"
else
    PROJECT_DESC="Description of the project."
fi

cp -r ~/.config/scripts/cproject/* ./

DATE=$(date "+%m-%d-%Y")

sed -i "2,2s/00-00-0000/$DATE/" README.md
sed -i "17,17s/00-00-0000/$DATE/" README.md
sed -i "3,3s/00-00-0000/$DATE/" src/main.c

sed -i "1,1s%NAME%$PROJECT_NAME%" README.md
sed -i "5,5s%Description of the project\.%$PROJECT_DESC%" README.md

sed -i "1,1s%NAME%$PROJECT_NAME%" src/main.c
sed -i "5,5s%Description of the project\.%$PROJECT_DESC%" src/main.c

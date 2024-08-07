#!/bin/bash
set -e

unset DART_DEFINES
opt="$1"

show_menu(){
    normal=`echo "\033[m"`
    menu=`echo "\033[36m"` #Blue
    number=`echo "\033[33m"` #yellow
    bgred=`echo "\033[41m"`
    fgred=`echo "\033[31m"`
    printf "\n${menu}*********************************************${normal}\n"
    printf "${menu}**${number} i  ${menu} Build iOS Only ${normal}\n"
    printf "${menu}**${number} a  ${menu} Build Android Only ${normal}\n"
    printf "${menu}**${number} w  ${menu} Build Web Only ${normal}\n"
    printf "${menu}**${number} ↵  ${menu} Build Both ${normal}\n"
    printf "${menu}**${number} x ${menu} Exit ${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please enter a menu option and enter or ${fgred}Enter to run both builds. ${normal}"
    read opt
    if [$opt = '']; then 
        opt='b';
    fi
}

option_picked(){
    msgcolor=`echo "\033[01;31m"` # bold red
    normal=`echo "\033[00;00m"` # normal white
    message=${@:-"${normal}Error: No message passed"}
    printf "${msgcolor}${message}${normal}\n"
}

web(){
cd web && flutter build web && cd ..    
}

ios(){
cd ios && fastlane alpha && cd ..
}
android(){
cd android && fastlane alpha && cd ..
}
both(){
    android
    ios
}

update(){
    cd ..
    pwd
    git pull
    cd app
    revision=`git rev-list --count HEAD`
    version=`grep 'version: ' pubspec.yaml | sed 's/version: //' | sed 's/\.[0-9]*+.*//'`
    version="version: $version.$revision+$revision"
    option_picked "Build version: $version"
    res="sed -i '' 's/version:.*$/${version}/' pubspec.yaml"
    eval $res
#    flutter pub upgrade
    # flutter packages pub run build_runner build
}

clear
if [[ $opt = '' ]]; then show_menu; fi;
echo $opt
while [ $opt != '' ]
    do
    if [ $opt = '' ]; then
      exit;
    else
      case $opt in
        i) clear;
            option_picked "iOS Only";
            update;
            ios;
            exit;
        ;;
        a) clear;
            option_picked "Android Only";
            update;
            android;
            exit;
        ;;
        w) clear;
            option_picked "Web Only";
            update;
            web;
            exit;
        ;;
        x)exit;
        ;;
        \n)exit;
        ;;
        *)clear;
            option_picked "Both builds";
            update;
            both;
            exit;
        ;;
      esac
    fi
done

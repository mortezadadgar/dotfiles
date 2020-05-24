#!/bin/bash
###################################################################
#  _____   ____ _______   ____          _____ _  ___    _ _____   #
# |  __ \ / __ \__   __| |  _ \   /\   / ____| |/ / |  | |  __ \  #
# | |  | | |  | | | |    | |_) | /  \ | |    | ' /| |  | | |__) | #
# | |  | | |  | | | |    |  _ < / /\ \| |    |  < | |  | |  ___/  #
# | |__| | |__| | | |    | |_) / ____ \ |____| . \| |__| | |      #
# |_____/ \____/  |_|    |____/_/    \_\_____|_|\_\\____/|_|      #
###################################################################

# Save default IFS value
DefaultIFS=$IFS

# Display title
clear
echo -e "\e[96mDOT BACKUP SCRIPT\e[0m"
echo ''
# define backup directory
echo -e "\e[96mBackup directory:\e[0m"
pwd=$(pwd)
echo "$pwd/dotfiles"
dot=$pwd

# dot files directories
directories=()
input="dotfiles_list.txt"
while IFS= read -r line
do
    IFS=''
    directories+=($HOME/$line)
    IFS=$DefaultIFS
done < "$input"

# backup files
backup(){
    # Set IFS to '' so spaces are not ignored
	IFS=''
    # copy dot files to backup directory
    echo -e "\e[96mBackuping the following dotfiles:\e[0m"
    # backup new dotfiles
    for dir in ${directories[@]}; do
        echo "$dir"
        # copy the dotfile
        cp -R -f "$dir" $dot
    done
    echo -e "\e[96mDotfiles backup done!\e[0m"
    # Reset IFS to its default value
    IFS=$DefaultIFS
    echo ''
}

# backup list of installed packages
backup_app(){
    read -r -p "Backup explicitly installed app list? [y/N]" response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then    
        pacman -Qe > appList.txt && echo -e "\e[96mApp list backup done!\e[0m"
    else
        echo -e "\e[96mSkipping app list backup.\e[0m"
    fi
    echo ''
}


# push files to the user repo
user_repo=$(git config --get remote.origin.url)
git(){
    GIT=`which git`
    echo -e "\e[96mDo you want to push the backup to the following repo?\e[0m"
    echo "$user_repo"
    read -r -p "[y/N]" response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e "\e[96mPushing files to your repo.\e[0m"  
        ${GIT} add .
        ${GIT} reset backup.sh
        read -r -p "Commit message:" response
        ${GIT} commit -sm "$response"
        ${GIT} push
    fi
    echo ''
}

# execute the functions
cleaner
backup
backup_app
git
echo -e "\e[96mBackup completed!\e[0m"

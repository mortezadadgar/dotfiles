#!/bin/bash
###################################################################################################################
#                                                                                                                 #
#  _____   ____ _______ ______ _____ _      ______  _____   __  __          _   _          _____ ______ _____     #
# |  __ \ / __ \__   __|  ____|_   _| |    |  ____|/ ____| |  \/  |   /\   | \ | |   /\   / ____|  ____|  __ \    #
# | |  | | |  | | | |  | |__    | | | |    | |__  | (___   | \  / |  /  \  |  \| |  /  \ | |  __| |__  | |__) |   #
# | |  | | |  | | | |  |  __|   | | | |    |  __|  \___ \  | |\/| | / /\ \ | . ` | / /\ \| | |_ |  __| |  _  /    #
# | |__| | |__| | | |  | |     _| |_| |____| |____ ____) | | |  | |/ ____ \| |\  |/ ____ \ |__| | |____| | \ \    #
# |_____/ \____/  |_|  |_|    |_____|______|______|_____/  |_|  |_/_/    \_\_| \_/_/    \_\_____|______|_|  \_\   #
#                                                                                                                 #                                                                                                        
###################################################################################################################

# Save default IFS value
DefaultIFS=$IFS
dot=$(pwd)

# Backup utility
backup_utility(){
    # Display title
    clear
    echo -e "\e[96mDOTFILES BACKUP SCRIPT\e[0m"
    echo ''
    # define backup directory
    echo -e "\e[96mBackup directory:\e[0m"
    echo "$dot"

    # dot files directories
    directories=()
    input="dotfiles_list.txt"
    while IFS= read -r line
    do
        IFS=''
        directories+=($line)
        IFS=$DefaultIFS
    done < "$input"

    # backup files
    backup(){
        # Set IFS to '' so spaces are not ignored
        IFS=''
        # copy dotfiles to backup directory
        echo -e "\e[96mBackuping the following dotfiles:\e[0m"
        # backup new dotfiles
        for dir in ${directories[@]}; do
            # copy the dotfile
            echo "$dir"
            cp --parents -r -f "$HOME/$dir" $dot
            cp -r -f $dot$HOME/. $dot
            dir_rm=$dot/$HOME/
            parentdir="$(dirname "$dir_rm")"
            rm -rf $parentdir
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
            ${GIT} reset dotfiles_manager.sh
            read -r -p "Commit message:" response
            ${GIT} commit -m "$response"
            ${GIT} push
        fi
        echo ''
    }

    # execute the functions
    backup
    backup_app
    git
    echo -e "\e[96mBackup completed!\e[0m"
}

# Restore utility
restore_utility(){
    clear

    # dot files directories
    directories=()
    input="dotfiles_list.txt"
    while IFS= read -r line
    do
        IFS=''
        directories+=($line)
        IFS=$DefaultIFS
    done < "$input"

    # restore files
    restore(){
        # Set IFS to '' so spaces are not ignored
        IFS=''
        # copy dotfiles to their directories
        echo -e "\e[96mRestoring the following dotfiles:\e[0m"
        # restore dotfiles
        for dir in ${directories[@]}; do
            # copy the dotfile
            echo "$dot/$dir $HOME/$dir"
            if cp -r -f "$dot/$dir/." "$HOME/$dir"; then
                :
            else
                cp -r -f "$dot/$dir" "$HOME/$dir"
            fi

        done
        echo -e "\e[96mDotfiles restore done!\e[0m"
        # Reset IFS to its default value
        IFS=$DefaultIFS
        echo ''
    }

    # execute the functions
    restore
}

# MAIN
main(){
    echo -e "\e[96mDOTFILES MANAGER SCRIPT\e[0m"
    echo ''
    echo -e "\e[96m1)Backup utility\e[0m"
    echo -e "\e[96m2)Restore utility\e[0m"
    read -r -p "Enter a selection:" response
    if [ "$response" == "1" ]; then
        backup_utility
    elif [ "$response" == "2" ]; then
        restore_utility
    else
        clear
        echo -e "\e[31mPlease enter a valid value\e[0m"
        main
    fi
}
clear
main

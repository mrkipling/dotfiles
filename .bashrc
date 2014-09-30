# This is a not complete .bashrc file!
# Append this stuff as required

# Custom aliases and functions

alias ls='ls -alh --color'
alias sc='screen -dR'
alias delpyc='find -name "*.pyc" -delete'
alias crontab='crontab -i' # confirm before deleting crontab
alias upd='sudo apt-get update && sudo apt-get dist-upgrade'
alias optimise_jpgs='mkdir optimised; for i in *.JPG; do jpegoptim "$i" --max=80 --dest="optimised"; done'

function fname() { find . -iname "*$@*"; }
function dumpdb { mysqldump -u root -p --databases $1 > ~/db_dumps/$2; }
function restoredb { cat ~/db_dumps/$1 | mysql -uroot -p $2; }

function tarup { tar -zcvf $1.tar.gz $1; }
function untar { tar -xzvf $1; }

# nginx

alias ngrestart='sudo /etc/init.d/nginx restart'
alias ngav='cd /etc/nginx/sites-available'
alias ngen='cd /etc/nginx/sites-enabled'

function ngenable { sudo ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled; }
function ngdisable { sudo rm /etc/nginx/sites-enabled/$1; }

# GPG

alias gpg-import='gpg --import ~/Downloads/address.txt'

function gpg-encrypt {
    gpg --recipient $1 --output ~/Downloads/message.gpg --armor --encrypt ~/Downloads/message.txt
}

# copy with progress bar
# https://chris-lamb.co.uk/2008/01/24/can-you-get-cp-to-give-a-progress-bar-like-wget/

function cp_p() {
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# upload a file for temporary (2 week) sharing via http://transfer.sh/
function transfer() { curl --upload-file ./$1 https://transfer.sh/$1; }
alias transfer=transfer

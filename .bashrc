# This is a not complete .bashrc file!
# Append this stuff as required

# Custom aliases

alias ls='ls -al --color'
alias sc='screen -dR'
alias delpyc='find -name "*.pyc" -delete'

# Custom functions

function fname() { find . -iname "*$@*"; }
function dumpdb { mysqldump -u root --databases $1 > ~/db_dumps/$2 }
function restoredb { cat ~/db_dumps/$1 | mysql -uroot $2 }

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

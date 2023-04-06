alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .4='cd ../../../'
alias .5='cd ../../../../'

alias ports='netstat -tulanp'

alias l.='ls -d .* --color=auto'

alias ipe='curl ipinfo.io/ip; echo'

alias jsonf="python -m json.tool"

alias gs="git status"

alias policz='du -m --max-depth 1 | sort -n'

alias python='python3.11'
alias python3='python3.11'

alias losuj="python -c 'from os import urandom; from base64 import b64encode; print(b64encode(urandom(32)).decode(\"utf-8\"))'"

alias raport='coverage html --omit "venv/*,tests/*"'

alias wszystko='git log --branches --remotes --tags --graph --oneline --decorate'

alias glcicd='gitlab-runner exec docker --cache-dir=/tmp/gitlab-cache --docker-cache-dir=/tmp/gitlab-cache --docker-volumes=/tmp/gitlab-cache'

alias dcdev='docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d --force-recreate'

function doprzodu() {
    SPECIFIED_BRANCH=$1
    if [[ -z "$SPECIFIED_BRANCH" ]]; then
        echo "Nie podano nazwy gałęzi - podaj ją jako argument"
        return
    fi
    COMMIT_TO_CHECKOUT="$(git rev-list --topo-order HEAD.."$1" | tail -1)"
    if [[ -z "$COMMIT_TO_CHECKOUT" ]]; then
        echo "Brak następnych commitów"
        git checkout "$SPECIFIED_BRANCH"
        return
    else
        git checkout "$COMMIT_TO_CHECKOUT"
    fi
}

alias zapisz_strone='wget --no-clobber --convert-links --random-wait -p -E -e robots=off --no-parent -U mozilla'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .4='cd ../../../'
alias .5='cd ../../../../'

alias ports='ss -tulanp'

alias l.='ls -d .* --color=auto'
alias lt='ls --human-readable --size -1 -S --classify'

alias ipe='curl ipinfo.io/ip; echo'

alias jsonf="python -m json.tool"

alias gs="git status"
alias gt='cd `git rev-parse --show-toplevel`'

alias policz='du -m --max-depth 1 | sort -n'

alias python3='python3.10'
alias s="source ./venv/bin/activate"

alias secret='python3 -c "import secrets; print(secrets.token_urlsafe(32))"'

alias raport='coverage html --omit "venv/*,tests/*"'

alias {wsz,wszystko}='git log --branches --remotes --tags --graph --oneline --decorate'
alias zguba='git log --oneline --all --graph'

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

alias k='kubectl'
alias ka='kubectl apply -f'
alias kp='kubectl get pods'
alias kd='KUBECTL_EXTERNAL_DIFF="colordiff -N -u" kubectl diff'
alias ktory='kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName'
alias kcurl='kubectl run mycurlpod --image=curlimages/curl -i --tty -- sh'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)\ /';
}

qq() {
    clear
    local gpath="${GOPATH:-$HOME/go}"
    "${gpath%%:*}/src/github.com/y0ssar1an/q/q.sh" "$@"
}

rmqq() {
    if [[ -f "$TMPDIR/q" ]]; then
        rm "$TMPDIR/q"
    fi
    qq
}

alias kubesh='pod=$(kubectl get pods | cut -f1 -d" " | fzf); kubectl exec -ti $pod bash || kubectl exec -ti $pod sh'
alias kubeusecontext='context=$(kubectl config get-contexts -o name | fzf); kubectl config use-context $context'

whoseport() {
    lsof -i ":$1" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} LISTEN
}

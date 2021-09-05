parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)\ /';
}

qq() {
    clear

    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi

    if [[ ! -f "$logpath" ]]; then
        echo 'Q LOG' > "$logpath"
    fi

    tail -100f -- "$logpath"
}

rmqq() {
    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi
    if [[ -f "$logpath" ]]; then
        rm "$logpath"
    fi
    qq
}

alias kubesh='pod=$(kubectl get pods -o custom-columns=":metadata.name" --no-headers | fzf); kubectl exec -ti $pod bash || kubectl exec -ti $pod sh'
alias kubeusecontext='context=$(kubectl config get-contexts -o name | fzf); kubectl config use-context $context'

whoseport() {
    lsof -i ":$1" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} LISTEN
}

generate_jwt() {
    if [ $# -ne 3 ]; then
        echo "Please provide key type, jwt body and the private key"
        return 1
    fi

    HEADER=`echo -n \{\"alg\":\"$1\",\"typ\":\"JWT\"\} | base64 | sed s/\+/-/g | sed -E s/=+$//g | sed 's/\//_/g'`
    PAYLOAD=`echo -n $2 | base64 | sed s/\+/-/g | sed -E s/=+$//g | sed 's/\//_/g'`
    BODY=`echo -n "$HEADER.$PAYLOAD" | openssl dgst -sha256 -sign $3 -binary | base64 | sed s/\+/-/g | sed -E s/=+$//g | sed 's/\//_/g'`
    echo "$HEADER.$PAYLOAD.$BODY" | tr -d '\n'
    echo
}

vimspector_go() {
    read -p 'enter path of main file: ' MAIN_FILE
    echo $MAIN_FILE
    cat <<EOF > .vimspector.json
{
    "configurations": {
        "run": {
            "adapter": "vscode-go",
            "configuration": {
                "request": "launch",
                "program": "\${workspaceRoot}/$MAIN_FILE",
                "mode": "debug",
                "dlvToolPath": "$HOME/go/bin/dlv"
            }
        }
    }
}
EOF
}

audio_cpu() {
    for (( i=0; i<=$(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor | wc -l); i++ ))
    do
        sudo cpufreq-set -c $i -g performance
    done
}

normal_cpu() {
    for (( i=0; i<=$(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor | wc -l); i++ ))
    do
        sudo cpufreq-set -c $i -g powersave
    done
}

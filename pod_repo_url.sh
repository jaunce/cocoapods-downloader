#!/usr/bin/env bash
url="$1"
options="$2"
back_url=$1
url=${url#*//}
git_account="$(cat ~/.git_pwd)"

function access_repo() {
    a=`git ls-remote -h -- "$1" HEAD`
    if [ $? -ne 0 ]; then
        echo "1"
    else
        echo "0"
    fi
}

gitlab_tag="gitlab.yundasys.com:8090"
if [[ $back_url == *$gitlab_tag* ]]; then
    for account in $(cat ~/.git_pwd); do
        new_url="http://$account@$url"
        result="$(access_repo $new_url)"
        if [ "$result" = "0" ]; then
            back_url=$new_url
            break
        fi
    
    done
    echo "$back_url"
else
    echo "$1" >> ~/a.log
#    if [[ $back_url == *$sdweb* ]]; then
#        echo "http://10.19.186.32:8099/SDWebImag_0.0.1-beta_20210822.zip"
##        echo "$1"
#    else
        echo "$1"
#    fi
    
fi

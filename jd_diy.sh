#!/usr/bin/env bash
## CUSTOM_SHELL_FILE for https://gitee.com/lxk0301/jd_docker/tree/master/docker

#### i-chenzhe https://github.com/i-chenzhe/qx
rm -rf /i-chenzhe
git clone https://github.com/i-chenzhe/qx.git /i-chenzhe
#
for jsname in $(ls /i-chenzhe | grep -E "js$" | tr "\n" " "); do cp /i-chenzhe/$jsname /scripts/i-chenzhe_$jsname; done
for jsname in $(ls /i-chenzhe | grep -E "js$" | tr "\n" " "); do
    jsnamecron=$(cat /i-chenzhe/$jsname | grep -A 1 -E "\[Script\]" | grep -oE "^cron.*$jsname" | cut -d\" -f2)
    [[ jsnamecron != "" ]] echo "$jsnamecron node /scripts/i-chenzhe_$jsname >> /scripts/logs/i-chenzhe_$jsname.log 2>&1" >> /scripts/docker/merged_list_file.sh
done

#### cui521 https://github.com/cui521/jdqd
wget --no-check-certificate -O /scripts/cui521_DIY_shopsign.js https://raw.githubusercontent.com/cui521/jdqd/main/DIY_shopsign.js
echo "0 8,20 * * * node /scripts/cui521_DIY_shopsign.js >> /scripts/logs/cui521_DIY_shopsign.js.log 2>&1" >> /scripts/docker/merged_list_file.sh
#!/usr/bin/env bash
## CUSTOM_SHELL_FILE for https://gitee.com/lxk0301/jd_docker/tree/master/docker

function monkcoder(){
    # https://github.com/monk-coder/dust
    rm -rf /monkcoder /scripts/monkcoder_*
    git clone https://github.com/monk-coder/dust.git /monkcoder
    # 拷贝新文件
    for jsname in $(find /monkcoder -name "*.js" | grep -vE "\/backup\/"); do cp ${jsname} /scripts/monkcoder_${jsname##*/}; done
    for jsname in $(find /monkcoder -name "*.js" | grep -vE "\/backup\/"); do
        jsnamecron="$(cat $jsname | grep -oE "/?/?cron \".*\"" | cut -d\" -f2)"
        test -z "$jsnamecron" || echo "$jsnamecron node /scripts/monkcoder_${jsname##*/} >> /scripts/logs/monkcoder_${jsname##*/}.log 2>&1" >> /scripts/docker/merged_list_file.sh
    done
}

function whyour(){
    # https://github.com/whyour/hundun/tree/master/quanx
    rm -rf /whyour /scripts/whyour_*
    git clone https://github.com/whyour/hundun.git /whyour
    # 拷贝新文件
    for jsname in jx_factory.js jx_factory_component.js jdzz.js jd_zjd_tuan.js; do cp /whyour/quanx/$jsname /scripts/whyour_$jsname; done
    for jsname in jx_factory.js jx_factory_component.js jdzz.js jd_zjd_tuan.js; do
        jsnamecron="$(cat /whyour/$jsname | grep -oE "/?/?cron \".*\"" | cut -d\" -f2)"
        test -z "$jsnamecron" || echo "$jsnamecron node /scripts/whyour_$jsname >> /scripts/logs/whyour_$jsname.log 2>&1" >> /scripts/docker/merged_list_file.sh
    done
}

function diycron(){
    # 启用京价保
    echo "41 0,23 * * * node /scripts/jd_price.js >> /scripts/logs/jd_price.log 2>&1" >> /scripts/docker/merged_list_file.sh
}

function main(){
    #
    a_jsnum=$(ls -l /scripts | grep -oE "^-.*js$" | wc -l)
    a_jsname=$(ls -l /scripts | grep -oE "^-.*js$" | grep -oE "[^ ]*js$")
    monkcoder
    whyour
    b_jsnum=$(ls -l /scripts | grep -oE "^-.*js$" | wc -l)
    b_jsname=$(ls -l /scripts | grep -oE "^-.*js$" | grep -oE "[^ ]*js$")
    #
    diycron
    #
    info_more=$(echo $a_jsname  $b_jsname | tr " " "\n" | sort | uniq -c | grep -oE "1 .*$" | grep -oE "[^ ]*js$" | tr "\n" " ")
    [[ "$a_jsnum" == "0" || "$a_jsnum" == "$b_jsnum" ]] || curl -sX POST "https://api.telegram.org/bot$TG_BOT_TOKEN/sendMessage" -d "chat_id=$TG_USER_ID&text=DIY脚本更新完成：$a_jsnum $b_jsnum $info_more" >/dev/null
}

main

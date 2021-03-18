#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin && export PATH
# Usage:
## wget --no-check-certificate https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh && chmod +x jdformat.sh && bash jdformat.sh

# 传入参数中含有fromfile就从文件读取配置：fromfile@/etc/.jd_sku 
echo $@ | grep -qE "fromfile@[^ ]+" && all_parameter=($(cat $(echo $@ | grep -oE "fromfile@[^ ]+" | cut -f2 -d@))) || all_parameter=($(echo $@))

# 文件路径： jd_scripts diy 脚本和log等的保存路径
workdir="/jd_sku/jd_scripts" && [[ ! -d "$workdir" ]] && mkdir -p $workdir
cookiefile="$workdir/cookie.file"
composefile="$workdir/docker-compose.yml"

# 基础工具和文件创建
function jd_sku_base(){
	workdir_bak=${workdir}_$(date +%s)
	[[ ! -d "$workdir" ]] && mkdir -p $workdir || echo $(mv $workdir $workdir_bak) $workdir 文件已备份至 $workdir_bak
    git clone https://github.com/mixool/jd_sku.git $workdir
}

# docker-compose.yml 所有支持的变量： jd_sku_var@ENABLE_AUTO_HELP@true jd_sku_var@TG_BOT_TOKEN@123456:AABB jd_sku_var@TG_USER_ID@-123456
function jd_sku_var(){
    varlist=($(echo ${all_parameter[*]} | grep -oE "jd_sku_var@[^@]+@[^ ]+" | tr "\n" " ")) && [[ ${#varlist[*]} == 0 ]] && return 0
    for ((i = 0; i < ${#varlist[*]}; i++)); do
        varname="$(echo ${varlist[i]} | cut -f2 -d@)"
        varvalue="$(echo ${varlist[i]} | cut -f3 -d@)"
        [[ $varname == "" || $varvalue == "" ]] && echo 变量 $varname $varvalue 参数无效 && continue
        sed -i "/$varname.*/d" $composefile
        echo "                - $varname=$varvalue" >>$composefile
    done
    cat $composefile
}

# 从workdir目录下的cookie.file获取格式化后cookie导入docker-compose.yml,后期cookie过期维护使用: bash jdformat.sh jd_sku_initck
function jd_sku_initck() {
    cookies="$(cat $cookiefile | grep -vE "^#" | tr "\n" "&" | sed "s/&$//")"
    sed -i "/JD_COOKIE.*/d" $composefile
    echo "                - JD_COOKIE=$cookies" >>$composefile
    cat $composefile
    return 0
}

function main() {
    echo ${all_parameter[*]} | grep -q "jd_sku_initck" && jd_sku_initck && exit 0
    jd_sku_base
    jd_sku_var
}

main
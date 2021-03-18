> [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker) 快速部署 FOR VPS Debian 10 64 | 记录和自用 | 测试中...

#### 快速部署
* `apt update && apt install -y python3-pip curl vim git moreutils; curl -sSL get.docker.com | sh; pip3 install --upgrade pip; pip install docker-compose`
* `wget --no-check-certificate https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh && chmod +x jdformat.sh`
* 按需传入参数配置docker-compose.yml
`bash jdformat.sh 'jd_sku_var@JD_COOKIE@pt_key=aaa;pt_pin=aaaa; jd_sku_var@ENABLE_AUTO_HELP@true jd_sku_var@CUSTOM_SHELL_FILE=https://raw.githubusercontent.com/mixool/jd_sku/main/jd_i-chenzhe.sh'`
* 其它 [jdformat.sh](https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh)

#### 容器执行
* `cd /jd_sku/jd_scripts && docker-compose up -d`
* `docker-compose logs`
* 获取cookie: `docker exec -it jd_scripts /bin/sh -c 'node getJDCookie.js'`
* 查看任务列表 `docker exec -it jd_scripts /bin/sh -c 'crontab -l'`
* 执行指定任务 `docker exec -it jd_scripts /bin/sh -c 'git -C /scripts pull && node /scripts/jd_bean_change.js'`
* 其它 [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker), 请遵守lxk0301项目的一切声明

Tips:
* [jd_i-chenzhe.sh](https://raw.githubusercontent.com/mixool/jd_sku/main/jd_i-chenzhe.sh) 为diy脚本,建议启用，jd_docker的默认定时任务docker_entrypoint.sh会执行对应内容

Thanks: 
* [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker)
* [i-chenzhe](https://github.com/i-chenzhe/qx.git)
> [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker) 快速部署 FOR VPS Debian 10 64 | 记录和自用 | 测试中...

#### 快速部署
* `apt update && apt install -y python3-pip curl vim git moreutils; curl -sSL get.docker.com | sh; pip3 install --upgrade pip; pip install docker-compose`
* `wget --no-check-certificate -O jdformat.sh https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh && chmod +x jdformat.sh`
* 按需传入 `docker-compose.yml` 配置参数
```bash
bash jdformat.sh 'jd_sku_var@JD_COOKIE@pt_key=aaa;pt_pin=aaaa; jd_sku_var@ENABLE_AUTO_HELP@true jd_sku_var@CUSTOM_SHELL_FILE=https://raw.githubusercontent.com/mixool/jd_sku/main/jd_i-chenzhe.sh'
```
* 其它 [jdformat.sh](https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh)

#### 容器执行
* `cd /jd_sku/jd_scripts && docker-compose up -d`
* `docker-compose logs`
* 扫码获取cookie: `docker exec -it jd_scripts /bin/sh -c 'node getJDCookie.js'`
* 查看任务列表 `docker exec -it jd_scripts /bin/sh -c 'crontab -l'`
* 执行指定任务 `docker exec -it jd_scripts /bin/sh -c 'git -C /scripts pull && node /scripts/jd_bean_change.js'`
* 其它 [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker), 请遵守lxk0301项目的一切声明

Tips:
* 首次执行时不必传入 `jd_sku_var@JD_COOKIE@pt_key=aaa;pt_pin=aaaa;` 参数，容器运行正常后扫码获取cookie，按一行一个的格式填入cookie.file后再执行格式化脚本后重启容器  
`bash jdformat.sh jd_sku_initck && cd /jd_sku/jd_scripts && docker-compose up -d`  
* [jd_i-chenzhe.sh](https://raw.githubusercontent.com/mixool/jd_sku/main/jd_i-chenzhe.sh) 为diy脚本,建议启用，jd_docker的默认定时任务docker_entrypoint.sh会执行脚本更新文件和任务

Thanks: 
* [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker)
* [i-chenzhe](https://github.com/i-chenzhe/qx.git)
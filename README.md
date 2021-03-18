> [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker) 快速部署 FOR VPS Debian 10 64 | 测试中...

#### 快速部署
1. `wget --no-check-certificate https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh && chmod +x jdformat.sh`
2. `bash jdformat.sh 'jd_sku_var@JD_COOKIE@pt_key=aaa;pt_pin=aaaa; jd_sku_var@ENABLE_AUTO_HELP@true jd_sku_var@CUSTOM_SHELL_FILE=https://raw.githubusercontent.com/mixool/jd_sku/main/jd_i-chenzhe.sh'`

#### 容器执行
1. cd /jd_sku/jd_scripts && docker-compose up -d
2. docker-compose logs
3. 获取cookie: docker exec -it jd_scripts /bin/sh -c 'node getJDCookie.js'
4. 查看任务列表 `docker exec -it jd_scripts /bin/sh -c 'crontab -l'`
5. 执行指定任务 `docker exec -it jd_scripts /bin/sh -c 'git -C /scripts pull && node /scripts/jd_bean_change.js'`
6. 其它 [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker), 请遵守lxk0301项目的一切声明

> [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker) 部署 FOR VPS Debian 10 64 | 记录和自用 | 测试中...

#### 快速部署  
* docker 和 docker-compose 安装  
```bash
apt update && apt install -y python3-pip curl vim git moreutils; curl -sSL get.docker.com | sh; pip3 install --upgrade pip; pip install docker-compose
```
* 下载部署脚本  
```bash
wget --no-check-certificate -O jdformat.sh https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh && chmod +x jdformat.sh
```
* 按需传入 `docker-compose.yml` 配置参数  
```bash
bash jdformat.sh 'jd_sku_var@ENABLE_AUTO_HELP@true jd_sku_var@CUSTOM_SHELL_FILE@https://raw.githubusercontent.com/mixool/jd_sku/main/jd_diy.sh jd_sku_var@JD_COOKIE@pt_key=aaa;pt_pin=aaaa;'
```
[参数说明](https://gitee.com/lxk0301/jd_docker/blob/master/githubAction.md)  
* 其它 [jdformat.sh](https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh)

#### 容器执行  
* `cd /jd_sku/jd_scripts && docker-compose up -d`
* `docker-compose logs`
* cookie扫码获取 `docker exec -it jd_scripts /bin/sh -c 'node getJDCookie.js'`
* 查看任务列表 `docker exec -it jd_scripts /bin/sh -c 'crontab -l'`
* 执行指定任务
```bash
docker exec -it jd_scripts /bin/sh -c 'git -C /scripts pull && node /scripts/jd_bean_change.js'
```
* 其它 [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker), 请遵守lxk0301项目的一切声明
  
### Tips:
* [jdformat.sh](https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh) 仅仅是使用传入参数来编辑docker-compose.yml文件，建议有能力的直接编辑对应文件使用
* [jd_diy.sh](https://raw.githubusercontent.com/mixool/jd_sku/main/jd_diy.sh) 为diy脚本,建议启用,其中涉及到的js脚本均由其它作者编写
* jd_docker的默认定时任务docker_entrypoint.sh以及重启容器均可更新包括diy脚本在内的所有的文件和任务
* 首次执行时不必传入 `jd_sku_var@JD_COOKIE@pt_key=aaa;pt_pin=aaaa;` 参数，容器运行正常后扫码获取cookie，按一行一个的格式填入/jd_sku/jd_scripts/cookie.file后再执行格式化脚本后重启容器
```  
bash jdformat.sh jd_sku_initck && cd /jd_sku/jd_scripts && docker-compose up -d
```
  
#### Thanks: 
* [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker)
* [i-chenzhe](https://github.com/i-chenzhe/qx.git)
* 其它diy脚本中涉及到的作者
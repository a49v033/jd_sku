> [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker) 部署 FOR VPS Debian 10 64
  
#### 部署
* docker docker-compose安装
```bash
apt update && apt install -y python3-pip curl vim git moreutils; curl -sSL get.docker.com | sh; pip3 install --upgrade pip; pip install docker-compose
```
* 下载jdformat脚本并运行
```bash
wget --no-check-certificate -O jdformat.sh https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh && chmod +x jdformat.sh && bash jdformat.sh
```
* 扫码获取cookie,按一行一个的格式填入/jd_sku/jd_scripts/cookie.file后再执行格式化脚本后重启jd_scripts容器
```bash
cd /jd_sku/jd_scripts && docker-compose up -d
docker exec -it jd_scripts /bin/sh -c 'node getJDCookie.js'
vim /jd_sku/jd_scripts/cookie.file
cd /jd_sku/jd_scripts && bash jdformat.sh && docker-compose up -d
```
* 常用指令
```bash
docker exec -it jd_scripts /bin/sh
docker exec -it jd_scripts /bin/sh -c 'crontab -l'
docker exec -it jd_scripts /bin/sh -c 'node getJDCookie.js'
docker exec -it jd_scripts /bin/sh -c 'docker_entrypoint.sh'
docker exec -it jd_scripts /bin/sh -c 'git -C /scripts pull && node /scripts/jd_bean_change.js'
```
  
#### Tips:
* jd_docker的默认定时任务docker_entrypoint.sh以及重启容器均可更新包括diy脚本在内的所有的文件和任务
* [jd_diy.sh](https://raw.githubusercontent.com/mixool/jd_sku/main/jd_diy.sh) 为diy脚本,**默认启用**,其中涉及到的js脚本均由其它作者编写,未作任何改动
* [jdformat.sh](https://raw.githubusercontent.com/mixool/jd_sku/main/jdformat.sh) 可使用传入参数和网络参数来编辑docker-compose.yml文件
* 其它帮助和声明 [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker)
  
#### Thanks:
* [lxk0301/jd_docker](https://gitee.com/lxk0301/jd_docker)
* [i-chenzhe](https://github.com/i-chenzhe/qx.git)
* 其它diy脚本中涉及到的作者
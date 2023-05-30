# LDM

## 目录

| 目录                   | 描述                                                                           | 备注     |
|----------------------|------------------------------------------------------------------------------|--------|
| terraform            | 基于CCE，将所有的资源创建在CCE的数据中心节点中，依赖RDS、DCS等云服务                                     ||
| terraform-cce-turbo  | 基于CCE-Turbo，将所有的资源创建在CCE-Remote的边缘IES节点中，依赖RDS等云服务（由于DCS没下沉IES，只能部署开源Redis）  | 过期，勿用  |
| resources            | 资源目录，详细如下所示                                                                  |        |


## 资源
### 预置资源（提前上传到OBS:ldm-res桶里）
| 资源                              | 描述                                       | 备注                        |
|---------------------------------|------------------------------------------|---------------------------|
| post_install.sh                 | 当CCE init-node创建完成后，会自动下载并执行该脚本          |                           |
| helm_install.sh                 | 用与安装helm cli与下载chart包，并使用helm cli安装ldm应用 |                           |
| ldm.sql.zip                     | 用于初始化RDS的数据库，包含了ldm的数据库结构和数据             |                           |
| helm-v3.11.3-linux-amd64.tar.gz | helm cli的安装包                             | 需要手动下载                    |
| ldm-helm-chart.tar.gz           | ldm的helm chats包                          | 通过tar -zcvf helmchart目录得到 |                

### 运行时资源
| 资源              | 描述                           |
|-----------------|------------------------------|
| kubeconfig.json | CCE集群创建完毕后，生成的kubeconfig文件   |
| outputs.yaml    | terraform执行完毕后生成的输出值，包含数据库信息 |

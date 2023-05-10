# RoboPackage

使用 Helm 和 Terraform 技术完成云机器人应用的【环境+应用】自动化部署，此仓库目录组织如下：

```shell
./robopackage
├── <app-dir>
│    ├── helmchart  # 存放应用的Kubernetes资源，使用helm管理
│    └── terraform  # 存放应用的云服务资源资源，使用terraform管理
└── README.md
```

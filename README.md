Nginx Server
========
# Nginx Server

`Nginx Server` 命令行运行小工具，用户本地页面测试

## 特点

1. 无需安装，直接使用。
2. 运行快速，只能支持HTML。
3. 原版第三方服务软件，直接替换，方便版本更新。

## Nginx Server layout

    Nginx Server目录结构
        │
        ├─conf - 项目配置文件
        │  │
        │  └─nginx - nginx服务器配置
        │
        ├─logs - 项目日志
        │  │
        │  └─nginx - nginx服务器日志
        │
        ├─nginx-0.8.50 - nginx服务器，后面是版本号
        │
        ├─sbin - 项目脚本
        │  │
        │  ├─nginx.bat - nginx服务器运行脚本
        │  │
        │  └─server.bat - 服务器运行基础脚本
        │
        ├─tools - 项目工具
        │
        └─nginx.bat - 项目启动脚本
# Docker的部署和删除
* 构建容器：

    ```bash
    # 创建镜像
    $ make image
    # 创建容器
    $ make container
    ```

* 删除容器：

    ```bash
    # 删除镜像
    $ make rm-image
    # 删除容器
    $ make rm-container
    # 删除镜像和容器
    $ make rm
    ```

# 可选服务
#
## 本地 Web 服务

```
$ make serve
```

浏览器访问 `http://localhost:4000`

![](images/web.png)


## Github Page
生成 web 静态资源文件：

```bash
$ make html
```

在 Github Page 设置时指定 `main` 分支下的 `docs` 路径即可。每次 push 后会自动更新。

## 二进制可执行文件
**前提**：需要 Golang 环境提供编译，且版本要求：**`>= 1.16`**。

默认编译为 linux 平台下的二进制文件，如需 windows 平台请使用 `os=windows` 进行指定。

```bash
# linux 平台
$ make exec
# windows 平台
$ make exec os=windows
```

例如：在 linux 平台下
* 查看版本等信息

    ```bash
    $ ./assets/exec -v
    ```

* 启动本地 web 服务，程序默认监听 8800 端口：

    ```bash
    $ ./assets/exec
    ```

    

* 也可手动指定监听端口：

    ```bash
    $ ./assets/exec -p 12300
    ```

    浏览器访问：`http://localhost:12300`

# 
